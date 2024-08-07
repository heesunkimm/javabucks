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
<section id="store_cart" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>장바구니</p>
        </div>

        <form name="" action="" method="post">
            <ul class="cart_list">
                <li class="cart_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <dl>
                            <dt>품목이름</dt>
                            <dd>13,000원</dd>
                        </dl>
                        <div>
                            <div class="count_box">
                                <div class="minus_btn img_box">
                                    <img src="../images/icons/minus.png" alt="">
                                </div>
                                <label>
                                    <input type="text" name="" value="20" readonly>
                                </label>
                                <div class="minus_btn img_box">
                                    <img src="../images/icons/minus.png" alt="">
                                </div>
                            </div>
                            <button type="button">수량 변경</button>
                        </div>
                        <dl>
                            <dt>금액</dt>
                            <dd>23,000원</dd>
                        </dl>
                    </div>
                </li>
            </ul>
            <div class="delivers_info bg_beige">
                <div>
                    <dl>
                        <dt>배송예정일:</dt>
                        <dd>2024-08-15</dd>
                    </dl>
                    <dl>
                        <dt>배송지:</dt>
                        <dd>지점주소</dd>
                    </dl>
                </div>
                <div style="text-align: right;">
                    <dl>
                        <dt>최종 주문 금액:</dt>
                        <dd>000,000원</dd>
                    </dl>
                    <button type="button">주문</button>
                </div>
            </div>
        </form>
    </div>
</section>
<!-- e: content -->
