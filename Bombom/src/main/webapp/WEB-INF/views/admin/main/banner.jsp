<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path }/resources/css/main/bannerPage.css">

<style>
/*페이지 타이틀*/
.page-title {
	margin-bottom: 3%;
}
/*상단 버튼과 셀렉트 박스 정렬*/
.btns-category {
	display: flex;
	justify-content: space-between;
}
/*선택삭제 버튼*/
#selectDel {
	margin-left: 5px;
}

#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
}

#admin-container {
	min-width: 800px;
	width: 100%;
	padding-right: 100px;
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이벤트" />
</jsp:include>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">메인관리</h3>
			<hr>
			<!-- 메인 이벤트 배너 관리 -->
			<div id="slide_banner">
				<h5>슬라이드 배너 관리</h5>
				<div class="btns-category mb-2">
					<!-- 전체 선택, 선택 삭제 버튼 -->
					<div class="buttons">
						<button class="btn btn-outline-success" id="selectAll"
							onclick="selectAll();">전체 선택</button>
						<button class="btn btn-outline-success" id="selectDel" onclick="">선택
							삭제</button>
					</div>
				</div>

				<!-- 관리 테이블 -->
				<div id="event-table-wrap" class="post table-responsive-md">
					<table id="" class="table table-hover">
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>연관상품</th>
								<th>제목</th>
								<th>소제목</th>
								<th>이미지미리보기</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty list }">
								<thead>
									<tr>
										<td colspan="8" style="text-align: center;">존재하는 배너가
											없습니다.</td>
									</tr>
								</thead>
							</c:if>
							<c:forEach items="${list }" var="b">
								<tr>
									<td><input type="checkbox" name="check" value="check"></td>
									<td><p>
											<c:out value="${b.bannerNo }" />
										</p></td>
									<!-- 번호 -->
									<td><p>
											<c:out value="${b.pdtName }" />
										<p></td>
									<!-- 연관상품 -->
									<td style="white-space: pre;"><c:out
											value="${b.bannerTitle }" /></td>
									<!-- 제목 -->
									<td style="white-space: pre;"><c:out
											value="${b.bannerSubtitle }" /></td>
									<!-- 소제목 -->
									<!-- 이미지미리보기 -->
									<td><img class="image_viewer"
										src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_attach2.gif">
										<span class="img_span"
										style="position: absolute; display: none;"> <img
											src="${path }/resources/images/main/banner/${b.bannerThumb}"
											height="80">
									</span></td>
									<td><button id="banner-update"
											class="btn btn-sm btn-outline-secondary"
											onclick="fn_update('${b.bannerNo}');">수정</button></td>
									<td><button id="banner-delete"
											class="btn btn-sm btn-outline-danger"
											onclick="fn_delete('${b.bannerNo}');">삭제</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<button class="btn btn-outline-success" id=""
					onclick="location.href='${path}/admin/moveInsertBanner'">배너
					등록</button>
			</div>
			<div id="page-bar">${pageBar }</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	$(".image_viewer").hover(e=> {
		$(e.target).next().css("display","inline-block");
	}, function(){
	  	$(".img_span").not(this).css("display","none");
	}); 
	
	var checkAll = 'false';

	function selectAll() {
		let items = document.getElementsByName("check");
	
		if (checkAll == 'false') {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = true;
			}
			checkAll = "true";
		} else {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = false;
			}
			checkAll = "false";
		}
	}
	
	//삭제버튼 구현
	function fn_delete(bannerNo){
		var url = "${path}/admin/deleteBanner";
		var no = { bannerNo:bannerNo };
		var ck = confirm("정말로 삭제하시겠습니까?");
		if(ck){
			window.location = url+'?'+$.param(no);
		}
	}
	
	//수정하기버튼 구현
	function fn_update(bannerNo){
		var url = "${path}/admin/moveBannerUpdate";
		var no = {bannerNo :bannerNo };
		window.location = url+'?'+$.param(no);
	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />


