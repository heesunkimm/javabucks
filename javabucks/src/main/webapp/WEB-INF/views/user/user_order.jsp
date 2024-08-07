<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <section id="user_order" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">Order</p>
            </div>

            <ul class="cate_list">
                <li><a class="tab_btn s_active" href="javascript:;" data-tab="cate_drink">음료</a></li>
                <li><a class="tab_btn" href="javascript:;" data-tab="cate_foond">푸드</a></li>
                <li><a class="tab_btn" href="javascript:;" data-tab="cate_pdt">상품</a></li>
            </ul>

            <div id="cate_drink" class="tab-content s_active">
                <ul class="menu_list">
                    <li class="menu_item">
                        <a href="user_menudetail.html">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명1</p>
                                <p class="txt_price">가격</p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div id="cate_foond" class="tab-content">
                <ul class="menu_list">
                    <li class="menu_item">
                        <a href="user_menudetail.html">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명2</p>
                                <p class="txt_price">가격</p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div id="cate_pdt" class="tab-content">
                <ul class="menu_list">
                    <li class="menu_item">
                        <a href="user_menudetail.html">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명3</p>
                                <p class="txt_price">가격</p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="cart_box">
                <!-- 클릭시 매장 선택 페이지로 재이동 -->
                 <a class="select_store" href="user_store.html">매장명 <span class="font_gray">(매장이용/To-go)</span></a>
                <button class="cart_btn" type="button">
                    <div class="img_box">
                        <img src="../images/icons/[li]order_basket.png" alt="">
                    </div>
                    <p class="cart_count">0</p>
                </button>
            </div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>