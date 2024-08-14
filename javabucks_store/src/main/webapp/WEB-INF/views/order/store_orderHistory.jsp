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
	                        <p style="width: 50%;">주문내역</p>
	                        <p style="width: 18%;">주문금액</p>
	                        <p style="width: 18%;">주문일시</p>
	                    </div>
	                    <p class="order_num" style="width: 14%; text-align: center;">${order.orderCode}</p>
	                    <ul class="menu_list" style="width: 50%;">
							${order.orderList}
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