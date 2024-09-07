<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 숫자 포맷팅 할 때 필요 -->
<%@ include file="user_top.jsp" %>
	<style>
		#user_nav .nav_list li:nth-child(2) .nav_icon {filter: brightness(0) saturate(100%) invert(24%) sepia(60%) saturate(1080%) hue-rotate(122deg) brightness(98%) contrast(103%);}
	</style>
    <!-- s: content -->
    <section id="user_pay" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">Pay</p>
            </div>

            <div class="card_box div_box">
                <p>JavaBucks Card</p>
                <ul class="card_list div_box">
                	<c:if test="${not empty listCard}">
						<c:forEach var="card" items="${listCard}">
		                    <li>
		                        <a class="popup_btn" href="javascript:;" data-popup="cardpay" data-cardregnum="${card.cardRegNum}" data-cardname="${card.cardName}" data-cardprice="${card.cardPrice}" >
		                            <div class="img_box">
		                                <img src="../images/icons/buckscard.png" alt="">
		                            </div>
		                        </a>
		                    </li>
	                    </c:forEach>
                    </c:if>
                </ul>
                <c:if test="${listCardSize < 5}">
                <!-- 카드등록 페이지 이동 -->
                <div class="addcard_box div_box">
                    <a class="" href="user_addcard">
                        <p>JavaBucks 카드를 등록하고 <br/>다양한 혜택을 누려보세요!</p>
                        <div class="add_icon img_box">
                            <img src="../images/icons/plus.png" alt="">
                        </div>
                    </a>
                </div>
                </c:if>
            </div>

        </div>
        <!-- 카드충전 팝업 -->
        <div class="popup_box pay_card"  id="cardpay" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">카드이름</p>
                <a class="popup_btn edit_btn" href="javascript:;" data-popup="cardedit" >
                    <img src="../images/icons/edit.png" alt="">
                </a>
            	<p class="card_num">카드번호</p>
            </div>
            <p class="card_price">잔액: <span>0</span>원</p>
            <div class="card_img img_box">
                <img src="../images/icons/buckscard.png" alt="">
            </div>
            <form name="f" action="user_paycharge" method="post">
            	<input type="hidden" name="cardRegNum" value="">
                <!-- s: 내용 작성 -->
                
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button type="submit">충전하기</button>
                    <button class="close_btn" type="button" data-popup="cardpay">취소</button>
                </div>
            </form>
        </div>
        <!-- 카드명 수정 -->
        <div class="popup_box edit_card" id="cardedit" style="display: none;">
            <form name="f" action="modifyCardName" method="POST">
                <!-- s: 내용 작성 -->
                 <div class="insert_box">
                     <p>변경할 이름을 입력해주세요.</p>
                     <label>카드 이름
                         <input type="text" name="cardName" value="" placeholder="카드명 최대 20자" maxlength="20">
                         <input type="hidden" name="modicardRegNum" value="">
                     </label>
                 </div>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" data-popup="cardedit" type="button">취소</button>
                    <button type="submit">확인</button>
                </div>
            </form>
        </div>
       
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
     <script>
	     // 숫자를 천 단위로 포맷하는 함수
	     function formatNumber(num) {
	         return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	     }
     
         $(".popup_btn").on('click', function(e) {
 			let cardName = $(this).data('cardname');
 			let cardPrice = $(this).data('cardprice');
 			let cardRegNum = $(this).data('cardregnum');
	
 			let formattedCardNum = String(cardRegNum).replace(/(\d{4})(?=\d)/g, '$1-');
 			
 			$('#cardpay .card_num').text(formattedCardNum);
 			$('#cardpay .txt_tit').text(cardName);
 			$('#cardpay .card_price span').text(formatNumber(cardPrice));
 			
 			$("#cardpay input[name='cardRegNum']").val(cardRegNum);
         });
     
        $(".edit_btn").on("click",function () {
            if(!$(".edit_card").hasClass("s_active")) {
                $(".pay_card").removeClass("s_active");
            }
            
            let cardRegNum = $(".card_num").text().trim().replace(/-/g, '');
            
            $("#cardedit input[name='modicardRegNum']").val(cardRegNum);
        })
        
        $(".edit_card .close_btn").on("click",function () {
            $(".pay_card").addClass("s_active");
        })
     </script>
<%@ include file="user_bottom.jsp" %>