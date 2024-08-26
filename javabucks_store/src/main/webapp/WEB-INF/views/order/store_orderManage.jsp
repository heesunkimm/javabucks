<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_ordermanage" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>주문관리</p>
        </div>

        <div class="order_box">
            <button type="button">신규주문 정지</button>
            <div class="order_wrap">
                <div>
                    <div class="orders">
                        <p class="orders_tit">매장 신규주문</p>
                       	<c:if test="${empty storeOrderList}">
                       		<ul class="order_list">
		                            <li class="order_item list_item bg_beige">
		                                <div class="txt_box">
		                                	매장 신규주문이 없습니다.
		                                </div>
		                            </li>
		                        </ul>
                       	</c:if>
                       	<c:if test="${not empty storeOrderList}">
                       		<c:forEach var="order" items="${storeOrderList}">
		                        <ul class="order_list">
		                            <li class="order_item list_item bg_beige">
		                                <div class="txt_box">
		                                    <dl>
		                                        <dt>주문번호</dt>
		                                        <dd>(${order.orderCode})</dd>
		                                    </dl>
		                                    <ul class="menu_list">
		                                    	<c:forEach var="menuOrder" items="${order.orderListbyMenuOrder}">
			                                        <li class="menu_item">${menuOrder.menuName} ${menuOrder.quantity}개</li>
							                        <li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType} 외</li>
	<%-- 						                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
							                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
							                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>  --%>
		                                        </c:forEach>
		                                    </ul>
		                                </div>
		                                <form action="/startOrder.do" method="GET">
		                                	<input type="hidden" name="orderCode" value="${order.orderCode}">
		                                	<button type="submit">주문접수</button>
		                                </form>	                                
		                            </li>
		                        </ul>
	                       	</c:forEach>
	                        <div class="pagination">
	                        	<c:if test="${storeOrder_startPage > storeOrder_pageBlock}"> 
	                        		<button type="button" onclick="storeBefore()">이전</button>
	                        	</c:if>
	                        	<c:if test="${storeOrder_pageCount > storeOrder_endPage}">
	                        		<button type="button" onclick="storeNext()">다음</button>
	                        	</c:if>
	                        </div>
                       	</c:if>
                    </div>
                        
                    <div class="orders">
                        <p class="orders_tit">배달 신규주문</p>
                        <c:if test="${empty deliverOrderList}">
                        	<ul class="order_list">
		                            <li class="order_item list_item bg_beige">
		                                <div class="txt_box">
		                                    배달 신규주문이 없습니다.
		                                </div>                               
		                            </li>
		                        </ul>
                        </c:if>
                        <c:if test="${not empty deliverOrderList}">
                        	<c:forEach var="deliver" items="${deliverOrderList}">
	                        	<ul class="order_list">
		                            <li class="order_item list_item bg_beige">
		                                <div class="txt_box">
		                                    <dl>
		                                        <dt>주문번호</dt>
		                                        <dd>(${deliver.orderCode})</dd>
		                                    </dl>
		                                    <ul class="menu_list">
		                                        <c:forEach var="menuOrder" items="${deliver.orderListbyMenuOrder}">
			                                        <li class="menu_item">${menuOrder.menuName} ${menuOrder.quantity}개</li>
							                        <li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType} 외</li>
	<%--						                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
	 						                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
							                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>  --%>
			                                    </c:forEach>
		                                    </ul>
		                                </div>
		                                <form action="/startOrder.do" method="GET">
		                                	<input type="hidden" name="orderCode" value="${deliver.orderCode}">
		                                	<button type="submit">주문접수</button>
		                                </form>	                                
		                            </li>
		                        </ul>
		                    </c:forEach>
	                        <div class="pagination">
	                            <c:if test="${deliverOrder_startPage > deliverOrder_pageBlock}"> 
	                        		<button type="button" onclick="deliverBefore()">이전</button>
	                        	</c:if>
	                        	<c:if test="${deliverOrder_pageCount > deliverOrder_endPage}">
	                        		<button type="button" onclick="deliverNext()">다음</button>
	                        	</c:if>
	                        </div>
                        </c:if>
                    </div>
                </div>
                
                <div class="making_box">
                    <p class="orders_tit">제조중</p>
                    <c:if test="${empty makingList}">
                    	<ul class="making_list list_box">
		                        <li class="making_item list_item bg_beige">
		                            <div class="txt_box">
		                                제조중인 주문이 없습니다.
		                            </div>		                            
		                        </li>
		                    </ul>
                    </c:if>
                    <c:if test="${not empty makingList}">
                    	<c:forEach var="making" items="${makingList}">
		                    <ul class="making_list list_box">
		                        <li class="making_item list_item bg_beige">
		                            <div class="txt_box">
		                                <dl>
		                                    <dt>주문번호</dt>
		                                    <dd>(${making.orderCode})</dd>
		                                </dl>
		                                <ul class="menu_list">
		                                    <c:forEach var="menuOrder" items="${making.orderListbyMenuOrder}">
			                                        <li class="menu_item">${menuOrder.menuName} ${menuOrder.quantity}개</li>
							                        <li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType}</li>
							                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
	 						                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
	 						                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>
			                                </c:forEach>
		                                </ul>
		                            </div>
		                            <form action="/endOrder.do" method="GET">
		                                <input type="hidden" name="orderCode" value="${making.orderCode}">
		                                <button type="submit">제조완료</button>
		                            </form>	
		                            <div class="pagination"></div>
		                        </li>
		                    </ul>
		                </c:forEach>
	                    <div class="pagination">
	                        <c:if test="${making_startPage > making_pageBlock}"> 
	                        	<button type="button" onclick="makingBefore()">이전</button>
	                       	</c:if>
	                       	<c:if test="${making_pageCount > making_endPage}">
	                       		<button type="button" onclick="makingNext()">다음</button>
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

<script type="text/javascript" >
document.addEventListener('DOMContentLoaded', function() {
	var optElement = document.querySelectorAll('.menu_opt');
	//console.log(optElement);
	
	optElement.forEach(function(optElement, index){
			var opt = optElement.textContent;
			//console.log(opt); //- SHOT : 기본 추가 1회
			var count = opt.match(/(\d+)회/);
						
			if(count && count[1]) {
            	//console.log(count[1]);            
            	if(count[1] === '0') {
                	optElement.style.display = 'none'; // 숫자가 0인 경우 숨김 처리
           		}
       		}
			
			// : 다음에 null인 항목들 숨김처리
			var text = optElement.textContent.trim();
			var parts = text.split(':');

			if (parts.length > 1 && !parts[1].trim()) {
	            optElement.style.display = 'none';
	        }
	});
	
});



function storeBefore(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage-1}&deliverOrder_pageNum=${deliverOrder_startPage}&making_pageNum=${making_startPage}'
}

function storeNext(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage+1}&deliverOrder_pageNum=${deliverOrder_startPage}&making_pageNum=${making_startPage}'
}

function deliverBefore(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage-1}&making_pageNum=${making_startPage}'
}

function deliverNext(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage+1}&making_pageNum=${making_startPage}'
}

function makingBefore(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage}&making_pageNum=${making_startPage-1}'
}

function makingNext(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage}&making_pageNum=${making_startPage+1}'
}


</script> 


