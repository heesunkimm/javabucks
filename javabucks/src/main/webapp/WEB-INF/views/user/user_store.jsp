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
    <section id="user_store" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="tit_box">
                    <p class="font_bold">Order</p>
                </div>
    
                <div class="search_box">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="검색">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                    <!-- <a href="javascript:;">자주가는 매장</a> -->
                </div>
            </div>
            <ul class="store_list">
                <li class="store_item">
                    <a class="popup_btn" href="javascript:;" data-popup="pickupselect">
                        <div class="img_box">
                            <!-- <img src="" alt=""> -->
                        </div>
                        <div class="txt_box">
                            <p>지점명</p>
                            <p>지점 주소</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- 픽업 선택 팝업 -->
        <div class="popup_box pickup_box" id="pickupselect" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">픽업은 어떻게 하시겠어요?</p>
            </div>
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <input type="hidden" name="store" value="">
                 <input type="hidden" name="pickup" value="">
                <div class="select_box">
                    <a class="select_btn" href="user_order.html">
                        <div class="img_box">
                            <img src="../images/icons/[li]eat.png" alt="">
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">매장 이용</p>
                            <p class="txt_desc">매장에서 먹을게요</p>
                        </div>
                    </a>
                    <a class="select_btn" href="user_order.html">
                        <div class="img_box">
                            <img src="../images/icons/[li]to_go.png" alt="">
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">To-go</p>
                            <p class="txt_desc">밖으로 가져갈게요</p>
                        </div>
                    </a>
                </div>
                <div class="btn_box">
                    <button class="close_btn" type="button" data-popup="pickupselect">닫기</button>
                </div>
                <!-- e: 내용 작성 -->
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>