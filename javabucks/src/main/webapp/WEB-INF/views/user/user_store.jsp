<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/user.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../js/user.js"></script>
</head>
<body>
    <!-- s: content -->
    <section id="user_store" class="content">
        <div class="inner_wrap">
            <div class="top_box">
                <div class="tit_box">
                    <p class="font_bold">Order</p>
                </div>
    
                <div class="search_box">
                    <form name="" action="user_store?mode=store" method="post">
                        <label>
                            <input type="text" name="storeSearch" value="${storeSearch}" placeholder="검색">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                    <!-- <a href="javascript:;">자주가는 매장</a> -->
                </div>
            </div>
            <ul class="store_list">
        	    <c:if test= "${empty storeList}">
       	    	<li class="nostore">이용하실 매장명 또는 지역을 검색해주세요.</li>
        		</c:if>
        		<c:if test= "${not empty storeList}">        		
	        		<c:forEach var ="dto" items="${storeList}">
	                	<c:choose>
							<c:when test="${dto.orderEnalbe eq 'Y'}">
	                			<li class="store_item">
				                    <a class="popup_btn" href="javascript:;" data-popup="pickupselect" data-bucksId="${dto.bucksId}" data-bucksName="${dto.bucksName}" data-bucksLocation="${dto.bucksLocation}">
				                        <div class="img_box">
				                           <img src="../images/logo/starbucks_logo_black.png" alt="">
				                        </div>                                              
				                        <div class="txt_box">
			                         	  <p class="txt_store">${dto.bucksName}</p>
			             				  <p class="txt_location">${dto.bucksLocation}</p>
				                        </div>
				                    </a>
	               		 		</li>
		                   	</c:when>
		                 </c:choose>
	                </c:forEach>
	                <!-- 주문 불가한 매장은 아래쪽으로 -->
	                <c:forEach var ="dto" items="${storeList}">
	                	<c:choose>
							<c:when test="${dto.orderEnalbe eq 'N'}">
								<c:set var="activeClass" value="pdt_dimm" />
	                			<li class="store_item">
				                    <a class="popup_btn" href="javascript:;" data-popup="pickupselect" data-bucksId="${dto.bucksId}" data-bucksName="${dto.bucksName}" data-bucksLocation="${dto.bucksLocation}">
				                        <div class="img_box">
				                           <img src="../images/logo/starbucks_logo_black.png" alt="">
				                        </div>                                              
				                        <div class="txt_box">
			                         	  <p class="txt_store">${dto.bucksName}</p>
			             				  <p class="txt_location">${dto.bucksLocation}</p>
				                        </div>
			                    	</a>
                				</li>
	                   		</c:when>
	                   	</c:choose>
	               	</c:forEach>
                </c:if>
            </ul>
        </div>
        
        <!-- 픽업 선택 팝업 -->
        <div class="popup_box pickup_box" id="pickupselect" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">픽업은 어떻게 하시겠어요?</p>
            </div>
            <form name="f" action="user_order" method="post">
                <!-- s: 내용 작성 -->
                 <input type="hidden" name="store" value="">
                 <input type="hidden" name="pickup" value="">
                 <input type="hidden" name="storeName" value="">
                 <input type="hidden" name="bucksId" value="">
                <div class="select_box">
                    <a class="select_btn" href="javascript:;" onclick="submitForm('매장이용')">
                        <div class="img_box">
                            <img src="../images/icons/eat.png" alt="">
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">매장 이용</p>
                            <p class="txt_desc">매장에서 먹을게요</p>
                        </div>
                    </a>
                    <a class="select_btn" href="javascript:;" onclick="submitForm('To-go')">
                        <div class="img_box">
                            <img src="../images/icons/to_go.png" alt="">
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">To-go</p>
                            <p class="txt_desc">밖으로 가져갈게요</p>
                        </div>
                    </a>
                </div>
                <div class="btn_box">
                    <button class="close_btn" type="button" data-popup="pickupselect">닫기</button>
                </div>
                <!-- e: 내용 작성 -->
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>
<script type="text/javascript">
		$(function() {
		    // 매장 정보를 클릭했을 때 팝업 표시
		    $(".popup_btn").on('click', function(e) {
		        e.preventDefault();
		
		        // 선택한 매장 정보 가져오기
		        let bucksName = $(this).data('bucksname');
		        let bucksId = $(this).data('bucksid');
		        let popupId = $(this).data('popup');
		
		        // 팝업 내의 요소들에 매장 정보 삽입
		        $("#pickupselect input[name='storeName']").val(bucksName);
		        $("#pickupselect input[name='bucksId']").val(bucksId);
		        
		        // 팝업 열기
		        $('#' + popupId).show();
		        $('.dimm').show();
		    });
		    
		    // 팝업 닫기
		    $(".close_btn").on('click', function() {
		        let popupId = $(this).data('popup');
		        $('#' + popupId).hide();
		        $('.dimm').hide();
		    });
		    
		});
			
		function submitForm(pickupType) {
		    // 선택한 pickupType (매장이용 또는 To-go)을 input에 설정
		    $("input[name='pickup']").val(pickupType);

		    // form 제출
		    $("form[name='f']").submit();
		}
</script>