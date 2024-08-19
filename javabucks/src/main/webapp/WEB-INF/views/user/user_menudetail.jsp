<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
    <section id="user_menudetail" class="content">
        <div class="inner_wrap">
            <div class="menu_img img_box">
                <!-- <img src="" alt=""> -->
            </div>

            <div class="txt_box">
                <p class="txt_tit">${menu.menuName}</p>
                <p class="txt_desc">${menu.menuDesc}</p>
                <p class="txt_price">${menu.menuPrice}</p>
            </div>

            <div class="btn_box">
                <button type="button">퍼스널옵션</button>
            </div>
            <div class="opt_wrap">
                <!-- 옵션박스 -->
                <div class="size_box opt_box">
                </div>

                <!-- 옵션: 커피 -->
                <div class="opt_box">
                    <p class="opt_tit">커피</p>
                    <div class="opt_rows">
                        <p>에스프레소 샷</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="">
                            </div>
                            <label>
                                <input type="text" name="" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 옵션: 시럽 -->
                <div class="opt_box">
                    <p class="opt_tit">시럽</p>
                    <div class="opt_rows">
                        <p>바닐라 시럽</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="">
                            </div>
                            <label>
                                <input type="text" name="" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="opt_rows">
                        <p>헤이즐넛 시럽</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="">
                            </div>
                            <label>
                                <input type="text" name="" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="opt_rows">
                        <p>카라멜 시럽</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="">
                            </div>
                            <label>
                                <input type="text" name="" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 옵션: 우유 -->
                <div class="opt_box">
                    <p class="opt_tit">우유</p>
                    <div class="opt_rows">
                        <div class="select_box">
                            <label>
                                <input type="button" name="" value="">
                                <span>일반</span>
                            </label>
                            <label>
                                <input type="button" name="" value="">
                                <span>저지방</span>
                            </label>
                            <label>
                                <input type="button" name="" value="">
                                <span>무지방</span>
                            </label>
                            <label>
                                <input type="button" name="" value="">
                                <span>두유</span>
                            </label>
                            <label>
                                <input type="button" name="" value="">
                                <span>오트(귀리)</span>
                            </label>
                        </div>
                    </div>
                </div>

            </div>

            <div class="order_box">
                <button type="button">담기</button>
                <button type="button">주문하기</button>
                <button class="addlike" type="button">
                    <img src="../images/icons/like.png" alt="">
                </button>
            </div>

        </div>
    </section>
    <!-- e: content -->

<%@ include file="user_bottom.jsp"%>