package com.kh.bom.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.CommunityMngService;
import com.kh.bom.common.page.AdminProSearchAjaxPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.vo.BoardReply;

@Controller
public class CommunityAdminController {

	@Autowired
	private CommunityMngService service;


	 //댓글 페이지 매핑 주소
	 @RequestMapping("/admin/community/communityMng") public String replyList() {
	 
	 return "/admin/community/communityMng"; }
	 
	// 댓글 첫 페이지
	@RequestMapping("/admin/community/communityMngAjax") //페이지 매핑 주소
	public ModelAndView replyList(ModelAndView mv, @RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage, String order, @RequestParam(value="keyword", defaultValue="") String keyword) {

		System.out.println("순서" + order);
		
		Map m = new HashMap();
		m.put("order", order);
		m.put("keyword", keyword);
		
		mv.addObject("list", service.selectReplyList(cPage, numPerpage,m));
		int totalData = service.selectPage();

		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "communityMng"));
		mv.addObject("totalData", totalData);

		mv.setViewName("/admin/community/communityMngAjax"); //매핑된 페이지에서 보여주는 화면
		return mv;

	}
	
	//신고된 아이디 찾기
	
	
	
	//신고 내용
	@RequestMapping("/admin/community/reportReply")
	public ModelAndView reportReply(BoardReply br,ModelAndView mv) {
		
		System.out.println("댓글신고 : " + br);
		
		int result = service.reportReply(br);
		
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "댓글이 신고 되었습니다.";
			loc = "/community/communityList";
			icon = "success"; // icon 종류 : success,error,warning
		} else {
			msg ="댓글 신고에 실패하였습니다.";
			loc = "/community/communityList";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	
	//댓글 신고 상태 변경
	@RequestMapping("/admin/community/warnMemberYn")
	@ResponseBody
	public boolean warnMemberYn(BoardReply br) {
		int result = service.warnMemberYn(br);
		return result >0 ? true:false;
	}

}