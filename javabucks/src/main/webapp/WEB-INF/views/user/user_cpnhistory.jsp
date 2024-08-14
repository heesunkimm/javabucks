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
    <section id="user_cpnhistory" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">쿠폰 히스토리</p>
            </div>
             <c:if test="${empty couponlist}">
           	 사용 가능한 쿠폰이 없어요
            </c:if>
			<c:forEach var ="dto" items="${couponlist}">
            <ul class="cpn_list">
                <!-- 쿠폰 사용완료시 <li class="cpn_item">에 use_complete 클래스 추가하면 딤처리됨 -->
                <li class="cpn_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_sub">JabaBucks</p>
                        <p class="txt_tit">${dto.cpnName} ${dto.cpnDesc}</p>
                        <ul class="txt_desc">
                            <li>${dto.cpnListEndDate}</li>
                            <li>기간만료</li>
                        </ul>
                    </div>
                </li>
            </ul>
            </c:forEach>
           
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>