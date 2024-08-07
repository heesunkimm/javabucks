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
    <section id="user_mymenu" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">나만의메뉴</p>
            </div>
            <ul class="menu_list">
                <li class="menu_item">
                    <div class="close_icon img_box">
                        <a href="javascript:;">
                            <img src="../images/icons/close.png" alt="">
                        </a>
                    </div>
                    <div class="menu_icon img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">메뉴명</p>
                        <p class="txt_price">메뉴가격</p>
                        <div class="btn_box">
                            <button type="button">담기</button>
                            <button type="button">주문하기</button>
                        </div>
                    </div>
                </li>
            </ul>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>