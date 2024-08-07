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
    <section id="user_cart" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">장바구니</p>
            </div>

            <form name="" action="" method="post">
                <div class="toolbar_box">
                    <label>
                        <input type="checkbox" name="" value="">전체 선택
                    </label>
                    <div class="btn_box">
                        <button class="font_green" type="button">선택삭제</button>
                        <button class="font_gray" type="button">전체삭제</button>
                    </div>
                </div>
                <ul class="cart_list">
                    <li class="cart_item">
                        <div class="top_box">
                            <label>
                                <input type="checkbox" name="" value="">
                            </label>
                            <div class="img_box">
                                <img src="../images/icons/close.png" alt="">
                            </div>
                        </div>
                        <div class="menu_info">
                            <div class="menu_img img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명</p>
                                <p class="txt_opt font_gray"><span>ICE</span>|<span>Tall</span>|<span>금액</span></p>
                                <ul class="opt_list font_gray">
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                    <li class="opt_item"><span>추가옵션명</span><span>추가옵션금액</span></li>
                                </ul>
                                <div class="price_box">
                                    <div class="count_box">
                                        <div class="minus_btn img_box">
                                            <img src="../images/icons/minus.png" alt="">
                                        </div>
                                        <label>
                                            <input type="text" name="" value="2" readonly>
                                        </label>
                                        <div class="plus_btn img_box">
                                            <img src="../images/icons/plus.png" alt="">
                                        </div>
                                    </div>
                                    <div class="total_box">
                                        <p>총금액</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <div class="order_box">
                    <div class="txt_box">
                        <p class="txt_count">총 <span class="font_green">0</span>개/20개</p>
                        <p class="txt_total">0원</p>
                    </div>
                    <div class="btn_box">
                        <button type="submit">주문하기</button>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>