<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/store.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/store.js"></script>
    </head>
    <script>
    $(document).ready(function(){
		$.ajax({
			url: "sessionStoreCheck",
			type: "GET",
			success: function(resp){
				if(!resp){
					alert("올바르지 않은 경로입니다. 로그인 후 이용해주세요.");
					window.location.href = 'store_login';
				}
				else{
					// window.location.href = 'store_index'; 무한로딩
					if (window.location.pathname !== '/store_index') {
                        // 'store_index' 페이지로 리다이렉트
                        window.location.href = 'store_index';
                    }
				}
			},
			error: function(err){
				console.log(err);
			}
		});
	});


		</script>
<body>
    <header class="bg_beige">
        <div class="logo_box img_box">
            <a href="javascript:;">
                <img src="../images/icons/starbucks_logo.png" alt="">
                <span>JAVABUCKS</span>
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
            <a href="javascript:;"><em class="font_green">${inBucks.bucksId} 님</em> 환영합니다.</a>
            <button type="button" onclick="window.location='logout'">로그아웃</button>
        </div>
        <input type="hidden" name="bucksId" value="${inBucks.bucksId}">
    </header>
