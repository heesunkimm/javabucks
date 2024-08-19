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
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="../js/user.js"></script>
    <style>
        body {max-width: 768px!important;}

        .tab-content {display: none;}
        .div_box {margin-top: 20px;}
        .content {padding: 0 0 100px;}
        .addcontent {padding: 0 0 140px;}
        .inner_wrap > .tit_box {padding-bottom: 20px; font-size: 32px;}
        #user_paynow .store_confirm {border-top: 1px solid #ccc; padding: 20px 0;}
        #user_paynow .store_confirm li:first-child {font-size: 18px; line-height: 28px;}
        #user_paynow .store_confirm li span {margin-left: 10px; display: inline-block; font-size: 16px;}
        #user_paynow .store_confirm li:not(:first-child) {font-size: 16px; line-height: 26px;}

        #user_paynow .btn_box button {position: relative; width: 100%; padding: 10px 0; font-size: 20px; text-align: left;}
        #user_paynow .btn_box button::after {content: ''; position: absolute; top: 50%; transform: translateY(-50%) rotate(45deg); right: 0; display: block; width: 16px; height: 16px; border-bottom: 2px solid #555; border-right: 2px solid #555;}

        #user_paynow .btn_box .toggle_btn.t_active::after {transform: rotate(-135deg);}

        #user_paynow .pay_list {padding: 20px 0;}
        #user_paynow .pay_list .pay_item {display: flex; align-items: flex-start; justify-content: space-between; padding:  10px 20px;}
        #user_paynow .pay_list .pay_item .img_box {width: 100px; height: 100px; border-radius: 50%; border: 1px solid #ccc;}

        #user_paynow .pay_list .pay_item .img_box.cpn_icon {width: 50px; height: 50px; filter: brightness(0) saturate(100%) invert(32%) sepia(3%) saturate(8%) hue-rotate(339deg) brightness(96%) contrast(87%); border-radius: 0; border: none;}

        #user_paynow .pay_list .pay_item .txt_box {width: 600px;}
        #user_paynow .pay_list .pay_item .txt_box dl:first-child {font-size: 16px;}
        #user_paynow .pay_list .pay_item .txt_box dl:not(:first-child) {margin-top: 6px; font-size: 14px;}
        #user_paynow .pay_list .pay_item .txt_box dl {display: flex; align-items: center; justify-content: space-between;}

        #user_paynow #howtopay input[type="radio"] {margin-right: 10px; width: 20px; height: 20px;}
        #user_paynow #howtopay > li {padding: 12px 0;}
        #user_paynow #howtopay .cardlist {overflow: visible; margin-top: 20px; width: 420px; height: 370px;}
        #user_paynow #howtopay .cardlist li +li {margin-left: 30px;}
        #user_paynow #howtopay .cardlist .card_slide {width: 420px;}
        #user_paynow #howtopay .cardlist .card_slide a {display: inline-block; width: 100%; height: 264px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box {margin-top: 6px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box .txt_name {font-size: 16px;}
        #user_paynow #howtopay .cardlist .card_slide .txt_box .txt_price {margin-top: 4px; font-size: 16px; color: #555;}
        #user_paynow #howtopay .cardlist .add_slide {height: 264px; border: 1px solid #ccc; border-radius: 8px;}
        #user_paynow #howtopay .cardlist .add_slide a {display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 20px;}
        #user_paynow #howtopay .cardlist .add_slide .add_icon {width: 30px; height: 30px; filter: brightness(0) saturate(100%) invert(34%) sepia(0%) saturate(1425%) hue-rotate(280deg) brightness(92%) contrast(87%);}

        #user_paynow .cpn_box {border-top: 1px solid #ccc;}
        #user_paynow .cpn_box a {display: flex; align-items: center; gap: 20px; padding: 20px;}
        #user_paynow .cpn_box .img_box {width: 30px; height: 30px;}

        #user_paynow .cpnpop {width: 400px; padding: 30px 20px 0;}
        #user_paynow .cpnpop .tit_box {font-size: 18px;}
        #user_paynow .cpnpop form {margin-top: 16px;}
        #user_paynow .cpnpop .cpn_list li + li {border-top: 1px solid #ccc;}
        #user_paynow .cpnpop .cpn_list li a {display: flex; align-items: center; gap: 20px; padding: 10px 0;}
        #user_paynow .cpnpop .cpn_list li .img_box {width: 46px; height: 46px; border: 1px solid #ccc;}
        #user_paynow .cpnpop .cpn_list li .txt_box .txt_tit {font-size: 16px;}
        #user_paynow .cpnpop .cpn_list li .txt_box .txt_date {margin-top: 6px; font-size: 14px; color: #555;}

        #user_paynow .cpnpop .pbtn_box {width: 100%; display: flex; align-items: center; justify-content: center; border-top: 1px solid #ccc;}
        #user_paynow .cpnpop .pbtn_box button {position: relative; width: 50%; padding: 20px 0;}
        #user_paynow .cpnpop .pbtn_box button:first-child {border-right: 1px solid #ccc;}

        #user_paynow .pricecheck_box {padding: 20px; background-color: #eee;}
        #user_paynow .pricecheck_box dl {display: flex; align-items: center; justify-content: space-between;}
        #user_paynow .pricecheck_box dl:not(:nth-child(3)) {margin-top: 10px; font-size: 18px;}
        #user_paynow .pricecheck_box dl:nth-child(3) {margin-top: 16px; font-size: 20px; font-weight: 700;}
        #user_paynow .pricecheck_box .pay_btn {margin-top: 16px; width: 100%; height: 34px; line-height: 34px; padding: 0 10px; border-radius: 25px; background-color: #006241; font-size: 18px; color: #fefefe;}
    </style>
    
</head>
<body>
    <!-- s: content -->
    <section id="user_paynow" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">결제하기</p>
            </div>

            <ul class="store_confirm">
                <li>주문하신 매장을 확인해주세요!</li>
                <li>지점명<span class="font_gray">To-go/매장이용</span></li>
                <li>지점주소</li>
            </ul>

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="orderlist">주문 내역</button>
            </div>
            <ul id="orderlist" class="pay_list toggle-content">
                <li class="pay_item">
                    <div class="img_box">
                        <!-- <img src="" alt=""> -->
                    </div>
                    <div class="txt_box">
                        <dl>
                            <dt class="txt_tit">메뉴명</dt>
                            <dd class="txt_total">총금액</dd>
                        </dl>
                        <dl class="font_gray">
                            <dt><span>ICE</span>|<span>Tall</span></dt>
                            <dd>기본금액</dd>
                        </dl>
                        <dl class="opt_item font_gray">
                            <dt>추가옵션명 * 0</dt>
                            <dd>추가옵션금액</dd>
                        </dl>
                    </div>
                </li>
            </ul>

            <div class="cpn_box">
                <a class="popup_btn" href="javascript:;" data-popup="cpnpay">
                    <div class="img_box">
                        <img src="../images/icons/pay_coupon.png" alt="">
                    </div>
                    <p>사용가능 쿠폰 확인하기</p>
                </a>
            </div>

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="howtopay">결제 수단</button>
            </div>
            <ul id="howtopay" class="pay_list toggle-content">
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" class="pay_starbucks" name="paytype" value="">스타벅스 카드
                    </label>
                    <div style="width: 768px; overflow: hidden;">
                        <div class="cardlist swiper">
                            <ul class="card_wrapper swiper-wrapper">
                                <li class="card_slide swiper-slide">
                                    <a href="javascript:;">
                                        <div class="img_box">
                                            <img src="../images/icons/starbucksCard.png" alt="">
                                        </div>
                                    </a>
                                        <div class="txt_box">
                                            <p class="txt_name">카드이름</p>
                                            <p class="txt_price">잔액</p>
                                        </div>
                                </li>
                                <li class="add_slide card_slide swiper-slide">
                                    <a href="javascript:;">
                                        <p>JavaBucks 카드를 등록하고 <br/>다양한 혜택을 누려보세요!</p>
                                        <div class="add_icon img_box">
                                            <img src="../images/icons/plus.png" alt="">
                                        </div>
                                    </a>
                                </li>
                            </ul>
                            <div class="card_pagination swiper-pagination"></div>
                        </div>
                    </div>
                </li>
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" name="paytype" value="">카카오 페이
                    </label>
                </li>
            </ul>

            <div class="pricecheck_box">
                <form name="" action="" method="post">
                    <dl>
                        <dt>주문 금액</dt>
                        <dd>0,000원</dd>
                    </dl>
                    <dl class="font_gray">
                        <dt>상품 금액</dt>
                        <dd>0,000원</dd>
                    </dl>
                    <dl>
                        <dt>최종 결제 금액</dt>
                        <dd>0,000원</dd>
                    </dl>
                    <button class="pay_btn" type="submit">결제하기</button>
                </form>
            </div>
        </div>
        <!-- 사용가능 쿠폰 리스트 조회 팝업 -->
        <div class="popup_box cpnpop" id="cpnpay" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">쿠폰목록</p>
            </div>
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <ul class="cpn_list">
                    <li>
                        <a href="javascript:;">
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">쿠폰명</p>
                                <p class="txt_date">쿠폰유효기간</p>
                            </div>
                        </a>
                    </li>
                 </ul>
                
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button type="submit">사용하기</button>
                    <button class="close_btn" type="button" data-popup="cpnpay">취소</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
    
<%@ include file="user_bottom.jsp" %>    