<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../store_top.jsp"%>
<style>
	#store_ordermanage .order_box .order_wrap .orders .order_list {min-height: 115px!important; height: auto;}
	#store_ordermanage .order_box .order_wrap .list_item.making_item {width: 440px;}
</style>
<!-- s: content -->
<section id="store_ordermanage" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>주문관리</p>
        </div>

        <div class="order_box">
        	<div class="btn_box">
	        	<c:if test="${orderStopCheck eq true}">
	        		<button class="orderEnableBtn" type="button" onclick="restartOrder()">신규주문 재시작</button>
	        	</c:if>
	        	<c:if test="${orderStopCheck eq false}">
	            	<button class="orderDisableBtn" type="button" onclick="stopOrder()">신규주문 정지</button>
	            </c:if>
        	</div>
            <div class="order_wrap">
                <div>
                    <div class="orders">
                        <p class="orders_tit">매장 신규주문</p>
                       	<c:if test="${empty storeOrderList}">
                       		<ul class="order_list">
	                            <li class="order_item list_item nolist bg_beige">매장 신규주문이 없습니다.</li>
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
			                                        <li class="menu_item">${menuOrder.menuName} - ${menuOrder.quantity}개</li>
			                                        <c:if test="${not empty menuOrder.cupType}">
			                                        	<li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType} 외 옵션</li>
	 						                        <%--<li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
							                       		<li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        	<li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
							                        	<li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        	<li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>  --%>
			                                        </c:if>
		                                        </c:forEach>
		                                    </ul>
		                                </div>
		                                <div class="btn_box">
			                                <button class="orderOk" type="button" name="orderButton" onclick="orderStart(this)" data-orderCode="${order.orderCode}">주문접수</button>
			                                <button class="orderDel" type="button" name="orderCancelButton" onclick="orderCancel(this)" data-orderCode="${order.orderCode}">주문취소</button>                           
		                                </div>
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
	                            <li class="order_item list_item nolist bg_beige">배달 신규주문이 없습니다.</li>
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
			                                        <li class="menu_item">${menuOrder.menuName} - ${menuOrder.quantity}개</li>
							                        <c:if test="${not empty menuOrder.cupType}">
			                                        	<li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType} 외 옵션</li>
	 						                        <%--<li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
							                       		<li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        	<li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
							                        	<li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        	<li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>  --%>
			                                        </c:if>
			                                    </c:forEach>
		                                    </ul>
		                                </div>
		                                <div class="btn_box">
			                                <button class="orderOk" type="button" name="orderButton" onclick="orderStart(this)" data-orderCode="${deliver.orderCode}">주문접수</button>
			                                <button class="orderDel" type="button" name="orderCancelButton" onclick="orderCancel(this)" data-orderCode="${deliver.orderCode}">주문취소</button>                      
		                                </div>
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
	                        <li class="making_item list_item nolist bg_beige">제조중인 주문이 없습니다.</li>
	                    </ul>
                    </c:if>
                    <c:if test="${not empty makingList}">
		            	<ul class="making_list list_box">
		                    <c:forEach var="making" items="${makingList}">
		                        <li class="making_item list_item bg_beige">
		                            <div class="txt_box">
		                                <dl>
		                                    <dt>주문번호</dt>
		                                    <dd>(${making.orderCode})</dd>
		                                </dl>
		                                <ul class="menu_list">
		                                    <c:forEach var="menuOrder" items="${making.orderListbyMenuOrder}">
			                                        <li class="menu_item">${menuOrder.menuName} - ${menuOrder.quantity}개</li>
							                        <li class="menu_opt" id="cup_opt">- SIZE : ${menuOrder.cupType}</li>
							                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회</li>
	 						                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회</li>
							                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}</li>
	 						                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}</li>
							                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}</li>
			                                </c:forEach>
		                                </ul>
		                            </div>
		                            <button class="orderSubmit" type="button" name="orderButton" onclick="orderFinish(this)" data-orderCode="${making.orderCode}">제조완료</button>
		                        </li>
		                	</c:forEach>
		                </ul>
		                
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
    <div id="messageContainer" data-message="${sessionScope.message}"></div>
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

function orderStart(element){
	var orderCode = element.getAttribute('data-orderCode');
	
	$.ajax({
		type : "POST",
		url : "orderStart.ajax",
		data : {
			orderCode : orderCode
		},
		success : function(response){
			console.log(response);
			var resp = response;
			var respVal = resp.response;
			var notEnoughStocks = resp.notEnoughStocksMap;
			
			
			if(respVal === "success"){
				alert("주문번호 " +orderCode + "번의 주문이 접수되었습니다.");
				window.location.href='orderManage.do';
			} else if (respVal === "notEnough"){
				var alertMsg = "재고가 부족하여 주문번호 " + orderCode + "번의 주문을 접수할 수 없습니다.\n";
			    
			    // Object.entries()로 notEnoughStocks 객체의 키와 값을 동시에 꺼냄
			    //for (var [key, value] of Object.entries(notEnoughStocks)) {
			    	var stocks = notEnoughStocks.stockListName;
			    	var quantity = notEnoughStocks.notEnoughQuantity;
			        alertMsg += "재고명 : " + stocks + " - " + quantity + "개 부족\n"; // stockListCode와 부족한 수량 추가

			    //}
			    
				alert(alertMsg);
				location.reload();
			} else if(respVal === "stockMinusFail"){
				alert("재고 차감 실패. 관리자에게 문의하세요.");
				location.reload();
			} else if(respVal === "orderStatusFail"){
				alert("주문 상태 변경 실패. 관리자에게 문의하세요.");
				location.reload();
			} else if(respVal === "alarmInsertFail"){
				alert("알람 인서트 실패. 관리자에게 문의하세요.");
				location.reload();
			} else {
				alert("주문 접수 실패. 관리자에게 문의하세요.");
				location.reload();
			}
			
		},
		error : function(error){
			alert("에러 발생. 관리자에게 문의하세요.");
			location.reload();
		}		
	});
}



function orderCancel(element){
	const orderCode = element.getAttribute('data-orderCode');
	console.log(orderCode);
	
	$.ajax({
		type : "POST",
		url : "orderCancel.ajax",
		data : {
			orderCode : orderCode
		},
		success : function(response){
			var resp = response;
			var respVal = resp.response;
			if(respVal === "success"){
				alert("주문번호 " +orderCode + "번의 주문이 취소되었습니다.");
				window.location.href='orderManage.do';
			} else if (respVal === "cancelUpdateFail"){
				alert("재고가 부족하여 주문번호 " +orderCode + "번의 주문을 접수할 수 없습니다.");
				location.reload();
			} else {
				alert("알람 인서트 실패. 관리자에게 문의하세요.");
				location.reload();
			}
		},
		error : function(error){
			alert("주문 취소에 실패했습니다.");
			location.reload();
		}		
	});
}


function orderFinish(element){
	const orderCode = element.getAttribute('data-orderCode');
	console.log(orderCode);
	
	$.ajax({
		type : "POST",
		url : "orderFinish.ajax",
		data : {
			orderCode : orderCode
		},
		success : function(response){
			var resp = response;
			var respVal = resp.response;
			if(respVal === "success"){
				alert("주문번호 " +orderCode + "번의 제조가 완료되었습니다.");
				location.reload();
			} else if (respVal === "finishUpdateFail"){
				alert("제조완료 상태 업데이트 실패. 관리자에게 문의해주세요.");
				location.reload();
			} else if (respVal === "alarmInsertFail"){
				alert("제조완료 알람 인서트 실패. 관리자에게 문의해주세요.");
				location.reload();
			} else {
				alert("에러 발생. 관리자에게 문의하세요.");
				location.reload();
			}
		},
		error : function(error){
			alert("주문 제조완료에 실패했습니다.");
			location.reload();
		}		
	});
}


function stopOrder(){
	$.ajax({
		type : "POST",
		url : "orderStop.ajax",
		data : { },
		success : function(response){
			var resp = response;
			var respVal = resp.response;
			
			if(respVal === "success"){
				alert("지점의 모든 주문 기능이 정지되었습니다.");
				location.reload();
			} else if (respVal === "fail"){
				alert("주문 기능 정지에 실패했습니다.");
				location.reload();
			}			
		},
		error : function(error){
			alert("에러 발생. 관리지에게 문의하세요.");
			location.reload();
		}		
	});
}

function restartOrder(){
	$.ajax({
		type : "POST",
		url : "orderRestart.ajax",
		data : { },
		success : function(response){
			var resp = response;
			var respVal = resp.response;
			
			if(respVal === "success"){
				alert("지점의 모든 주문이 오픈되었습니다.");
				location.reload();
			} else if (respVal === "fail"){
				alert("주문 기능 오픈에 실패했습니다.");
				location.reload();
			}			
		},
		error : function(error){
			alert("에러 발생. 관리지에게 문의하세요.");
			location.reload();
		}		
	});
}


function checkNewOrder() {
    $.ajax({
        url: "/checkNewOrder.ajax",
        type: "GET",
        success: function(response) {
        	console.log(response.newOrder);
            if (response.newOrder) {
                location.reload();  // 화면 새로고침
            }
        },
        error: function(error) {
            console.error('주문 새로고침 에러 발생:', error);
        }
    });
}

setInterval(checkNewOrder, 30000);

</script> 


