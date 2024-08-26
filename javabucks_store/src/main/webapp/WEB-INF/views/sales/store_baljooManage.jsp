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
                <form name="" action="searchBaljoo.do" method="post">
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
                    <p class="totabl_sales">총 발주 금액:
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
                                <th>결제취소</th>
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
                                            <td>${bal.baljooPrice}</td>
                                            <td><a href="javascript:;">취소</a></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
					    <c:forEach var="i" begin="1" end="${totalPages}">
					        <a href="?year=${param.year}&month=${param.month}&page=${i}&size=${param.size}" class="${i == currentPage ? 'active' : ''}">${i}</a>
					    </c:forEach>
					</div>  
                </div>
            </div>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>

<script>


const yearSelect = document.getElementsByClassName('yearSelect')[0];
const currentYear = new Date().getFullYear();
for (let i = currentYear; i >= currentYear - 5; i--) {
    let option = document.createElement('option');
    option.value = i;
    option.text = i + '년';
    yearSelect.appendChild(option);
}

const monthSelect = document.getElementsByClassName('monthSelect')[0];
const currentMonth = new Date().getMonth() + 1; 
for (let i = 1; i <= 12; i++) {
    let option = document.createElement('option');
    option.value = i;
    option.text = i + '월';
    monthSelect.appendChild(option);
}

yearSelect.value = currentYear;
monthSelect.value = currentMonth;

</script>
