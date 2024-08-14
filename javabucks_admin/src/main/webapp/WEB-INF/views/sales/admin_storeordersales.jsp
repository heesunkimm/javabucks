<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section id="admin_storeordersales" class="content tab_management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점별 발주정산</p>
            </div>

            <div class="select_box">
                <form name="" action="/searchOrderSales.do" method="post">
                    <div class="count_box">
                        <span>연월</span>
                        <div class="minus_btn img_box">
                            <img src="../images/icons/minus.png" alt="minus" class="minusBtn">
                        </div>
                        <input type="text" class="dateInput" name="orderDate" value="" readonly>
                        <div class="plus_btn img_box">
                            <img src="../images/icons/plus.png" alt="plus" class="plusBtn">
                        </div>
                        <select name="bucksId">
                        <c:forEach items="${bucksN}" var="bucks">
                            <option value="${bucks.bucksId}">${bucks.bucksName} (${bucks.bucksId})</option>
                        </c:forEach>
                        </select>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead class="bg_green font_white">
                            <tr>
                            	<th style="width: 40%">날짜</th>
                                <th style="width: 30%">지점명</th>
                                <th style="width: 30%">발주금액</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty baljooList}">
                        	<tr>
						        <td colspan="3" style="text-align: center;">해당 날짜와 지점에 대한 발주 정산 데이터가 없습니다.</td>
						    </tr>
						  </c:if>
                        <c:forEach items="${baljooList}" var="blist">
	                         
						     <tr>
						       	<td><a class="tab_btn" href="javascript:;" data-tab="2024_01">${blist.baljooDate}</a></td>
						        <td>${blist.bucksName}</td> 
						        <td><fmt:formatNumber value="${blist.baljooPrice}" type="number" maxFractionDigits="0"/>원</td>
						     </tr>
						       
                         </c:forEach>
                            <tr class="bg_green font_white">
                                <td>총계</td>
                                <td></td>
                                <td><fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/>원</td> 
                            </tr>
                        </tbody>
                    </table>

                    <ul id="2024_01" class="s_active tab-content">
                        <li>
                            <ul class="cont_toolbar">
                                <li>발주번호</li>
                                <li>발주일</li>
                                <li>발주품목</li>
                                <li>발주금액</li>
                            </ul>
                        </li>
                        <li>
                            <ul class="cont_details">
                                <li>발주번호</li>
                                <li>발주일</li>
                                <li>발주품목</li>
                                <li>발주금액</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
 <jsp:include page="../admin_bottom.jsp"/>
 <script>
 document.addEventListener('DOMContentLoaded', function() {
	    const dateInput = document.querySelector('.dateInput');
	    const minusBtn = document.querySelector('.minusBtn');
	    const plusBtn = document.querySelector('.plusBtn');

	    // 현재 날짜로 초기화
	    const now = new Date();
	    let year = now.getFullYear();
	    let month = now.getMonth() + 1; // 0부터 시작하므로 +1

	    // 월이 한 자리 숫자일 경우 앞에 0을 추가
	    month = month < 10 ? "0" + month : month;

	    // 초기 값 설정
	    dateInput.value = year + "-" + month;

	    function updateDate(offset) {
	        month = parseInt(month) + offset;

	        if (month > 12) {
	            month = 1;
	            year++;
	        } else if (month < 1) {
	            month = 12;
	            year--;
	        }

	        // 월이 한 자리 숫자일 경우 앞에 0을 추가
	        month = month < 10 ? "0" + month : month;

	        dateInput.value = year + "-" + month;
	    }

	    minusBtn.addEventListener('click', function() {
	        updateDate(-1);
	    });

	    plusBtn.addEventListener('click', function() {
	        updateDate(1);
	    });
	});
 </script>