<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_stocks" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>재고현황</p>
        </div>

        <div class="select_box">
            <div class="tab_box">
                <a class="tab_btn ${empty param.foo_pageNum && empty param.cup_pageNum && empty param.syr_pageNum && empty param.whi_pageNum && empty param.mil_pageNum && empty param.tum_pageNum && empty param.won_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_drink">음료</a>
                <a class="tab_btn ${not empty param.foo_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_food">푸드</a>
                <a class="tab_btn ${not empty param.cup_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_cup">컵</a>
                <a class="tab_btn ${not empty param.syr_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_syrup">시럽</a>
                <a class="tab_btn ${not empty param.whi_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_whip">휘핑크림</a>
                <a class="tab_btn ${not empty param.mil_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_milk">우유</a>
                <a class="tab_btn ${not empty param.tum_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_tumbler">텀블러</a>
                <a class="tab_btn ${not empty param.won_pageNum ? 's_active' : ''}" href="javascript:;" data-tab="stocks_beans">원두</a>
            </div>

            <div id="stocks_drink" class="tab-content ${empty param.foo_pageNum && empty param.cup_pageNum && empty param.syr_pageNum && empty param.whi_pageNum && empty param.mil_pageNum && empty param.tum_pageNum && empty param.won_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>음료</p>
                </div>

                <ul class="stocks_list">
                	<c:forEach var="bevStocks" items="${bevStocksList}">
	                    <li class="stocks_item">
	                        	<c:if test="${bevStocks.stockListStatus eq 'Y'}">
		                        <div class="img_box">
	                        		<img src="/images/stocks_image/${bevStocks.stockListImage}">
	                        	</div>
	                        	</c:if>
	                        	<c:if test="${bevStocks.stockListStatus eq 'N'}">
                        		<div class="img_box order_dimm">
	                        		<img src="/images/stocks_image/${bevStocks.stockListImage}">
	                        	</div>
	                        	</c:if>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${bevStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${bevStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                                
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${bevStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${bevStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                
	                                <c:if test="${bevStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${bevStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>	
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>         
                </ul>
                <!-- 음료 페이징 -->
				<div class="pagination pagination_y">
				    <c:if test="${bev_startPage > bev_pageBlock}"> 
				        <a class="page_btn prev_btn" href="stocks.do?pageNum=${bev_startPage-3}">
			        	<img src="../../images/icons/arrow.png" alt="">
				        </a>
				    </c:if>
				    
				    <c:forEach var="i" begin="${bev_startPage}" end="${bev_endPage}">
				        <c:set var="activeClass" value=""/>
				        <c:choose>
				            <c:when test="${empty param.pageNum and i == 1}">
				                <c:set var="activeClass" value="page_active"/>
				            </c:when>
				            <c:when test="${param.pageNum == i}">
				                <c:set var="activeClass" value="page_active"/>
				            </c:when> 
				        </c:choose>
				        <a href="stocks.do?pageNum=${i}" class="${activeClass}  page_num">${i}</a>
				    </c:forEach>
				    
				    <c:if test="${bev_pageCount > bev_endPage}">
				        <a class="page_btn next_btn" href="stocks.do?pageNum=${bev_startPage+3}">
			        	<img src="../../images/icons/arrow.png" alt="">
				        </a>
				    </c:if>
				</div>    
            </div>    
            
            
            <div id="stocks_food" class="tab-content ${not empty param.foo_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>푸드</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="fooStocks" items="${fooStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${fooStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${fooStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${fooStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>	
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${fooStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${fooStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${fooStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${fooStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${fooStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${fooStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>	
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!-- 푸드 페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${foo_startPage > foo_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?foo_pageNum=${foo_startPage-3}">
				        	<img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${foo_startPage}" end="${foo_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.foo_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.foo_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?foo_pageNum=${i}" class="${activeClass}  page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${foo_pageCount > foo_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?foo_pageNum=${foo_startPage+3}">
				        	<img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_cup" class="tab-content ${not empty param.cup_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>컵</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="cupStocks" items="${cupStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${cupStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${cupStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${cupStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${cupStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${cupStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${cupStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${cupStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${cupStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${cupStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>	
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${cup_startPage > cup_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?cup_pageNum=${cup_startPage-3}">
				        	<img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${cup_startPage}" end="${cup_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.cup_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.cup_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?cup_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${cup_pageCount > cup_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?cup_pageNum=${cup_startPage+3}">
				        	<img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_syrup" class="tab-content ${not empty param.syr_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>시럽</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="syrStocks" items="${syrStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${syrStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${syrStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${syrStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${syrStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${syrStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${syrStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${syrStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${syrStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${syrStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>	
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${syr_startPage > syr_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?syr_pageNum=${syr_startPage-3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${syr_startPage}" end="${syr_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.syr_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.syr_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?syr_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${syr_pageCount > syr_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?syr_pageNum=${syr_startPage+3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_whip" class="tab-content ${not empty param.whi_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>휘핑크림</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="whiStocks" items="${whiStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${whiStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${whiStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${whiStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${whiStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${whiStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${whiStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${whiStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${whiStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${whiStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${whi_startPage > whi_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?whi_pageNum=${whi_startPage-3}">
				        	<img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${whi_startPage}" end="${whi_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.whi_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.whi_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?whi_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${whi_pageCount > whi_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?whi_pageNum=${whi_startPage+3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_milk" class="tab-content ${not empty param.mil_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>우유</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="milStocks" items="${milStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${milStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${milStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${milStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${milStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${milStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${milStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${milStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${milStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${milStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${mil_startPage > mil_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?mil_pageNum=${mil_startPage-3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${mil_startPage}" end="${mil_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.mil_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.mil_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?mil_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${mil_pageCount > mil_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?mil_pageNum=${mil_startPage+3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_tumbler" class="tab-content ${not empty param.tum_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>텀블러</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="tumStocks" items="${tumStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${tumStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${tumStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${tumStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${tumStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${tumStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${tumStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${tumStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${tumStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${tumStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${tum_startPage > tum_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?tum_pageNum=${tum_startPage-3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${tum_startPage}" end="${tum_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.tum_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.tum_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?tum_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${tum_pageCount > tum_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?tum_pageNum=${tum_startPage+3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
            <div id="stocks_beans" class="tab-content ${not empty param.won_pageNum ? 's_active' : ''}">
                <div class="ttit_box">
                    <p>원두</p>
                </div>
                <ul class="stocks_list">
                	<c:forEach var="wonStocks" items="${wonStocksList}">
	                    <li class="stocks_item">
	                        <div class="img_box">
	                            <c:if test="${wonStocks.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${wonStocks.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${wonStocks.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>
	                        </div>
	                        <div class="txt_box">
	                            <dl>
	                                <dt>품목명</dt>
	                                <dd>${wonStocks.stockListName}</dd>
	                            </dl>
	                            <dl>
	                                <dt>발주가격</dt>
	                                <dd><fmt:formatNumber value="${wonStocks.stockListPrice}" pattern="###,###"/>원</dd>
	                            </dl>
	                            <dl>
	                                <dt>남은재고</dt>
	                                <dd><fmt:formatNumber value="${wonStocks.stocksCount}" pattern="###,###"/>개</dd>
	                            </dl>
	                            <div class="add_box">
	                                <div class="count_box">
	                                    <div class="minus_btn img_box">
	                                        <img src="../images/icons/minus.png" name="minusBtn" alt="" onclick="minusCount(this)">
	                                    </div>
	                                    <label>
	                                        <input type="text" name="quantityValue" value="0">
	                                        <input type="hidden" name="stockListCode" value="${wonStocks.stockListCode}">
	                                    </label>
	                                    <div class="plus_btn img_box">
	                                        <img src="../images/icons/plus.png" name="plusBtn" alt="" onclick="plusCount(this)">
	                                    </div>
	                                </div>
	                                <c:if test="${wonStocks.stockListStatus eq 'Y'}">
		                        		<button type="button" onclick="addCart(this)">담기</button>
		                        	</c:if>
		                        	<c:if test="${wonStocks.stockListStatus eq 'N'}">
		                        		<button type="button" onclick="noti(this)" style="background:grey">담기</button>
		                        	</c:if>
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    
                    <!--  페이징 -->
					<div class="pagination pagination_y">
					    <c:if test="${won_startPage > won_pageBlock}"> 
					        <a class="page_btn prev_btn" href="stocks.do?won_pageNum=${won_startPage-3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					    
					    <c:forEach var="i" begin="${won_startPage}" end="${won_endPage}">
					        <c:set var="activeClass" value=""/>
					        <c:choose>
					            <c:when test="${empty param.won_pageNum and i == 1}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					            <c:when test="${param.won_pageNum == i}">
					                <c:set var="activeClass" value="page_active"/>
					            </c:when>
					        </c:choose>
					        <a href="stocks.do?won_pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${won_pageCount > won_endPage}">
					        <a class="page_btn next_btn" href="stocks.do?won_pageNum=${won_startPage+3}">
					        <img src="../../images/icons/arrow.png" alt="">
					        </a>
					    </c:if>
					</div>    
                </ul>
            </div>
            
            
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>

<script type="text/javascript">
	const textboxVal = document.getElementsByName('quantityValue');

	textboxVal.forEach(function(input) {
       // 숫자 외 입력 시 삭제
       input.addEventListener('input', function(event) {
           this.value = this.value.replace(/[^0-9]/g, '');
       });

       // 사용자가 입력할 때마다 범위를 검사
       input.addEventListener('blur', function(event) {
           let value = parseInt(this.value);

           // 숫자 값이 없거나 비어있으면 0으로 설정
           if (isNaN(value) || value === '') {
               this.value = 0;
           } else if (value > 100) {
               this.value = 100;
           } else if (value < 0) {
               this.value = 0;
           }
       });
	});	
	
	function minusCount(element) {
	    const inputValue = element.closest('.count_box').querySelector('input[name="quantityValue"]');
	    let value = parseInt(inputValue.value);
	    if (value > 0) {
	        inputValue.value = value - 1;
	    }
	}

	function plusCount(element) {
	    const inputValue = element.closest('.count_box').querySelector('input[name="quantityValue"]');
	    let value = parseInt(inputValue.value);
	    if (value < 100) {
	        inputValue.value = value + 1;
	    }
	}
	
	function addCart(element){		
		const addBox = element.closest('.add_box');	
		const stockListCode = addBox.querySelector('input[name="stockListCode"]');
		let stockListCodeVal = stockListCode.value;
		const inputValue = addBox.querySelector('input[name="quantityValue"]');
	    let QuantityVal = parseInt(inputValue.value);
	    
	    console.log(stockListCodeVal);
	    console.log(QuantityVal);
		
	    if(QuantityVal > 0){
			$.ajax({
				type: "POST",
				url: "addStocksCart.ajax",
				data : {
					stockListCode : stockListCodeVal,
					quantity : QuantityVal
				},	
				success: function(response){
					console.log("성공", response);
					if (confirm("상품이 장바구니에 성공적으로 담겼습니다. 장바구니로 이동하시겠습니까?")) {
						// Yes를 누르면 장바구니로 이동
						window.location.href = "/stocksCart.do";
					} else {
						// No를 누르면 현재 페이지 유지
						// 아무 작업도 하지 않음
					}
				},
				error : function(error){
					console.log("에러", error);
				}
			});
	    } else {
	    	alert("수량을 입력해주세요.")
	    }
		
	}
	
	function noti(element){
		alert("해당 상품은 발주되지 않습니다. 본사에 문의해주세요.");
	}
	
</script>

