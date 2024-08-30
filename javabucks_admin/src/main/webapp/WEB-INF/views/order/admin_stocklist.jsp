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
            <form name="adminStockList_f" action="findAdminStockList.do" method="GET">
                <label>카테고리코드
                    <select name="searchCate">
                        <option value="ALL" ${searchCate == 'ALL' ? 'selected' : ''}>전체</option>
                        <option value="BEV" ${searchCate == 'BEV' ? 'selected' : ''}>음료(BEV)</option>
                        <option value="CAK" ${searchCate == 'CAK' ? 'selected' : ''}>케이크(CAK)</option>
                        <option value="SAN" ${searchCate == 'SAN' ? 'selected' : ''}>샌드위치(SAN)</option>
                        <option value="TUM" ${searchCate == 'TUM' ? 'selected' : ''}>텀블러(TUM)</option>
                        <option value="WON" ${searchCate == 'WON' ? 'selected' : ''}>원두(WON)</option>
                        <option value="CUP" ${searchCate == 'CUP' ? 'selected' : ''}>컵(CUP)</option>
                        <option value="SYR" ${searchCate == 'SYR' ? 'selected' : ''}>시럽(SYR)</option>
                        <option value="MIL" ${searchCate == 'MIL' ? 'selected' : ''}>우유(MIL)</option>
                        <option value="WHI" ${searchCate == 'WHI' ? 'selected' : ''}>휘핑크림(WHI)</option>
                    </select>
                </label>
                <label>품목명
                    <input type="text" name="searchStockListName" value="${searchStockListName}">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>
        
        <c:if test="${empty findAdminStockList && empty adminStockList}">
        	<div class="list_box">
	            <ul class="search_list bg_beige">
	            	<li class="">
	                    재고 품목이 없습니다.                   
	                </li>
	            </ul>
	        </div>
        </c:if>
        
		<c:if test="${empty findAdminStockList && not empty adminStockList}">
	        <div class="list_box">
	            <ul class="search_list bg_beige">
	            	<c:forEach var="stocks" items="${adminStockList}">            	
		                <li class="search_item">
		                    <ul class="search_toolbar">
		                        <li style="width: 14%;">카테고리</li>
		                        <li style="width: 17%;">카테고리 코드</li>
		                        <li style="width: 40%;">품목명</li>
		                        <li style="width: 10%;">남은재고</li>
		                        <li style="width: 20%;"></li>
		                    </ul>
		                    <ul class="search_cont">
		                        <li class="stocks_cate" style="width: 14%; text-align: center;">${stocks.stockCateCode}</li>
		                        <li class="stocks_listCode" style="width: 17%; text-align: center;">${stocks.stockListCode}</li>
		                        <li class="stocks_listName" style="width: 40%; text-align: center;">${stocks.stockListName}</li>
		                        <li class="stocks_count" style="width: 10%; text-align: center;">${stocks.stockListCount}</li>
		                        <li style="width: 20%; text-align: center;">
		                            <button class="stocks_btn" type="button" onclick="stocksPlus(this)">재고확충</button>
		                            <c:if test="${stocks.stockListStatus eq 'Y'}">
		                            	<button class="stocks_btn block" type="button" onclick="orderBlock(this)">발주막기</button>
		                            	<button class="stocks_btn release" type="button" style="display:none;" onclick="orderRelease(this)">발주풀기</button>
		                            </c:if>
		                            <c:if test="${stocks.stockListStatus eq 'N'}">
		                            	<button class="stocks_btn block" type="button" style="display:none;" onclick="orderBlock(this)">발주막기</button>
		                            	<button class="stocks_btn release" type="button" onclick="orderRelease(this)">발주풀기</button>
		                            </c:if>
		                        </li>
		                    </ul>                    
		                </li>
	                </c:forEach>	        	
	            </ul>
	        </div>
	        <!--  페이징 -->
			<div class="pagination pagination">
			    <c:if test="${startPage > pageBlock}"> 
			        <a class="page_btn prev_btn" href="adminStockList.do?pageNum=${startPage-3}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			    
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			        <c:set var="activeClass" value=""/>
			        <c:choose>
			            <c:when test="${empty param.pageNum and i == 1}">
			                <c:set var="activeClass" value="page_active"/>
			            </c:when>
			            <c:when test="${param.pageNum == i}">
			                <c:set var="activeClass" value="page_active"/>
			            </c:when>
			        </c:choose>
			        <a href="adminStockList.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
			    </c:forEach>
			    
			    <c:if test="${pageCount > endPage}">
			        <a class="page_btn next_btn" href="adminStockList.do?pageNum=${startPage+3}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			</div>
		</c:if>
		
		<c:if test="${not empty findAdminStockList}">
	        <div class="list_box">
	            <ul class="search_list bg_beige">
	            	<c:forEach var="stocks" items="${findAdminStockList}">            	
		                <li class="search_item">
		                    <ul class="search_toolbar">
		                        <li style="width: 14%;">카테고리</li>
		                        <li style="width: 17%;">카테고리 코드</li>
		                        <li style="width: 40%;">품목명</li>
		                        <li style="width: 10%;">남은재고</li>
		                        <li style="width: 20%;"></li>
		                    </ul>
		                    <ul class="search_cont">
		                        <li class="stocks_cate" style="width: 14%; text-align: center;">${stocks.stockCateCode}</li>
		                        <li class="stocks_listCode" style="width: 17%; text-align: center;">${stocks.stockListCode}</li>
		                        <li class="stocks_listName" style="width: 40%; text-align: center;">${stocks.stockListName}</li>
		                        <li class="stocks_count" style="width: 10%; text-align: center;">${stocks.stockListCount}</li>
		                        <li style="width: 20%; text-align: center;">
		                        	<button class="stocks_btn" type="button" onclick="stocksPlus(this)">재고확충</button>
		                            <c:if test="${stocks.stockListStatus eq 'Y'}">
		                            	<button class="stocks_btn block" type="button" onclick="orderBlock(this)">발주막기</button>
		                            	<button class="stocks_btn release" type="button" style="display:none;" onclick="orderRelease(this)">발주풀기</button>
		                            </c:if>
		                            <c:if test="${stocks.stockListStatus eq 'N'}">
		                            	<button class="stocks_btn block" type="button" style="display:none;" onclick="orderBlock(this)">발주막기</button>
		                            	<button class="stocks_btn release" type="button" onclick="orderRelease(this)">발주풀기</button>
		                            </c:if>
		                        </li>
		                    </ul>                    
		                </li>
	                </c:forEach>	        	
	            </ul>
	        </div>
	        <!--  페이징 -->
			<div class="pagination pagination">
			    <c:if test="${startPage > pageBlock}"> 
			        <a class="page_btn prev_btn" href="findAdminStockList.do?pageNum=${startPage-3}&searchCate=${searchCate}&searchStockListName=${searchStockListName}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			    
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			        <c:set var="activeClass" value=""/>
			        <c:choose>
			            <c:when test="${empty param.pageNum and i == 1}">
			                <c:set var="activeClass" value="page_active"/>
			            </c:when>
			            <c:when test="${param.pageNum == i}">
			                <c:set var="activeClass" value="page_active"/>
			            </c:when>
			        </c:choose>
			        <a href="findAdminStockList.do?pageNum=${i}&searchCate=${searchCate}&searchStockListName=${searchStockListName}" class="${activeClass} page_num">${i}</a>
			    </c:forEach>
			    
			    <c:if test="${pageCount > endPage}">
			        <a class="page_btn next_btn" href="findAdminStockList.do?pageNum=${startPage+3}&searchCate=${searchCate}&searchStockListName=${searchStockListName}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			</div>
		</c:if>

    </div>
</section>
<!-- e: content -->
<%@ include file="../admin_bottom.jsp"%>

<script type="text/javascript">
	function stocksPlus(element){
		const stockListCode = element.closest('.search_item').querySelector('.stocks_listCode').textContent.trim();
		const stockListName = element.closest('.search_item').querySelector('.stocks_listName').textContent.trim();
		const stockCount = element.closest('.search_item').querySelector('.stocks_count').textContent.trim();
		
		// 수량이 표시된 위치
		const stockCountElement = element.closest('.search_item').querySelector('.stocks_count'); 
		
		$.ajax({
			type: "POST",
			url: "stockPlus.ajax",
			data : {
				stockListCode : stockListCode,
				stockCount : stockCount
			},	
			success : function(response){
				let newStockCount = response.updateCount;
				console.log(newStockCount);
				stockCountElement.textContent = newStockCount;
				alert(stockListName+"("+stockListCode + ")의 재고가 추가되었습니다.")
			},
			error : function(error){
				console.log("에러", error);
			}
		});
	}
	
	function orderBlock(element){
		const stockListCode = element.closest('.search_item').querySelector('.stocks_listCode').textContent.trim();
		const stockListName = element.closest('.search_item').querySelector('.stocks_listName').textContent.trim();
		
		$.ajax({
			type : "POST",
			url : "adminOrderBlock.ajax",
			data : {
				stockListCode : stockListCode
			},
			success : function(response){
				console.log(response.result);
				if(response.result === "success"){
					alert(stockListName+"("+stockListCode+") 재고 품목의 발주기능을 막았습니다.");
 					$(element).hide();
 					$(element).siblings('.release').css('display', 'inline-block');
				} else {
					alert("발주기능 막기 실패했습니다.")
				}
			},
			error : function(){
				alert("서버 오류 발생")
			}
		});
	}
	
	function orderRelease(element){
		const stockListCode = element.closest('.search_item').querySelector('.stocks_listCode').textContent.trim();
		console.log(stockListCode);
		const stockListName = element.closest('.search_item').querySelector('.stocks_listName').textContent.trim();
		console.log(stockListName);
		
		$.ajax({
			type : "POST",
			url : "adminOrderRelease.ajax",
			data : {
				stockListCode : stockListCode
			},
			success : function(response){
				console.log(response.result);
				if(response.result === "success"){
					alert(stockListName+"("+stockListCode+") 재고 품목의 발주기능을 풀었습니다.");
 					$(element).hide();
 					$(element).siblings('.block').css('display', 'inline-block');
				} else {
					alert("발주기능 풀기 실패했습니다.")
				}
			},
			error : function(){
				alert("서버 오류 발생")
			}
		});
	}
	

</script>