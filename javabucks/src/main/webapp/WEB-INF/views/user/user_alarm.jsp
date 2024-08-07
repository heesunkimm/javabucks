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
    <section id="user_alarm" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">알림</p>
            </div>
            <div class="select_box">
                <label>
                    <select name="">
                        <option value="">전체</option>
                        <!-- 등급 변경시 -->
                        <option value="">프로모션/이벤트</option>
                        <option value="">쿠폰 알림</option>
                        <option value="">사이렌 오더 알림</option>
                        <option value="">카드 충전 알림</option>
                    </select>
                </label>
            </div>

            <ul class="history_list">
                <!-- 프로모션/이벤트 > 등급변경시 -->
                <li class="history_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">
                            GOLD Level이 되신 것을 축하합니다.
                        </p>
                        <p class="txt_date font_gray">2024.03.16 14:21:00</p>
                    </div>
                </li>
                <!-- 쿠폰 알림 > 쿠폰발급시 -->
                <li class="history_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">
                            (쿠폰명)이 발급되었습니다.
                        </p>
                        <p class="txt_date font_gray">2024.03.16 14:21:00</p>
                    </div>
                </li>
                <!-- 사이렌 오더 알림 > 매장에서 주문확인했을때 -->
                <li class="history_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">
                            2번째로 메뉴를 준비중입니다. (B-20) <br/>
                            전자영수증이 발행되었습니다.
                        </p>
                        <p class="txt_date font_gray">2024.03.16 14:21:00</p>
                    </div>
                </li>
                <!-- 사이렌 오더 알림 > 제조완료상태 -->
                <li class="history_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">
                            메뉴가 모두 준비되었어요. <br/>
                            픽업대에서 메뉴를 픽업해주세요!
                        </p>
                        <p class="txt_date font_gray">2024.03.16 14:21:00</p>
                    </div>
                </li>
                <!-- 카드 충전 알림 > 카드충전시 -->
                <li class="history_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">
                            (카드명)에 (금액)원 충전되었습니다.
                        </p>
                        <p class="txt_date font_gray">2024.03.16 14:21:00</p>
                    </div>
                </li>
            </ul>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>