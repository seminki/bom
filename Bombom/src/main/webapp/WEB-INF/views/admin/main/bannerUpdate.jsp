<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/*페이지 타이틀*/
.page-title {
	margin-bottom: 3%;
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
	<jsp:param name="title" value="" />
</jsp:include>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">배너수정</h3>
			<div id="bannerFrm">
				<form action="${path }/admin/updateBanner" method="post"
					name="insertBannerFrm" enctype="multipart/form-data">
					<div class="term">
						<label for="pdtNo">연관상품선택</label>
						<select name="pdtNo" id="pdtNo"	class="form-control" required>
							<option disabled>${bannerOne.pdtNo}/${bannerOne.pdtName }</option>
							<c:forEach items="${list }" var="p">
								<option value="${p.pdtNo }">${p.pdtNo }/${p.pdtName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="term">
						<label for="title">타이틀입력</label>
						<textarea id="title" name="bannerTitle" rows="3"
							style="resize: none;" class="form-control"
							placeholder="배너위에 노출시킬 타이틀을 입력해주세요" required>${bannerOne.bannerTitle }</textarea>
					</div>
					<div class="term">
						<label for="subTitle">이동시킬 서브타이틀 입력</label>
						<textarea id="subTitle" name="bannerSubtitle" rows="3"
							class="form-control" style="resize: none;"
							placeholder="배너위에 노출시킬 서브타이틀을 입력해주세요."
							required>${bannerOne.bannerSubtitle }</textarea>
					</div>
					<div class="term">
						<label for="upFile">노출시킬 배너 이미지선택</label>
						<input type="file"name="upload" id="upFile" class="form-control" value="${bannerOne.bannerThumb }" required>
						<label class="custom-file-label" for="upFile">${bannerOne.bannerThumb }</label>
					</div>
					
					<input type="hidden" value="${bannerOne.bannerNo }" name="bannerNo">
					<input type="hidden" name="pastThumb" value="${bannerOne.bannerThumb }">
					
					<div style="text-align: center;" class="term">
						<button id="insertBanner" type="submit"
							class="btn btn-outline-success">배너등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	//파일 선택하면 파일input의 레이블이 파일이름으로 바뀜
	$(function() {
		$('[name=upload]').on("change", function() {
			var filename = $(this).prop('files')[0].name;
			$(this).next(".custom-file-label").html(filename);
		});
	})
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />


