<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_cart" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>장바구니</p>
        </div>
        <form name="cart_f" action="addStoreOrder.do" method="post" onsubmit="return validate()">
            <ul class="cart_list">
            	<c:if test="${empty stockCartList}">
            		<li class="noCart">장바구니에 담긴 재고 품목이 없습니다.</li>
            	</c:if>
            	<c:if test="${not empty stockCartList}">
            		<c:set var="sumPrice" value="0" />
	            	<c:forEach var="stockCart" items="${stockCartList}">
		                <li class="cart_item">		                	
		                    <div class="img_box">
		                    	<c:if test="${stockCart.stockListStatus eq 'Y'}">
	                        		<img src="/images/stocks_image/${stockCart.stockListImage}">
	                        	</c:if>
	                        	<c:if test="${stockCart.stockListStatus eq 'N'}">
	                        		주문막힘
	                        	</c:if>			                        
		                    </div>
		                    <div class="txt_box">
		                        <dl>
		                            <dt>${stockCart.stockListName}</dt>
		                            <dd><fmt:formatNumber value="${stockCart.stockListPrice}" pattern="###,###"/>원</dd>		                            
		                        </dl>
		                        <div>
		                            <div class="count_box">
		                                <div class="minus_btn img_box">
		                                    <img src="../images/icons/minus.png" alt="" onclick="minusCount(this)">
		                                </div>
		                                <label>		                                	
		                                    <input type="text" name="stockCartCount" value="${stockCart.stockCartCount}">
		                                    <input type="hidden" name="stockListPrice" value="${stockCart.stockListPrice}">
		                                    <input type="hidden" name="stockListCode" value="${stockCart.stockListCode}">
		                                    <input type="hidden" name="stockCartNum" value="${stockCart.stockCartNum}">
		                                    <input type="hidden" name="stockListStatus" value="${stockCart.stockListStatus}">
		                                </label>
		                                <div class="plus_btn img_box">
		                                    <img src="../images/icons/plus.png" alt="" onclick="plusCount(this)">
		                                </div>
		                            </div>
		                            <div class="btn_box">
		                            <button type="button" onclick="quantityUpdate(this)">수량 변경</button>
		                            <button type="button" onclick="deleteCart(this)">품목 삭제</button>
		                            </div>
		                        </div>
		                        <dl>
		                            <dt>금액</dt>
		                            <dd><fmt:formatNumber value="${stockCart.stockListPrice * stockCart.stockCartCount}" pattern="###,###"/>원</dd>
		                        </dl>
		                    </div>
		                </li>
		                <c:set var="sumPrice" value="${sumPrice + (stockCart.stockListPrice * stockCart.stockCartCount)}" />
	                </c:forEach>
                </c:if>
            </ul>
            <div class="delivers_info bg_beige">
                <div>
                    <dl>
                        <dt>배송예정일:</dt>
                        <dd>${tommorow}</dd>
                    </dl>
                    <dl>
                        <dt>배송지:</dt>
                        <dd>${address}</dd>
                    </dl>
                </div>
                <div style="text-align: right;">
                    <dl>
                        <dt>최종 주문 금액:</dt>
                        <dd><fmt:formatNumber value="${sumPrice}" pattern="###,###"/>원</dd>
                    </dl>
                    <button type="submit">주문하기</button>
                </div>
            </div>
        </form>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>

<script type="text/javascript">
	const textboxVal = document.getElementsByName('stockCartCount');

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
	
	// 수량 minus
	function minusCount(element) {
	    const inputValue = element.closest('.count_box').querySelector('input[name="stockCartCount"]');
	    let value = parseInt(inputValue.value);
	    if (value > 0) {
	        inputValue.value = value - 1;
	    }
	}

	// 수량 plus
	function plusCount(element) {
	    const inputValue = element.closest('.count_box').querySelector('input[name="stockCartCount"]');
	    let value = parseInt(inputValue.value);
	    if (value < 100) {
	        inputValue.value = value + 1;
	    }
	}

	// 장바구니 수량 업뎃
 	function quantityUpdate(element){
		const stockListCode = element.closest('.txt_box').querySelector('input[name="stockListCode"]');
		let stockListCodeVal = stockListCode.value;
		const inputValue = element.closest('.txt_box').querySelector('input[name="stockCartCount"]');
	    let value = parseInt(inputValue.value);
	    
	    $.ajax({
	    	type: "POST",
	    	url: "updateQuantity.ajax",
	    	data:{
	    		stockListCode : stockListCodeVal,
	    		quantity : value
	    	},
	    	success: function(response){
	    		alert("수량이 업데이트 되었습니다.");
	    		window.location.reload();
	    	},
	    	error : function(error){
	    		console.log("에러", error);
	    	}
	    });
	}
 	
	// 장바구니 삭제
 	function deleteCart(element){
		const stockListCode = element.closest('.txt_box').querySelector('input[name="stockListCode"]');
		let stockListCodeVal = stockListCode.value;
		
		if (confirm("해당 품목을 장바구니에서 삭제하시겠습니까?")) {
			$.ajax({
		    	type: "POST",
		    	url: "deleteCart.ajax",
		    	data:{
		    		stockListCode : stockListCodeVal,
		    	},
		    	success: function(response){
		    		alert("해당 품목이 장바구니에서 삭제되었습니다.");
		    		window.location.reload();
		    	},
		    	error : function(error){
		    		console.log("에러", error);
		    	}
		    });
		} else {
			// No를 누르면 현재 페이지 유지
			// 아무 작업도 하지 않음
		}	    
	}
	
	// 장바구니 주문 전 검증
	function validate(){
		const cartItem = document.querySelectorAll('.txt_box');
		
		for (const item of cartItem){
			const stockListStatus = item.querySelector('input[name="stockListStatus"]').value;
			
			if(stockListStatus === 'N'){
				alert("장바구니에 품절된 상품이 포함되어있습니다. 장바구니에서 제외한 후 주문해주세요.")
				return false;
			}
		}
			alert("주문이 완료되었습니다.")
			return true;		
	}
	
</script>
