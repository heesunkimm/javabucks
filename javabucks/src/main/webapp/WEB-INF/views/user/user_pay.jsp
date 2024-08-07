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
    <section id="user_pay" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">Pay</p>
            </div>

            <div class="card_box div_box">
                <p>JavaBucks Card</p>
                <ul class="card_list div_box">
                    <li>
                        <a class="popup_btn" href="javascript:;" data-popup="cardpay">
                            <div class="img_box">
                                <img src="../images/icons/starbucksCard.png" alt="">
                            </div>
                        </a>
                    </li>

                </ul>
                <!-- 카드등록 페이지 이동 -->
                <div class="addcard_box div_box">
                    <a class="" href="user_addcard">
                        <p>JavaBucks 카드를 등록하고 <br/>다양한 혜택을 누려보세요!</p>
                        <div class="add_icon img_box">
                            <img src="../images/icons/plus.png" alt="">
                        </div>
                    </a>
                </div>
            </div>

        </div>
        <!-- 카드결제 팝업 -->
        <div class="popup_box pay_card" id="cardpay" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">JavaBucks e카드</p>
                <a class="popup_btn edit_btn" href="javascript:;" data-popup="cardedit">
                    <img src="../images/icons/edit.png" alt="">
                </a>
            </div>
            <a class="close_btn" href="javascript:;" data-popup="cardpay">
                <img src="../images/icons/close.png" alt="">
            </a>
            <p class="card_price">잔액: <span>50,000</span>원</p>
            <div class="card_img img_box">
                <img src="../images/icons/starbucksCard.png" alt="">
            </div>
            <form name="f" action="user_paynow" method="post">
                <!-- s: 내용 작성 -->
                
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button type="submit">결제하기</button>
                    <button type="button">충전하기</button>
                </div>
            </form>
        </div>
        <!-- 카드명 수정 -->
        <div class="popup_box edit_card" id="cardedit" style="display: none;">
            <form name="f" action="" method="post">
                <!-- s: 내용 작성 -->
                 <div class="insert_box">
                     <p>카드 이름을 입력해주세요.</p>
                     <label>카드 이름
                         <input type="text" name="" value="">
                     </label>
                 </div>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" data-popup="cardedit" type="button">취소</button>
                    <button type="submit">확인</button>
                </div>
            </form>
        </div>
       
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
     <script>
        $(".edit_btn").on("click",function () {
            if(!$(".edit_card").hasClass("s_active")) {
                $(".pay_card").removeClass("s_active");
            }
        })
        $(".edit_card .close_btn").on("click",function () {
            $(".pay_card").addClass("s_active");
        })
     </script>
<%@ include file="user_bottom.jsp" %>