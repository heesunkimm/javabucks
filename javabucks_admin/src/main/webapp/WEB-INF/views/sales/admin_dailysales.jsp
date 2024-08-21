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
                <form name="dailySearchForm" action="/searchDailySales.do" method="post">
                    <div class="search_box">
                        <label>기간
                            <input type="date" name="startDate" value="" required>
                            ~
                            <input type="date" name="startDate" value="" required>
                        </label>
                        
                        <label>지점명
                            <input type="text" name="bucksName" required>
                        </label>
                        <label>메뉴 카테고리
                            <select name="category" required>
                            	<option value="">전체</option>
                                <option value="B">음료</option>
                                <option value="C">디저트</option>
                                <option value="M">MD상품</option>
                            </select>
                        </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <p class="totabl_sales">해당 기간 총 매출액:<span>000,000,000원</span></p>
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
                        <c:choose>
						    <c:when test="${empty list}">
						        <tr>
						            <td colspan="6">해당 날짜의 매출이 없습니다.</td>
						        </tr>
						    </c:when>
						    <c:otherwise>
						        <c:forEach items="${list}" var="dlist">
						            <tr>
						                <td>${dlist.payhistoryDate}</td>
						                <td>${dlist.branchName}</td>
						                <td>${dlist.bucksId}</td>
						                <td>${dlist.bucksOwner}</td>
						                <td></td>
						                <td></td>
						            </tr>
						        </c:forEach>
						    </c:otherwise>
						</c:choose>
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