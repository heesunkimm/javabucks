<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_delivershistory" class="content orderhistory">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>배달주문내역</p>
        </div>

        <div class="search_box">
            <form name="search_delivers_f" action="deliversHistory.do" method="post">
                <label>주문일
                    <input type="date" name="searchOpt_orderDate" value="${searchOpt_orderDate}">
                </label>
                <label>주문번호
                    <input type="text" name="searchOpt_orderCode" value="${searchOpt_orderCode}">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="list_box">
        	<c:if test="${empty deliversOrderInfoList}">
	        	<ul class="search_list bg_beige">
	        		<li class="search_item nolist">주문내역이 없습니다.</li>
	        	</ul>
        	</c:if>
        	<c:if test="${not empty deliversOrderInfoList}">
	            <ul class="search_list bg_beige">
	            	<c:forEach var="delivers" items="${deliversOrderInfoList}">
		                <li class="search_item">
		                    <div class="search_toolbar">
		                        <p style="width: 14%;">주문번호</p>
		                        <p style="width: 41%;">주문내역</p>
		                        <p style="width: 10%;">주문상태</p>
		                        <p style="width: 10%;">주문금액</p>
		                        <p style="width: 25%;">주문일시</p>
		                    </div>
		                    <p class="order_num" style="width: 14%; text-align: center;">${delivers.orderCode}</p>
		                    <ul class="menu_list" style="width: 41%;">
		                    	<c:forEach var="menuOrder" items="${delivers.orderListbyMenuOrder}">
		                        	<li class="menu_item">${menuOrder.menuName} ${menuOrder.quantity}개</li>
			                        <li class="menu_opt" id="cup_opt">- CUP : ${menuOrder.cupType}  (${menuOrder.cupPrice}원)</li>
			                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회 (${menuOrder.shotPrice}원)</li>
			                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회 (${menuOrder.syrupPrice}원)</li>
			                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}  (${menuOrder.icePrice}원)</li>
			                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}  (${menuOrder.whipPrice}원)</li>
			                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}  (${menuOrder.milkPrice}원)</li>
		                        </c:forEach>
		                    </ul>
		                    <p class="order_status" style="width: 10%; text-align: center;">${delivers.orderStatus}</p>
		                    <p class="order_price" style="width: 10%; text-align: center;"><fmt:formatNumber value="${delivers.orderPrice}" pattern="###,###"/>원</p>
		                    <p class="order_date" style="width: 25%; text-align: center;">${delivers.orderDate}</p>
		                </li>
		            </c:forEach>
	            </ul>
            </c:if>
        </div>
    </div>
</section>
<%@ include file="../store_bottom.jsp"%>
<script type="text/javascript" >
document.addEventListener('DOMContentLoaded', function() {
	var optElement = document.querySelectorAll('.menu_opt');
	//console.log(optElement);
	
	optElement.forEach(function(optElement, index){
			var opt = optElement.textContent;
			//console.log(opt); //- SHOT : 기본 추가 1회 (600원)
			var price = opt.match(/\((\d+)원\)/);
			//console.log(price); //(600원)
			//console.log(price[1]); // 600
			
			if(price && price[1] === '99999'){
				optElement.style.display = 'none';
			}
	});
});
</script> 
