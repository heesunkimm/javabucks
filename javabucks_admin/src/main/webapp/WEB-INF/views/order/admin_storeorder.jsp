<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin_top.jsp"%>
<!-- s: content -->
<section id="admin_storeorder" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>지점별 발주현황</p>
        </div>

        <div class="search_box">
            <form name="" action="" method="post">
                <div style="width: 100%;">
                    <label>발주기간
                        <select name="">
                            <option value="">2024</option>
                            <option value="">2023</option>
                            <option value="">2022</option>
                            <option value="">2021</option>
                        </select>
                    </label>
                    <label>
                        <select name="">
                            <option value="">12</option>
                            <option value="">11</option>
                            <option value="">10</option>
                            <option value="">9</option>
                            <option value="">8</option>
                            <option value="">7</option>
                            <option value="">6</option>
                            <option value="">5</option>
                            <option value="">4</option>
                            <option value="">3</option>
                            <option value="">2</option>
                            <option value="">1</option>
                        </select>
                    </label>
                    <label>
                        <input type="checkbox" name="" value="">미처리건 조회
                    </label>
                </div>
                <label>발주지점
                    <select name="">
                        <option value="">1</option>
                    </select>
                </label>
                <label>발주번호
                    <select name="">
                        <option value="">1</option>
                    </select>
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="search_list">
            <div class="list_box">
                <table class="search_list s_table">
                    <thead class="bg_green font_white">
                        <tr>
                            <th>발주일</th>
                            <th>발주번호</th>
                            <th>발주지점</th>
                            <th>재고코드</th>
                            <th>품목명</th>
                            <th>발주수량</th>
                            <th>발주처리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>발주일</td>
                            <td>발주번호</td>
                            <td>발주지점</td>
                            <td>재고코드</td>
                            <td>품목명</td>
                            <td>발주수량</td>
                            <td><a href="javascript:;">[처리]</a></td>
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
<!-- e: content -->
<%@ include file="../admin_bottom.jsp"%>
