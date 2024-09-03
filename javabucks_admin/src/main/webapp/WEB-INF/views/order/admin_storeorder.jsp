<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin_top.jsp"%>
<!-- s: content -->
<section id="admin_storeorder" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>지점별 발주현황</p>
        </div>

        <div class="search_box">
            <form name="searchBaljoo_f" action="searchAdminStoreOrder.do" method="GET">
                <div style="width: 100%;">
                    <label>발주기간
                        <select name="selectYear">
                        	<c:forEach var="year" items="${yearList}">
                            	<option value="${year}" <c:if test="${selectYear eq year}">selected</c:if>>${year}</option>
                            </c:forEach>
                        </select>
                        년
                    </label>
                    <label>
                        <select name="selectMonth">
                            <c:forEach var="month" items="${monthList}">
                            	<option value="${month}" <c:if test="${selectMonth eq month}">selected</c:if>>${month}</option>
                            </c:forEach>
                        </select>
                        월
                    </label>
                    <label>
                        <input type="checkbox" name="unproCheck" value="checked" <c:if test="${unproCheck == 'checked'}">checked</c:if>>미처리건 조회
                    </label>
                </div>
                <div style="width: 100%; display: flex; align-items: center;">
                <label>발주지점
                    <select name="selectStore">
                    	<option value="ALL">전체</option>
                        <c:forEach var="store" items="${storeNamelist}">
                           	<option value="${store.bucksId}" <c:if test="${store.bucksId eq selectStore}">selected</c:if>>${store.bucksName}</option>
                        </c:forEach>
                    </select>
                </label>
                <label>발주번호
					<input type="text" name="selectNum" value="${selectNum}">
                </label>
                <button type="submit">검색</button>
                </div>
            </form>
        </div>

        <div class="search_list">
            <div class="list_box">
                <table class="search_list s_table">
                    <thead class="bg_green font_white">
                        <tr>
                            <th style="width: 10%;">발주번호</th>
                            <th>발주일</th>
                            <th>발주지점</th>
                            <th>발주품목</th>
                            <th>발주금액</th>
                            <th>발주처리</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:if test="${empty searchBaljooList}">
	                    	<c:if test="${empty baljooList}">
	                    		<tr><td colspan="6" style="text-align: center;">발주내역이 없습니다.</td></tr>
	                    	</c:if>
	                    	<c:if test="${not empty baljooList}">
		                    	<c:forEach var="baljoo" items="${baljooList}">
			                        <tr>
			                        	<td>${baljoo.baljooNum}</td>
			                            <td>		                            
				                            <c:set var="parsedDate" value="${baljoo.baljooDate}" />	                       
											<fmt:parseDate var="date" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss" />
											<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />	
			                            </td>	                            
			                            <td>${baljoo.bucksName}</td>
			                            <td>
			                            	<ul>
			                            	<c:forEach var="item" items="${baljoo.baljooListbyBaljooOrder}">
			                            		<li>${item.stockListName} ${item.quantity}개</li>
			                            	</c:forEach>
			                            	</ul>
			                            </td>
			                            <td><fmt:formatNumber value="${baljoo.baljooPrice}" pattern="###,###"/>원</td>
			                            <td>
			                            	<c:if test="${baljoo.baljooStatus eq '주문완료'}">
			                            		<button class="orderBtn orderBtn01" onclick="storeOrderOk(this)" data-baljooNum="${baljoo.baljooNum}">접수</button>
			                            	</c:if>
			                            	<c:if test="${baljoo.baljooStatus eq '접수완료'}">
			                            		<button class="orderBtn orderBtn02" onclick="" data-baljooNum="${baljoo.baljooNum}">접수완료</button>
			                            	</c:if>
			                            </td>
			                        </tr>
			                	</c:forEach>   
		                	</c:if>
		                </c:if>
		                
		                <c:if test="${not empty searchBaljooList}">
		                	<c:forEach var="search" items="${searchBaljooList}">
		                        <tr>
		                        	<td>${search.baljooNum}</td>
		                            <td>		                            
			                            <c:set var="parsedDate" value="${search.baljooDate}" />	                       
										<fmt:parseDate var="date" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />	
		                            </td>	                            
		                            <td>${search.bucksName}</td>
		                            <td>
		                            	<ul>
		                            	<c:forEach var="item" items="${search.baljooListbyBaljooOrder}">
		                            		<li>${item.stockListName} ${item.quantity}개</li>
		                            	</c:forEach>
		                            	</ul>
		                            </td>
		                            <td><fmt:formatNumber value="${search.baljooPrice}" pattern="###,###"/>원</td>
		                            <td>
		                            	<c:if test="${search.baljooStatus eq '주문완료'}">
		                            		<button class="orderBtn orderBtn01" type="button" onclick="storeOrderOk(this)" data-baljooNum="${search.baljooNum}">접수</button>
		                            	</c:if>
		                            	<c:if test="${search.baljooStatus eq '접수완료'}">
		                            		<button class="orderBtn orderBtn02" type="button" onclick="" data-baljooNum="${search.baljooNum}">접수완료</button>
		                            	</c:if>
		                            </td>
		                        </tr>
		                	</c:forEach>
		            	</c:if>
                    </tbody>
                </table>
                
                <c:if test="${not empty baljooList}">
	               	<!-- 페이징 -->
	                <div class="pagination">
					    <c:if test="${startPage > pageBlock}"> 
					        <a class="page_btn prev_btn" href="adminStoreOrder.do?pageNum=${startPage-3}">
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
					        <a href="adminStoreOrder.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    
					    <c:if test="${pageCount > endPage}">
					        <a class="page_btn next_btn" href="adminStoreOrder.do?pageNum=${startPage+3}">
					        	<img src="../../images/icons/arrow.png">
					        </a>
					    </c:if>
	                </div> 
                </c:if>
                
                <c:if test="${not empty searchBaljooList}">
                	<!-- 페이징 -->
	                <div class="pagination">
					    <c:if test="${startPage > pageBlock}"> 
					        <a class="page_btn prev_btn" href="searchAdminStoreOrder.do?pageNum=${startPage-3}&selectYear=${selectYear}&selectMonth=${selectMonth}&selectStore=${selectStore}&selectNum=${selectNum}&unproCheck=${unproCheck}">
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
					        <a href="searchAdminStoreOrder.do?pageNum=${i}&selectYear=${selectYear}&selectMonth=${selectMonth}&selectStore=${selectStore}&selectNum=${selectNum}&unproCheck=${unproCheck}" class="${activeClass} page_num">${i}</a>
					    </c:forEach>
					    <c:if test="${pageCount > endPage}">
					        <a class="page_btn next_btn" href="searchAdminStoreOrder.do?pageNum=${startPage+3}&selectYear=${selectYear}&selectMonth=${selectMonth}&selectStore=${selectStore}&selectNum=${selectNum}&unproCheck=${unproCheck}">
					        	<img src="../../images/icons/arrow.png">
					        </a>
					    </c:if>
	                </div> 
                </c:if>
            </div>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../admin_bottom.jsp"%>
<script type="text/javascript">

	function storeOrderOk(element){
		const baljooNum = element.dataset.baljoonum;
		
		$.ajax({
			type : "POST",
			url : "/storeOrderOk.ajax",
			data : {
				baljooNum : baljooNum
			},
			success : function(response){
				console.log(response);
				var resp = response;
				var respVal = resp.response;
				if(respVal === "success"){
					alert("주문번호 " +baljooNum + "번의 주문이 접수되었습니다.");
				} else if (respVal === "notEnough"){
					alert("재고가 부족하여 주문번호 " +baljooNum + "번의 주문을 접수할 수 없습니다.");
				} else if(respVal === "adminStockMinusFail"){
					alert("관리자 재고 차감 실패. 관리자에게 문의하세요.");
				} else if(respVal === "baljooTableUpdateFail"){
					alert("발주테이블 업데이트 실패. 관리자에게 문의하세요.");
				} else if(respVal === "storeStocksUpdateFail"){
					alert("지점 재고 업데이트 실패. 관리자에게 문의하세요.");
				} else {
					alert("기타 실패. 관리자에게 문의하세요.")
				}
				location.reload();
			},
			error : function(error){
				console.log(error);
			}
		});
	}

</script>
