<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="user_top.jsp" %>
    <!-- s: content -->
    <section id="user_paycharge" class="pay_cont content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">충전하기</p>
            </div>

            <div class="price_box">
                <p>충전 금액</p>
                <button type="button" data-price="10000">1만원</button>
                <button type="button" data-price="30000">3만원</button>
                <button type="button" data-price="50000">5만원</button>
                <button type="button" data-price="70000">7만원</button>
                <button type="button" data-price="100000">10만원</button>
            </div>

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="howtopay">결제 수단</button>
            </div>
            <ul id="howtopay" class="pay_list toggle-content">
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" name="paytype" value="카카오페이" checked>카카오페이
                    </label>
                </li>
            </ul>

            <div class="pricecheck_box">
                <form name="ff" action="" method="post">
                    <dl>
                        <dt>충전 후 예상 총 카드 잔액</dt>
                        <dd><fmt:formatNumber value="${card.cardPrice}" pattern="#,###"/>원</dd>
                    </dl>
                    
                    <input type="hidden" name="chargeAmount" >
                    <input type="hidden" name="cardRegNum" value="${card.cardRegNum}">
                    <input type="hidden" name="cardName" value="${card.cardName}">
                    <input type="hidden" name="payhistoryPayType" value="충전">
                    <input type="hidden" name="payhistoryPayWay" value="카카오페이">
                    <button class="pay_btn" type="button" onclick="requestPay()">충전하기</button>
                </form>
            </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>    
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
        $(".price_box button").click(function() {
                $(".price_box button").removeClass("p_active");
                $(this).addClass("p_active");
                
                // 현재 카드 잔액가져옴
                let cardPrice = parseInt("${card.cardPrice}");
                // 클릭된 버튼의 data-price 값을 가져옴
                let chargeAmount = parseInt($(this).data('price'));
				// 충전할 금액 hidden input에 담음.
                $("input[name='chargeAmount']").val(chargeAmount);
                // 충전할 금액 + 기존 잔액 더해서 예상총금액 구함.
                let totalAmount = cardPrice + chargeAmount;

                // 예상 총 카드 잔액을 업데이트
                $(".pricecheck_box dd").text(totalAmount.toLocaleString() + "원");
            });
        
        function requestPay() {
            IMP.init('imp85860730'); // 아임포트 가맹점 식별코드
            let chargeAmount = $("input[name='chargeAmount']").val(); // 선택한 충전 금액
            let cardRegNum = $("input[name='cardRegNum']").val(); // 카드 번호
            let cardName = $("input[name='cardName']").val(); // 카드 이름
            let payhistoryPayType = $("input[name='payhistoryPayType']").val();
            let payhistoryPayWay = $("input[name='payhistoryPayWay']").val();
            let payUser = '${inUser.userId}'

            // 결제 요청
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: 'JAVABUCKS_' + new Date().getTime(), // 주문번호
                name: cardName, // 결제할 상품명 (카드 이름)
                amount: chargeAmount, // 결제할 금액
                buyer_name: payUser // 구매자 이름
            }, function (rsp) {
                if (rsp.success) {
                    // 결제 성공 시 서버에 데이터 전송
                     $.ajax({
                    url: 'user_paycharge.ajax',
                    method: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    data: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        paid_amount: rsp.paid_amount,
                        userId: payUser,
                        payhistoryPrice: chargeAmount,
                        cardRegNum: cardRegNum,
                        payhistoryPayType: payhistoryPayType,
                        payhistoryPayWay: payhistoryPayWay
                    }),
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('충전이 성공적으로 완료되었습니다.');
                            window.location.replace("/user_pay");
                        } else {
                            console.log('처리 중 오류가 발생했습니다. 다시 시도해 주세요.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('처리 중 오류가 발생했습니다:', error);
                        alert('처리 중 오류가 발생했습니다. :', error);
                    }
                });
                } else {
                    // 결제 실패 시 처리
                    alert(rsp.error_msg);
                }
            });
        }

        $(".toggle_btn").each(function() {
            $(this).on('click', function(e) {
                e.preventDefault();
                let popupId = $(this).data('toggle');
                
                $(this).toggleClass('t_active');
                
                if ($(this).hasClass('t_active')) {
                    $('#' + popupId).show();
                } else {
                    $('#' + popupId).hide();
                }
            });
        });

        $("input[name='paytype']").change(function() {
            if ($(".pay_starbucks").is(":checked")) {
                $(".cardlist").show();
            } else {
                $(".cardlist").hide();
            }
        });
     </script>
