<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <section id="user_main" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="random_box">
                    <p>
                    <c:if test="${not empty inUser.userNickname}">
                    ${inUser.userNickname}님,
                    </c:if>
                    <c:if test="${empty inUser.userNickname}">
                    ${inUser.userId}님,
                    </c:if>
                    <br/> 오늘도 힘찬 하루★ 반가워요!
                    </p>
                </div>
                <div class="reward_box div_box"> 
                    <p class="remain_count font_green">
                        <span class="star_count">${frequency}</span>
                        <span class="star_icon star_icon--01"></span>
                        <span class="grade_name">until ${until} Level</span>
                    </p>
                    <div class="progress_box">
                        <progress class="progress_bar"  min="0" max="100" value="${progress_bar}"></progress>
                        <p class="total_count">
                            <span>${frequency}</span>/<span class="font_green">${maxStar}</span>
                            <span class="star_icon star_icon--02"></span>
                        </p>
                    </div>
                </div>
            </div>
    
            <div class="summary_box div_box">
                <ul class="summary_list">
                    <li>
                        <a class="link_btn" href="user_pay">
                            <div class="img_box">
                                <img src="../images/icons/pay_card.png" alt="">
                            </div>
                            <span>Pay</span>
                        </a>
                    </li>
                    <li>
                        <a class="link_btn" href="user_cpnhistory">
                            <div class="img_box">
                                <img src="../images/icons/pay_coupon.png" alt="">
                            </div>
                            <span>Coupon</span>
                        </a>
                    </li>
                </ul>
    
                <div class="alarm_box">
                    <a class="link_btn" href="user_alarm">
                        <div class="img_box">
                            <img src="../images/icons/alarm.png" alt="">
                        </div>
                    </a>
                </div>
            </div>
    
            <div class="whats_new div_box">
                <div class="tit_box">
                    <p>What's New</p>
                    <a class="veiw_more font_green" href="javascript:;">see all</a>
                </div>
                <div class="news_box">
                    <a href="javascript:;">
                        <div class="img_box">
                            <!-- <img src="" alt=""> -->
                        </div>
                    </a>
                </div>
    
            </div>
    
            <div class="recommend_menu div_box">
                <div class="tit_box">
                    <p><span>
                    <c:if test="${not empty inUser.userNickname}">
                    ${inUser.userNickname}
                    </c:if>
                    <c:if test="${empty inUser.userNickname}">
                    ${inUser.userId}
                    </c:if>
                    </span>님을 위한 추천 메뉴</p>
                </div>
                <ul class="recommend_list">
                    <li>
                        <a href="javascript:;">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <p>메뉴명</p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <p>메뉴명</p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <p>메뉴명</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <!-- e: content -->

<%@ include file="user_bottom.jsp" %>