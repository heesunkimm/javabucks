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
                        <input type="text" class="dateInput" name="orderDate" value="${param.orderDate}" readonly>
                        <div class="plus_btn img_box">
                            <img src="../images/icons/plus.png" alt="plus" class="plusBtn">
                        </div>
                       <label>지점명
                        <input type="text" name="bucksName" value="${param.bucksName}" style="border: 1px solid #666; width: 200px;">
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
                                <li style="width: 15%;">발주번호</li>
                                <li style="width: 25%;">발주일</li>
                                <li style="width: 37%;">발주품목</li>
                                <li style="width: 23%;">발주금액</li>
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
 document.addEventListener('DOMContentLoaded', function() {
     const dateInput = document.querySelector('.dateInput');
     const minusBtn = document.querySelector('.minusBtn');
     const plusBtn = document.querySelector('.plusBtn');

     let now = new Date();
     let year = now.getFullYear();
     let month = now.getMonth() + 1;

     month = month < 10 ? "0" + month : month;
     dateInput.value = dateInput.value || year + "-" + month;

     function updateDate(offset) {
         month = parseInt(month) + offset;
         if (month > 12) {
             month = 1;
             year++;
         } else if (month < 1) {
             month = 12;
             year--;
         }
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
     $.ajax({
         type: "POST",
         url: "/viewOrderDetails.do",
         data: {
             bucksId: bucksId,
             orderDate: baljooMonth
         },
         success: function(response) {
             const salesCont = $('.sales_cont');
             salesCont.empty();

             if (response.length === 0) {
                 salesCont.append(
                     '<li><ul class="cont_toolbar"><li style="width: 15%;">발주번호</li><li style="width: 25%;">발주일</li><li style="width: 37%;">발주품목</li><li style="width: 23%;">발주금액</li></ul></li>' +
                     '<li style="width: 100%; text-align: center; padding: 20px;">발주 내역이 없습니다.</li>'
                 );
             } else {
                 let listHtml = '<li><ul class="cont_toolbar"><li style="width: 15%;">발주번호</li><li style="width: 25%;">발주일</li><li style="width: 37%;">발주품목</li><li style="width: 23%;">발주금액</li></ul></li>';

                 response.forEach(function(order) {
                     let stockItemsHtml = '';
                     order.stockList.forEach(function(stockItem) {
                         let stockName = Array.isArray(stockItem.stockListName) ? stockItem.stockListName[0] : stockItem.stockListName;
                         stockItemsHtml += stockName + ' x ' + stockItem.quantity + '<br>';
                     });

                     listHtml += '<li><ul class="cont_details">';
                     listHtml += '<li style="width: 15%;">' + order.baljooNum + '</li>';
                     listHtml += '<li style="width: 25%;">' + order.baljooDate + '</li>';
                     listHtml += '<li style="width: 37%;">' + stockItemsHtml + '</li>';
                     listHtml += '<li style="width: 23%;">' + order.baljooPrice.toLocaleString('ko-KR') + '원</li>';
                     listHtml += '</ul></li>';
                 });

                 salesCont.append(listHtml);
             }
         },
         error: function(error) {
             console.log("Error fetching order details:", error);
         }
     });
 }
</script>
