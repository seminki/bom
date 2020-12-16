package com.kh.bom.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

@Controller
@SessionAttributes("loginMember")
public class memberController {
    @Autowired
    private MemberService service;
	
    @Autowired
    BCryptPasswordEncoder pwEncoder;
    
    
	@RequestMapping("/mypage/orderStatus")
	public ModelAndView order(ModelAndView mv) {
		
		//주문내역
		
		mv.setViewName("mypage/orderStatus");
		return mv;
	}
	//회원정보수정 전 비밀번호 체크화면
	@RequestMapping("/mypage/updateMember")
	public String updateMember() {
		return "mypage/updateMemberPwCk";
	}
	//회원정보수정 접근시 비밀번호 체크
	@RequestMapping("/member/updateMemberView")

	public ModelAndView updateMemberPwCk(String memPwd,String memNo,ModelAndView mv){

		//회원번호로 회원정보가져오기
		Member login=service.selectMemberOne(memNo);
		//암호화처리한 회원비밀번호와 매개변수 비밀번호가 일치하면 true,일치하지 않으면  false
		if(pwEncoder.matches(memPwd.trim(),login.getMemPwd())) {
			mv.addObject("loginMember",login);
			mv.setViewName("mypage/updateMemberView");
			
		}else {
			mv.addObject("msg","비밀번호가 일치하지 않습니다.");
			mv.addObject("loc","/mypage/updateMember");
			mv.setViewName("common/msg");
		}
		return mv;
		
	}
	//회원탈퇴
	@RequestMapping("/member/deleteMember")
	public ModelAndView deleteMember(String memNo,ModelAndView mv,SessionStatus ss) {
		int result=service.deleteMember(memNo);
		if(result>0) {
			//회원탈퇴시 세션닫기
			if(!ss.isComplete()) {
				ss.setComplete();
			}
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("msg","회원탈퇴 실패");
			mv.addObject("icon","warning");
			mv.addObject("loc","/mypage/updateMember");
			mv.setViewName("common/msg");
		}
		return mv;
	}
	//닉네임 중복검사
	@RequestMapping("/member/checkDuplicateNick")
	@ResponseBody
	public boolean checkDuplicateNick(String memNick) {
		Member m=service.selectMemberNick(memNick);
		//닉네임이 있으면 false,없으면 true
		return m!=null?false:true;
	}
	
	//회원정보수정
	@RequestMapping("/member/updateMemberEnd")
	public ModelAndView updateMember(Member m,String pastPro,
			@RequestParam(value="upload",required=false) MultipartFile[] upFile,
			ModelAndView mv, HttpSession session) throws Exception {
		String path=session.getServletContext().getRealPath("/resources/upload/profile");
		File dir = new File(path);
		if(!dir.exists())dir.mkdirs(); //경로상에 없는 폴더 생성
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				//본래 파일이름 가져오기
				String originalName=f.getOriginalFilename();
				//확장자 분리
				String ext=originalName.substring(originalName.lastIndexOf(".")+1);
				//리네임양식정하기
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndValue=(int)(Math.random()*1000);
				String reName="pro"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
				try {
					f.transferTo(new File(path+"/"+reName));
				}catch(IOException e) {
					e.printStackTrace();
				}
				m.setMemPro(reName); //리네임한 파일이름 프로필로 넣기
				
				//이전에 등록한 프로필 파일 삭제
				if((pastPro!=null) && (!pastPro.equals("basic.png"))) {
					String deletePath=path+"/"+pastPro;
					File del=new File(deletePath);
					if(del.exists())del.delete();
				}
				
			}
		}
		
		//비밀번호 암호화처리
		String oriPw=m.getMemPwd().trim();
		System.out.println("암호화전"+oriPw);
		//공백이 아닐때만 암호화처리
		if(oriPw.length()>0) {
			m.setMemPwd(pwEncoder.encode(oriPw));
		}else {
			m.setMemPwd(oriPw);
		}
		
		//닉네임 공백처리
		m.setMemNick(m.getMemNick().trim());
		
		int result=service.updateMember(m);
		String msg="";
		String loc="/mypage/updateMember";
		String icon="";
		if(result>0) {
			//변경된 정보 다시 loginMember에 넣기
			mv.addObject("loginMeber",service.selectMemberOne(m.getMemNo()));

			msg="회원정보가 수정되었습니다.";
			icon="success";
		}else {
			msg="회원정보가 수정되지 않았습니다. 반복될경우 관리자에게 문의하세요.";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	
	//회원가입
	@RequestMapping("/member/enrollMember")
	public String enrollMember(Member mem,
			@RequestParam(value="nick") String nick,
			@RequestParam(value="email") String email,
			@RequestParam(value="password") String password,
			Model m) {
		mem.setMemNick(nick);
		mem.setMemEmail(email);
		mem.setMemPwd(password);
		Point p=new Point();
		p.setPointContent("회원가입");
		p.setPointChange(2000);
		
		//패스워드 암호화처리
		String oriPw=mem.getMemPwd();
		
		mem.setMemPwd(pwEncoder.encode(oriPw));
		
		int result=service.insertMember(mem,p);
		m.addAttribute("msg",result>0?"다시:봄 회원이 되셨습니다.":"회원가입 실패!!!!!!");
		m.addAttribute("loc","/");
		
		
		return "common/msg";
	}
	
	//로그인
	@RequestMapping("/member/loginMember")
	public String loginMember(String email, String password, 
							Model m, String saveId, HttpServletResponse response) {
		
		if(saveId!=null){
		Cookie c = new Cookie("saveId",email);
		c.setMaxAge(24*60*60);
		c.setPath("/bom");
		response.addCookie(c);
	
		}else {
		Cookie c=new Cookie("saveId","");
		c.setMaxAge(0);
		response.addCookie(c);
	}
		
		Member login=service.selectOneMember(email);
		//암호화된 비번 비교 
		if(pwEncoder.matches(password, login.getMemPwd())) {
			m.addAttribute("loginMember",login);
		
		}else {
			m.addAttribute("msg","잘못된 이메일 또는 비밀번호를 입력하셨습니다.");
			m.addAttribute("loc","/");
			return "common/msg";
		}
		
		
		return "redirect:/";
				
	}
	
	@RequestMapping("/member/logout")
	public String logout(SessionStatus ss) {
		//세션이 살아있으면, 
		if(!ss.isComplete()) {
			ss.setComplete();
		}
		return "redirect:/";		
	}
	
	//이메일 중복검사
		@RequestMapping("/member/checkDuplicateEmail")
		@ResponseBody
		public boolean checkDuplicateEmail(String memEmail) {
			Member m=service.selectMemberEmail(memEmail);
			//이메일이 있으면 false,없으면 true
			return m!=null?false:true;
		}
	
	//스탬프 페이지로 이동
	@RequestMapping("/mypage/stamp")
	public ModelAndView stamp(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		Member login=service.selectMemberOne(m.getMemNo());
		mv.addObject("loginMember",login);
		mv.setViewName("mypage/stamp");
		return mv;
	}
	
	//인증번호 후 비밀번호 변경 
	@RequestMapping("/member/changePw")
	public ModelAndView changePw(ModelAndView mv,Member m,
					@RequestParam String newPw, HttpSession session) {
		
		String veriEmail=(String)session.getAttribute("veriEmail");
		System.out.println("이멜인증:"+veriEmail+"새비밀번호:"+ newPw);
		m.setMemEmail(veriEmail);
		m.setMemPwd(newPw);
	
		if(newPw.length()>0) {
			m.setMemPwd(pwEncoder.encode(newPw));
		}else {
			m.setMemPwd(newPw);
		}
		
		int result=service.updateMemberPw(m);
		String msg="";
		String loc="/";
		String icon="";
		if(result>0) {
 
			msg="비밀번호가 변경되었습니다.";
			icon="success";
		}else {
			msg="비밀번호를 바꾸는데 실패하였습니다. 다시 시도해주세요.";
			icon="warning";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		
		return mv;
	}

	
}
