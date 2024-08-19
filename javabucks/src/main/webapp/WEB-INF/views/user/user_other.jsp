<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <section id="user_other" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <ul class="btn_list">
                    <li>
                        <a href="user_alarm">
                            <div class="alarm_icon img_box">
                                <img src="../images/icons/alarm.png" alt="">
                            </div>
                        </a>
                    </li>
                </ul>
                <div class="tit_box div_box">
                    <p class="font_bold">Other</p>
                </div>
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
                        <a href="user_info">
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
                        <a href="javascript:;">
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
                            <p>히스토리</p>
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
                        <a href="javascript:;">
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
                            <p>배달완료 히스토리</p>
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
                <form name="f" action="" method="post">
                    <!-- s: 내용 작성 -->
                    <div class="date_box">
                        <label>
                            <input type="password" name="" value="">
                        </label>
                    </div>
                    <!-- e: 내용 작성 -->
                    <div class="pbtn_box">
                        <button class="close_btn" type="button" data-popup="pwbox">취소</button>
                        <button class="submit_btn" type="submit">완료</button>
                    </div>
                </form>
            </div>
            <div class="dimm"></div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>