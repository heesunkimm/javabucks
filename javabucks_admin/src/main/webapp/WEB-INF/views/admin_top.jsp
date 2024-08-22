<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/admin.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../js/admin.js"></script>
    </head>
<body>
    <header class="bg_beige">
        <div class="logo_box">
            <a href="javascript:;">
            	<div class="img_box">
                    <img src="../images/icons/starbucks_logo.png" alt="">
                </div>
                <span>JAVABUCKS</span>
            </a>
        </div>

        <ul class="nav_list">
            <li class="nav_item">
                <a href="javascript:;">계정관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">관리자 계정 관리</a></li>
                    <li><a href="storemanage.do">지점 계정 관리 </a></li>
                    <li><a href="javascript:;">유저 계정 관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="admin_drinklist">커피 및 음료</a></li>
                    <li><a href="javascript:;">케이크</a></li>
                    <li><a href="javascript:;">샌드위치</a></li>
                    <li><a href="javascript:;">텀블러</a></li>
                    <li><a href="javascript:;">원두</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="adminStoreOrder.do">발주관리</a>
                <ul class="dropdown_content">
                    <li><a href="adminStoreOrder.do">지점 발주현황</a></li>
                    <li><a href="adminStockList.do">본사 재고관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="bucksSalesM.do">월별 지점 매출 관리</a></li>
                    <li><a href="bucksSalesD.do">일별 지점 매출 관리</a></li>
                    <li><a href="bucksOrderSales.do">발주 정산관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">혜택관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">쿠폰발급현황</a></li>
                    <li><a href="javascript:;">쿠폰생성</a></li>
                </ul>
            </li>
        </ul>

        <div class="store_box">
            <a href="javascript:;"><em class="font_green">관리자 OOO</em> 로그인하셨습니다.</a>
        </div>
    </header>