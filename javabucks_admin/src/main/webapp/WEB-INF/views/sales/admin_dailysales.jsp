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
                    <p class="totabl_sales"> 해당 기간 총 매출액:<span><fmt:formatNumber value="${total}" pattern="#,##0"/>원</span></p> 
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
    <c:set var="alreadyPrinted" value="false" />
    <c:forEach var="dlist" items="${list}">
        <c:set var="branchDateKey" value="${dlist.bucksId}_${dlist.payhistoryDate}" />
        <c:if test="${branchDateKey eq entry.key && alreadyPrinted eq false}">
            <c:set var="alreadyPrinted" value="true" /> <!-- 해당 지점과 날짜가 이미 출력된 경우 -->
            
            <!-- 지점 정보 출력 -->
            <tr>
                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.payhistoryDate}"/></td>
                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.branchName}"/></td>
                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.bucksId}"/></td>
                <td rowspan="${fn:length(entry.value) + 1}"><c:out value="${dlist.bucksOwner}"/></td>
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
    <td></td><td></td><td></td><td></td>
    <td><strong>총 합</strong></td>
    <c:set var="branchId" value="${dlist.bucksId}"/>
    <td><strong><fmt:formatNumber value="${branchTotalSalesMap[branchId]}" pattern="#,##0"/>원</strong></td>
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
					    <c:if test="${currentPage > 1}">
					        <a href="?page=${currentPage - 1}&pageSize=${pageSize}">&laquo; 이전</a>
					    </c:if>
					
					    <c:forEach var="i" begin="1" end="${totalPages}">
					        <c:if test="${i == currentPage}">
					            <strong>${i}</strong>
					        </c:if>
					        <c:if test="${i != currentPage}">
					            <a href="?page=${i}&pageSize=${pageSize}">${i}</a>
					        </c:if>
					    </c:forEach>
					
					    <c:if test="${currentPage < totalPages}">
					        <a href="?page=${currentPage + 1}&pageSize=${pageSize}">다음 &raquo;</a>
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