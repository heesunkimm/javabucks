<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="store_top.jsp"%>

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
    <%@ include file="store_bottom.jsp"%>
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

