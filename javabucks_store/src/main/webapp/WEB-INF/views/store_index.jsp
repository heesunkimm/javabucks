<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="store_top.jsp"%>
    <!-- s: content -->
    <section id="store_index" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="top3_box">
                    <p class="tit_box">이번주 판매 TOP3</p>
                    <ul class="top_list">
					    <c:forEach var="menu" items="${top3MenuDetails}" varStatus="status">
					        <li class="top_item">
					            <p class="top_bedge">${status.count}위</p>
					            <div class="img_box">
					                <img src="../../images/upload_menuImages/${menu.menuImages}" alt="${menu.menuName}">
					            </div>
					            <div class="txt_box">
					                <p class="txt_tit">${menu.menuName}</p>
					                <p class="txt_count">총 주문 수량: ${menu.orderCount}건</p>
					            </div>
					        </li>
					    </c:forEach>
					</ul>
                </div>
    
                <div class="news_box">
                    <p class="tit_box">이 달의 새소식</p>
                    <div class="news_container swiper">
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
            </div>
			<div class="annualsales_box">
			    <p class="tit_box">${currentYear}년 매출 현황</p> <!-- 현재 연도 표시 -->
			    <div class="sales_chart">
			        <div class="chart_inner">
			            <ul class="chart_statistic">
			                <li class="statistic_item">0원</li>
			                <li class="statistic_item">
			                <fmt:formatNumber value="${maxSales}" type="number" groupingUsed="true"/>원</li>
			            </ul>
			            <ul class="monthly_list">
			                <c:forEach var="sales" items="${salesData}" varStatus="status">
			                    <li class="monthly_item">
			                        <div class="txt_box">
			                            <strong class="txt_month">${status.index + 1}월</strong>
			                        </div>
			                        <div class="chart_graph">
			                            <span class="sales" style="height: ${maxSales > 0 ? (sales / maxSales * 100) : 0}%;"></span>
			                        </div>
			                        <div class="sales_amount">
			                        	<p><fmt:formatNumber value="${sales}" type="number" groupingUsed="true"/>원</p>
			                        </div>
			                    </li>
			                </c:forEach>
			            </ul>
			        </div>                                                 
			    </div>
			</div>
        </div>
    </section>
    <!-- e: content -->
    <%@ include file="store_bottom.jsp"%>
    <script>
        let swiper = new Swiper(".news_container", {
            slidesPerView: 1,
            spaceBetween: 0,
            loop: true,
            autoplay: {
                delay: 5000,
            },
            pagination: {
            el: ".news_pagination",
            clickable: true,
            }
        });
    </script>

