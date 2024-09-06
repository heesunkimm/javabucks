<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_alarm" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">알림</p>
            </div>
            <div class="select_box">
            	<form method="post">
	                <label>
	                    <select id="cate" name="alarmCate" onchange="updateList()">
	                        <option value="all" ${alarmCate == 'all' ? 'selected' : ''}>전체</option>
	                        <option value="cpn" ${alarmCate == 'cpn' ? 'selected' : ''}>쿠폰/등급</option>
	                        <option value="order" ${alarmCate == 'order' ? 'selected' : ''}>주문 알림</option>
	                        <option value="charge" ${alarmCate == 'charge' ? 'selected' : ''}>카드 충전 알림</option>
	                    </select>
	                </label>
                </form>
            </div>

            <ul id="alarmList" class="history_list">
            <c:if test="${empty listAlarm}">
            	알람이 없습니다.
            </c:if>
            <c:if test="${not empty listAlarm}">
            	<c:forEach var="alarm" items="${listAlarm}">
                <li class="history_item">
                	<c:if test="${alarm.alarmCate =='cpn'}">
                    <div class="img_box">
                        <img src="../images/icons/javabucks_cupon.png" alt="">
                    </div>
                    </c:if>
                    <c:if test="${alarm.alarmCate =='order'}">
                    <div class="img_box">
                        <img src="../images/icons/receipt.png" alt="">
                    </div>
                    </c:if>
                    <c:if test="${alarm.alarmCate =='pickUp'}">
                    <div class="img_box">
                        <img src="../images/icons/order.png" alt="">
                    </div>
                    </c:if>
                    <c:if test="${alarm.alarmCate =='grade'}">
                    <div class="img_box">
                        <img src="../images/icons/gradeup.png" alt="">
                    </div>
                    </c:if>
                    <c:if test="${alarm.alarmCate =='charge'}">
                    <div class="img_box">
                        <img src="../images/icons/charge.png" alt="">
                    </div>
                    </c:if>
                    <div class="txt_box">
                        <p class="txt_tit">
                            ${alarm.alarmCont}
                        </p>
                        <p class="txt_date font_gray">${alarm.alarmRegDate}</p>
                    </div>
                </li>
                </c:forEach>
			</c:if>
            </ul>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script type="text/javascript">
	 function updateList() {
	        // 선택된 카테고리 값 가져오기
	        var selectedCate = $('#cate').val();
	        
	        // AJAX 요청 보내기
	        $.ajax({
	            url: 'getAlarmList.ajax', // 서버 요청 URL
	            type: 'POST',
	            data: { alarmCate: selectedCate },
	            dataType: 'json',
		            success: function(data) {
		            	 // 리스트 업데이트를 위한 대상 요소 선택
		                var alarmList = $('#alarmList');
		                alarmList.empty(); // 기존 리스트 제거

		                // 리턴된 데이터가 없을 경우 처리
		                if (data.length === 0) {
		                    alarmList.append('<li>알람이 없습니다.</li>');
		                } else {
		                    // 새로운 리스트 항목 추가
		                    $.each(data, function(index, alarm) {
		                    	 var imageUrl = '';
		                         switch (alarm.alarmCate) {
		                             case 'cpn':
		                                 imageUrl = '../images/icons/javabucks_cupon.png';
		                                 break;
		                             case 'order':
		                                 imageUrl = '../images/icons/receipt2.png';
		                                 break;
		                             case 'pickUp':
		                                 imageUrl = '../images/icons/order.png';
		                                 break;
		                             case 'grade':
		                                 imageUrl = '../images/logo/starbucks_logo.png';
		                                 break;
		                             case 'charge':
		                                 imageUrl = '../images/icons/charge.png';
		                                 break;
		                             default:
		                                 break;
		                         }
		                    	
		                        var listItem = '<li class="history_item">' +
		                                       '<div class="img_box">'+
		                                       '<img src="' + imageUrl + '" alt="">' +
		                                       '</div>' +
		                                       '<div class="txt_box">' +
		                                       '<p class="txt_tit">' + alarm.alarmCont + '</p>' +
		                                       '<p class="txt_date font_gray">' + alarm.alarmRegDate + '</p>' +
		                                       '</div></li>';
		                        alarmList.append(listItem);
		                    });
		                }
		            },
		            error: function(xhr, status, error) {
		                console.log('오류 발생:', error);
		            }
		        });
		    }
</script>