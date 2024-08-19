<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin_top.jsp"%>
<!-- s: content -->
<section id="admin_stocklist" class="content managelist">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>본사 재고관리</p>
        </div>

        <div class="search_box">
            <form name="" action="" method="post">
                <label>카테고리코드
                    <select name="">
                        <option value="">전체</option>
                        <option value="">음료(BEV)</option>
                        <option value="">케이크(CAK)</option>
                        <option value="">샌드위치(SAN)</option>
                        <option value="">텀블러(TUM)</option>
                        <option value="">원두(WON)</option>
                    </select>
                </label>
                <label>품목명
                    <input type="text" name="" value="">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="list_box">
            <ul class="search_list bg_beige">
            	<c:forEach var="stocks" items="${adminStockList}">            	
	                <li class="search_item">
	                    <ul class="search_toolbar">
	                        <li style="width: 20%;">카테고리</li>
	                        <li style="width: 20%;">카테고리 코드</li>
	                        <li style="width: 20%;">품목명</li>
	                        <li style="width: 20%;">남은재고</li>
	                        <li style="width: 20%;"></li>
	                    </ul>
	                    <ul class="search_cont">
	                        <li class="stocks_cate" style="width: 20%; text-align: center;">${stocks.stockCateCode}</li>
	                        <li class="stocks_item" style="width: 20%; text-align: center;">${stocks.stockListCode}</li>
	                        <li class="stocks_item" style="width: 20%; text-align: center;">${stocks.stockListName}</li>
	                        <li class="stocks_account" style="width: 20%; text-align: center;">${stocks.stockListCount}</li>
	                        <li style="width: 20%; text-align: center;">
	                            <button class="stocks_btn" type="button">재고확충</button>
	                            <button class="stocks_btn" type="button">발주막기</button>
	                        </li>
	                    </ul>                    
	                </li>
                </c:forEach>	        	
            </ul>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../admin_bottom.jsp"%>