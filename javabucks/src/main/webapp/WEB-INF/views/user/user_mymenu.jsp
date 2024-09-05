<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>         
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_mymenu" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">나만의메뉴</p>
            </div>
            <ul class="menu_list">
            	<c:if test="${empty mymenu}">
            	<li class="menu_item nolist">
	            	등록된 나만의 메뉴가 없습니다. <br/>
	            	즐겨 찾는 음료나 푸드를 나만의 메뉴로 등록하고 빠르게 주문해 보세요.
            	 </li>
            	</c:if>
            	<c:if test="${not empty mymenu}">
            	<c:forEach var="menu" items="${mymenu}">
					<input type="hidden" id = "menuCode_${menu.menuCode}" name="menuCode" value="${menu.menuCode}">
					<input type="hidden" id = "bucksId_${menu.menuCode}" name="bucksId" value="${menu.bucksId}">
					<input type="hidden" id = "pickup_${menu.menuCode}" name="pickup" value="">
                <li class="menu_item">
                    <div class="close_icon img_box">
                        <a href="user_mymenu?mode=deleteMymenu&menuCode=${menu.menuCode}">
                            <img src="../images/icons/close.png" alt="">
                        </a>
                    </div>
                    <div class="menu_icon img_box">
                        <img src="upload_menuImages/${menu.menuImages}" alt="">
                    </div>
                    <div class="txt_box">
                        <p class="txt_tit">${menu.menuName}</p>
                        <p class="txt_price"><fmt:formatNumber value="${menu.menuPrice}" pattern="#,###"/> 원</p>
                        <div class="btn_box">
                            <button id="store" type="button" onclick="ToOrder('${menu.menuCode}', '매장이용', this)">Store</button>
                            <button id="togo" type="button" onclick="ToOrder('${menu.menuCode}', 'To-go', this)">To-go</button>
                            <button id="delivers" type="button" onclick="ToOrder('${menu.menuCode}', 'Delivers', this)">Delivers</button>
                        </div>
                    </div>
                </li>
                </c:forEach>
                </c:if>
            </ul>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script>
	
	function ToOrder(menuCode, pickup, clickedButton) {
		
		// 버튼들에 대한 ID를 설정합니다.
        var buttons = document.querySelectorAll('.btn_box button');
    	
        // hidden input 요소의 값을 가져옵니다.
        var pickupInput = document.getElementById('pickup_' + menuCode);
		var menuCodeInput = document.getElementById('menuCode_' + menuCode);
	    var bucksIdInput = document.getElementById('bucksId_' + menuCode);
		
		if (pickupInput) {
		        pickupInput.value = pickup;
		    }
			
	    // 알림창을 띄웁니다.
	    var userConfirmed = confirm("메뉴 상세 페이지로 이동합니다.");
		
	    // 사용자가 '확인'을 눌렀다면 페이지를 이동합니다.
	    if (userConfirmed) {
	    		        
			var menuCodeValue = menuCodeInput ? menuCodeInput.value : '';
			        var bucksIdValue = bucksIdInput ? bucksIdInput.value : '';

			        // URL에 menuCode를 포함하여 이동합니다.
			        var url = "/user_menudetail?menuCode=" + encodeURIComponent(menuCodeValue) + 
			                  "&bucksId=" + encodeURIComponent(bucksIdValue) + 
			                  "&pickup=" + encodeURIComponent(pickupInput.value);
			        window.location.href = url;
			    }
			}
</script>
