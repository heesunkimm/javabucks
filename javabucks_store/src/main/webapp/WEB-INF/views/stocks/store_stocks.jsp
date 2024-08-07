<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/store.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/store.js"></script>
    </head>
<body>
    <header class="bg_beige">
        <div class="logo_box img_box">
            <a href="javascript:;">
                <img src="../images/logo/starbucks_logo.png" alt="">
                <span>JAVABUCKS</span>
            </a>
        </div>

        <ul class="nav_list">
            <li class="nav_item">
                <a href="javascript:;">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">커피 및 케이크</a></li>
                    <li><a href="javascript:;">케이크</a></li>
                    <li><a href="javascript:;">샌드위치</a></li>
                    <li><a href="javascript:;">텀블러</a></li>
                    <li><a href="javascript:;">원두</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">재고관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">재고현황</a></li>
                    <li><a href="javascript:;">장바구니</a></li>
                    <li><a href="javascript:;">발주내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">주문관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">배달관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">매출관리</a></li>
                    <li><a href="javascript:;">발주정산</a></li>
                </ul>
            </li>
        </ul>

        <div class="store_box">
            <a href="javascript:;"><em class="font_green">JavaBucks **지점</em> 환영합니다.</a>
        </div>
    </header>
<!-- s: content -->
<section id="store_stocks" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>재고현황</p>
        </div>

        <div class="select_box">
            <div class="tab_box">
                <a class="tab_btn s_active" href="javascript:;" data-tab="stocks_drink">음료</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_food">푸드</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_cup">컵</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_syrup">시럽</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_whip">휘핑크림</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_milk">우유</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_tumbler">텀블러</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_beans">원두</a>
            </div>

            <div id="stocks_drink" class="tab-content s_active">
                <div class="ttit_box">
                    <p>음료</p>
                </div>

                <ul class="stocks_list">
                    <li class="stocks_item">
                        <div class="img_box">
                            <!-- <img src="" alt=""> -->
                        </div>
                        <div class="txt_box">
                            <dl>
                                <dt>품목이름</dt>
                                <dd>품목설명</dd>
                            </dl>
                            <dl>
                                <dt>발주가격</dt>
                                <dd>13,000원</dd>
                            </dl>
                            <dl>
                                <dt>재고</dt>
                                <dd>10개</dd>
                            </dl>
                            <div class="add_box">
                                <div class="count_box">
                                    <div class="minus_btn img_box">
                                        <img src="../images/icons/minus.png" alt="">
                                    </div>
                                    <label>
                                        <input type="text" name="" value="20" readonly>
                                    </label>
                                    <div class="minus_btn img_box">
                                        <img src="../images/icons/minus.png" alt="">
                                    </div>
                                </div>
                                <button type="button">담기</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div id="stocks_food" class="tab-content">
                <div class="ttit_box">
                    <p>푸드</p>
                </div>
            </div>
            <div id="stocks_cup" class="tab-content">
                <div class="ttit_box">
                    <p>컵</p>
                </div>
            </div>
            <div id="stocks_syrup" class="tab-content">
                <div class="ttit_box">
                    <p>시럽</p>
                </div>
            </div>
            <div id="stocks_whip" class="tab-content">
                <div class="ttit_box">
                    <p>휘핑크림</p>
                </div>
            </div>
            <div id="stocks_milk" class="tab-content">
                <div class="ttit_box">
                    <p>우유</p>
                </div>
            </div>
            <div id="stocks_tumbler" class="tab-content">
                <div class="ttit_box">
                    <p>텀블러</p>
                </div>
            </div>
            <div id="stocks_beans" class="tab-content">
                <div class="ttit_box">
                    <p>원두</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- e: content -->