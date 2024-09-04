<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_orderaccount" class="content management">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>발주내역</p>
        </div>

        <div class="select_box">
            <div id="" class="tab-content s_active">
                <form name="" action="searchBaljoo.do" method="get">
                    <div class="search_box">
                        <label>발주기간
                            <select class="yearSelect" name="year">
                                <!-- 년도 옵션은 스크립트로 채워짐 -->
                            </select>
                        </label>
                        <label>
                            <select class="monthSelect" name="month">
                                <!-- 월 옵션은 스크립트로 채워짐 -->
                            </select>
                        </label>
                        <!-- <label>발주번호
                            <input type="text" name="" value="">
                        </label> -->
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <p class="totabl_sales">총 발주 승인 금액:
                    	<span>
                            <fmt:formatNumber value="${totalBaljooPrice}" type="number" maxFractionDigits="0" />원
                        </span></p>
                        
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>결제일</th>
                                <th>결제번호</th>
                                <th>주문내역</th>
                                <th>결제금액</th>
                                <th>주문상태</th>
                                <!-- <th>결제취소</th> -->
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                                <c:when test="${empty updateOrderList}">
                                    <tr>
                                        <td colspan="5" style="text-align:center;">해당 기간에 발주내역이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${updateOrderList}" var="bal">
                                        <tr>
                                            <td>${bal.baljooDate}</td>
                                            <td>${bal.baljooNum}</td>
                                            <td>
                                                <c:forEach items="${bal.stockList}" var="item">
                                                    ${item.STOCKLISTNAME} : ${item.quantity}<br/>
                                                </c:forEach>
                                            </td>
                                            <td><fmt:formatNumber value="${bal.baljooPrice}" type="number" groupingUsed="true" /></td>
                                            <td>${bal.baljooStatus}</td>
                                           <!--  <td><a href="javascript:;">취소</a></td> -->
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <c:if test="${not empty startPage and not empty endPage}">
                    
                    <div class="pagination pagination">
			        <c:if test="${startPage > pageBlock}"> 
			            <a class="page_btn prev_btn" href="store_baljooManage.do?pageNum=${startPage-3}">
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
			            <a href="store_baljooManage.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
			        </c:forEach>
			        
			        <c:if test="${pageCount > endPage}">
			            <a class="page_btn next_btn" href="store_baljooManage.do?pageNum=${startPage+3}">
			                <img src="../../images/icons/arrow.png">
			            </a>
			        </c:if>
			    </div>
			    </c:if>
			    
			    <c:if test="${not empty startPage2 and not empty endPage2}">
    <div class="pagination pagination">
    <c:if test="${startPage2 > pageBlock2}">
       <a class="page_btn prev_btn" href="searchBaljoo.do?pageNum=${startPage2-3}&year=${param.year}&month=${param.month}">
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
        <a href="searchBaljoo.do?pageNum=${i}&year=${param.year}&month=${param.month}" class="${activeClass} page_num">${i}</a>
    </c:forEach>
    
    <c:if test="${pageCount2 > endPage2}">
        <a class="page_btn next_btn" href="searchBaljoo.do?pageNum=${startPage2+3}&year=${param.year}&month=${param.month}">
            <img src="../../images/icons/arrow.png">
        </a>
    </c:if>
</div>
</c:if>
			    
  
                </div>
            </div>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>

<script>


const yearSelect = document.getElementsByClassName('yearSelect')[0];
const monthSelect = document.getElementsByClassName('monthSelect')[0];

const urlParams = new URLSearchParams(window.location.search);
const selectedYear = urlParams.get('year');
const selectedMonth = urlParams.get('month');

const currentYear = new Date().getFullYear();
for (let i = currentYear; i >= currentYear - 5; i--) {
    let option = document.createElement('option');
    option.value = i;
    option.text = i + '년';
    yearSelect.appendChild(option);
}

for (let i = 1; i <= 12; i++) {
    let option = document.createElement('option');
    option.value = i;
    option.text = i + '월';
    monthSelect.appendChild(option);
}

if (selectedYear) {
    yearSelect.value = selectedYear;
} else {
    yearSelect.value = currentYear;
}

if (selectedMonth) {
    monthSelect.value = selectedMonth;
} else {
    monthSelect.value = new Date().getMonth() + 1;
}

</script>
