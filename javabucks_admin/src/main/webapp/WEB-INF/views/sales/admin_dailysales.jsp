<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

  
 <section id="admin_dailysales" class="content management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>일별 지점 매출관리</p>
            </div>

            <div class="select_box">
                <form name="dailySearchForm" action="/searchDailySales.do" method="post">
    <div class="search_box">
        <label>기간
            <input type="date" name="startDate" value="${startDate}">
            ~
            <input type="date" name="endDate" value="${endDate}">
        </label>

        <label>지점명
            <input type="text" name="bucksName" value="${bucksName}">
        </label>
        <label>메뉴 카테고리
            <select name="category">
                <option value="" ${category == '' ? 'selected' : ''}>전체</option>
                <option value="음료" ${category == '음료' ? 'selected' : ''}>음료</option>
                <option value="디저트" ${category == '디저트' ? 'selected' : ''}>디저트</option>
                <option value="MD상품" ${category == 'MD상품' ? 'selected' : ''}>MD상품</option>
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
                                <th style="width: 16%;">일자</th>
                                <th style="width: 16%;">지점명</th>
                                <th style="width: 16%;">지점등록번호</th>
                                <th style="width: 16%;">점주명</th>
                                <th style="width: 16%;">메뉴카테고리</th>
                                <th style="width: 20%;">매출액</th>
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
							                <td><c:out value="${dlist.payhistoryDate}"/></td>
							                <td><c:out value="${dlist.branchName}"/></td>
							                <td><c:out value="${dlist.bucksId}"/></td>
							                <td><c:out value="${dlist.bucksOwner}"/></td>
								            <!-- 각 카테고리 및 매출액 출력 -->
							                <td>
							                	<ul>
							                		<c:forEach items="${entry.value}" var="categoryEntry">
							                		<li><c:out value="${categoryEntry.key}"/></li>
							                		</c:forEach>
							                	</ul>
							                </td>
							                <td>
							                	<ul>
							                		<c:forEach items="${entry.value}" var="categoryEntry">
							                		<li><fmt:formatNumber value="${categoryEntry.value}" pattern="#,##0"/>원</li>
							                		</c:forEach>
							                	</ul>
							                </td>
							            </tr>
							            <!-- 지점별 총 매출 합계 출력 -->
							            <tr class="total_col">
										    <td colspan="5"><strong>총 합</strong></td>
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
                    <c:if test="${not empty startPage and not empty endPage}">
					    <div class="pagination pagination">
					        <c:if test="${startPage > pageBlock}"> 
					            <a class="page_btn prev_btn" href="bucksSalesD.do?pageNum=${startPage-3}">
					                <img src="../../images/icons/arrow.png">
					            </a>
					        </c:if>
					        
					        <c:forEach var="i" begin="${startPage}" end="${endPage}">
					            <c:set var="activeClass" value=""/>
					            <c:choose>
					                <c:when test="${empty param.pageNum and i == 1}">
					                    <c:set var="activeClass" value="page_active"/>
					                </c:when>
					                <c:when test="${param.pageNum == i}">
					                    <c:set var="activeClass" value="page_active"/>
					                </c:when>
					            </c:choose>
					            <a href="bucksSalesD.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
					        </c:forEach>
					        
					        <c:if test="${pageCount > endPage}">
					            <a class="page_btn next_btn" href="bucksSalesD.do?pageNum=${startPage+3}">
					                <img src="../../images/icons/arrow.png">
					            </a>
					        </c:if>
					    </div>
					</c:if>
					
					<c:if test="${not empty startPage2 and not empty endPage2}">
					    <div class="pagination pagination">
					    <c:if test="${startPage2 > pageBlock2}">
					        <a class="page_btn prev_btn" href="searchDailySales.do?pageNum=${startPage2-3}&startDate=${startDate}&endDate=${endDate}&bucksName=${bucksName}&category=${category}">
					            <img src="../../images/icons/arrow.png">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${startPage2}" end="${endPage2}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="searchDailySales.do?pageNum=${i}&startDate=${startDate}&endDate=${endDate}&bucksName=${bucksName}&category=${category}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${pageCount2 > endPage2}">
					        <a class="page_btn next_btn" href="searchDailySales.do?pageNum=${startPage2+3}&startDate=${startDate}&endDate=${endDate}&bucksName=${bucksName}&category=${category}">
					            <img src="../../images/icons/arrow.png">
					        </a>
					    </c:if>
					</div>
					</c:if>
        <!-- e:페이징 -->   
                </div>
            </div>
        </div>
    </section>


 <jsp:include page="../admin_bottom.jsp"/>
 
 <script>
 $(document).ready(function() {
	    // 현재 날짜 가져오기
	    var today = new Date();
	    
	    // 날짜를 YYYY-MM-DD 형식으로 변환
	    var year = today.getFullYear();
	    var month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
	    var day = ('0' + today.getDate()).slice(-2);

	    // 포맷된 날짜 문자열
	    var formattedDate = year + '-' + month + '-' + day;

	    // input 요소에 날짜 설정
	    $('input[name="startDate"]').val(function(index, value) {
	        return value || formattedDate;
	    });
	    $('input[name="endDate"]').val(function(index, value) {
	        return value || formattedDate;
	    });
	});
</script>