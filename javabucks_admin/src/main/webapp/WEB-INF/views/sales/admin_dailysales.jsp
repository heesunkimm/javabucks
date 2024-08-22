<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>
.paging {
    display: flex;
    justify-content: center;
    margin: 20px 0;
}

.paging a {
    margin: 0 3px; /* 좌우 간격을 줄여 버튼 사이의 간격을 좁힘 */
    padding: 5px 10px; /* 패딩을 줄여 버튼을 작게 만듦 */
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    text-decoration: none;
    color: #333;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    font-size: 14px; /* 폰트 크기를 줄여 버튼을 더 작게 만듦 */
}

.paging a.active {
    background-color: #006242;
    color: white;
    border-color: #006242;
}

.paging a:hover {
    background-color: #0056b3;
    color: white;
}

</style>

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
                            <input type="date" name="endDate" value="" required>
                        </label>
                        
                        <label>지점명
                            <input type="text" name="bucksName" required>
                        </label>
                        <label>메뉴 카테고리
                            <select name="category">
                            	<option value="">전체</option>
                                <option value="음료">음료</option>
                                <option value="디저트">디저트</option>
                                <option value="MD상품">MD상품</option>
                            </select>
                        </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <p class="totabl_sales">해당 기간 총 매출액:<span><fmt:formatNumber value="${total}" pattern="#,##0"/>원</span></p>
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
                            <c:when test="${empty branchSalesMap}">
                                <tr>
                                    <td colspan="6">해당 날짜의 매출이 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${branchSalesMap}" var="entry">
                                    <c:forEach var="dlist" items="${list}">
                                        <c:set var="branchDateKey" value="${dlist.bucksId}_${dlist.payhistoryDate}" />
											<c:if test="${branchDateKey eq entry.key}">
                                            <!-- 지점 정보 출력 (첫 번째 카테고리 항목에만 출력) -->
                                             <tr>
                                                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.payhistoryDate}"/></td> <!-- 일자 -->
                                                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.branchName}"/></td> <!-- 지점명 -->
                                                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.bucksId}"/></td> <!-- 지점 등록번호 -->
                                                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.bucksOwner}"/></td> <!-- 점주명 -->
                                            </tr>
                                            <!-- 각 카테고리 및 매출액 출력 -->
                                            <c:forEach items="${entry.value}" var="categoryEntry">
                                                <tr>
                                                    <td><c:out value="${categoryEntry.key}"/></td> <!-- 메뉴 카테고리 -->
                                                    <td><fmt:formatNumber value="${categoryEntry.value}" pattern="#,##0"/>원</td> <!-- 매출액 -->
                                                </tr>
                                            </c:forEach>
                                            <!-- 지점별 총 매출 합계 출력 -->
                                            <tr>
                                            	<td></td>
                                            	<td></td>
                                            	<td></td>
                                            	<td></td>
                                            	
                                                <td><strong>총 합</strong></td>
                                                <td><strong>
                                                    <c:set var="totalSales" value="0"/>
                                                    <c:forEach items="${entry.value}" var="categoryEntry">
                                                        <c:set var="totalSales" value="${totalSales + categoryEntry.value}"/>
                                                    </c:forEach>
                                                    <fmt:formatNumber value="${totalSales}" pattern="#,##0"/>원
                                                    </strong>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="paging">
            	<c:if test="${pageCount > 1}">
                	<c:set var="startPage" value="${currentPage - 2}"/>
                	
                <c:if test="${startPage lt 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                
                	<c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${endPage gt pageCount}">
                    <c:set var="endPage" value="${pageCount}"/>
                </c:if>
                
                <c:url value="/storemanage.do" var="firstPageUrl">
                    <c:param name="page" value="1"/>
                </c:url>
                
                <c:url value="/storemanage.do" var="prevPageUrl">
                    <c:param name="page" value="${currentPage - 1}"/>
                </c:url>
                
                <a href="${firstPageUrl}">First</a>
                <c:if test="${currentPage > 1}">
                    <a href="${prevPageUrl}">Previous</a>
                </c:if>
                
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
                    <c:url value="/storemanage.do" var="pageUrl">
                        <c:param name="page" value="${pageNumber}"/>
                    </c:url>
                    <a href="${pageUrl}" class="${pageNumber == currentPage ? 'active' : ''}">${pageNumber}</a>
                </c:forEach>
                <c:url value="/storemanage.do" var="nextPageUrl">
                    <c:param name="page" value="${currentPage + 1}"/>
                </c:url>
                <c:if test="${currentPage lt pageCount}">
                    <a href="${nextPageUrl}">Next</a>
                </c:if>
                <c:url value="/storemanage.do" var="lastPageUrl">
                    <c:param name="page" value="${pageCount}"/>
                </c:url>
                <a href="${lastPageUrl}">End</a>
            </c:if>
        </div>
        <!-- e:페이징 -->   
                </div>
            </div>
        </div>
    </section>


 <jsp:include page="../admin_bottom.jsp"/>
 
 <script>
 
 
 
 </script>