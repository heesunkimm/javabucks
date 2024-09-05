<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_top.jsp"%>
	<style>
		#user_nav .nav_list li:nth-child(5) .nav_icon {filter: brightness(0) saturate(100%) invert(24%) sepia(60%) saturate(1080%) hue-rotate(122deg) brightness(98%) contrast(103%);}
	</style>
    <!-- s: content -->
    <section id="user_other" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">Other</p>
            </div>

            <div class="user_box div_box">
                <p>
            	<c:if test="${not empty inUser.userNickname}">
                    ${inUser.userNickname}님,
                    </c:if>
                <c:if test="${empty inUser.userNickname}">
                    ${inUser.userId}님,
                </c:if>
            	<br/>환영합니다!
            	</p>
                <ul class="div_box">
                    <li>
                        <a href="user_starhistory">
                            <div class="img_box">
                                <img src="../images/icons/star_line.png" alt="">
                            </div>
                            <p>별 히스토리</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_recepit">
                            <div class="img_box">
                                <img src="../images/icons/other_receipt.png" alt="">
                            </div>
                            <p>전자영수증</p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" data-popup="pwbox" class="popup_btn">
                            <div class="img_box">
                                <img src="../images/icons/other_mypageManage.png" alt="">
                            </div>
                            <p>개인정보 관리</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_mymenu">
                            <div class="img_box">
                                <img src="../images/icons/other_mymenu.png" alt="">
                            </div>
                            <p>나만의 메뉴</p>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="pay_box div_box">
                <p class="div_tit font_bold">Pay</p>
                <ul class="pay_list other_list">
                    <li>
                        <a href="user_addcard">
                            <div class="img_box">
                                <img src="../images/icons/pay_card.png" alt="">
                            </div>
                            <p>스타벅스 카드 등록</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_cpnhistory">
                            <div class="img_box">
                                <img src="../images/icons/order_history.png" alt="">
                            </div>
                            <p>쿠폰 히스토리</p>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="order_box div_box">
                <p class="div_tit font_bold">Order</p>
                <ul class="order_list other_list">
                    <li>
                        <a href="user_cart?modeInput=ordercart">
                            <div class="img_box">
                                <img src="../images/icons/order_basket.png" alt="">
                            </div>
                            <p>장바구니</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_orderhistory">
                            <div class="img_box">
                                <img src="../images/icons/order_history.png" alt="">
                            </div>
                            <p>주문 히스토리</p>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="delivers_box div_box">
                <p class="div_tit font_bold">Delivers</p>
                <ul class="delivers_list other_list">
                    <li>
                        <a href="user_delivers">
                            <div class="img_box">
                                <img src="../images/icons/delivers.png" alt="">
                            </div>
                            <p>주문하기</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_cart?modeInput=deliverscart">
                            <div class="img_box">
                                <img src="../images/icons/order_basket.png" alt="">
                            </div>
                            <p>장바구니</p>
                        </a>
                    </li>
                    <li>
                        <a href="user_delivershistory">
                            <div class="img_box">
                                <img src="../images/icons/order_history.png" alt="">
                            </div>
                            <p>주문 히스토리</p>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="logout_box div_box">
                <a href="user_logout">로그아웃</a>
            </div>

            <!-- 개인정보 관리 패스워드 확인 팝업 -->
            <div class="popup_box" id="pwbox" style="display: none;">
                <div class="tit_box">
                    <p class="txt_tit">비밀번호를 입력해주세요.</p>
                </div>
                <form name="f" action="userInfo.do" method="GET" onsubmit="return checkPasswd(this)">
                    <!-- s: 내용 작성 -->
                    <div class="date_box">
                        <label>
                            <input type="password" name="inputPassWd" value="">
                        </label>
                    </div>
                    <!-- e: 내용 작성 -->
                    <div class="btn_box">
                        <button class="close_btn" type="button" data-popup="pwbox">취소</button>
                        <button class="submit_btn" type="submit">확인</button>
                    </div>
                </form>
            </div>
            <div class="dimm"></div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>

<script>

	function checkPasswd(event){
		let inputPasswd = document.getElementsByName('inputPassWd')[0].value;
		$.ajax({
			type : "POST",
			url : "passWdCheck.ajax",
			data : {
				inputPasswd : inputPasswd
			},
			success : function(response){
				if(response){
					alert("인증되었습니다. 개인정보수정 페이지로 이동합니다.");
					document.forms['f'].submit();
				}else{
					alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				}
			},
			error : function(error){
				console.log(error);
			}
		})
		return false;
	}
	
</script>








