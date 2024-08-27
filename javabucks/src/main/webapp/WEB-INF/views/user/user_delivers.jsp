<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<section id="user_delivers" class="content">
		<div class="inner_wrap">
			<div class="top_box">
				<div class="tit_box">
					<p class="font_bold">Delivers</p>
				</div>

				<div class="search_box">
					<form name="" action="user_delivers?mode=store" method="post">
						<label> <input type="text" id="deliveryAddress"
							name="deliveryAddress" value="${param.deliveryAddress}" readonly>
						</label> <label> <input type="text" name="storeSearch" value=""
							placeholder="지점명 검색">
						</label>
						<button type="submit">검색</button>
					</form>
					<!-- <a href="javascript:;">자주가는 매장</a> -->
				</div>
			</div>
			<ul class="store_list">
				<c:if test="${empty storeList}">
        			검색된 결과가 없습니다.
        		</c:if>
				<c:forEach var="dto" items="${storeList}">				
					<li class="store_item">
						<c:choose>
							<c:when test="${dto.orderEnalbe eq 'Y'}">
								<div class="img_box">
									<!-- <img src="" alt=""> -->
								</div> 
									<a href="user_order?storeName=${dto.bucksName}">${dto.bucksName}</a>
									<a href="user_order?storeName=${dto.bucksName}">${dto.bucksLocation}</a>
								</c:when>				
						</c:choose>
						<div class="txt_box"></div>
					</li>
				</c:forEach>
				<c:forEach var="dto" items="${storeList}">				
					<li class="store_item">
						<c:choose>				
							<c:when test="${dto.orderEnalbe eq 'N'}">
								<c:set var="activeClass" value="pdt_dimm" />
								<div class="img_box">
									<!-- <img src="" alt=""> -->
								</div> 
									<a href="user_order?storeName=${dto.bucksName}">${dto.bucksName}</a>
									<a href="user_order?storeName=${dto.bucksName}">${dto.bucksLocation}</a>
								</c:when>
						</c:choose>
						<div class="txt_box"></div>
					</li>
				</c:forEach>

			</ul>
		</div>

		<!-- 픽업 선택 팝업 -->
		<div class="popup_box pickup_box" id="insertAddress"
			style="display: none;">
			<div class="tit_box">
				<p class="txt_tit">주소 설정</p>
			</div>
			<form name="f" action="" method="post">
				<!-- s: 내용 작성 -->
				<div class="select_box">
					<div class="location_box">
						<label> <input class="" type="text" id="address"
							name="addr1" size="50" placeholder="주소" readonly>
						</label> <label> <input class="" type="text" id="detailAddress"
							name="addr2" size="50" placeholder="상세주소">
						</label>
					</div>
					<input class="" type="button" value="주소 검색" onclick="checkPost()">
					<input type="hidden" id="house_addr" name="house_addr">
				</div>
				<div class="btn_box">
					<button class="" type="button">확인</button>
					<button class="close_btn" type="button" data-popup="insertAddress">취소</button>
				</div>
				<!-- e: 내용 작성 -->
			</form>
		</div>
		<div class="dimm"></div>
	</section>
	<!-- e: content -->

	<%@ include file="user_bottom.jsp"%>
	<!-- 주소 검색 API -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function() {
			// input 필드의 value 값을 가져옴
			var deliveryAddressValue = document
					.getElementById("deliveryAddress").value;

			// value 값이 비어 있으면 팝업을 띄움
			if (!deliveryAddressValue) {
				document.getElementById("insertAddress").style.display = "block";
			}
		};

		// 배달주소 검색
		function checkPost() {
			new daum.Postcode(
					{
						oncomplete : function(data) {

							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}

							}
							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById("address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress").focus();
						}
					}).open();
		}

		// 확인 버튼 클릭 시 팝업의 주소 데이터를 메인 화면으로 전달
		document
				.querySelector(".btn_box button[type='button']")
				.addEventListener(
						"click",
						function() {
							// 팝업의 주소와 상세주소 값을 가져옴
							var addr1 = document.getElementById("address").value;
							var addr2 = document
									.getElementById("detailAddress").value;

							// 메인 화면의 배달 주소지 필드에 값을 설정
							document.getElementById("deliveryAddress").value = addr1
									+ " " + addr2;

							// 팝업을 닫음
							document.getElementById("insertAddress").style.display = "none";
						});
	</script>