<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/user.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../js/user.js"></script>
</head>
<body>
    <!-- s: content -->
    <section id="user_cart" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">장바구니</p>
            </div>

            <form name="" action="" method="post">
                <div class="toolbar_box">
                    <label>
                        <input type="checkbox" onclick="toggleCheckboxes(this)">전체 선택
                    </label>
                    <div class="btn_box"> 
                        <button class="font_green" type="button">선택삭제</button>
                        <button class="font_gray" type="button">전체삭제</button>
                    </div>
                </div>
                <ul class="cart_list">
                	<c:forEach var ="dto" items="${cart}">
                    <li class="cart_item">                    
                        <div class="top_box">
                            <label>
                                <input type="checkbox" class = "item-checkbox" name="" value="">
                            </label>
                            <div class="img_box">
                                <img src="../images/icons/close.png" alt="">
                            </div>
                        </div>
                        <div class="menu_info">
                            <div class="menu_img img_box">
                                <img src="upload_menuImages/${dto.menuimages}" alt="">
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">${dto.menuname}</p>
                                <p class="txt_opt font_gray">
                                <c:choose>
			                        <c:when test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'I'}">
			                            <span>ICE |</span>
			                        </c:when>
			                        <c:when test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'H'}">
			                            <span>HOT|</span>
			                        </c:when>
			                        <c:otherwise>
			                            <span></span>
			                        </c:otherwise>
                    			</c:choose>
                                <span>Tall</span> |<span> ${dto.menuprice}</span></p>
                                <ul class="opt_list font_gray">
                                    <li class="opt_item"><span>${dto.cupType}</span><span>${dto.cupPrice}</span></li>
        							<li class="opt_item"><span>${dto.shotType} X ${dto.shotCount}</span><span>${dto.shotPrice * dto.shotCount}</span></li>
        							<li class="opt_item"><span>${dto.syrupType} X ${dto.syrupCount}</span><span>${dto.syrupPrice * dto.syrupCount}</span></li>
        							<li class="opt_item"><span>얼음 ${dto.iceType}</span><span>${dto.icePrice}</span></li>
        							<li class="opt_item"><span>휘핑 ${dto.whipType}</span><span>${dto.whipPrice}</span></li>
        							<li class="opt_item"><span>${dto.milkType}</span><span>${dto.milkPrice}</span></li>
                                </ul>
                                <div class="price_box">
                                    <div class="count_box">
                                        <div class="minus_btn img_box">
                                            <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus(${dto.cartNum}, ${dto.totprice})">
                                        </div>
                                        <label>
                                            <input type="text" id= "${dto.cartNum}" name="order_number" value="${dto.cartCnt}" readonly>
                                        	<input type="hidden" name="${dto.cartNum}" value="${dto.cartNum}">
                                        </label>
                                        <div class="plus_btn img_box">
                                            <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus(${dto.cartNum}, ${dto.totprice})">
                                        </div>
                                    </div>
                                    <div class="total_box">
                                        <p id="${dto.cartNum}"><fmt:formatNumber value="${dto.totprice}" pattern="###,###"/> 원</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    </c:forEach>
                </ul>

                <div class="order_box">
                    <div class="txt_box">
                        <p class="txt_count">총 <span class="font_green">0</span>개/20개</p>
                        <p class="txt_total">0원</p>
                    </div>
                    <div class="btn_box">
                        <button type="submit">주문하기</button>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script>
	function minus(fieldId, unitPrice) {
	    var input = document.getElementById(fieldId);
	    var value = parseInt(input.value, 10); // 현재 값 가져오기
	    value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	    value--; // 감소
	    if (value < 0) value = 0; // 음수 방지
	    input.value = value; // 값 적용
		 // 가격 업데이트
	    updatePrice(fieldId, unitPrice, 0);
	}
	
	// 증가 버튼 클릭 시 호출되는 함수
	function plus(fieldId, unitPrice) {
	    var input = document.getElementById(fieldId);
	    var value = parseInt(input.value, 10); // 현재 값 가져오기
	    value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	    value++; // 증가
	    input.value = value; // 값 적용
		 // 가격 업데이트
	    updatePrice(fieldId, unitPrice, 0);
	}
		
    function toggleCheckboxes(source) {
        // 모든 체크박스를 가져옵니다.
        const checkboxes = document.querySelectorAll('input[type="checkbox"].item-checkbox');
        
        // 체크박스의 상태를 "전체 선택" 체크박스의 상태와 맞춥니다.
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = source.checked;
        });
    }
    
    function updatePrice(cartNum, unitPrice, change) {
        // 현재 수량 가져오기
        var quantityInput = document.getElementById(cartNum);
        var currentQuantity = parseInt(quantityInput.value);

        // 수량을 증가 또는 감소시킴
        var newQuantity = currentQuantity + change;
        
        // 수량이 1보다 작지 않도록 설정
        if (newQuantity < 1) return;

        // 업데이트된 수량을 input 필드에 설정
        quantityInput.value = newQuantity;

        // 새로운 총 가격 계산
        var newTotalPrice = unitPrice * newQuantity;

        // 천 단위 콤마 추가하여 표시
        var formattedPrice = new Intl.NumberFormat().format(newTotalPrice);

        // 계산된 총 가격을 화면에 업데이트
        var totalPriceElement = document.getElementById(cartNum);
        totalPriceElement.innerText = formattedPrice + " 원";
    }
    
    
</script>