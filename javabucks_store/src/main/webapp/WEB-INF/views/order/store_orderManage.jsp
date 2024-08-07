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
        <style>
            #store_ordermanage .order_box .btn_box {margin-bottom: 20px; text-align: right;}
            #store_ordermanage .order_box .btn_box button {width: 80px; height: 26px; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fff;}
            #store_ordermanage .order_box .order_wrap .orders_tit {font-size: 20px; margin-bottom: 10px;}
            #store_ordermanage .order_box .order_wrap .making_list {width: 500px; max-height: 400px; overflow-y: scroll;}
            #store_ordermanage .order_box .order_wrap .list_item {width: 460px; padding: 16px 20px; border-radius: 2px;}
            #store_ordermanage .order_box .order_wrap .list_item .menu_list .menu_item + .menu_item {margin-top: 6px;}
            #store_ordermanage .order_box .order_wrap .list_item .menu_list .menu_item {margin-top: 10px; font-size: 18px;}
            #store_ordermanage .order_box .order_wrap .list_item .menu_list .menu_opt {margin-top: 4px; padding-left: 6px; font-size: 16px; color: #555;}

            #store_ordermanage .order_box .order_wrap .pagination {margin: 16px 0 0 0; width: 100%;}
            #store_ordermanage .order_box .order_wrap .pagination button {width: 40px;}

            #store_ordermanage .order_box .order_wrap {display: flex; align-items: flex-startc; justify-content: space-between; padding: 20px; border-radius: 2px; background-color: #eee;}
            #store_ordermanage .order_box .order_wrap .orders + .orders {margin-top: 20px;}
            #store_ordermanage .order_box .order_wrap .orders, 
            #store_ordermanage .order_box .making_box {padding: 20px; background-color: #fefefe;}
            #store_ordermanage .order_box .order_wrap .orders .order_list {width: 500px; height: 115px;}
            #store_ordermanage .order_box .order_wrap .orders .order_list:last-child {margin-top: 20px;}
            #store_ordermanage .order_box .order_wrap .orders .order_list .order_item {display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between;}
            #store_ordermanage .order_box .order_wrap .orders .order_list .order_item dl, 
            #store_ordermanage .order_box .making_box .making_item .txt_box dl {display: flex; font-size: 18px;}
            #store_ordermanage .order_box .order_wrap .orders .order_list .order_item dl dt, 
            #store_ordermanage .order_box .making_box .making_item .txt_box dl dt {margin-right: 10px;}

            #store_ordermanage .order_box .making_box {position: relative; max-height: 474px;}
            #store_ordermanage .order_box .making_box .pagination {position: absolute; left: 50%; transform: translateX(-50%); bottom: 20px;}

            #store_ordermanage .order_box .making_box .making_item + .making_item {margin-top: 10px;}
            #store_ordermanage .order_box .making_box .making_item {display: flex; align-items: center; justify-content: space-between;}
            #store_ordermanage .order_box .making_box .making_item .txt_box {width: 400px;}
        </style>
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
    <section id="store_ordermanage" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>주문관리</p>
            </div>

            <div class="order_box">
                <div class="btn_box">
                    <button type="button">주문 막기</button>
                </div>
                <div class="order_wrap">
                    <div>
                        <div class="orders">
                            <p class="orders_tit">매장 신규주문</p>
                            <ul class="order_list">
                                <li class="order_item list_item bg_beige">
                                    <div class="txt_box">
                                        <dl>
                                            <dt>주문번호</dt>
                                            <dd>(A-01)</dd>
                                        </dl>
                                        <ul class="menu_list">
                                            <li class="menu_item">메뉴명 * 1</li>
                                            <li class="menu_opt">- 샷추가 + 2</li>
                                        </ul>
                                    </div>
                                    <button type="button">주문접수</button>
                                </li>
                            </ul>
                            <div class="pagination">
                                <button type="button">이전</button>
                                <button type="button">다음</button>
                            </div>
                        </div>
                            
                        <div class="orders">
                            <p class="orders_tit">배달 신규주문</p>
                            <ul class="order_list">
                                <li class="order_item list_item bg_beige">
                                    <div class="txt_box">
                                        <dl>
                                            <dt>주문번호</dt>
                                            <dd>(A-01)</dd>
                                        </dl>
                                        <ul class="menu_list">
                                            <li class="menu_item">메뉴명 * 1</li>
                                            <li class="menu_opt">- 샷추가 + 2</li>
                                        </ul>
                                    </div>
                                    <button type="button">주문접수</button>
                                </li>
                            </ul>
                            <div class="pagination">
                                <button type="button">이전</button>
                                <button type="button">다음</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="making_box">
                        <p class="orders_tit">제조중</p>
                        <ul class="making_list list_box">
                            <li class="making_item list_item bg_beige">
                                <div class="txt_box">
                                    <dl>
                                        <dt>주문번호</dt>
                                        <dd>(A-01)</dd>
                                    </dl>
                                    <ul class="menu_list">
                                        <li class="menu_item">메뉴명 * 1</li>
                                        <li class="menu_opt">- 샷추가 + 2</li>
                                    </ul>
                                </div>
                                <button type="button">제조완료</button>
                                <div class="pagination"></div>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <!-- e: content -->
    <footer></footer>
</body>
</html>