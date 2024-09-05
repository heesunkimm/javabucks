<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="user_top.jsp"%>
	<!-- s: content -->
	<section id="user_cart" class="content">
		<div class="inner_wrap">
			<div class="tit_box">
				<p class="font_bold">장바구니</p>
			</div>
			<form name="" action="user_paynow" method="post">
				<input type="hidden" id="modeInput" name="modeInput" value="${modeInput}">
				<input type="hidden" id="bucksId" name="bucksId" value="${bucksId}">
				<input type="hidden" id="cart" name="cart" value="cart">
				<input type="hidden" id="pickup" name="pickup" value="${pickup}">
				<c:if test="${not empty cart}">
				<div class="toolbar_box">
					<label> <input type="checkbox" onclick="toggleCheckboxes(this); updateCheckedCount(); OrderButton()">전체 선택</label>			
					<div class="btn_box">
						<button class="font_green" type="button" onclick="deleteCheck('each')">선택삭제</button>
						<button class="font_gray" type="button" onclick="deleteCheck('all')">전체삭제</button>
					</div>
				</div>
				</c:if>
				<ul class="cart_list">
					<c:if test="${empty cart}">
					<li class=nolist>
						음료/푸드 장바구니가 비어있습니다.<br>
						<button class="font_green" type="button" onclick="window.location.href='/user_store'">메뉴 담으러 가기</button>
					</li>
					</c:if>
					<c:if test="${not empty cart}">
					<c:forEach var="dto" items="${cart}">
						<li class="cart_item">
							<div class="top_box">
								<label> 
									<input type="checkbox" class="item-checkbox" onclick="updateTotalPrice(); updateCheckedCount(); updateCheckboxesState(); OrderButton()" name="${dto.cartNum}" value="">
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
										<c:if test="${fn:substring(dto.menuCode, 0, 1) == 'B'}">
										<c:choose>
											<c:when
												test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'I'}">
												<span>ICE |</span>
											</c:when>
											<c:when
												test="${dto.menuCode != null && fn:length(dto.menuCode) >= 5 && fn:substring(dto.menuCode, 4, 5) == 'H'}">
												<span>HOT |</span>
											</c:when>
											<c:otherwise>
												<span></span>
											</c:otherwise>
										</c:choose>
										<span>${dto.cupType} | </span> 
										</c:if>
										<span><fmt:formatNumber value="${dto.menuprice}" pattern="###,###" /></span>
									</p>
									<ul class="opt_list font_gray">
										<c:if test="${fn:substring(dto.menuCode, 0, 1) == 'B'}">
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
										<c:if test="${not empty dto.iceType}">
											<li class="opt_item"><span>얼음 ${dto.iceType}</span><span>${dto.icePrice}</span></li>
										</c:if>
										<c:if test="${not empty dto.whipType}">
											<li class="opt_item"><span>휘핑 ${dto.whipType}</span><span>${dto.whipPrice}</span></li>
										</c:if>
										<c:if test="${not empty dto.milkType}">
											<li class="opt_item"><span>${dto.milkType}</span><span>${dto.milkPrice}</span></li>
										</c:if>
										</c:if>
									</ul>
									<div class="price_box">
										<div class="count_box">
											<div class="minus_btn img_box">
												<img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus(${dto.cartNum}, ${dto.eachPrice})">
											</div>
											<label> 
												<input type="text" id="${dto.cartNum}" name="order_number" value="${dto.cartCnt}" readonly>
												<input type="hidden" name="cartNum" value="${dto.cartNum}">
												<input type="hidden" name="cartCnt1" value="${dto.cartCnt}">
											</label>
											<div class="plus_btn img_box">
												<img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus(${dto.cartNum}, ${dto.eachPrice})">
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
	//총 금액 합계와 초기 체크박스 상태 설정
	window.onload = function() {
	    // 페이지 로드 시 총합 계산
	    calculateTotalPrice();
	    
	 	// 모든 체크박스를 가져옵니다.
	    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	    
	    // 모든 체크박스를 체크된 상태로 설정합니다.
	    checkboxes.forEach(function(checkbox) {
	        checkbox.checked = true;
	    });     
      	
	    // 선택된 개수 및 주문하기 버튼 상태 업데이트
	    updateCheckedCount();
	    OrderButton();
	};
	
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
       
       // input 요소의 value에서 값을 가져옵니다.
	   var cartCnt = value; // cartCnt는 감소된 수량
	   var cartNum = fieldId; // cartNum은 fieldId를 그대로 사용
       
       //ajax로 처리(실시간 db 업데이트)
       $.ajax({
           url: 'cartCountUpdate.ajax',
           type: 'POST',
           contentType: 'application/json',
           data: JSON.stringify({
        	   cartCnt: cartCnt, // 전송할 cartCnt 값
               cartNum: cartNum // 전송할 cartNum 값
           }),
           success: function(response) {
           	if (response > 0) {
               }
           },
           
           error: function(error) {
               console.error('AJAX 요청 중 오류 발생:', error);
               alert('요청 처리 중 오류가 발생했습니다.');
           }
       });
   }
   
   // 증가 버튼 클릭 시 호출되는 함수
   function plus(fieldId, unitPrice) {
       var input = document.getElementById(fieldId);
       var value = parseInt(input.value, 10); // 현재 값 가져오기
       
       value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
       
       // 최대값을 설정합니다.
       var maxQuantity = 20;
       
    	// 현재 값이 최대값보다 작을 경우에만 증가
       // 모든 메뉴의 수량을 합산합니다.
       var totalQuantity = 0;
       var allInputs = document.querySelectorAll('input[name="order_number"]');
       allInputs.forEach(function(input) {
           totalQuantity += parseInt(input.value, 10) || 0; // 각 입력값을 합산
       });

       if (totalQuantity < maxQuantity) {
           if (value < maxQuantity) {
               value++;
               input.value = value;
           } else {
               // 최대값에 도달한 경우 경고 메시지 표시
               alert('최대 20개까지 주문이 가능합니다.');
           }
       } else {
           // 총 수량이 최대값에 도달한 경우 경고 메시지 표시
           alert('최대 20개까지 주문이 가능합니다.');
       }
       
    	// input 요소의 value에서 값을 가져옵니다.
	   var cartCnt = value; // cartCnt는 감소된 수량
	   var cartNum = fieldId; // cartNum은 fieldId를 그대로 사용
       
       //ajax로 처리(실시간 db 업데이트)
       $.ajax({
           url: 'cartCountUpdate.ajax',
           type: 'POST',
           contentType: 'application/json',
           data: JSON.stringify({
        	   cartCnt: cartCnt, // 전송할 cartCnt 값
               cartNum: cartNum // 전송할 cartNum 값
           }),
           success: function(response) {
           	if (response > 0) {
               }
           },
           
           error: function(error) {
               console.error('AJAX 요청 중 오류 발생:', error);
               alert('요청 처리 중 오류가 발생했습니다.');
           }
       });
       
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
    	// 총합 가격 업데이트
       updateTotalPrice()
    	// 전체 선택 체크박스 상태 업데이트
       updateCheckboxesState();
    }
   
   	//모든 메뉴 체크박스의 상태를 감시하고, 전체 선택 체크박스의 상태를 업데이트
    function updateCheckboxesState() {
        // 모든 메뉴 체크박스와 전체 선택 체크박스 요소를 선택합니다.
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');
        const selectAllCheckbox = document.querySelector('input[type="checkbox"][onclick*="toggleCheckboxes(this)"]');

        // 모든 메뉴 체크박스 중 하나라도 체크가 해제된 경우, 전체 선택 체크박스도 해제합니다.
        const allChecked = Array.from(itemCheckboxes).every(checkbox => checkbox.checked);

        // 전체 선택 체크박스의 상태를 업데이트합니다.
        selectAllCheckbox.checked = allChecked;
    }
   
   	
   function updateCheckedCount() {
       // 모든 체크박스를 선택
       const checkboxes = document.querySelectorAll('.item-checkbox');
       
       // 체크된 체크박스의 개수 계산
       const checkedCount = Array.from(checkboxes).filter(checkbox => checkbox.checked).length;
       
       // 체크된 개수를 표시할 요소에 반영
       document.getElementById('checkedCount').textContent = checkedCount;
   }
   
   
   // 체크박스 체크한 것만 가격합산!
   function updateTotalPrice() {
	   var checkboxes = document.getElementsByClassName('item-checkbox');
       var totalCheckedPrice = 0;
       
       // 체크된 항목들의 가격을 합산
       for (var i = 0; i < checkboxes.length; i++) {
           if (checkboxes[i].checked) {
               var fieldId = checkboxes[i].getAttribute('name'); // cartNum 가져오기
               var priceElement = document.getElementById('price_' + fieldId); // 해당 항목의 가격 요소
               var priceText = priceElement.innerText.replace(/[^0-9]/g, ''); // 숫자만 추출
               var price = parseInt(priceText, 10); // 정수로 변환

               totalCheckedPrice += price; // 총합에 더하기
           }
       }

       // 합산된 총 금액을 천 단위 콤마 포함하여 출력
       var totalPriceElement = document.getElementById('totalPrice');
       totalPriceElement.innerText = new Intl.NumberFormat().format(totalCheckedPrice) + " 원";
   }
   
   function deleteCheck(AllorEach, element) {
	   // 장바구니번호 담을 배열 생성
	   var selectedCartNums = [];
	   // 선택메뉴 삭제
		   if (AllorEach == 'each'){
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
	       if (AllorEach == 'all'){
	    	   // 모든 체크박스를 선택
	    	    var allCheckboxes = document.querySelectorAll('.item-checkbox');
	    	    
	    	    // 체크박스 체크 후 확인 창 표시
	    	    allCheckboxes.forEach(function(checkbox) {
	    	        checkbox.checked = true; // 모든 체크박스 체크
	    	        selectedCartNums.push(checkbox.name); // 체크된 모든 체크박스의 cartNum 수집
	    	    });

	    	    // 체크박스 체크가 완료된 후 확인 창 표시
	    	    var userConfirmed = confirm("장바구니에 담긴 모든 메뉴를 삭제하시겠습니까?");  	   
	       }
		   // x이미지 클릭시 삭제
		   if (AllorEach == 'xbox'){
			  	var userConfirmed = confirm("선택한 메뉴를 삭제하시겠습니까?");
				// 이미지의 name 속성 값에서 cartNum 부분 추출
		        var cartNum = element.getAttribute('name').split('-')[1];
		        selectedCartNums.push(cartNum);	       	      
		   }
		   
	   var modeInput = document.getElementById("modeInput").value;
	   if (userConfirmed) {
		   
	   console.log(modeInput);
		$.ajax({
	        url: 'deleteCart',
	        type: 'POST',
	        contentType: "application/json",
	        data: JSON.stringify({
	        	cartNum: selectedCartNums,  // 배열로 전달
              eachOrAll: AllorEach, // 필요에 따라 이 값을 설정
              	pickup: pickup, // 배달인지 주문인지
            modeInput: modeInput
          }),         
	        success: function(response) {
	            if (response.success) {
	                alert("선택하신 메뉴가 삭제되었습니다.");
	                window.location = "user_cart?modeInput=" + encodeURIComponent(modeInput);
	            } else {			
	                alert("선택한 메뉴는 삭제가 불가합니다.");
	            }	
	        },
	        error: function() {
	            alert("서버 오류가 발생했습니다.");
	        }
	   	 });
		
	} else {
        // 사용자가 취소를 클릭한 경우 체크박스 해제
        allCheckboxes.forEach(function(checkbox) {
            checkbox.checked = false; // 모든 체크박스 해제
        });
        selectedCartNums = []; // 선택된 장바구니 번호 초기화
    }
}
   
   // 주문하기 버튼 눌렀을때 체크박스에 체크된 것만 데이터 보내기
   function submitCheckedItems(event) {
       // 기존의 hidden cartNum 요소를 모두 제거합니다.
       const form = document.querySelector('form[action="user_paynow"]');
       const existingInputs = form.querySelectorAll('input[name="cartNum"]');
       existingInputs.forEach(input => input.remove());

       // 체크된 체크박스에서 cartNum과 cartCnt 값을 수집하고 hidden input으로 추가합니다.
       const checkboxes = document.querySelectorAll('.item-checkbox:checked');

       // 체크된 항목이 없으면 경고창을 띄우고 폼 제출을 막습니다.
       if (checkboxes.length === 0) {
           alert("주문하실 메뉴를 선택해주세요.");
           event.preventDefault(); // 폼 제출을 막습니다.
           return; // 함수 종료
       }

       checkboxes.forEach(checkbox => {
           const cartNum = checkbox.name; // 체크박스의 name 속성에 cartNum이 들어 있습니다.
           const cartCnt = checkbox.closest('.cart_item').querySelector('input[name="order_number"]').value;
           
           // hidden input 생성 (cartNum)
           const hiddenInputNum = document.createElement('input');
           hiddenInputNum.type = 'hidden';
           hiddenInputNum.name = 'cartNum';
           hiddenInputNum.value = cartNum;

           // hidden input 생성 (cartCnt)
           const hiddenInputCnt = document.createElement('input');
           hiddenInputCnt.type = 'hidden';
           hiddenInputCnt.name = 'cartCnt';
           hiddenInputCnt.value = cartCnt;

           // form에 hidden input 추가
           form.appendChild(hiddenInputNum);
           form.appendChild(hiddenInputCnt);
       });

       // 체크박스가 선택된 경우에만 폼을 제출합니다.
       form.submit();
   }

   // 주문하기 버튼에 이벤트 리스너 추가
   const orderButton = document.querySelector('#orderButton'); // 버튼의 ID를 사용
   orderButton.addEventListener('click', function(event) {
       submitCheckedItems(event);
   });

   
   // [주문하기 버튼] 활성화 클래스 추가하기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   function OrderButton() {
	    // 모든 체크박스 선택
	    const checkboxes = document.querySelectorAll('.item-checkbox');	    
	    // 체크된 체크박스가 있는지 확인
	    const isAnyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);	    
	    // 주문하기 버튼 요소 선택
	    const orderButton = document.getElementById('orderButton');
	    
	    // 체크된 체크박스가 있으면 'active' 클래스를 추가
	    if (isAnyChecked) {
        orderButton.classList.add('active');
        
    	} else {
        orderButton.classList.remove('active');
    	}
	}

</script>