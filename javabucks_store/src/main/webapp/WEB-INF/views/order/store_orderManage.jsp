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
						                        <li class="menu_opt" id="cup_opt">- CUP : ${menuOrder.cupType}</li>
						                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
						                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
						                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
						                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
						                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li> 
	                                        </c:forEach>
	                                    </ul>
	                                </div>
	                                <button type="button" onclick="startOrder(this)" data-orderCode="${order.orderCode}">주문접수</button>
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
                    </div>
                        
                    <div class="orders">
                        <p class="orders_tit">배달 신규주문</p>
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
						                        <li class="menu_opt" id="cup_opt">- CUP : ${menuOrder.cupType}</li>
						                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
						                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
						                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
						                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
						                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li> 
		                                    </c:forEach>
	                                    </ul>
	                                </div>
	                                <button type="button" onclick="startOrder(this)" data-orderCode="${deliver.orderCode}">주문접수</button>
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
                    </div>
                </div>
                
                <div class="making_box">
                    <p class="orders_tit">제조중</p>
                    <ul class="making_list list_box">
                        <li class="making_item list_item bg_beige">
                            <div class="txt_box">
                                <dl>
                                    <dt>주문번호</dt>
                                    <dd>(A-01)</dd>
                                </dl>
                                <ul class="menu_list">
                                    <li class="menu_item">메뉴명 * 1</li>
                                    <li class="menu_opt">- 샷추가 + 2</li>
                                </ul>
                            </div>
                            <button type="button">제조완료</button>
                            <div class="pagination"></div>
                        </li>
                    </ul>
                    <div class="pagination">
                        <button type="button">이전</button>
                        <button type="button">다음</button>
                    </div>
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
	});
});

function storeBefore(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage-1}&deliverOrder_pageNum=${deliverOrder_startPage}'
}

function storeNext(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage+1}&deliverOrder_pageNum=${deliverOrder_startPage}'
}

function deliverBefore(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage-1}'
}

function deliverNext(){
	window.location.href='orderManage.do?storeOrder_pageNum=${storeOrder_startPage}&deliverOrder_pageNum=${deliverOrder_startPage+1}'
}

function startOrder(element){
	const orderCode = element.dataset.ordercode; //data- 뒤에 붙은 속성은 소문자로 변환 필요
	console.log(orderCode);
	
	$.ajax({
		type : "POST",
		url : "startOrder.ajax",
		data : {
			orderCode : orderCode
		},
		success : function(response){
			
		},
		error : function(){
			
		}		
	});
	
}

function endOrder(element){
	
	
	$.ajax({
		type : "POST",
		url : "endOrder.ajax",
		data : {
			
		},
		success : function(response){
			
		},
		error : function(){
			
		}		
	});
}
</script> 


