<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin_top.jsp"%>
<!-- s: content -->
<section id="admin_storeorder" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>지점별 발주현황</p>
        </div>

        <div class="search_box">
            <form name="searchBaljoo_f" action="" method="post">
                <div style="width: 100%;">
                    <label>발주기간
                        <select name="selectYear">
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                        </select>
                    </label>년
                    <label>
                        <select name="selectMonth">
                            <option value="12">12</option>
                            <option value="11">11</option>
                            <option value="10">10</option>
                            <option value="9">9</option>
                            <option value="8">8</option>
                            <option value="7">7</option>
                            <option value="6">6</option>
                            <option value="5">5</option>
                            <option value="4">4</option>
                            <option value="3">3</option>
                            <option value="2">2</option>
                            <option value="1">1</option>
                        </select>
                    </label>월
                    <label>
                        <input type="checkbox" name="unpro" value="">미처리건 조회
                    </label>
                </div>
                <label>발주지점
                    <select name="selectStore">
                        <option value="">1</option>
                    </select>
                </label>
                <label>발주번호
                    <select name="selectBaljooNum">
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
                            <th>발주번호</th>
                            <th>발주일</th>
                            <th>발주지점</th>
                            <th>발주품목</th>
                            <th>발주금액</th>
                            <th>발주처리</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="baljoo" items="${baljooList}">
	                        <tr>
	                        	<td>${baljoo.baljooNum}</td>
	                            <td>		                            
		                            <c:set var="parsedDate" value="${baljoo.baljooDate}" />	                       
									<fmt:parseDate var="date" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss" />
									<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />	
	                            </td>	                            
	                            <td>${baljoo.bucksName}</td>
	                            <td>${baljoo.baljooList}</td>
	                            <td><fmt:formatNumber value="${baljoo.baljooPrice}" pattern="###,###"/>원</td>
	                            <td><a href="javascript:;">[처리]</a></td>
	                        </tr>
	                	</c:forEach>
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
