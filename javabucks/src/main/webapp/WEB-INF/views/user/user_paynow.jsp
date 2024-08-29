<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/reset.css">
	<link rel="stylesheet" href="../css/user.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="../js/user.js"></script>
    <style>
        body {max-width: 768px!important;}

        .tab-content {display: none;}
        .div_box {margin-top: 20px;}
        .content {padding: 0 0 100px;}
        .addcontent {padding: 0 0 140px;}
        .inner_wrap > .tit_box {padding-bottom: 20px; font-size: 32px;}
        #user_paynow .store_confirm {border-top: 1px solid #ccc; padding: 20px 0;}
        #user_paynow .store_confirm li:first-child {font-size: 18px; line-height: 28px;}
        #user_paynow .store_confirm li span {margin-left: 10px; display: inline-block; font-size: 16px;}
        #user_paynow .store_confirm li:not(:first-child) {font-size: 16px; line-height: 26px;}

        #user_paynow .btn_box button {position: relative; width: 100%; padding: 10px 0; font-size: 20px; text-align: left;}
        #user_paynow .btn_box button::after {content: ''; position: absolute; top: 50%; transform: translateY(-50%) rotate(45deg); right: 0; display: block; width: 16px; height: 16px; border-bottom: 2px solid #555; border-right: 2px solid #555;}

        #user_paynow .btn_box .toggle_btn.t_active::after {transform: rotate(-135deg);}

        #user_paynow .pay_list {padding: 20px 0;}
        #user_paynow .pay_list .pay_item {display: flex; align-items: flex-start; justify-content: space-between; padding:  10px 20px;}
        #user_paynow .pay_list .pay_item .img_box {width: 100px; height: 100px; border-radius: 50%; border: 1px solid #ccc;}

        #user_paynow .pay_list .pay_item .img_box.cpn_icon {width: 50px; height: 50px; filter: brightness(0) saturate(100%) invert(32%) sepia(3%) saturate(8%) hue-rotate(339deg) brightness(96%) contrast(87%); border-radius: 0; border: none;}

        #user_paynow .pay_list .pay_item .txt_box {width: 600px;}
        #user_paynow .pay_list .pay_item .txt_box dl:first-child {font-size: 16px;}
        #user_paynow .pay_list .pay_item .txt_box dl:not(:first-child) {margin-top: 6px; font-size: 14px;}
        #user_paynow .pay_list .pay_item .txt_box dl {display: flex; align-items: center; justify-content: space-between;}

        #user_paynow #howtopay input[type="radio"] {margin-right: 10px; width: 20px; height: 20px;}
        #user_paynow #howtopay > li {padding: 12px 0;}
        #user_paynow #howtopay .cardlist {overflow: visible; margin-top: 20px; width: 420px; height: 370px;}
        #user_paynow #howtopay .cardlist li +li {margin-left: 30px;}
        #user_paynow #howtopay .cardlist .card_slide {width: 420px;}
        #user_paynow #howtopay .cardlist .card_slide a {display: inline-block; width: 100%; height: 264px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box {margin-top: 6px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box .txt_name {font-size: 16px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box .txt_price {margin-top: 4px; font-size: 16px; color: #555;}
        #user_paynow #howtopay .cardlist .add_slide {height: 264px; border: 1px solid #ccc; border-radius: 8px;}
        #user_paynow #howtopay .cardlist .add_slide a {display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 20px;}
        #user_paynow #howtopay .cardlist .add_slide .add_icon {width: 30px; height: 30px; filter: brightness(0) saturate(100%) invert(34%) sepia(0%) saturate(1425%) hue-rotate(280deg) brightness(92%) contrast(87%);}

        #user_paynow .cpn_box {border-top: 1px solid #ccc;}
        #user_paynow .cpn_box a {display: flex; align-items: center; gap: 20px; padding: 20px;}
        #user_paynow .cpn_box .img_box {width: 30px; height: 30px;}

        #user_paynow .cpnpop {width: 400px; padding: 30px 20px 0;}
        #user_paynow .cpnpop .tit_box {font-size: 18px;}
        #user_paynow .cpnpop form {margin-top: 16px;}
        #user_paynow .cpnpop .cpn_list li + li {border-top: 1px solid #ccc;}
        #user_paynow .cpnpop .cpn_list li a {display: flex; align-items: center; gap: 20px; padding: 10px 0;}
        #user_paynow .cpnpop .cpn_list li .img_box {width: 46px; height: 46px; border: 1px solid #ccc;}
        #user_paynow .cpnpop .cpn_list li .txt_box .txt_tit {font-size: 16px;}
        #user_paynow .cpnpop .cpn_list li .txt_box .txt_date {margin-top: 6px; font-size: 14px; color: #555;}

        #user_paynow .cpnpop .pbtn_box {width: 100%; display: flex; align-items: center; justify-content: center; border-top: 1px solid #ccc;}
        #user_paynow .cpnpop .pbtn_box button {position: relative; width: 50%; padding: 20px 0;}
        #user_paynow .cpnpop .pbtn_box button:first-child {border-right: 1px solid #ccc;}

        #user_paynow .pricecheck_box {padding: 20px; background-color: #eee;}
        #user_paynow .pricecheck_box dl {display: flex; align-items: center; justify-content: space-between;}
        #user_paynow .pricecheck_box dl:not(:nth-child(3)) {margin-top: 10px; font-size: 18px;}
        #user_paynow .pricecheck_box dl:nth-child(3) {margin-top: 16px; font-size: 20px; font-weight: 700;}
        #user_paynow .pricecheck_box .pay_btn {margin-top: 16px; width: 100%; height: 34px; line-height: 34px; padding: 0 10px; border-radius: 25px; background-color: #006241; font-size: 18px; color: #fefefe;}
    </style>
    
</head>
<body>
    <!-- s: content -->
    <section id="user_paynow" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">결제하기</p>
            </div>

            <ul class="store_confirm">
                <li>주문하신 매장을 확인해주세요!</li>
                <li>${bdto.bucksName}<span class="font_gray">${pickup}</span></li>
                <li>${bdto.bucksLocation}</li>
            </ul>

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="orderlist">주문 내역</button>
            </div>
            <ul id="orderlist" class="pay_list toggle-content">
            <c:if test="${cart=='imme'}">
            	<li class="pay_item">
                    <div class="img_box">
                        <img src="/upload_menuImages/${mdto.menuImages}" alt="">
                    </div>
                    <div class="txt_box">
                        <dl>
                            <dt class="txt_tit"><span>${mdto.menuName}</span> X <span>${quantity}</span></dt>
                            <dd class="txt_total"><fmt:formatNumber value="${(mdto.menuPrice) * quantity}" pattern="#,###"/>원</dd>
                        </dl>
                        <dl class="font_gray">
                        	<c:set var="iceOrHot" value="${fn:substring(mdto.menuoptCode, 3, 4)}" />
                        	<c:if test="${iceOrHot=='I'||iceOrHot=='i'}">
                            <dt><span>ICE</span> | <span>${cupdto.cupType} X ${quantity}</span></dt>
                            </c:if>
                            <c:if test="${iceOrHot=='H'||iceOrHot=='h'}">
                            <dt><span>HOT</span> | <span>${cupdto.cupType} X ${quantity}</span></dt>
                            </c:if>
                            <dd>+<fmt:formatNumber value="${cupdto.cupPrice*quantity}" pattern="#,###"/>원</dd>
                        </dl>
                        <dl class="opt_item font_gray">
                        	<c:if test="${not empty icedto}">
                        	<dt>얼음 ${icedto.iceType}</dt>
                        	</c:if>
                        </dl>
                        <dl class="opt_item font_gray">
                        	<c:if test="${optdto.optShotCount != 0}">
                        	<dt>샷 ${shotdto.shotType} (+${optdto.optShotCount}) X ${quantity}</dt>
                        	<dd>+<fmt:formatNumber value="${optdto.optShotCount*600*quantity}" pattern="#,###"/>원</dd>
                        	</c:if>
                        </dl>
                        <dl class="opt_item font_gray">
                        	<c:if test="${optdto.optSyrupCount != 0}">
                        	<dt>${syrupdto.syrupType} (+${optdto.optSyrupCount}) X ${quantity}</dt>
                        	<dd>+<fmt:formatNumber value="${optdto.optSyrupCount*syrupdto.syrupPrice*quantity}" pattern="#,###"/>원</dd>
                        	</c:if>
                        </dl>
                        <dl class="opt_item font_gray">
                        	<c:if test="${not empty milkdto}">
                        	<dt>우유종류 ${milkdto.milkType} X ${quantity}</dt>
                        	<dd>+<fmt:formatNumber value="${milkdto.milkPrice*quantity}" pattern="#,###"/>원</dd>
                        	</c:if>
                        </dl>
                        <dl class="opt_item font_gray">
                        	<dt>총 추가금액</dt>
                        	<dd><fmt:formatNumber value="${optPrice*quantity}" pattern="#,###"/>원</dd>
                        </dl>
                        <dl>
                        	<dt class="txt_tit">총 금액</dt>
                        	<dd class="txt_total"><fmt:formatNumber value="${(mdto.menuPrice*quantity)+(optPrice*quantity)}" pattern="#,###"/>원</dd>
                        </dl>	
                    </div>
                </li>
            </c:if>
            <c:if test="${cart=='cart'}">
                <li class="pay_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <dl>
                            <dt class="txt_tit"><span>메뉴명</span> * <span>수량</span></dt>
                            <dd class="txt_total">총금액</dd>
                        </dl>
                        <dl class="font_gray">
                            <dt><span>ICE</span>|<span>Tall</span></dt>
                            <dd>기본금액</dd>
                        </dl>
                        <dl class="opt_item font_gray">
                            <dt>추가옵션명 * 0</dt>
                            <dd>추가옵션금액</dd>
                        </dl>
                    </div>
                </li>
            </c:if>
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

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="howtopay">결제 수단</button>
            </div>
            <ul id="howtopay" class="pay_list toggle-content">
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" class="pay_starbucks" name="PayWay" value="자바벅스카드">자바벅스 카드
                    </label>
                    <div style="width: 768px; overflow: hidden;">
                        <div class="cardlist swiper">
                            <ul class="card_wrapper swiper-wrapper">
                                <c:forEach var="card" items="${listCard}">
                                <li class="card_slide swiper-slide">
                                    <a href="javascript:;">
                                        <div class="img_box">
                                            <img src="../images/icons/starbucksCard.png" alt="">
                                        </div>
                                    </a>
                                        <div class="txt_box">
                                            <p class="txt_name">${card.cardName}</p>
                                        	<p class="txt_cardNum">${card.cardRegNum}</p>
                                            <p class="txt_price">잔액 <fmt:formatNumber value="${card.cardPrice}" pattern="#,###"/>원</p>
                                        </div>
                                </li>
                                </c:forEach>        
                                <li class="add_slide card_slide swiper-slide">
                                    <a href="javascript:;">
                                        <p>JavaBucks 카드를 등록하고 <br/>다양한 혜택을 누려보세요!</p>
                                        <div class="add_icon img_box">
                                            <img src="../images/icons/plus.png" alt="">
                                        </div>
                                    </a>
                                </li>
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
                        <dd><fmt:formatNumber value="${(mdto.menuPrice*quantity)+(optPrice*quantity)}" pattern="#,###"/>원</dd>
                    </dl>
                    <dl class="font_gray">
                        <dt>할인 금액</dt>
                        <dd><fmt:formatNumber value="" pattern="#,###"/>원</dd>
                    </dl>
                    <dl>
                        <dt>최종 결제 금액</dt>
                        <dd><fmt:formatNumber value="${(mdto.menuPrice*quantity)+(optPrice*quantity)}" pattern="#,###"/>원</dd>
                    </dl>
                    <input type="hidden" name="cardRegNum">
                    <input type="hidden" name="payhistoryPayWay" id="payhistoryPayWay">
                    <input type="hidden" name="payhistoryPayType" value=${pickup}>
                    <button class="pay_btn" type="button" onclick="requestPay()">결제하기</button>
                </form>
            </div>
        </div>
        <!-- 사용가능 쿠폰 리스트 조회 팝업 -->
        <div class="popup_box cpnpop" id="cpnpay" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">쿠폰목록</p>
            </div>
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <ul class="cpn_list">
                 	<c:forEach var="dto" items="${couponlist}">
	                    <li>
	                        <a href="javascript:;">
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
                 </ul>
                
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button type="submit">사용하기</button>
                    <button class="close_btn" type="button" data-popup="cpnpay">취소</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
    
<%@ include file="user_bottom.jsp" %>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
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

		$(document).ready(function(){
		    // 카드 이미지 클릭 이벤트
		    $('.card_slide').on('click', function(){
		        // 클릭된 카드 슬라이드에서 카드 이름과 잔액을 선택
		        var cardRegNum = $(this).find('.txt_cardNum').text();
		        var cardName = $(this).find('.txt_name').text();
		        var cardPrice = $(this).find('.txt_price').text();
		
		        $("input[name='cardRegNum']").val(cardRegNum);
		        console.log($("input[name='cardRegNum']").val());
		    });
		});

		
		function requestPay() {
            IMP.init('imp85860730'); // 아임포트 가맹점 식별코드
            let chargeAmount = ${(mdto.menuPrice*quantity)+(optPrice*quantity)};
            let payhistoryPayType = $("input[name='payhistoryPayType']").val();
            let payhistoryPayWay = $("input[name='payhistoryPayWay']").val();
            let payUser = '${inUser.userId}';
            let orderName = "${mdto.menuName} ${quantity}개";
            
            let bucksId = "${bdto.bucksId}";
            let menuPrice = "${(mdto.menuPrice) * quantity}";
            let optPrice = "${optPrice*quantity}";
            
            
            // 주문 데이터
            let orders = [
            	{ menuCode: '${mdto.menuCode}', optId: ${optId}, quantity: ${quantity} }
            ];
         	// JSON 배열 생성 및 문자열 변환
            let orderJson = orders.map(order => `${mdto.menuCode}:${optId}:${quantity}`);
            let orderList = JSON.stringify(orderJson);
        	
            // 결제 요청
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: 'JAVABUCKS_' + new Date().getTime(), // 주문번호
                name: orderList, // 결제할 orderList
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
                        optPrice: optPrice
                    }),
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('결제가 성공적으로 완료되었습니다.');
                        } else {
                            console.log('처리 중 오류가 발생했습니다. 다시 시도해 주세요.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('처리 중 오류가 발생했습니다:', error);
                    }
                });
                } else {
                    // 결제 실패 시 처리
                    alert(rsp.error_msg);
                }
            });
        }
</script>	
	