<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section id="admin_monthlysales" class="content tab_management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>월별 지점 매출관리</p>
            </div>

            <div class="select_box">
                <form name="" action="/searchMonthSales.do" method="post">
                    <div class="count_box">
        <span>연월</span>
        <div class="minus_btn img_box">
            <img src="../images/icons/minus.png" alt="minus" class="minusBtn">
        </div>
        <input type="text" class="dateInput" name="orderDate" value="${orderDate}" readonly>
        <div class="plus_btn img_box">
            <img src="../images/icons/plus.png" alt="plus" class="plusBtn">
        </div>
        <label>지점명
            <input type="text" name="bucksName" value="${bucksName}" style="border: 1px solid #666; width: 200px;">
        </label>
        <button type="submit">검색</button>
    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead class="bg_green font_white">
                            <tr>
                            	<th style="width: 33%;">연월</th>
                                <th style="width: 33%;">지점명</th>
                                <th style="width: 34%;">매출액</th>
                               
                            </tr>
                        </thead>
                        <tbody>
                         <c:set var="totalSum" value="0" /> <!-- 총 매출액 변수 초기화 -->
                        <c:forEach items="${list}" var="mlist"> 
                            <tr>
                                <td>${mlist.payhistoryYearMonth}</td>
                                <td><a class="tab_btn" href="javascript:;" onclick="MonthlyDetails('${mlist.bucksId}', '${mlist.payhistoryYearMonth}')">${mlist.branchName}</a></td>
                                <td><fmt:formatNumber value="${mlist.totalSales}" type="number" maxFractionDigits="0"/>원
                                	<!-- 매출액을 총합에 더하기 -->
                                <c:set var="totalSum" value="${totalSum + mlist.totalSales}" />
                                </td>
                           
                            </tr>
                        </c:forEach>
                            <tr class="bg_green font_white">
                                <td>총계</td>
                                <td></td>
                                <td><!-- 계산된 총 매출액 표시 -->
                                <fmt:formatNumber value="${totalSum}" type="number" maxFractionDigits="0"/>원</td>
                            </tr>
                        </tbody>
                    </table>

                    <ul class="sales_cont">
                        <li>
                            <ul class="cont_toolbar">
                                <li style="width: 33%;">메뉴카테고리</li>
                                <li style="width: 33%;">매출액</li>
                                <li style="width: 34%;">비중</li>
                            </ul>
                        </li>
                        <li>
                            <ul class="cont_details">
                                
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
 <jsp:include page="../admin_bottom.jsp"/>
 <script>
//검색 기능시간 
	document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.querySelector('.dateInput');
    const minusBtn = document.querySelector('.minusBtn');
    const plusBtn = document.querySelector('.plusBtn');

    // 서버에서 전달된 값이 없을 경우 현재 날짜로 초기화
    if (!dateInput.value) {
        const now = new Date();
        let year = now.getFullYear();
        let month = now.getMonth() + 1; // 0부터 시작하므로 +1

        // 월이 한 자리 숫자일 경우 앞에 0을 추가
        month = month < 10 ? "0" + month : month;

        // 초기 값 설정
        dateInput.value = year + "-" + month;
    }

    function updateDate(offset) {
        let [year, month] = dateInput.value.split('-').map(Number);

        month += offset;

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


	function MonthlyDetails(bucksId, payhistoryYearMonth) {
	    console.log("bucksId:", bucksId); 
	    console.log("payhistoryYearMonth:", payhistoryYearMonth); 

	    $.ajax({
	        type: "POST", // POST 요청 타입을 설정
	        url: "/MonthlyDetails.do", // 요청을 보낼 서버의 URL 설정
	        data: {
	            bucksId: bucksId, // 요청 데이터에 포함될 bucksId
	            orderDate: payhistoryYearMonth // 요청 데이터에 포함될 orderDate
	        },
	        success: function(response) {
	            // 기존 매출 내역을 비웁니다.
	            $('.sales_cont').empty();
	            
	            if (!response.hasSalesData) {
	                // 매출 내역이 없을 때
	                $('.sales_cont').append('<li><ul class="cont_toolbar"><li>메뉴카테고리</li><li>매출액</li><li>비중</li></ul></li>' + 
	                    '<li><ul class="cont_details"><li style="width:100%">해당 지점의 매출 내역이 없습니다</li></ul></li>');
	            } else {
	                // cont_toolbar 부분을 반복문 밖으로 빼서 한 번만 추가
	                $('.sales_cont').append('<li><ul class="cont_toolbar"><li>메뉴카테고리</li><li>매출액</li><li>비중</li></ul></li>');

	                // response 데이터를 반복하면서 각 카테고리와 매출액을 추가
	                $.each(response, function(category, categoryData) {
	                    if (category !== "totalSales" && category !== "hasSalesData") {
	                        var totalSales = categoryData.totalSales;
	                        var percentage = categoryData.percentage.toFixed(2);

	                        // 각 카테고리와 매출액, 비중을 cont_detail 리스트에 추가
	                        $('.sales_cont').append(
	                            '<li><ul class="cont_details"><li>' + category + '</li> ' +
	                            '<li>' + totalSales.toLocaleString('ko-KR') + '원</li>' + '<li>' + percentage + '%</li></ul></li>'
	                        );
	                    }
	                });
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("Ajax request failed:", status, error);
	            alert("매출 데이터를 불러오는 중 오류가 발생했습니다.");
	        }
	    });
	}
 </script>