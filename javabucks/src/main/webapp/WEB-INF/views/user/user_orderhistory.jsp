<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <section id="user_orderhistory" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">매장 주문 히스토리</p>
            </div>
            <div class="period_box">
                <label>
                    <select name="">
                        <option value="">주문상태(전체)</option>
                        <option value="">주문완료</option>
                        <option value="">제조중</option>
                        <option value="">제조완료</option>
                        <option value="">주문취소</option>
                    </select>
                </label>
            </div>

            <div class="view_date">
                <p class="font_gray">2024.07.01  ~ 2024.08.01</p>
                <a class="popup_btn font_green" href="javascript:;" data-popup="periodpop">기간 설정</a>
            </div>
            <c:if test="${empty orderInfoList}">
            	<ul class="history_list">
	                <li class="history_item">
	                    <div class="txt_box">
	                        <p class="txt_tit">주문내역이 없습니다.</p>
	                    </div>
	                </li>
	            </ul>
            </c:if>
			<c:if test="${not empty orderInfoList}">
	            <ul class="history_list">
	            	<c:forEach var="order" items="${orderInfoList}">
		                <li class="history_item">
		                    <!-- 메뉴준비 상태, 갯수에 따라 딤처리 menu_status 추가 -->
		                    <div class="img_box">
		                        <img src="../images/logo/starbucks_logo_black.png" alt="">
		                    </div>
		                    <div class="txt_box">
		                        <p class="txt_tit">${order.orderList }</p>
		                        <ul class="txt_desc">
		                            <li class="font_gray">${order.orderDate}</li>
		                            <li>${order.bucksId}<span>${order.orderPrice}</span></li>
		                        </ul>
		                    </div>
		                </li>
		            </c:forEach>
	            </ul>
            </c:if>
            
        </div>
        <!-- 기간설정 팝업 -->
        <div class="popup_box period_date" id="periodpop" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">기간 설정</p>
            </div>
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <div class="date_box">
                     <label>시작일
                         <input type="date" name="" value="">
                     </label>
                     <label>종료일
                         <input type="date" name="" value="">
                     </label>
                 </div>
                <div class="select_period">
                    <label>
                        <input type="radio" name="period_startdate" value="">
                        1개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="">
                        3개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="" checked>
                        기간설정
                    </label>
                </div>
                <ul class="date_noti">
                    <li>* 최근 3개월까지의 이력만 조회 가능합니다.</li>
                </ul>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" type="button" data-popup="periodpop">취소</button>
                    <button type="submit">완료</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>