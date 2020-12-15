<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SpringAgain</title>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<!-- swiper -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- icon -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<link rel="stylesheet" href="${path }/resources/css/common/allPage.css">

<style>
/*모달차 내 로고  */
.logoimg {
	width: auto;
	height: 40px;
}

.logo-box {
	text-align: center;
	width: 440px;
	margin-left: 29px;
}

/*모달 창  */
.social-container {
	text-align: center;
	padding: 16px;
}

p.p-info {
	margin: 1rem 0 1rem 0;
}

#verification {
	margin-top: 20px;
}

.info {
	background-color: #e9ecef;
	text-align: center;
}

/*유효성 검사*/
.pwOk, .nickOk, .emailOk {
	color: green;
	margin: 3px;
}

.pw, .nickError, .nickError2, .emailError, .emailError2, .emailSize {
	color: red;
	margin: 3px;
}

/* 헤더 아이콘 */
.header_icon {
	top: 6px;
	left: 6px;
	color: #45A663;
}
</style>
</head>

<body>
	<header id="spring-main-header" style="min-width: 1000px;">
		<!-- header -->
		<div id="header-container">
			<div id="loginJoin" class="d-flex flex-row-reverse">
				<ul class="nav">
					<c:if test="${loginMember == null }">
						<li class="nav-item"><a class="nav-link" data-toggle="modal"
							data-target="#loginModal">로그인</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="modal"
							data-target="#myModal">회원가입</a></li>
					</c:if>

					<c:if test="${loginMember!=null }">
						<c:if test="${loginMember.memManagerYn eq 'N' }">
							<li class="nav-item user_basic"><p class="nav-link">
									<c:out value="${loginMember.memNick }" />
								</p></li>
						</c:if>
						<c:if test="${loginMember.memManagerYn eq 'Y' }">
							<li class="nav-item user_manager"><p class="nav-link">
									<c:out value="${loginMember.memNick }" />
								</p></li>
						</c:if>
						<li class="nav-item"><a class="nav-link"
							onclick="location.replace('${path}/member/logout');">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${path }/mypage/orderStatus">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${path }/order/basket?memNo=${loginMember.memNo}"> <svg
									class="header_icon" width="20" height="20" viewBox="0 0 24 24"
									stroke="currentColor" fill="none" stroke-linejoin="round"
									stroke-width="2">
                    				<path stroke-linecap="round"
										d="M4 5h18l-2.6 10.5a2 2 0 0 1-2 1.5H8.6a2 2 0 0 1-2-1.5L4 5zm4 15.5a1.5 1.5 0 1 1 3 0 1.5 1.5 0 1 1-3 0zm7 0a1.5 1.5 0 1 1 3 0 1.5 1.5 0 1 1-3 0z"></path>
                    				<path d="M1 2h3v3"></path></svg>
						</a></li>
					</c:if>
					<li class="nav-item"><a class="nav-link" data-toggle="modal"
						data-target="#searchModal"> <svg class="header_icon"
								width="20" height="20" viewBox="0 0 24 24" stroke="currentColor"
								fill="none" stroke-width="2" preserveAspectRatio="xMidYMid meet">
                    			<path d="M22 22l-5-5"></path>
                    			<circle cx="11" cy="11" r="8"></circle>
                    		</svg>
					</a></li>
				</ul>
			</div>
			<div id="logo-wrap" class="">
				<a href="${path }"><img id="logo"
					class="img-responsive center-block"
					src="${path }/resources/images/springAgainLogo.png" alt="mainLogo"></a>
			</div>
			<div id="menuNav" class="dropmenu" style="margin-top: 22px;">
				<nav>
					<ul id="menu_ul" class="nav justify-content-center pt-3">
						<li class="nav-item"><a class="nav-link"
							href="${path }/intro/moveIntro">다시:봄 소개</a></li>
						<li class="nav-item dropdown"><a id="menuNav-product"
							class="nav-link" href="${path }/product/productAll">제품</a>
							<ul class="">
								<li><a class="" href="${path }/product/productAll">전체제품</a></li>
								<li><a class="" href="${path }/product/food">식품</a></li>
								<li><a class="" href="${path }/product/stuff">잡화</a></li>
								<li><a class="" href="${path }/product/kitchen">주방</a></li>
								<li><a class="" href="${path }/product/bathroom">욕실</a></li>
								<li><a class="" href="${path }/product/woman">여성용품</a></li>
								<li><a class="" href="${path }/product/pet">반려동물</a></li>
								<li><a class="" href="${path }/product/sale">할인상품</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link"
							href="${path }/community/communityList">커뮤니티</a> <c:if
								test="${loginMember == null }">

							</c:if></li>
						<li class="nav-item"><a class="nav-link" href="#">게시판</a>
							<ul class="">
								<li><a class="" href="${path }/notice/noticeList">공지사항</a></li>
								<li><a class="" href="${path }/faq/faqList">자주묻는질문</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a id="menuNav-admin"
							class="nav-link" href="${path }/admin/memberList">관리자페이지</a>

							<ul class="">
								<li><a class="" href="${path }/admin/memberList">회원관리</a></li>
								<li><a class="" href="${path }/admin/moveProduct">제품관리</a></li>
								<li><a class="" href="${path }/admin/order">주문관리</a></li>
								<li><a class="" href="${path }/admin/qnaList">1:1문의 관리</a></li>
								<li><a class="" href="${path }/admin/moveEvent">이벤트관리</a></li>
								<li><a class="" href="${path }/admin/moveMainBanners">메인관리</a></li>

							</ul></li>
					</ul>
				</nav>
			</div>

			<script>
                $(function(){
                    $(".dropmenu ul li").hover(function(){
                       $(this).find("ul").stop().fadeToggle(300);
                    });
                })

            </script>
		</div>
	</header>

	<!--모달 회원가입 -->
	<div class="springHeader">

		<!-- The Modal -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<div class="logo-box">
							<img class="logoimg"
								src="${path }/resources/images/springAgainLogo.png"
								alt="mainLogo">
							<h4 class="modal-title">회원가입</h4>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							X</button>
					</div>

					<!-- Modal body -->
					<form action="${path}/member/enrollMember" method="post">
						<div class="modal-body">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="닉네임"
									name="nick" id="memNick" required /> <label
									class="guide nickOk">멋진 닉네임이네요.</label> <label
									class="guide nickError">사용할 수 없는 닉네임입니다.</label> <label
									class="guide nickError2">닉네임은 한글,영문,숫자만 가능합니다.</label>

							</div>
							<div class="form-group">
								<input type="email" class="form-control" placeholder="이메일주소"
									name="email" id="memEmail" required />
								<label class="guide emailOk">GOOD</label> <label
									class="guide emailError">이미 가입된 이메일입니다.</label> <label
									class="guide emailError2">올바른 이메일 형식이 아닙니다.</label>
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호"
									name="password" id="memPw" required /> <label
									class="guide pw">영문,숫자,특수문자 조합 8자 이상 16자 이하로 입력해주세요.</label> <label
									class="guide pwOk">GOOD</label>
							</div>
							<div class="form-group form-check">
								<label class="form-check-label"> <input
									class="form-check-input" type="checkbox" required /> 다시:봄 이용 약관
									및 개인정보 취급방침에 대한 내용을 모두 <br /> 확인하였으며, 이에 동의합니다.
								</label>
							</div>
							<button type="submit" class="btn btn-success btn-block"
								onclick="return fn_signUp();">회원가입</button>
						</div>

						<!-- Modal footer -->
						<div class="social-container">
							<p>소셜 계정으로 간편하게 로그인 하세요 !</p>
							<div class="row">
								<div class="col">구글</div>
								<div class="col">카카오</div>
								<div class="col">네이버</div>
							</div>
							<br />
							<p class="p-class">이미 회원이신가요?</p>
							<a class="login-link" data-toggle="modal"
								data-target="#loginModal" data-dismiss="modal">
								로그인 하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!--로그인창  -->
		<!-- The Modal -->
		<div class="modal fade" id="loginModal">

			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<div class="logo-box">
							<img class="logoimg"
								src="${path }/resources/images/springAgainLogo.png"
								alt="mainLogo">
							<h4 class="modal-title">로그인</h4>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							X</button>
					</div>

					<!-- Modal body -->
					<form action="${path}/member/loginMember" method="post">
						<div class="modal-body">
							<div class="form-group">

								<input type="email" class="form-control" placeholder="이메일주소"
									name="email" id="loginEmail" required
									value="${cookie.saveId.value }" />
								<label class="login emailSize">이메일을 입력해주세요.</label> <label
									class="login emailOk">GOOD</label> <label
									class="login emailError">올바른 이메일 형식이 아닙니다.</label>

							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호"
									name="password" id="loginPw" required /> <label
									class="login pw">영문,숫자,특수문자 조합 8자 이상 16자 이하로 입력해주세요.</label> <label
									class="login pwOk">GOOD</label>
							</div>
							<div class="form-group form-check">
								<input class="form-check-input" type="checkbox" name="saveId"
									<c:if test="${cookie.saveId.value ne null}">checked</c:if> />
								ID저장
							</div>
							<button type="submit" class="btn btn-success btn-block">
								로그인</button>
						</div>

						<!-- Modal footer -->
						<div class="social-container">
							<p>소셜 계정으로 간편하게 로그인 하세요 !</p>
							<div class="row">
								<div class="col">구글</div>
								<div class="col">카카오</div>
								<div class="col">네이버</div>
							</div>
							<br /> <a class="lostPwd" data-toggle="modal"
								data-target="#pwModal" data-dismiss="modal">비밀번호를 잊어 버렸어요.</a>
							<p class="p-class">아직 회원이 아니신가요?</p>
							<a href="#" class="signUp" data-toggle="modal"
								data-target="#myModal" data-dismiss="modal">회원
								가입하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!--비밀번호 모달  -->
		<div class="modal fade" id="pwModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<div class="logo-box">
							<img class="logoimg"
								src="${path }/resources/images/springAgainLogo.png"
								alt="mainLogo">
							<h4 class="modal-title">비밀번호 찾기</h4>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							X</button>
					</div>

					<!-- Modal body -->

					<div class="info">
						<p class="p-info">
							가입한 이메일 주소로 인증번호를 알려드립니다. <br /> 인증 확인 후, 새비밀번호를 설정합니다.
						</p>
					</div>
					<div class="modal-body">
						<input type="email" class="form-control" placeholder="이메일주소"
							name="email" id="email-find" required /> <input
							type="hidden" id="oriCode" name="oriCode" value="${veriCode}">

						<button type="button" class="btn btn-success btn-block"
							id="emailSend">이메일발송</button>

						<input type="text" class="form-control" placeholder="인증번호"
							id="verification" name="code" /> <label
							for="email">ajax 인증 시간:4분 59초</label>
						<div class="row">
							<div class="col">
								<button type="button" class="btn btn-success btn-block"
									data-toggle="modal" data-target="" data-dismiss="modal"
									id="confirmBtn">인증확인</button>
							</div>
							<div class="col">
								<button type="submit" class="btn btn-success btn-block" onclick=>
									재전송</button>
							</div>
						</div>
					</div>


					<!-- Modal footer -->
					<div class="social-container">
						<p class="p-class">비밀번호가 기억나셨다고요?</p>
						<a class="login-link" data-toggle="modal"
							data-target="#loginModal" data-dismiss="modal">로그인
							하기</a>
					</div>
				</div>
			</div>
		</div>
		<!--비밀번호 재설정  -->
		<div class="modal fade" id="resetModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<div class="logo-box">
							<img class="logoimg"
								src="${path }/resources/images/springAgainLogo.png"
								alt="mainLogo">
							<h4 class="modal-title">비밀번호 재설정</h4>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							X</button>
					</div>

					<!-- Modal body -->
					<div class="info">
						<p class="p-info">
							새로운 비밀번호를 설정해주세요. <br />

						</p>
					</div>
					<form action="" method="">
						<div class="modal-body">
							<div class="form-group">
								<input type="password" class="form-control" placeholder="새 비밀번호"
									id="pwd" /> <label for="email">ajax
									정규표현식?? </label>
							</div>
							<div class="form-group">
								<input type="password" class="form-control"
									placeholder="새 비밀번호 확인" id="pwdCheck" />
								<label for="pwd">ajax 입력한 새
									비밀번호와 일치여부. </label>
							</div>
							<button type="submit" class="btn btn-success btn-block">
								재설정 완료</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--container div 모달끝  -->

	<!-- 검색모달 -->
	<div id="search-container">
		<!-- The Modal -->
		<div class="modal fade" id="searchModal">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">

					<!-- Modal body -->
					<div class="modal-body">
						<span>검색</span> <input type="text" placeholder="검색어를 입력하세요"
							class="col-xl-10 search_input">
					</div>

				</div>
			</div>
		</div>

	</div>
	<!-- 검색모달 종료  -->

	<script type="text/javascript">

 
 $(function(){
	 $(".guide").hide();
	 $(".login").hide();

	 //닉네임중복체크 가이드
	   $("#memNick").keyup(e=>{
		  const nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
	      const memNick=$(e.target).val().trim();

	      if(memNick.length<2){
	    	  $(".guide").hide();
	    	  return;
	      }else{ 
	    	  $.ajax({
	   	         url:"${path}/member/checkDuplicateNick",
	   	         data:{memNick:memNick},
	   	         success:data=>{
	   	            if(data===true){
	   	            	if(!nickReg.test(memNick)){
		  	            	$(".guide.nickError2").show();
		  	            	$(".guide.nickError").hide();
		  	            	$(".guide.nickOk").hide(); 
		  	            }else{
		  	            	$(".guide.nickError2").hide();
		  	            	$(".guide.nickError").hide();
		    	            $(".guide.nickOk").show(); 
		  	            }
	   	            }else{
	   	               $(".guide.nickError2").hide();
	   	               $(".guide.nickError").show();
	   	               $(".guide.nickOk").hide();
	   	            }
	   	         }
		   	  });
	      }
	   }); 
	 //이메일 중복체크
	 $("#memEmail").keyup(e=>{
		const emailReg= /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		const memEmail=$(e.target).val().trim();
		
		if(memEmail.length<2){
	    	  $(".guide").hide();
	    	  return;
		}else{
			$.ajax({
	   	         url:"${path}/member/checkDuplicateEmail",
	   	         data:{memEmail:memEmail},
	   	         success:data=>{
	   	            if(data===true){
	   	            	if(!emailReg.test(memEmail)){
		  	            	$(".guide.emailError2").show();
		  	            	$(".guide.emailError").hide();
		  	            	$(".guide.emailOk").hide(); 
		  	            }else{
		  	            	$(".guide.emailError2").hide();
		  	            	$(".guide.emailError").hide();
		    	            $(".guide.emailOk").show(); 
		  	            }
	   	            }else{
	   	               $(".guide.emailError2").hide();
	   	               $(".guide.emailError").show();
	   	               $(".guide.emailOk").hide();
	   	            }  
	   	         }
		   	  });
		}
	 })
	 

	   //비밀번호 유효성검사
	   $("#memPw").keyup(e=>{
	      $(".guide.pw").show();
	      var memPwd=$("#memPw").val().trim();
	      var pwReg=/^.*(?=^.{8,15})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%%^&*()]).*$/;
	      if(pwReg.test(memPwd)){
	         $(".guide.pw").hide();
	         $(".guide.pwOk").show(); 
	      }else{
	         $(".guide.pw").show();
	         $(".guide.pwOk").hide();
	               
	      }
	   });
	 
		//로그인 이메일 유효성
	   $("#loginEmail").keyup(e=>{
		   $(".login.emailSize").show();
	      const emailReg= /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		  const memEmail=$(e.target).val().trim();
		 
	      if(emailReg.test(memEmail)){
	         $(".login.emailOk").show();
	         $(".login.emailError").hide();
	         $(".login.emailSize").hide();
	 
	      }else{
	         $(".login.emailOk").hide();
	         $(".login.emailError").show();
	         $(".login.emailSize").hide();

	               
	      }
	   });
	
		 //로그인 비밀번호 유효성
	   $("#loginPw").keyup(e=>{
	      $(".login.pw").show();
	      var memPwd=$("#loginPw").val().trim();
	      var pwReg=/^.*(?=^.{8,15})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%%^&*()]).*$/;
	      if(pwReg.test(memPwd)){
	         $(".login.pw").hide();
	         $(".login.pwOk").show(); 
	      }else{
	         $(".login.pw").show();
	         $(".login.pwOk").hide();
	               
	      }
	   });
			
 })
 
 //회원가입전 확인사항 체크
function fn_signUp(){
   	var memPwd=$("#memPw").val().trim();
   	var memNick=$("#memNick").val().trim();
   	var pwReg=/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
   	var nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
	var spaceCk=/\s/;
   	
   	if(spaceCk.test($("#memPw").val())){
   		swal("비밀번호에 띄어쓰기는 하실수 없습니다.");
   		return false;
   	}
	
   	if(spaceCk.test($("#memNick").val())){
   		swal("닉네임에 띄어쓰기는 하실수 없습니다.");
   		return false;
   	}
   	if(memNick.length>0){
	   var flag=true;
   	   if(!nickReg.test(memNick)){
   		 swal("닉네임 양식이 올바르지 않습니다.영문,숫자,한글로만 2자이상 10자이하로 입력해주세요.");  
   		 flag=false;
   	   }
	   $.ajax({
	       url:"${path}/member/checkDuplicateNick",
	       data:{memNick:memNick},
	       async:false, 
	       success:data=>{
	          if(data===false){
	             swal("닉네임이 중복됩니다. 확인해주세요");
	             flag=data;
	          }
	       }   
	    });
	    return flag;
	}

 
}
 
 //이메일 전송
 	 $("#emailSend").click(e=>{
 		 const email=$("#email-find").val().trim();
 		 if(email==null){
 			 swal('이메일을 입력해주세요.')
 		 }
		 $.ajax({
			 url:"${path}/email/auth",
			 data:{email,email},
			 type:"post",
			 success:data=> {
				 if(data!=0){
					 swal('인증번호를 발송하였습니다.');
					 console.log(data);
				 }else{
					 swal('가입이력이 없는 이메일입니다.');
				 }
			 }
		 });
	 }); 

 //인증확인
  	$("#confirmBtn").click(e=>{
 		const code=$("#verification").val().trim();
 		$.ajax({
 			url:"${path}/email/confirm",
 			data:{"code":code},
 			type:"post",
 			success:data=>{
 				if(data===true){
 					console(code);
 	 				console(data);
 	 				$("confirmBtn").attr("data-target","#resetModal");
 				}else{
 					console(data);
 				}
 				
 			}
 		});
 	}); 

 </script>