<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:set var="totalPdtPrice" value="0" />
<c:set var="totalSale" value="0"/>
<c:set var="totalPrice" value="0"/>
<c:forEach items="${list}" var="l">
	
	
	<c:set var="totalPdtPrice" value="${totalPdtPrice+ (l.inbasQty * l.pdtPrice)}"/>
	
	
	<c:if test="${l.salePer != 0 }">
		<!-- 옵션값이 없는경우 -->
		<c:if test="${empty l.pdtOptionNo }">
			<c:set var="totalSale" value="${totalSale+((l.pdtPrice * l.salePer/100))}"/>
		</c:if>
		<!-- 옵션값이 있는경우 -->
		<c:if test="${not empty l.pdtOptionNo }">
			<c:set var="totalSale" value="${totalSale+((l.pdtPrice + l.pdtOptionAddprice) * l.salePer/100)}"/>
		</c:if>
	</c:if>
	<!-- 옵션값 없는 상품값합하기 -->
	<c:if test="${empty l.pdtOptionNo }">
		<c:set var="totalPrice" value="${totalPrice + (l.inbasQty * (l.pdtPrice - (l.pdtPrice * l.salePer/100)))}" />
	</c:if>
	<!-- 옵션값 있는 상품값합하기 -->
	<c:if test="${not empty l.pdtOptionNo }">
		<c:set var="totalPrice" value="${totalPrice + (l.inbasQty * ((l.pdtPrice+ l.pdtOptionAddprice)
							 - ((l.pdtPrice+ l.pdtOptionAddprice) * l.salePer/100)))}" />
	</c:if>
	<c:set var="basketNo" value="${l.basketNo }"/>
</c:forEach>

<!-- icon -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="Welcome springAgain" />
</jsp:include>

<!-- 따라오는 div.js -->
<script src="${path }/resources/js/jquery.scrollfollow.js"></script>
<script src="${path }/resources/js/basket.js"></script>
<link rel="stylesheet" href="${path }/resources/css/order/memberBasket.css"/>

<script>
	//움직이는 사이드바
	$(document).ready(function() {
		$(".basket_sidebar").scrollFollow({
			speed : 1000, // 움직이는 속도
			offset : 150
		// 웹페이지 상단에서 부터의 거리
		});
	});
</script>

<section id="container" class="container">
	<div class="basket_header">
		<h1>주문하기</h1>
	</div>
	<div class="basket_container_wrap">
			<div class=" col-8">
				<div id="basket-container" class="media-body">
				<form name="basketFrm" id="basketFrm" action="${path}/order/doOrder">
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 40%;">선택한 상품</th>
							<th style="width: 20%;">수량</th>
							<th style="width: 20%;">가격</th>
							<th style="width: 15%;">할인</th>
							<th style="width: 5%;"></th><!-- 삭제 -->
						</tr>
					</thead>
						<tbody>
							<c:forEach items="${list }" var="b">
							<tr>
							
							<td>
							<!-- 상품보여주기 -->
							<div class="show_pdt-wrap">
								<a href="${path }/product/productOne?pdtNo=${b.pdtNo}" class="d-flex">
								<!-- 제품썸네일 -->
								<c:forTokens items="${b.pdtThumbImage}" var="th" delims="," varStatus="vs">
									<c:if test="${vs.first }">
										<img src="${path}/resources/upload/product/${th}"
											class="img-fluid" style="width:80px; height: 80px; margin: 0 15px 0 0;">
									</c:if>
								</c:forTokens>
								<!-- 제품명 -->
								<div class="pdtName_p">
								<p>
									<c:if test="${empty b.pdtOptionNo }"> <!-- 옵션 없는경우 -->
										<div class="pName"><c:out value="${b.pdtName }" /></div>
										<div class="pPrice"><fmt:formatNumber value="${b.pdtPrice}" pattern="#,###,###" />원</div>
									</c:if>	
									
									<c:if test="${not empty b.pdtOptionNo }"><!-- 옵션 있는경우 -->
										<div class="pName"><c:out value="${b.pdtName }" /></div>
										<div><c:out value="${b.pdtOptionContent }" /></div>
										<div class="pPrice"><fmt:formatNumber value="${b.pdtPrice + b.pdtOptionAddprice}" pattern="#,###,###" />원</div>
									</c:if>	
									
								</p>
								</div>
								</a>
							</div>
							<input type="hidden" class="pNo" name="pdtNo" value="${b.pdtNo }" > 
							<input type="hidden" class="bNo" name="basketNo" value="${b.basketNo }">
							</td>
							
							<!-- 수량 -->
							<td>
								<div class="input_number_wrap option-count-input form-number show_pdt-wrap">
									<button  class="minus form-number_control" type="button" onclick="fn_minus('${b.inbasQty}','${b.basketNo }','${b.pdtNo}','${b.pdtOptionNo }');"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M 7 11.5 h 10 v 1 H 7 Z"></path></svg></button>
									
									<input type="text" name="inbasQty" min="1"class="qty form-control " value="${b.inbasQty }" style="width: 80px; text-align: center;" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' />
									
									<button  class="plus form-number_control" type="button" onclick="fn_plus('${b.inbasQty}','${b.basketNo }','${b.pdtNo}','${b.pdtOptionNo }');"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M 11.5 11.5 V 6 h 1 v 5.5 H 18 v 1 h -5.5 V 18 h -1 v -5.5 H 6 v -1 h 5.5 Z"></path></svg></button>
								</div>
							</td>
							
							<!-- 가격 -->
							<td>
								<div class="pdtOnePrice show_pdt-wrap">
									<c:if test="${not empty b.pdtOptionNo }">
										<i class="sumPrice"><fmt:formatNumber 
											value="${b.salePer != 0? b.inbasQty* ((b.pdtPrice + b.pdtOptionAddprice)-((b.pdtPrice+b.pdtOptionAddprice)*(b.salePer/100))) : b.inbasQty*(b.pdtPrice + b.pdtOptionAddprice)}" 
											pattern="#,###,###" /></i>원
									</c:if>
									<c:if test="${empty b.pdtOptionNo }">
										<i class="sumPrice"><fmt:formatNumber 
											value="${b.salePer != 0? b.inbasQty*( b.pdtPrice-(b.pdtPrice*(b.salePer/100)) ): b.inbasQty*b.pdtPrice}" 
											pattern="#,###,###" /></i>원
									</c:if>
								</div>
							</td>
							
							
							<!-- 할인 -->
							<td><div class="show_pdt-wrap">
								<c:if test="${not empty b.pdtOptionNo }">
									<div>(-)<fmt:formatNumber pattern="#,###,###" value="${b.salePer != 0?(b.pdtPrice + b.pdtOptionAddprice)*(b.salePer/100) : 0 }" />원</div>
								</c:if>
								<c:if test="${empty b.pdtOptionNo }">
									<div>(-)<fmt:formatNumber pattern="#,###,###" value="${b.salePer != 0? b.pdtPrice*(b.salePer/100) : 0 }" />원</div>
								</c:if>
							</div></td>
							
							
							<!-- 삭제버튼 -->
							<td class="carted-product">
								<button type="button" class="remove carted-product__delete" 
									onclick="fn_delete('${b.pdtNo}','${b.basketNo }','${b.memNo }','${b.pdtOptionNo }');">
                         				<svg fill="currentColor" style="width: 15px;height:15px;"><path fill-rule="nonzero"
											d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path></svg>
								</button>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				</form>
				</div><!-- /basket-container -->
			</div><!-- /basket-container-wrap -->

			<!-- 따라다니는 사이드 바 영역-->
			<div class="col-4">
				<!-- 따라오는 사이드바 -->
				<div class="basket_sidebar">
					<div>
						<p>상품금액 <span id="plusPrice"><fmt:formatNumber pattern="#,###,###" value="${totalPdtPrice }"/></span>원</p>
					</div>
					<div>
						<p>할인금액 <span id="salePrice" style="color: red;font-weight: 800;">(-)<fmt:formatNumber pattern="#,###,###" value="${totalSale }"/></span>원</p>
					</div>
					<hr>
					<div>
						<p>결제금액 <span id="totalPrice" style="font-weight: 800;font-size: 18px;"><fmt:formatNumber pattern="#,###,###" value="${totalPrice }"/></span>원</p>
					</div>
					<!-- 결제하기 -->
					<div class="btn-contain">
						<c:if test="${not empty list }">
							<button form="basketFrm" class="btn btn-outline-success btn-block">결제하기</button>
						</c:if>
						<c:if test="${empty list }">
							<button form="basketFrm" class="btn btn-outline-success btn-block" disabled="disabled">결제하기</button>
						</c:if>
					</div>
				</div>
			</div>
		
	</div>
</section>

<script type="text/javascript">

	//select box ID로 접근하여 선택된 값 읽기
	//$("#셀렉트박스ID option:selected").val();
	var prices = $(".pdtOnePrice").html(); //상품가격(할인됐으면 할인적용)
	var pNos = $(".pNo"); //상품번호
	var bNos = $(".bNo"); //장바구니번호
	var opNos = $(".opNo"); //상품옵션번호
	var removes = $(".remove"); //삭제버튼
	
	
	
	//장바구니 상품삭제하기
	function fn_delete(pdtNo, basketNo,memNo,pdtOptionNo){
		var no = {"pdtNo":pdtNo, "basketNo":basketNo,"memNo":memNo, "pdtOptionNo":pdtOptionNo};
		var url = "${path}/order/deleteBasketOne";
		var ck = confirm("삭제하시겠습니까?");
		if(ck){
			window.location = url + "?" + $.param(no);
		}
	}
	
	
	
	
	var qtys = $(".qty"); //수량
	var pluss = $(".plus"); //+버튼
	var minuss = $(".minus"); //-버튼
	var sums = $(".sumPrice"); //가격
	
	//input text에서 수량조절했을때
	$(document).on("keyup",".qty",e=>{
		
	});
	
	
	//수량 +
	function fn_plus(qty,basketNo,pdtNo,pdtOptionNo){
		var inbasQty = {"inbasQty": qty, "calc":"+","basketNo":basketNo,
				"pdtNo":pdtNo,"pdtOptionNo":pdtOptionNo };	
		var url = "${path}/order/updateQty";
		window.location = url + "?" + $.param(inbasQty);
	}
	
	//수량 - 
	function fn_minus(qty,basketNo,pdtNo,pdtOptionNo){
		//1개 이하로 내려가면 경고 //...왜 0개도 되지..ㅠㅠ
		if(qty < 1){
			alert("1개 이상의 갯수를 선택하셔야 합니다.");
			//return;
		}else{
			var inbasQty = {"inbasQty": qty, "calc":"-","basketNo":basketNo,
					"pdtNo":pdtNo,"pdtOptionNo":pdtOptionNo};	
			var url = "${path}/order/updateQty";
			window.location = url + "?" + $.param(inbasQty);
		}
	}
	
	
	
</script>
<style>

</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />