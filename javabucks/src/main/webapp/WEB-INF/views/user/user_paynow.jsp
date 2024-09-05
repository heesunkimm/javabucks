<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_paynow" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">결제하기</p>
            </div>
			<c:if test="${cart=='imme'}">
            <ul class="store_confirm">
                <li><span class="font_green font_bold">${bdto.bucksName}</span>에서 <span class="font_green font_bold">${pickup}</span>을 선택하셨어요!<li>
                <li>${bdto.bucksName}의 위치는 <span class="font_green font_bold">${bdto.bucksLocation}</span>입니다.</li>
            </ul>
            </c:if>
            <c:if test="${cart=='cart'}">
            <ul class="store_confirm">
                <li><span class="font_green font_bold">${bucksName}</span>에서 <span class="font_green font_bold">${pickup}</span>을 선택하셨어요!<li>
                <li>${bucksName}의 위치는 <span class="font_green font_bold">${bucksLocation}</span>입니다.</li>
            </ul>
            </c:if>

           	<p class="sec_tit">주문 내역</p>
            <ul id="orderlist" class="pay_list toggle-content">
                <c:forEach var="ctp" items="${ctpList}">
	                <li class="pay_item">
	                    <div class="img_box">
	                        <img src="/upload_menuImages/${ctp.menuDTO.menuImages}" alt="">
	                    </div>
	                    <div class="txt_box">
	                        <dl>
	                            <dt class="txt_tit"><span>${ctp.menuDTO.menuName}</span> * <span>${ctp.cartCnt}</span></dt>
	                            <dd class="txt_total"><fmt:formatNumber value="${(ctp.menuDTO.menuPrice) * ctp.cartCnt}" pattern="#,###"/>원</dd>
	                        </dl>
	                        <dl class="font_gray">
	                        	<c:set var="iceOrHot" value="${fn:substring(ctp.menuDTO.menuoptCode, 3, 4)}" />
	                        	<c:if test="${iceOrHot=='I'||iceOrHot=='i'}">
	                            <dt><span>ICE</span> | <span>${ctp.cupDTO.cupType} * ${ctp.cartCnt}</span></dt>
	                            </c:if>
	                            <c:if test="${iceOrHot=='H'||iceOrHot=='h'}">
	                            <dt><span>HOT</span> | <span>${ctp.cupDTO.cupType} * ${ctp.cartCnt}</span></dt>
	                            </c:if>
	                            <dd>+<fmt:formatNumber value="${ctp.cupDTO.cupPrice*ctp.cartCnt}" pattern="#,###"/>원</dd>
	                        </dl>
                        	<c:if test="${not empty ctp.iceDTO}">
		                        <dl class="opt_item font_gray">
		                        	<dt>얼음 ${ctp.iceDTO.iceType}</dt>
		                        </dl>
                        	</c:if>
                        	<c:if test="${ctp.orderOptDTO.optShotCount != 0}">
		                        <dl class="opt_item font_gray">
		                        	<dt>샷 ${ctp.shotDTO.shotType} (+${ctp.orderOptDTO.optShotCount}) * ${ctp.cartCnt}</dt>
		                        	<dd>+<fmt:formatNumber value="${ctp.orderOptDTO.optShotCount*600*ctp.cartCnt}" pattern="#,###"/>원</dd>
		                        </dl>
                        	</c:if>
                        	<c:if test="${ctp.orderOptDTO.optSyrupCount != 0}">
		                        <dl class="opt_item font_gray">
		                        	<dt>${ctp.syrupDTO.syrupType} (+${ctp.orderOptDTO.optSyrupCount}) * ${ctp.cartCnt}</dt>
		                        	<dd>+<fmt:formatNumber value="${ctp.orderOptDTO.optSyrupCount*ctp.syrupDTO.syrupPrice*ctp.cartCnt}" pattern="#,###"/>원</dd>
		                        </dl>
                        	</c:if>
                        	<c:if test="${not empty ctp.milkDTO}">
		                        <dl class="opt_item font_gray">
		                        	<dt>우유종류 ${ctp.milkDTO.milkType} * ${ctp.cartCnt}</dt>
		                        	<dd>+<fmt:formatNumber value="${ctp.milkDTO.milkPrice*ctp.cartCnt}" pattern="#,###"/>원</dd>
		                        </dl>
                        	</c:if>
                        	<c:if test="${not empty ctp.whipDTO}">
		                        <dl class="opt_item font_gray">
		                        	<dt>휘핑추가 ${ctp.whipDTO.whipType} * ${ctp.cartCnt}</dt>
		                        	<dd>+<fmt:formatNumber value="${ctp.whipDTO.whipPrice*quantity}" pattern="#,###"/>원</dd>
		                        </dl>
                       		</c:if>
	                        <dl class="opt_item font_gray">
	                        	<dt>총 추가금액</dt>
	                        	<dd><fmt:formatNumber value="${ctp.optPrice*ctp.cartCnt}" pattern="#,###"/>원</dd>
	                        </dl>
	                        <dl>
	                        	<dt class="txt_tit">총 금액</dt>
	                        	<dd class="txt_total"><fmt:formatNumber value="${(ctp.menuDTO.menuPrice*ctp.cartCnt)+(ctp.optPrice*ctp.cartCnt)}" pattern="#,###"/>원</dd>
	                        </dl>	
	                    </div>
	                </li>
                </c:forEach>
            </ul>

            <div class="cpn_box">
            	<!-- 채성진 작업 시작 -->
                <a class="popup_btn" href="javascript:;" data-popup="cpnpay">
                    <div class="img_box">
                        <img src="../images/icons/pay_coupon.png" alt="">
                    </div>
                    <p>사용가능 쿠폰 확인하기</p>
                </a>
            </div>

            <p class="sec_tit">결제 수단</p>
            <ul id="howtopay" class="pay_list toggle-content">
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" class="pay_starbucks" name="PayWay" value="자바벅스카드" checked>자바벅스 카드
                    </label>
                    <div style="width: 768px; overflow: hidden;">
                        <div class="cardlist swiper">
                            <ul class="card_wrapper swiper-wrapper">
                                <c:forEach var="card" items="${listCard}">
                                <li class="card_slide swiper-slide">
                                    <a href="javascript:;">
                                        <div class="img_box">
                                            <img src="../images/icons/buckscard.png" alt="">
                                        </div>
                                    </a>
                                        <div class="txt_box">
                                            <p class="txt_name">${card.cardName}</p>
                                        	<p class="txt_cardNum">${card.cardRegNum}</p>
                                            <p class="txt_price">잔액 <fmt:formatNumber value="${card.cardPrice}" pattern="#,###"/>원</p>
                                        </div>
                                </li>
                                </c:forEach>        
                                <c:if test="${listCardSize < 5}">
                                <li class="add_slide card_slide swiper-slide">
                                    <a href="javascript:;" onclick="confirmAndRedirect()">
                                        <p>JavaBucks 카드를 등록하고 <br/>다양한 혜택을 누려보세요!</p>
                                        <div class="add_icon img_box">
                                            <img src="../images/icons/plus.png" alt="">
                                        </div>
                                    </a>
                                </li>
                                </c:if>
                            </ul>
                            <div class="card_pagination swiper-pagination"></div>
                        </div>
                    </div>
                </li>
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" name="PayWay" value="카카오페이">카카오 페이
                    </label>
                </li>
            </ul>

            <div class="pricecheck_box">
                <form name="payOrder" action="orderPayOk" method="post">
                    <dl>
                        <dt>주문 금액</dt>
                        <dd id="orderedAmount"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</dd>
                    </dl>
                    <dl class="font_gray">
                        <dt>할인 금액</dt>
                        <dd id="discountAmount"><fmt:formatNumber value="0" pattern="#,###"/>원</dd>
                    </dl>
                    <dl>
                        <dt>최종 결제 금액</dt>
                        <dd id="totcountAmount"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</dd>
                    </dl>
                    <input type="hidden" name="cardRegNum">
                    <input type="hidden" name="payhistoryPayWay" id="payhistoryPayWay">
                    <input type="hidden" name="payhistoryPayType" value="${pickup}">
                    <input type="hidden" name="selectedCouponPrice" value="0">
					<input type="hidden" name="selectedCouponListNum" value="">
                    <button class="pay_btn" type="button" onclick="requestPay()">결제하기</button>
                </form>
            </div>
        </div>
        <!-- 사용가능 쿠폰 리스트 조회 팝업 -->
        <div class="popup_box cpnpop" id="cpnpay" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">쿠폰목록</p>
            </div>
            <form name="cpn" action="" method="post">
                <!-- s: 내용 작성 -->
                 <ul class="cpn_list">
                 	<c:forEach var="dto" items="${couponlist}">
	                    <li>
	                        <a href="javascript:;" class="coupon-item" data-cpnPrice="${dto.cpnPrice}" data-cpnListNum="${dto.cpnListNum}">
	                            <div class="img_box">
	                                <img src="../images/icons/javabucks_cupon.png" alt="">
	                            </div>
	                            <div class="txt_box">
	                                <p class="txt_tit">${dto.cpnName}</p>
	                                <p class="txt_date">${dto.cpnListStartDate} ~ ${dto.cpnListEndDate}</p>
	                            </div>
	                        </a>
	                    </li>
                    </c:forEach>
                    <li>
                    	<a href="javascript:;" class="coupon-item cpn-no" data-cpnPrice="0">
                    		<div class="nocpn_img img_box">
                                <img src="../images/icons/javabucks_cupon.png" alt="">
                            </div>
							<div class="txt_box">
								<p class="txt_tit">쿠폰 사용안함</p>
							</div>
	                 	</a>
                    </li>
                 </ul>
                
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button type="button" id="applyCouponBtn">사용하기</button>
                    <button class="close_btn" type="button" data-popup="cpnpay">취소</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
    
<%@ include file="user_bottom.jsp" %>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
	let swiper = new Swiper(".cardlist", {
	    slidesPerView: 1,
	    spaceBetween: 0,
	    loop: false,
	});
	// 결제타입 선택에 따라 카드리스트 노출 유무
	$("input[name='PayWay']").change(function() {
        if ($(".pay_starbucks").is(":checked")) {
            $(".cardlist").show();
        } else {
            $(".cardlist").hide();
        }
    });
				
	let selectedCouponPrice = 0;

    document.addEventListener('DOMContentLoaded', function() {
        // 'orderedAmount' 요소에서 포맷된 숫자와 단위를 가져옵니다.
        const orderedAmountElement = document.getElementById('orderedAmount');
        let orderedAmountText = orderedAmountElement.innerText; // 예: "1,234원"

        // '원' 단위를 제거하고 숫자만 추출합니다.
        let orderedAmountValue = orderedAmountText.replace('원', '').replace(/,/g, '');
        
        // 문자열을 숫자로 변환합니다.
        let totalAmount = parseFloat(orderedAmountValue);

        // totalAmount가 올바른 숫자인지 확인
        if (!isNaN(totalAmount)) {
            // 'totcountAmount' 요소에 totalAmount 값을 설정합니다.
            document.getElementById('totcountAmount').innerText = totalAmount.toLocaleString() + "원";
        } else {
            console.error('totalAmount가 올바른 숫자가 아닙니다.');
        }
   	});
	
	//쿠폰 항목 클릭 시 가격을 저장
	document.querySelectorAll('.coupon-item').forEach(coupon => {
		 coupon.addEventListener('click', function() {
			 let selectedCpnPrice = $(this).data('cpnprice');
		     let selectedCpnListNum = parseInt($(this).data('cpnlistnum'), 10);
		        
		     // 쿠폰 할인 금액과 쿠폰 리스트 넘버를 숨겨진 인풋에 저장
		     $("input[name='selectedCouponPrice']").val(selectedCpnPrice);
		     $("input[name='selectedCouponListNum']").val(selectedCpnListNum);
		     
		     // 선택한 쿠폰의 가격을 가져옴
		     selectedCouponPrice = parseInt(this.getAttribute('data-cpnPrice'), 10);
		
		     // 모든 쿠폰에서 'selected' 클래스를 제거
		     document.querySelectorAll('.coupon-item').forEach(c => c.classList.remove('selected'));
		
		     // 현재 클릭한 쿠폰에 'selected' 클래스 추가
		     this.classList.add('selected');
		 });
	});
	
	//'사용하기' 버튼 클릭 시 쿠폰 적용 및 팝업 닫기
	document.getElementById('applyCouponBtn').addEventListener('click', function() {
		 if (selectedCouponPrice > 0) {
		     // 할인 금액을 업데이트 (이 부분은 실제 금액 업데이트에 맞게 수정 필요)
		     document.getElementById("discountAmount").innerText = selectedCouponPrice.toLocaleString() + "원";
		     updateTotalAmount();
		     // 팝업 닫기
		     $('#cpnpay').removeClass('s_active');
	         $('.dimm').removeClass('s_active');
		 } else if (selectedCouponPrice == 0) {
			 let selectedCouponPrice = 0;
			 document.getElementById("discountAmount").innerText = selectedCouponPrice.toLocaleString() + "원";
			 updateTotalAmount();
			 // 팝업 닫기
		     $('#cpnpay').removeClass('s_active');
	         $('.dimm').removeClass('s_active');
		 } else {
		     alert("쿠폰을 선택해 주세요.");
		 }
	});
	
	// 쿠폰 적용 시 호출되는 함수
	function updateTotalAmount() {
	    // 주문 금액 가져오기
	    let orderedAmount = parseInt(document.getElementById('orderedAmount').innerText.replace(/[^0-9]/g, ''), 10);
	    // 할인 금액 가져오기
	    let discountAmount = parseInt(document.getElementById('discountAmount').innerText.replace(/[^0-9]/g, ''), 10);
	    // 최종 결제 금액 계산
	    let totalAmount = orderedAmount - discountAmount;
	    
	    if (totalAmount < 0) {
	        alert("주문 금액보다 쿠폰의 할인 금액이 더 큽니다. 쿠폰을 확인해 주세요.");
	        totalAmount = 0; // totalAmount가 음수일 경우 0으로 설정
	    }
	    
	    // 할인 금액 업데이트
	    document.getElementById('discountAmount').innerText = discountAmount.toLocaleString() + "원";
	    // 최종 결제 금액 업데이트
	    document.getElementById('totcountAmount').innerText = totalAmount.toLocaleString() + "원";
	}

	document.addEventListener('DOMContentLoaded', function() {
	    // 라디오 버튼 그룹과 숨겨진 입력 필드를 선택합니다.
	    const radioButtons = document.querySelectorAll('#howtopay input[name="PayWay"]');
	    const hiddenInput = document.getElementById('payhistoryPayWay');
	
	    // 라디오 버튼 그룹에 이벤트 리스너를 추가하여 값이 변경될 때마다 숨겨진 입력 필드 업데이트
	    radioButtons.forEach(radio => {
	        radio.addEventListener('change', function() {
	            // 선택된 라디오 버튼의 값을 숨겨진 입력 필드에 설정
	            if (this.checked) {
	                hiddenInput.value = this.value;
	            }
	        });
	    });
	
	    // 페이지가 로드되면 초기 선택된 라디오 버튼의 값을 숨겨진 입력 필드에 설정
	    const selectedRadio = document.querySelector('#howtopay input[name="PayWay"]:checked');
	    if (selectedRadio) {
	        hiddenInput.value = selectedRadio.value;
	    }
	    
	});

	// 카드 번호에 하이픈 추가
	function formatCardNumber(cardNum) {
	    // 카드 번호를 하이픈을 추가해서 포맷하는 함수
	    return cardNum.replace(/(\d{4})(?=\d)/g, '$1-');
	}

	// 카드 번호에서 하이픈 제거
	function removeHyphens(cardNum) {
	    return cardNum.replace(/-/g, '');
	}

	$(document).ready(function(){
	    // 카드 이미지 클릭 이벤트
	    $('.card_slide').on('click', function(){
	    	// 먼저 모든 카드의 img_box에서 active 클래스를 제거하여 보더 스타일을 초기화
	        $('.card_slide .img_box').removeClass('active');

	        // 클릭한 카드의 img_box에 active 클래스를 추가하여 보더 스타일 적용
	        $(this).find('.img_box').addClass('active');

	        // 클릭된 카드 슬라이드에서 카드 번호와 관련된 정보를 선택
	        var cardRegNum = $(this).find('.txt_cardNum').text();
	        var cardName = $(this).find('.txt_name').text();
	        var cardPrice = $(this).find('.txt_price').text();

	        // 하이픈을 제거한 카드 번호를 설정
	        var cardRegNumWithoutHyphens = removeHyphens(cardRegNum);

	        $("input[name='cardRegNum']").val(cardRegNumWithoutHyphens);
	        console.log($("input[name='cardRegNum']").val());
	    });

	    // 카드 번호에 하이픈 추가
	    $('.card_slide').each(function() {
	        var cardNumElement = $(this).find('.txt_cardNum');
	        var rawCardNum = cardNumElement.text();
	        var formattedCardNum = formatCardNumber(removeHyphens(rawCardNum));
	        cardNumElement.text(formattedCardNum);
	    });
	});
	
	function confirmAndRedirect() {
	    // 확인 창을 띄우고 사용자의 선택을 받습니다.
	    var userConfirmed = window.confirm("단일 결제라면 주문하신 내역은 사라집니다.\n카드등록 페이지로 이동하시겠습니까?");
	    
	    if (userConfirmed) {
	        window.location.href = "/user_addcard";
	    } else {
	    	
	    }
	}
	
	function requestPay() {
		
        let cart = '${cart}';
        let payhistoryPayType = $("input[name='payhistoryPayType']").val();
        let payhistoryPayWay = $("input[name='payhistoryPayWay']").val();
        
		IMP.init('imp85860730'); // 아임포트 가맹점 식별코드

		let orderedAmount = parseInt(document.getElementById('orderedAmount').innerText.replace(/[^0-9]/g, ''), 10);
	    let discountAmount = parseInt(document.getElementById('discountAmount').innerText.replace(/[^0-9]/g, ''), 10);
	    let chargeAmount = orderedAmount - discountAmount;
	    
		// 선택된 쿠폰의 cpnListNum 가져오기
	    let cpnListNum = parseInt($("input[name='selectedCouponListNum']").val(), 10);
		console.log(cpnListNum);
	    
        let payUser = '${inUser.userId}';
        let bucksId = '${bucksId}';
        let orderList = '${orderList}';
        
        let menuPrice = '${totMenuPrice}';
        let optPrice = '${totOptPrice}';
        let quantity = '${quantity}';
        let orderName = "${firstOrder} 등";
        
        let cartNumList = ${cartNumList};
        if (!${cartNumList} || cartNumList.length === 0) {
            cartNumList = [];
        }
        
        	
        // 결제 요청
		if (payhistoryPayWay === '카카오페이'){
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: 'JAVABUCKS_' + new Date().getTime(), // 주문번호
                name: orderName, // 결제할 orderList
                amount: chargeAmount, // 결제할 금액
                buyer_name: payUser // 구매자 이름
            }, function (rsp) {
                if (rsp.success) {
                    // 결제 성공 시 서버에 데이터 전송
                     $.ajax({
                    url: 'orderPayCheck.ajax',
                    method: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    data: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        paid_amount: rsp.paid_amount,
                        userId: payUser,
                        bucksId: bucksId,
                        orderPrice: chargeAmount,
                        payhistoryPrice: chargeAmount,
                        payhistoryPayType: payhistoryPayType,
                        payhistoryPayWay: payhistoryPayWay,
                        orderType: payhistoryPayType,
                        orderList: orderList, 
                        menuPrice: menuPrice,
                        optPrice: optPrice,
                        quantity: quantity,
                        cpnListNum: cpnListNum
                    }),
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('결제가 성공적으로 완료되었습니다.');
                         // 카트삭제
                			$.ajax({
                		        url: '/afterdeleteCart',
                		        type: 'POST',
                		        contentType: "application/json",
                		        data: JSON.stringify({
                		        	cartNum: cartNumList
                	          }),         
                		        success: function(response) {
                		            if (response.success) {
                		            	console.log("카트삭제성공");
                		            	window.location.replace("/user_index");
                		            } else {			
                		            	console.log("구매한 카트가 삭제 실패");
                		            }	
                		        },
                		        error: function() {
                		            alert("서버 오류가 발생했습니다.");
                		        }
                		   	 });
                        } else {
                            console.log('처리 중 오류가 발생했습니다. 다시 시도해 주세요.');
                            return;
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('처리 중 오류가 발생했습니다:', error);
                        return;
                    }
                });
                } else {
                    // 결제 실패 시 처리
                    alert(rsp.error_msg);
                    return;
                }
            });
		} else if (payhistoryPayWay === '자바벅스카드'){
			let cardRegNum = $("input[name='cardRegNum']").val();
			
			if (!cardRegNum){
				alert("카드를 선택해주세요");
				return;
			}
			// 자바벅스카드로 결제
			 $.ajax({
                    url: 'orderPayBucksCard.ajax',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                    	cardRegNum: cardRegNum,
                        userId: payUser,
                        bucksId: bucksId,
                        orderedAmount: orderedAmount,
            		    discountAmount: discountAmount,
                        orderPrice: chargeAmount,
                        payhistoryPrice: chargeAmount,
                        payhistoryPayType: payhistoryPayType,
                        payhistoryPayWay: payhistoryPayWay,
                        orderType: payhistoryPayType,
                        orderList: orderList, 
                        menuPrice: menuPrice,
                        optPrice: optPrice,
                        quantity: quantity,
                        cpnListNum: cpnListNum,
                    }),
                    success: function(res) {
						console.log(res)
                    	if (res === 'PASS') {
                        	alert("잔액이 부족합니다. 충전 후 다시 이용해 주세요");
                        	return;
                        } else if (res === 'OK') {
	                        alert("결제가 완료 되었습니다.");
	                     // 카트삭제
	            			$.ajax({
	            		        url: '/afterdeleteCart',
	            		        type: 'POST',
	            		        contentType: "application/json",
	            		        data: JSON.stringify({
	            		        	cartNum: cartNumList
	            	          }),         
	            		        success: function(response) {
	            		            if (response.success) {
	            		            	console.log("카트삭제성공");
	            		            	window.location.replace("/user_index");
	            		            } else {			
	            		            	console.log("구매한 카트가 삭제 실패");
	            		            }	
	            		        },
	            		        error: function() {
	            		            alert("서버 오류가 발생했습니다.");
	            		        }
	            		   	 });
                        } else {
                            console.log('처리 중 오류가 발생했습니다. 다시 시도해 주세요.');
                            return;
                        }
                    },
                    error: function(error) {
                        console.error('처리 중 오류가 발생했습니다:', error.message || error);
                        return;
                    }
                });
			
		} else {
			alert("결제방식을 선택해주세요");
		}
       }
</script>	
	