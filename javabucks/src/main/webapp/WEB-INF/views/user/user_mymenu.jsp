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
					<input type="hidden" id = "menuCode" name="menuCode" value="${menu.menuCode}">
					<input type="hidden" id = "bucksId" name="bucksId" value="${menu.bucksId}">
					<input type="hidden" id = "pickup" name="pickup" value="">
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
                        <p class="txt_price"><fmt:formatNumber value="${menu.menuPrice}" pattern="#,###"/> 원</p>
                        <div class="btn_box">
                            <button id="store" type="button" onclick="ToOrder('${menu.menuCode}', '매장이용', this)">매장 이용</button>
                            <button id="togo" type="button" onclick="ToOrder('${menu.menuCode}', 'To-go', this)">To-go</button>
                            <button id="delivers" type="button" onclick="ToOrder('${menu.menuCode}', 'Delivers', this)">Delivers</button>
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
	
	function ToOrder(menuCode, pickup, clickedButton) {
		
		// 버튼들에 대한 ID를 설정합니다.
        var buttons = document.querySelectorAll('.btn_box button');

		// 희선님 여기입니다(버튼 클릭 시 클래스 추가)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // 모든 버튼에서 active 클래스를 제거합니다.
        buttons.forEach(function(button) {
            button.classList.remove('active');
        });

        // 클릭된 버튼에 active 클래스를 추가합니다.
        clickedButton.classList.add('active');
    	
        // hidden input 요소의 값을 가져옵니다.
        var pickupInput = document.getElementById('pickup');
        if (pickupInput) {
            pickupInput.value = pickup;
        }
	    // 알림창을 띄웁니다.
	    var userConfirmed = confirm("메뉴 상세 페이지로 이동합니다.");

	    // 사용자가 '확인'을 눌렀다면 페이지를 이동합니다.
	    if (userConfirmed) {
	    		        
	        var hiddenInput = document.getElementById('menuCode');
	        var menuCodeValue = hiddenInput ? hiddenInput.value : menuCode;
	        
	        var hiddenInput2 = document.getElementById('bucksId');
	        var bucksIdValue  = hiddenInput2 ? hiddenInput.value2 : bucksId;

	        
	        // URL에 menuCode를 포함하여 이동합니다.
	        var url = "/user_menudetail?menuCode=" + encodeURIComponent(menuCodeValue) + 
	        			"&bucksId=" + encodeURIComponent(bucksIdValue ) + 
	        			"&pickup=" + encodeURIComponent(pickupInput.value);
	        window.location.href = url;
	    }
	}    
</script>
