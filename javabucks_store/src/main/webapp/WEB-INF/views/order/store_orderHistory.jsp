<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_orderhistory" class="content orderhistory">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>매장주문내역</p>
        </div>

        <div class="search_box">
            <form name="" action="" method="post">
                <label>주문일
                    <input type="date" name="" value="">
                </label>
                <label>주문번호
                    <input type="text" name="" value="">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="list_box">
            <ul class="search_list bg_beige">
            	<c:forEach var="order" items="${orderInfoList}">
	                <li class="search_item">
	                    <div class="search_toolbar">
	                        <p style="width: 14%;">주문번호</p>
	                        <p style="width: 30%;">주문내역</p>
	                        <p style="width: 18%;">주문금액</p>
	                        <p style="width: 18%;">주문일시</p>
	                    </div>
	                    <p class="order_num" style="width: 14%; text-align: center;">${order.orderCode}</p>
	                    <ul class="menu_list" style="width: 50%;">
							<c:forEach var="menuOrder" items="${order.orderListbyMenuOrder}">
		                        <li class="menu_item">${menuOrder.menuName} ${menuOrder.quantity}개</li>
		                        <li class="menu_opt" id="cup_opt">- CUP : ${menuOrder.cupType}  (${menuOrder.cupPrice}원)</li>
		                        <li class="menu_opt" id="shot_opt">- SHOT : ${menuOrder.shotType} 추가 ${menuOrder.shotCount}회 (${menuOrder.shotPrice}원)</li>
		                        <li class="menu_opt" id="syrup_opt">- SYRUP : ${menuOrder.syrupType} 추가 ${menuOrder.syrupCount}회 (${menuOrder.syrupPrice}원)</li>
		                        <li class="menu_opt" id="ice_opt">- ICE : ${menuOrder.iceType}  (${menuOrder.icePrice}원)</li>
		                        <li class="menu_opt" id="whip_opt">- WHIP : ${menuOrder.whipType}  (${menuOrder.whipPrice}원)</li>
		                        <li class="menu_opt" id="milk_opt">- MILK : ${menuOrder.milkType}  (${menuOrder.milkPrice}원)</li> 
							</c:forEach>
	                    </ul>
	                    <p class="order_price" style="width: 18%; text-align: center;">${order.orderPrice}원</p>
	                    <p class="order_date" style="width: 18%; text-align: center;">${order.orderDate}</p>
	                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
<script type="text/javascript" >
document.addEventListener('DOMContentLoaded', function() {
	// 아이템 가격을 가져와서 확인합니다.
	var iceElement = document.getElementById('ice_opt');
	//console.log(iceElement);
	if (iceElement) {
	  // 가격 값을 추출합니다.
	  var text = iceElement.textContent || iceElement.innerText;
	  //console.log(text);
	  // 정규 표현식을 사용하여 가격을 추출합니다.
	  var priceMatch = text.match(/\((\d+)원\)/);
	  //console.log(priceMatch);
	  if (priceMatch && priceMatch[1] === '99999') {
	    // 가격이 9999이면 요소를 숨깁니다.
	    iceElement.style.display = 'none';
	    console.log('Element hidden');
	  }
	}
});
</script>