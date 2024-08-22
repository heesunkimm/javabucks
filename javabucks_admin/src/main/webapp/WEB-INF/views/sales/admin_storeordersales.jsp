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
                       <label>지점명
                        <input type="text" name="bucksName" value="" style="border: 1px solid #666; width: 200px;">
                    </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead class="bg_green font_white">
                            <tr>
                                <th style="width: 50%">지점명</th>
                                <th style="width: 50%">발주금액</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${bucksBal}" var="blist">
	                         
						     <tr>
						       	<td><a class="tab_btn" href="javascript:;" onclick="viewOrderDetails('${blist.bucksId}', '${blist.baljooMonth}')">${blist.bucksName}</a></td>
						        <td><fmt:formatNumber value="${blist.totalOrderAmount}" type="number" maxFractionDigits="0"/>원</td>
						     </tr>
						       
                         </c:forEach>
                            
                        </tbody>
                    </table>

                    <ul  class="sales_cont">
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
							    <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
							        
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
 	
 	function viewOrderDetails(bucksId, baljooMonth) {
 	    console.log("bucksId:", bucksId); // bucksId 확인
 	    console.log("baljooMonth:", baljooMonth); // baljooMonth 확인

 	   $.ajax({
 	        type: "POST",
 	        url: "/viewOrderDetails.do",
 	        data: {
 	            bucksId: bucksId,
 	            orderDate: baljooMonth
 	        },
 	       success: function(response) {
 	            console.log("Response:", response); // 응답 데이터 확인
 	           const salesCont = $('.sales_cont'); // sales_cont 요소 선택

 	            salesCont.empty(); // 기존 내용을 지움

 	            if (response.length === 0) {
 	                // 검색 결과가 없을 경우, 메시지 추가
 	                salesCont.append(
 	                    '<li><ul class="cont_toolbar"><li>발주번호</li><li>발주일</li><li>발주품목</li><li>발주금액</li></ul></li>' +
 	                    '<li style="width: 100%; text-align: center; padding: 20px;">발주 내역이 없습니다.</li>'
 	                );
 	            } else {
 	                // 검색 결과가 있을 경우
 	                let listHtml = '<li><ul class="cont_toolbar"><li>발주번호</li><li>발주일</li><li>발주품목</li><li>발주금액</li></ul></li>';

 	                response.forEach(function(order) {
 	                    let stockItemsHtml = '';

 	                    order.stockList.forEach(function(stockItem) {
 	                        // stockListName이 배열일 경우 첫 번째 요소 사용
 	                        let stockName = Array.isArray(stockItem.stockListName) ? stockItem.stockListName[0] : stockItem.stockListName;
 	                        stockItemsHtml += stockName + ' x ' + stockItem.quantity + '<br>';
 	                    });

 	                    // 각 발주에 대한 HTML 생성
 	                    listHtml += '<li><ul class="cont_details">';
 	                    listHtml += '<li>' + order.baljooNum + '</li>'; // 발주 번호
 	                    listHtml += '<li>' + order.baljooDate + '</li>'; // 발주 날짜
 	                    listHtml += '<li>' + stockItemsHtml + '</li>'; // 발주 품목 리스트
 	                    listHtml += '<li>' + order.baljooPrice + '원</li>'; // 발주 금액
 	                    listHtml += '</ul></li>';
 	                });

 	                salesCont.append(listHtml); // 생성된 HTML을 sales_cont에 추가
 	            }

 	            console.log("Data successfully appended to .sales_cont.");
 	        },
 	        error: function(error) {
 	            console.log("Error fetching order details:", error); // 오류 발생 시 메시지 출력
 	        }
 	    });
 	} 
 	</script>