<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_top.jsp" %>
	<style>
		#user_nav .nav_list li:nth-child(1) .nav_icon {filter: brightness(0) saturate(100%) invert(24%) sepia(60%) saturate(1080%) hue-rotate(122deg) brightness(98%) contrast(103%);}
	</style>
    <!-- s: content -->
    <section id="user_main" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="random_box">
                	<div class="random_img img_box">
	                	<img src="" alt="" style="opacity: 0.8;">
                	</div>
                    <p class="random_txt">
	                    <%-- <c:if test="${not empty inUser.userNickname}">
	                    ${inUser.userNickname}님,
	                    </c:if>
	                    <c:if test="${empty inUser.userNickname}">
	                    ${inUser.userId}님,
	                    </c:if>
	                    <br/> 오늘도 힘찬 하루★ 반가워요! --%>
                    </p>
                </div>
                <div class="reward_box div_box"> 
                    <p class="remain_count font_green">
                        <span class="star_count">${untilStar}</span>
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
                    <p>
                    	<span>
                    		<c:if test="${not empty inUser.userNickname}">
                    			${inUser.userNickname}
                   			</c:if>
                    		<c:if test="${empty inUser.userNickname}">
                    			${inUser.userId}
                    		</c:if>
                   		</span>님을 위한 추천 메뉴
                 	</p>
                </div>
                <ul class="recommend_list">
               	<c:forEach var="menu" items="${top3MenuNames}">
                    <li>
			            <a class="" href="user_store?menuCode=${menu.menuCode}" data-menucode="${menu.menuCode}">
			                <div class="img_box">
			                    <img src="../upload_menuImages/${menu.menuImages}" alt="${menu.menuName}">
			                </div>
			                <p>${menu.menuName}</p> <!-- 메뉴명을 동적으로 삽입 -->
			            </a>
			        </li>
                  </c:forEach>
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
			let UserNickname = '${inUser.userNickname != null ? inUser.userNickname : ""}';
		    let UserId = '${inUser.userId != null ? inUser.userId : ""}';
			let Users = UserNickname === "" || UserNickname === null ? UserId : UserNickname;
			
			let Data = [
				{"phrase": Users + "님 \n오늘도 힘찬하루★ 반가워요!", "images":"../images/banner/banner01.jpg"},
	            {"phrase": "진주경님의 \nSQLD 합격을 기원합니다★", "images":"../images/banner/banner02.jpg"},
	            {"phrase": "자바벅스에서 하루를 시작하세요. \n환영합니다.", "images":"../images/banner/banner03.jpg"},
				{"phrase": "좋은 하루 되세요", "images":"../images/banner/banner01.jpg"},
	            {"phrase": "자바벅스의 \n따듯한 환영을 받으세요!", "images":"../images/banner/banner02.jpg"},
	            {"phrase": "핑복님의 \nSQLD 합격을 기원합니다★", "images":"../images/banner/banner02.jpg"},
	            {"phrase": "경주 공주님의 \nSQLD 합격을 기원합니다★", "images":"../images/banner/banner02.jpg"},
	            {"phrase": "오늘의 커피가 \n" + Users + "님을 기다리고 있습니다.", "images":"../images/banner/banner03.jpg"}
			];
			
            let randomIndex = Math.floor(Math.random() * Data.length); // 랜덤 인덱스 생성
            let randomData = Data[randomIndex]; // 랜덤 데이터 추출
            $(".random_img img").attr("src", randomData.images);
            $(".random_txt").text(randomData.phrase);
			
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