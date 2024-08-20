<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
      <div class="logo_box">
        <a href="javascript:;">
            <div class="img_box">
                <img src="../images/logo/starbucks_logo.png" alt="">
            </div>
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
            <a href="javascript:;">
            	<!-- <em class="font_green">JavaBucks **지점</em>  -->
            		<em class="font_green">${inBucks.bucksName} 지점</em> 
            환영합니다.</a>
        </div>
    </header>
    <!-- s: content -->
    <section id="store_index" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="top3_box">
                    <p class="tit_box">이번주 판매 TOP3</p>
                    <ul class="top_list">
                        <li class="top_item">
                            <p class="top_bedge">1위</p>
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명메뉴명메뉴명메뉴명</p>
                                <p class="txt_count">총 주문 00건</p>
                            </div>
                        </li>
                        <li class="top_item">
                            <p class="top_bedge">2위</p>
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명메뉴명메뉴명메뉴명</p>
                                <p class="txt_count">총 주문 00건</p>
                            </div>
                        </li>
                        <li class="top_item">
                            <p class="top_bedge">3위</p>
                            <div class="img_box">
                                <!-- <img src="" alt=""> -->
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">메뉴명메뉴명메뉴명메뉴명</p>
                                <p class="txt_count">총 주문 00건</p>
                            </div>
                        </li>
                    </ul>
                </div>
    
                <div class="news_box">
                    <p class="tit_box">이 달의 새소식</p>
                    <div class="news_container swiper">
                        <ul class="news_wrapper swiper-wrapper">
                            <li class="news_wrapper swiper-slide">
                                <div class="img_box">
                                    <img src="../images/banner/mini_banner01.jpeg" alt="">
                                </div>
                            </li>
                            <li class="news_wrapper swiper-slide">
                                <div class="img_box">
                                    <img src="../images/banner/mini_banner02.jpeg" alt="">
                                </div>
                            </li>
                        </ul>
                        <div class="news_pagination swiper-pagination"></div>
                    </div>
                </div>
            </div>
            <div class="annualsales_box">
                <p class="tit_box">최근 1년 매출 현황</p>
                <div class="sales_chart">
                    <div class="chart_inner">
                      <ul class="chart_statistic">
                        <li class="statistic_item">0</li>
                        <li class="statistic_item">25</li>
                        <li class="statistic_item">50</li>
                        <li class="statistic_item">75</li>
                        <li class="statistic_item">100</li>
                      </ul>
                      <ul class="monthly_list">
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">1월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:32%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">2월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:65%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">3월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:45%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">4월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:62%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">5월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:70%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">6월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:30%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">7월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:20%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">8월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:70%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">9월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:30%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">10월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:50%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">11월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:40%;"></span>
                          </button>
                        </li>
                        <li class="monthly_item">
                          <div class="txt_box">
                            <strong class="txt_month">12월</strong>
                          </div>
                          <button class="chart_graph" type="button">
                            <span class="sales" style="height:80%;"></span>
                          </button>
                        </li>
                      </ul>
                    </div>                                                 
                  </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
    <footer></footer>
    <script>
        let swiper = new Swiper(".news_container", {
            slidesPerView: 1,
            spaceBetween: 0,
            loop: true,
            autoplay: {
                delay: 5000,
            },
            pagination: {
            el: ".news_pagination",
            clickable: true,
            }
        });
    </script>
</body>
</html>