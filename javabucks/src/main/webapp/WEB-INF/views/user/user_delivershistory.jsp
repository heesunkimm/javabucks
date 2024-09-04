<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_delivershistory" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">배달 주문 히스토리</p>
            </div>
            <div class="period_box">
            	<form id="deliversHistoryForm" method="post" action="updateDeliversHistory.do" onsubmit="setSearchPeriod()">
	                <label>
	                    <select name="orderStatus" onchange="document.getElementById('deliversHistoryForm').submit();">
	                        <option value="ALL" ${orderStatus eq 'ALL' ? 'selected' : ''}>주문상태 (전체)</option>
	                        <option value="주문완료" ${orderStatus eq '주문완료' ? 'selected' : ''}>주문완료</option>
	                        <option value="제조중" ${orderStatus eq '제조중' ? 'selected' : ''}>제조중</option>
	                        <option value="배달준비" ${orderStatus eq '배달준비' ? 'selected' : ''}>배달준비</option>
	                        <option value="배달완료" ${orderStatus eq '배달완료' ? 'selected' : ''}>배달완료</option>
	                        <option value="주문취소" ${orderStatus eq '주문취소' ? 'selected' : ''}>주문취소</option>
	                    </select>
	                </label>
	                <input type="hidden" name="startDate" value="${startDate}">
	                <input type="hidden" name="endDate" value="${endDate}">
	                <input type="hidden" name="period_option" value="${period_option}">
                </form>
            </div>

            <div class="view_date">
                <c:if test="${not empty startDate && not empty endDate}">
            		<p class="font_gray">${period_setting}</p>
            	</c:if>
            	<c:if test="${empty startDate && empty endDate}">
            		<p class="font_gray">전체</p>
            	</c:if>
                <a class="popup_btn font_green" href="javascript:;" data-popup="periodpop">기간 설정</a>
            </div>
			<c:if test="${empty deliversInfoList}">
            	<ul class="history_list">
	                <li class="history_item nolist">주문내역이 없습니다.</li>
	            </ul>
            </c:if>			

			<c:if test="${not empty deliversInfoList}">
	            <ul class="history_list">
	            	<c:forEach var="order" items="${deliversInfoList}">
		                <li class="history_item">
		                    <!-- 메뉴준비 상태, 갯수에 따라 딤처리 menu_status 추가 -->
		                    <div class="img_box">
		                        <img src="../images/logo/starbucks_logo_black.png" alt="">
		                    </div>
		                    <div class="txt_box">
		                    	[${order.orderType}] - ${order.orderStatus}
		                    	<c:forEach var="menu" items="${order.orderListbyMenuOrder}" varStatus="status">
		                        	<c:if test="${status.first}">
        								<p class="txt_tit">${menu.menuName} 외</p>
    								</c:if>
		                        </c:forEach>
		                        <ul class="txt_desc">
		                            <li class="font_gray">${order.orderDate}</li>
		                            <li>${order.bucksName}       
			                            <span>
				                            <fmt:formatNumber value="${order.orderPrice}" pattern="###,###"/>원
			                            </span>
		                            </li>
		                        </ul>
		                    </div>
		                </li>
		            </c:forEach>
	            </ul>
            </c:if>
        </div>
        <!-- 기간설정 팝업 -->
        <div class="popup_box period_date" id="periodpop" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">기간 설정</p>
            </div>
            <form name="f" action="updateDeliversHistory.do" method="post" onsubmit="setOrderStatus()">
                <!-- s: 내용 작성 -->
                 <div class="date_box">
                     <label>시작일
                         <input type="date" name="startDate" value="${startDate != null ? startDate : ''}">
                     </label>
                     <label>종료일
                         <input type="date" name="endDate" value="${endDate != null ? endDate : ''}">
                     </label>
                 </div>
                <div class="select_period">
                    <label>
                        <input type="radio" name="period_option" onclick="" value="1month" <c:if test="${period_option eq '1month'}">checked</c:if>>
                        1개월
                    </label>
                    <label>
                        <input type="radio" name="period_option" onclick="" value="3month" <c:if test="${period_option eq '3month'}">checked</c:if>>
                        3개월
                    </label>
                    <label>
                        <input type="radio" name="period_option" onclick="" value="custom" <c:if test="${period_option eq 'custom' || empty period_option}">checked</c:if>>
                        기간설정
                    </label>
                </div>
                <ul class="date_noti">
                    <li>* 최근 3개월까지의 이력만 조회 가능합니다.</li>
                </ul>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" type="button" data-popup="periodpop">취소</button>
                    <button type="submit">완료</button>
                </div>
                <input type="hidden" name="orderStatus" value="">
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>

<script>
	// 기간 선택시 input disabled 유무처리
	$("input[name='period_option']").change(function(){
		if($("input[name='period_option']:checked").val() != 'custom') {
			$(".period_date input[type='date']").prop("disabled", true);
		}else {
			$(".period_date input[type='date']").prop("disabled", false);
		}
	});
		
	function setSearchPeriod(){
		var orderStatus = document.querySelector('select[name="orderStatus"]').value;
        var startDate = document.querySelector('input[name="startDate"]').value;
        var endDate = document.querySelector('input[name="endDate"]').value;
        var period_option = document.querySelector('input[name="period_option"]:checked') ? document.querySelector('input[name="period_option"]:checked').value : '';
		console.log(period_option);
		document.querySelector('input[name="orderStatus"]').value = orderStatus;
        document.querySelector('input[name="startDate"]').value = startDate;
        document.querySelector('input[name="endDate"]').value = endDate;
        document.querySelector('input[name="period_option"]').value = period_option;
	}

	function setOrderStatus(){
		 var orderStatus = document.querySelector('select[name="orderStatus"]').value;
         var startDate = document.querySelector('input[name="startDate"]').value;
         var endDate = document.querySelector('input[name="endDate"]').value;
         var period_option = document.querySelector('input[name="period_option"]:checked') ? document.querySelector('input[name="period_option"]:checked').value : '';
         
         document.querySelector('input[name="orderStatus"]').value = orderStatus;
         document.querySelector('input[name="startDate"]').value = startDate;
         document.querySelector('input[name="endDate"]').value = endDate;
         document.querySelector('input[name="period_option"]').value = period_option;
	}
</script>