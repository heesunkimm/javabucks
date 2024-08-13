<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <section id="admin_dailysales" class="content management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>일별 지점 매출관리</p>
            </div>

            <div class="select_box">
                <form name="" action="" method="post">
                    <div class="search_box">
                        <label>기간
                            <select name="">
                                <option value="">2024</option>
                                <option value="">2023</option>
                                <option value="">2022</option>
                                <option value="">2021</option>
                                <option value="">2020</option>
                            </select>
                        </label>
                        <label>~
                            <select name="">
                                <option value="">1월</option>
                                <option value="">2월</option>
                                <option value="">3월</option>
                                <option value="">4월</option>
                                <option value="">5월</option>
                                <option value="">6월</option>
                                <option value="">7월</option>
                                <option value="">8월</option>
                                <option value="">9월</option>
                                <option value="">10월</option>
                                <option value="">11월</option>
                                <option value="">12월</option>
                            </select>
                        </label>
                        <label>지점명
                            <input type="text" name="" value="">
                        </label>
                        <label>메뉴 카테고리
                            <select name="">
                                <option value="">-</option>
                            </select>
                        </label>
                        <button type="button">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <p class="totabl_sales">매출액:<span>000,000,000원</span></p>
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>일자</th>
                                <th>지점명</th>
                                <th>지점등록번호</th>
                                <th>점주명</th>
                                <th>메뉴카테고리</th>
                                <th>매출액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>일자</td>
                                <td>지점명</td>
                                <td>지점등록번호</td>
                                <td>점주명</td>
                                <td>메뉴카테고리</td>
                                <td>매출액</td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
                    </div>    
                </div>
            </div>
        </div>
    </section>


 <jsp:include page="../admin_bottom.jsp"/>