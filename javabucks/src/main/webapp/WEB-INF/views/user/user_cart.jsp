<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
			<form name="" action="user_paynow" method="post">
				<c:if test="${not empty cart}">
				<div class="toolbar_box">
					<label> <input type="checkbox" onclick="toggleCheckboxes(this); updateCheckedCount(); OrderButton()">전체 선택</label>			
					<div class="btn_box">
						<button class="font_green" type="button" onclick="deleteCheck('each');">선택삭제</button>
						<button class="font_gray" type="button" onclick="deleteCheck('all')">전체삭제</button>
					</div>
				</div>
				</c:if>
				<ul class="cart_list">
					<c:if test="${empty cart}">	
					음료/푸드 장바구니가 비어있습니다.<br>	
					<button class="font_green" type="button" onclick="window.location.href='/user_store'">메뉴 담으러 가기</button>					
					</c:if>
					<c:if test="${not empty cart}">
					<c:forEach var="dto" items="${cart}">
						<li class="cart_item">
							<div class="top_box">
								<label> <input type="checkbox" class="item-checkbox"
									onclick="updateCheckedCount(); OrderButton()" name="${dto.cartNum}" value="">
								</label>
								<div class="img_box">
									<img src="../images/icons/close.png" alt="" name="delete-${dto.cartNum}" onclick="deleteCheck('xbox', this)">
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
											<c:when
												test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'I'}">
												<span>ICE |</span>
											</c:when>
											<c:when
												test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'H'}">
												<span>HOT|</span>
											</c:when>
											<c:otherwise>
												<span></span>
											</c:otherwise>
										</c:choose>
										<span>${dto.cupType}</span> | <span><fmt:formatNumber value="${dto.menuprice}" pattern="###,###" /></span>
									</p>
									<ul class="opt_list font_gray">
										<li class="opt_item"><span>${dto.cupType}</span><span>${dto.cupPrice}</span></li>
										<li class="opt_item"><span>${dto.shotType} X
												${dto.shotCount}</span><span>${dto.shotPrice * dto.shotCount}</span></li>
										<c:choose>
											<c:when test="${dto.syrupCount != 0}">
												<li class="opt_item"><span>${dto.syrupType} X
														${dto.syrupCount}</span> <span>${dto.syrupPrice * dto.syrupCount}</span>
												</li>
											</c:when>
										</c:choose>
										<li class="opt_item"><span>얼음 ${dto.iceType}</span><span>${dto.icePrice}</span></li>
										<li class="opt_item"><span>휘핑 ${dto.whipType}</span><span>${dto.whipPrice}</span></li>
										<li class="opt_item"><span>${dto.milkType}</span><span>${dto.milkPrice}</span></li>
									</ul>
									<div class="price_box">
										<div class="count_box">
											<div class="minus_btn img_box">
												<img src="../images/icons/minus.png" alt="감소 버튼"
													onclick="minus(${dto.cartNum}, ${dto.eachPrice})">
											</div>
											<label> <input type="text" id="${dto.cartNum}"
												name="order_number" value="${dto.cartCnt}" readonly>
												<input type="hidden" name="cartNum" value="${dto.cartNum}">
											</label>
											<div class="plus_btn img_box">
												<img src="../images/icons/plus.png" alt="증가 버튼"
													onclick="plus(${dto.cartNum}, ${dto.eachPrice})">
											</div>
										</div>
										<div class="total_box">
											<p id="price_${dto.cartNum}" class="each-totPrice">
												<fmt:formatNumber value="${dto.eachPrice * dto.cartCnt}" pattern="###,###" /> 원
											</p>
										</div>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
					</c:if>
				</ul>

				<div class="order_box">
					<div class="txt_box">
						<p class="txt_count">
							총 <span class="font_green" id="checkedCount">0</span>개/20개
						</p>
						<p class="txt_total" id="totalPrice"></p>
					</div>
					<div class="btn_box">
						<button type="submit" id="orderButton">주문하기</button>
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
       
       if (value < 1) value = 1; // 음수 방지
       input.value = value; // 값 적용
       // 가격 업데이트
       updatePrice(fieldId, value, unitPrice);
       calculateTotalPrice();
   }
   
   // 증가 버튼 클릭 시 호출되는 함수
   function plus(fieldId, unitPrice) {
       var input = document.getElementById(fieldId);
       var value = parseInt(input.value, 10); // 현재 값 가져오기
       
       value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
       value++; // 증가
       input.value = value; // 값 적용
       
       // 가격 업데이트
       updatePrice(fieldId, value, unitPrice);
       calculateTotalPrice();
   }
   
   function updatePrice(fieldId, value, unitPrice) {

       // 새로운 총 가격 계산
       var newTotalPrice = value * unitPrice;
       // 천 단위 콤마 추가하여 표시
       var formattedPrice = new Intl.NumberFormat().format(newTotalPrice);
       // 계산된 총 가격을 화면에 업데이트
       var totalPriceElement = document.getElementById('price_' + fieldId);
       totalPriceElement.innerText = formattedPrice + " 원";
   }
   
	// 총 금액 합계
   function calculateTotalPrice() {
       var totalPrice = 0;
       
       // 'item-price' 클래스가 부여된 모든 요소 가져오기
       var priceElements = document.getElementsByClassName('each-totPrice');
       
       // 모든 item-price 요소의 금액을 합산
       for (var i = 0; i < priceElements.length; i++) {
           // 금액에서 숫자만 추출
           var priceText = priceElements[i].innerText.replace(/[^0-9]/g, '');
           var price = parseInt(priceText, 10);
           totalPrice += price;
       }

       // 합산된 총 금액을 천 단위 콤마 포함하여 출력
       var totalPriceElement = document.getElementById('totalPrice');
       totalPriceElement.innerText = new Intl.NumberFormat().format(totalPrice) + " 원";
   }

   // 페이지 로드 시 또는 수량 변경 시 총합 계산
   window.onload = calculateTotalPrice;
      
   // 체크박스 전체선택
    function toggleCheckboxes(source) {
        // 모든 체크박스를 가져옵니다.
        const checkboxes = document.querySelectorAll('input[type="checkbox"].item-checkbox');
        
        // 체크박스의 상태를 "전체 선택" 체크박스의 상태와 맞춥니다.
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = source.checked;
        });      
      // 체크된 개수를 업데이트
       updateCheckedCount();
    }
   
   function updateCheckedCount() {
       // 모든 체크박스를 선택
       const checkboxes = document.querySelectorAll('.item-checkbox');
       
       // 체크된 체크박스의 개수 계산
       const checkedCount = Array.from(checkboxes).filter(checkbox => checkbox.checked).length;
       
       // 체크된 개수를 표시할 요소에 반영
       document.getElementById('checkedCount').textContent = checkedCount;
   }
   
   function deleteCheck(mode, element) {
	   // 장바구니번호 담을 배열 생성
	   var selectedCartNums = [];
	   // 선택메뉴 삭제
	   if (mode == 'each'){
		// 선택된 체크박스들에서 cartNum 값들을 수집   
       var checkboxes = document.querySelectorAll('.item-checkbox:checked');
       
       checkboxes.forEach(function(checkbox) {
           selectedCartNums.push(checkbox.name); // 체크박스 name 속성에 cartNum이 있음
       });

       if (selectedCartNums.length === 0) {
           alert("삭제할 메뉴를 선택해 주세요.");
           return;
       } 
       
			var userConfirmed = confirm("선택한 메뉴를 삭제하시겠습니까?");    	   
       }
	   // 전체메뉴 삭제
       if (mode == 'all'){
   			var userConfirmed = confirm("장바구니에 담긴 모든 메뉴를 삭제하시겠습니까?");    	   
       }
	   // x이미지 클릭시 삭제
	   if (mode == 'xbox'){
		  	var userConfirmed = confirm("선택한 메뉴를 삭제하시겠습니까?");
			// 이미지의 name 속성 값에서 cartNum 부분 추출
	        var cartNum = element.getAttribute('name').split('-')[1];
	        selectedCartNums.push(cartNum);	       	      
	   }
       
	   if (userConfirmed) {
	        
		$.ajax({
	        url: 'deleteCart',
	        type: 'POST',
	        contentType: "application/json",
	        data: JSON.stringify({
	        	cartNum: selectedCartNums,  // 배열로 전달
              eachOrAll: mode // 필요에 따라 이 값을 설정
          }),         
	        success: function(response) {
	            if (response.success) {
	                alert("선택하신 메뉴가 삭제되었습니다.");
	                window.location = "user_cart";
	            } else {			
	                alert("선택한 메뉴는 삭제가 불가합니다.");
	            }	
	        },
	        error: function() {
	            alert("서버 오류가 발생했습니다.");
	        }
	   	 });
		}
	}
   
   
   // [주문하기 버튼] 활성화 클래스 추가하기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   function OrderButton() {
	    // 모든 체크박스 선택
	    const checkboxes = document.querySelectorAll('.item-checkbox');	    
	    // 체크된 체크박스가 있는지 확인
	    const isAnyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);	    
	    // 주문하기 버튼 요소 선택
	    const orderButton = document.getElementById('orderButton');
	    
	    // 체크된 체크박스가 있으면 'visible' 클래스를 추가하고, 그렇지 않으면 'hidden' 클래스를 유지
	    if (isAnyChecked) {
	    	c
// 	        orderButton.classList.remove('hidden');
// 	        orderButton.classList.add('visible');
	    } else {
	    	
// 	        orderButton.classList.remove('visible');
// 	        orderButton.classList.add('hidden');
	    }
	}

</script>