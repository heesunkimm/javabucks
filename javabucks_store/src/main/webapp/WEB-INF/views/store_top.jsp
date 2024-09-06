<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JAVABUCKS_STORE</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/store.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/store.js"></script>
        <script>
		 $(document).ready(function(){
		    	$.ajax({
		    		url: "sessionStoreCheck.ajax",
		    		type: "get",
		    		success: function(resp){
		    			if(!resp){
		    				alert("올바르지 않은 경로입니다. 로그인 후 이용해주세요.");
		    				window.location.href = 'store_login';
		    			}
		    		},
		    		error: function(err){
		    			console.log(err);
		    		}
		    	});
		    });
	    </script>
    </head>
<body>
    <header class="bg_beige">
	    <div class="logo_box">
            <a href="/store_index.do">
            	<div class="img_box">
                    <img src="../images/icons/starbucks_logo.png" alt="">
                </div>
                <span>JAVABUCKS STORE</span>
            </a>
        </div>

        <ul class="nav_list">
            <li class="nav_item">
                <a href="store_alldrink">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="store_alldrink">커피 및 음료</a></li>
                    <li><a href="store_alldessert">디저트</a></li>
                    <li><a href="store_allmd">MD</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="stocks.do">재고관리</a>
                <ul class="dropdown_content">
                    <li><a href="stocks.do">재고현황</a></li>
                    <li><a href="stocksCart.do">장바구니</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="orderManage.do">주문관리</a>
                <ul class="dropdown_content">
                    <li><a href="orderManage.do">주문현황</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="orderHistory.do">주문내역</a>
                <ul class="dropdown_content">
                    <li><a href="orderHistory.do">매장 주문내역</a></li>
                    <li><a href="deliversHistory.do">배달 주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="store_sales.do">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="store_sales.do">매출관리</a></li>
                    <li><a href="store_baljooManage.do">발주정산</a></li>
                </ul>
            </li>
        </ul>
		<div class="store_box">
        	<p><em class="font_green">${inBucks.bucksId}님</em> 환영합니다.</p>
            <a class="setBtn" href="javascript:;"><img src="../images/icons/setting.png" alt=""></a>
	        <ul class="setting_box" style="display:none;">
	        	<li><a class="popup_btn" href="javascript:;" data-popup="passwdEdit">비밀번호 변경</a></li>
	        	<li><a href="user_logout.do">로그아웃</a></li>
	        </ul>
        </div>
        <input type="hidden" name="bucksId" value="${inBucks.bucksId}">
    </header>
	<!-- 비밀번호 변경 팝업 -->
    <div id="passwdEdit" class="popup_box" style="display: none;">
        <p class="popup_title">비밀번호 변경</p>
        <form name="f" action="" method="post">
            <div class="input_box">
                <label>신규 비밀번호
                    <input type="password" name="storePasswd1" value="">
                </label>
                <label>신규 비밀번호 확인
                    <input type="password" name="storePasswd2" value="">
                </label>
            </div>
            <div class="pbtn_box">
            	<input type="hidden" name="bucksId" value="${inBucks.bucksId}">
                <button class="editBtn" type="button" onclick="changePw()">비밀번호 변경</button>
                <button class="close_btn" type="button" data-popup="passwdEdit">취소</button>
            </div>
        </form>
    </div>
    <div class="dimm"></div>