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
    <section id="user_recepit" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">전자영수증</p>
            </div>

            <div class="view_date div_box">
                <p>전체</p>
                <div>
                    <p class="font_gray">2024.07.01  ~ 2024.08.01</p>
                    <a class="toggle_btn font_green" href="javascript:;">▽</a>
                </div>
            </div>
            <!-- 기간설정 토글 -->
            <div class="period_date" id="" style="display: none;">
                <form name="f" action="" method="post">
                    <!-- s: 내용 작성 -->
                    <div class="select_period">
                        <button type="button">1개월</button>
                        <button type="button">1년</button>
                        <button type="button">기간 설정</button>
                    </div>
                     <div class="date_box">
                         <label>
                             <input type="date" name="" value="">
                         </label>
                         <label>
                             <input type="date" name="" value="">
                         </label>
                     </div>

                     <div class="select_pay">
                        <label>
                            거래 유형
                            <select name="">
                                <option value="">전체</option>
                                <option value="">충전</option>
                                <option value="">결제</option>
                            </select>
                        </label>
                        <label>
                            결제 수단
                            <select name="">
                                <option value="">스타벅스 카드</option>
                                <option value="">카카오페이</option>
                            </select>
                        </label>
                     </div>
                    
                    <!-- e: 내용 작성 -->
                    <div class="pbtn_box">
                        <button type="button">취소</button>
                        <button type="submit">조회</button>
                    </div>
                </form>
            </div>

            <div class="list_box">
                <div class="count_box">
                    <p class="font_gray">총 <span class="font_green">0건</span></p>
                    <p class="font_gray">사용합계 <span class="font_green">0원</span></p>
                </div>
                <ul class="add_list">
                    <li>
                        <div class="txt_box">
                            <p class="txt_store">종로3가</p>
                            <div class="font_gray">
                                <p class="txt_date">2024-07-31 12:18:00</p>
                                <p class="txt_pay">결제</p>
                            </div>
                            <p class="txt_price font_green">6,700원</p>
                        </div>
                        <a class="popup_btn" href="javascript:;" data-popup="recepitbox">
                            <div class="img_box">
                                <img src="../images/icons/receipt.png" alt="">
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 영수증 팝업 -->
        <div class="popup_box recepit_detail" id="recepitbox" style="display: none;">
            <div class="tit_box">
                <p>JAVABUCKS</p>
            </div>
            <!-- s: 내용 작성 -->
             <ul class="store_info">
                <li>
                    <span>지점명</span>
                    <span>지점번호</span>
                </li>
                <li>지점위치</li>
                <li>
                    <span>점주</span>
                    <span>지점코드</span>
                </li>
                <li>결제시간</li>
             </ul>
             <div class="user_info">
                <div class="order_num">
                    <p>닉네임</p>
                    <p>(주문번호)</p>
                </div>
                <ul class="order_list">
                    <li class="order_item">
                        <span>메뉴명</span>
                        <div>
                            <span>가격</span>
                            <span>수량</span>
                        </div>
                        <span>합계</span>
                    </li>
                </ul>
                <div class="total_box">
                    <span>합계</span>
                    <span>총금액</span>
                </div>
                <div class="addvat_box">
                    <span><em>결제금액</em><br/><span>(부가세포함)</span></span>
                    <em>총금액</em>
                </div>
                <div class="pay_box">
                    <dl>
                        <dt>스타벅스카드</dt>
                        <dd>결제금액</dd>
                    </dl>
                    <dl>
                        <dt>스타벅스카드</dt>
                        <dd>카드번호</dd>
                    </dl>
                    <dl>
                        <dt>카드잔액</dt>
                        <dd>카드잔액</dd>
                    </dl>
                </div>
                <div class="reward_box">
                    
                </div>
             </div>
            <!-- e: 내용 작성 -->
            <div class="pbtn_box">
                <button class="close_btn" type="button" data-popup="recepitbox">닫기</button>
            </div>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>