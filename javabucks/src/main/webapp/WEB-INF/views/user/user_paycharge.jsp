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
</head>
<body>
    <!-- s: content -->
    <section id="user_paycharge" class="pay_cont content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">충전하기</p>
            </div>

            <div class="price_box">
                <p>충전 금액</p>
                <button type="button" data-price="1">1만원</button>
                <button type="button" data-price="2">3만원</button>
                <button type="button" data-price="3">5만원</button>
                <button type="button" data-price="4">7만원</button>
                <button type="button" data-price="5">10만원</button>
            </div>

            <div class="btn_box">
                <button class="toggle_btn t_active" type="button" data-toggle="howtopay">결제 수단</button>
            </div>
            <ul id="howtopay" class="pay_list toggle-content">
                <li>
                    <label style="display: flex; align-items: center;">
                        <input type="radio" name="paytype" value="" checked>카카오 페이
                    </label>
                </li>
            </ul>

            <div class="pricecheck_box">
                <form name="" action="" method="post">
                    <dl>
                        <dt>충전 후 예상 총 카드 잔액</dt>
                        <dd>0,000원</dd>
                    </dl>
                    <button class="pay_btn" type="submit">결제하기</button>
                </form>
            </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>    
     <script>
        $(".price_box button").click(function() {
                $(".price_box button").removeClass("p_active");
                $(this).addClass("p_active");
            });

        $(".toggle_btn").each(function() {
            $(this).on('click', function(e) {
                e.preventDefault();
                let popupId = $(this).data('toggle');
                
                $(this).toggleClass('t_active');
                
                if ($(this).hasClass('t_active')) {
                    $('#' + popupId).show();
                } else {
                    $('#' + popupId).hide();
                }
            });
        });

        $("input[name='paytype']").change(function() {
            if ($(".pay_starbucks").is(":checked")) {
                $(".cardlist").show();
            } else {
                $(".cardlist").hide();
            }
        });
     </script>
