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
    <section id="user_cpnhistory" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">쿠폰 히스토리</p>
            </div>

            <ul class="cpn_list">
                <!-- 쿠폰 사용완료시 <li class="cpn_item">에 use_complete 클래스 추가하면 딤처리됨 -->
                <li class="cpn_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_sub">JabaBucks</p>
                        <p class="txt_tit">[사이렌오더전용] 1+1쿠폰</p>
                        <ul class="txt_desc">
                            <li>2024-07-31 12:18:06</li>
                            <li>기간만료</li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>