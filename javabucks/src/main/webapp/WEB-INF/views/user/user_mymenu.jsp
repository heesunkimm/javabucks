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
    <section id="user_mymenu" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">나만의메뉴</p>
            </div>
            <ul class="menu_list">
            	<c:if test="${empty mymenu}">
            	<li class="menu_item">
	            	<p class="txt_tit">등록된 나만의 메뉴가 없습니다.</p>
	            	<p class="txt_price">즐겨 찾는 음료나 푸드를 나만의 메뉴로 등록하고 빠르게 주문해 보세요.<br>
	            	 아래 화면에서 ♥를 눌러 등록할 수 있습니다.</p>
            	 </li>
            	</c:if>
            	<c:if test="${not empty mymenu}">
            	<c:forEach var="menu" items="${mymenu}">
                <li class="menu_item">
                    <div class="close_icon img_box">
                        <a href="user_mymenu?mode=deleteMymenu&menuCode=${menu.menuCode}">
                            <img src="../images/icons/close.png" alt="">
                        </a>
                    </div>
                    <div class="menu_icon img_box">
                        <img src="upload_menuImages/${menu.menuImages}" alt="">
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">${menu.menuName}</p>
                        <p class="txt_price"><fmt:formatNumber value="${menu.menuPrice}" pattern="#,###"/></p>
                        <div class="btn_box">
                            <button type="button" onclick="ToCart()">담기</button>
                            <button type="button" onclick="ToOrder()">주문하기</button>
                        </div>
                    </div>
                </li>
                </c:forEach>
                </c:if>
            </ul>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script>
    function ToCart() {
        // 알림창을 띄웁니다.
        var userConfirmed = confirm("주문하실 매장을 선택해주세요.");

        // 사용자가 '확인'을 눌렀다면 페이지를 이동합니다.
        if (userConfirmed) {
            window.location.href = "/user_store?where=mymenu&go=cart"; // 이동할 페이지의 URL을 지정합니다.
        }
    }
    
    function ToOrder() {
        // 알림창을 띄웁니다.
        var userConfirmed = confirm("주문하실 매장을 선택해주세요.");

        // 사용자가 '확인'을 눌렀다면 페이지를 이동합니다.
        if (userConfirmed) {
            window.location.href = "/user_store?where=mymenu&go=order"; // 이동할 페이지의 URL을 지정합니다.
        }
    }
</script>
