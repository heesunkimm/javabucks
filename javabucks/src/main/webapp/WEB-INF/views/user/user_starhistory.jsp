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
    <section id="user_starhistory" class="content">
        <div class="inner_wrap">
                <div class="tit_box">
                    <p class="font_bold">별 히스토리</p>
                </div>

            <div class="star_count div_box">
                <dl>
                    <dt>기간 내 적립한 누적 별</dt>
                    <dd class="font_green">0개</dd>
                </dl>
                <ul class="star_noti">
                    <li>※ 거래 변경, 별 소멸 및 기타 사유로 인해 실제 별 개수와 다소 차이가 있을 수 있습니다.</li>
                </ul>
            </div>

            <div class="view_date div_box">
                <p class="font_gray">2024.07.01  ~ 2024.08.01</p>
                <a class="popup_btn font_green" href="javascript:;" data-popup="periodselect">기간 설정</a>
            </div>

            <div>
                <ul class="add_list">
                    <li>
                        <div class="add_box">
                            <div class="img_box">
                                <img src="../images/icons/star_line.png" alt="">
                            </div>
                            <p>+2</p>
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">적립_별 적립</p>
                            <!-- 일자 =적립시간 / 유효기간 = 1년 -->
                             <ul class="txt_desc">
                                 <li>일자 <span>2024-07-31 12:18:06</span></p>
                                 <li>유효기간 <span>2025-08-01</span></p>
                             </ul>
                        </div>
                    </li>
                </ul>
                <ul class="addlist_noti">
                    <li>최근 3개월까지의 별 히스토리를 조회가능합니다.</li>
                    <li>전체 별 히스토리는 홈페이지에서 조회하실 수 있습니다.</li>
                </ul>
            </div>
        </div>
        <!-- 기간설정 팝업 -->
        <div class="popup_box period_date" id="periodselect" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">기간 설정</p>
            </div>
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <div class="date_box">
                     <label>시작일
                         <input type="date" name="" value="">
                     </label>
                     <label>종료일
                         <input type="date" name="" value="">
                     </label>
                 </div>
                <div class="select_period">
                    <label>
                        <input type="radio" name="period_startdate" value="">
                        1개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="">
                        3개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="" checked>
                        기간설정
                    </label>
                </div>
                <ul class="date_noti">
                    <li>* 최근 3개월까지의 이력만 조회 가능합니다.</li>
                </ul>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" type="button" data-popup="periodselect">취소</button>
                    <button type="submit">완료</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>