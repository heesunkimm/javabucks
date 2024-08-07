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
<body>
    <header class="bg_beige">
        <div class="logo_box img_box">
            <a href="javascript:;">
                <img src="../images/logo/starbucks_logo.png" alt="">
                <span>JAVABUCKS</span>
            </a>
        </div>

        <ul class="nav_list">
            <li class="nav_item">
                <a href="javascript:;">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">커피 및 케이크</a></li>
                    <li><a href="javascript:;">케이크</a></li>
                    <li><a href="javascript:;">샌드위치</a></li>
                    <li><a href="javascript:;">텀블러</a></li>
                    <li><a href="javascript:;">원두</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">재고관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">재고현황</a></li>
                    <li><a href="javascript:;">장바구니</a></li>
                    <li><a href="javascript:;">발주내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">주문관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">배달관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">매출관리</a></li>
                    <li><a href="javascript:;">발주정산</a></li>
                </ul>
            </li>
        </ul>

        <div class="store_box">
            <a href="javascript:;"><em class="font_green">JavaBucks **지점</em> 환영합니다.</a>
        </div>
    </header>
<!-- s: content -->
<section id="store_orderhistory" class="content orderhistory">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>매장주문내역</p>
        </div>

        <div class="search_box">
            <form name="" action="" method="post">
                <label>주문일
                    <input type="date" name="" value="">
                </label>
                <label>주문번호
                    <input type="text" name="" value="">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="list_box">
            <ul class="search_list bg_beige">
                <li class="search_item">
                    <div class="search_toolbar">
                        <p style="width: 14%;">주문번호</p>
                        <p style="width: 50%;">주문내역</p>
                        <p style="width: 18%;">주문금액</p>
                        <p style="width: 18%;">주문일시</p>
                    </div>
                    <p class="order_num" style="width: 14%; text-align: center;">A-01</p>
                    <ul class="menu_list" style="width: 50%;">
                        <li class="menu_item">메뉴명 * 1</li>
                        <li class="menu_opt">- 샷추가 + 2</li>
                    </ul>
                    <p class="order_price" style="width: 18%; text-align: center;">23,000원</p>
                    <p class="order_date" style="width: 18%; text-align: center;">2024-08-02 16:22:22</p>
                </li>
            </ul>
        </div>
    </div>
</section>
<!-- e: content -->
