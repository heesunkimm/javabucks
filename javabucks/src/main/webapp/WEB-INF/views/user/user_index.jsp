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
                        <span class="grade_name">until ${until}</span>
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
                    <div class="img_box">
                        <img src="../images/icons/alarm.png" alt="">
                    </div>
					<span class="noReadNum">0</span>
                </div>
            </div>
    
            <div class="whats_new div_box">
                <div class="tit_box">
                    <p>What's New</p>
                    <!-- <a class="veiw_more font_green" href="javascript:;">see all</a> -->
                </div>
                <div class="news_box swiper">
                        <ul class="news_wrapper swiper-wrapper">
                            <li class="news_wrapper swiper-slide">
                                <div class="img_box">
                                    <img src="../images/banner/mini_banner01.jpeg" alt="">
                                </div>
                            </li>
                            <li class="news_wrapper swiper-slide">
                                <div class="img_box">
                                    <img src="../images/banner/mini_banner02.jpeg" alt="">
                                </div>
                            </li>
                        </ul>
                        <div class="news_pagination swiper-pagination"></div>
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
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
		$(document).ready(function() {
			let userId = `${inUser.userId}`;
			let swiper = new Swiper(".news_box", {
	            slidesPerView: 1,
	            spaceBetween: 0,
	            loop: true,
	            autoplay: {
	                delay: 7000,
	            },
	            pagination: {
	            el: ".news_pagination",
	            clickable: true,
	            }
	        });
			
			$('.alarm_box').on('click', function() {
			    updateAndFetchAlarms();
			    window.location.href = "user_alarm"; // 알람페이지 이동
			});
			
			// 알람 아이콘 클릭 시 업데이트 함
			function updateAndFetchAlarms() {
			    $.ajax({
			        url: `${pageContext.request.contextPath}/readAllAlarms.ajax`,
			        method: "POST",
			        data: { userId: userId },
			        success: function() {
			            // 알람 상태 업데이트 후 갯수를 다시 불러옴
			            checkAlarm();
			        },
			        error: function(error) {
			            console.error("Error updating alarms: ", error);
			        }
			    });
			};
			
			// 읽지않은 알림갯수 보여주기
			function checkAlarm() {
			    $.ajax({
			        url: `${pageContext.request.contextPath}/noReadAlarmCheck.ajax`,
			        method: "GET",
			        data: { userId: userId },
			        success: function(res) {
			            //console.log(res);
						$('.noReadNum').text(res);
			        },
			        error: function(error) {
			            console.error("Error: ", error);
			        }
			    });
			}

			checkAlarm();
			setInterval(checkAlarm, 10000);
		});
		$(window).on('pageshow', function(event) {
				// 캐시에 로드 됐을때 or 뒤로가기 or 앞으로 가기 했을때
		    if (event.originalEvent.persisted || window.performance && window.performance.navigation.type === 2) {
		        window.location.reload();
		    }
		});
    </script>