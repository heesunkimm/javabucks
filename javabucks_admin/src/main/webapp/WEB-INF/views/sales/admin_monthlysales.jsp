<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section id="admin_monthlysales" class="content tab_management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>월별 지점 매출관리</p>
            </div>

            <div class="select_box">
                <form name="" action="" method="post">
                    <div class="count_box">
                        <span>연월</span>
                        <div class="minus_btn img_box">
                            <img src="../images/icons/minus.png" alt="">
                        </div>
                        <input type="text" name="" value="2024-08" readonly>
                        <div class="plus_btn img_box">
                            <img src="../images/icons/plus.png" alt="">
                        </div>
                        <button type="button">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead class="bg_green font_white">
                            <tr>
                                <th>연월</th>
                                <th>매출액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><a class="tab_btn" href="javascript:;" data-tab="2024_01">2024.01</a></td>
                                <td>매출액</td>
                            </tr>
                            <tr class="bg_green font_white">
                                <td>총계</td>
                                <td>000,000,000원</td>
                            </tr>
                        </tbody>
                    </table>

                    <ul id="2024_01" class="s_active tab-content">
                        <li>
                            <ul class="cont_toolbar">
                                <li>메뉴카테고리</li>
                                <li>매출액</li>
                                <li>비중</li>
                            </ul>
                        </li>
                        <li>
                            <ul class="cont_details">
                                <li>메뉴카테고리</li>
                                <li>매출액</li>
                                <li>비중</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
 <jsp:include page="../admin_bottom.jsp"/>