<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="user_top.jsp"%>
	<style>
		#user_nav .nav_list li:nth-child(4) .nav_icon {filter: brightness(0) saturate(100%) invert(24%) sepia(60%) saturate(1080%) hue-rotate(122deg) brightness(98%) contrast(103%);}
	</style>
	<!-- s: content -->
	<section id="user_delivers" class="content">
		<div class="inner_wrap">
			<div class="top_box">
				<div class="tit_box">
					<p class="font_bold">Delivers</p>
				</div>

				<div class="search_box">
					<form name="" action="user_delivers?mode=store" method="post" onsubmit="return searchCheck()">
						<div class="loca_box my_location">
							<label>
								<input type="text" id="deliveryAddress" name="deliveryAddress" value="${param.deliveryAddress}" placeholder="배달주소지" readonly>
							</label>
							<button class="popup_btn" type="button" data-popup="insertAddress">주소검색</button>
						</div>
						<div class="loca_box store_location" style="display: none;">
							<c:if test="${not empty storeSearch}">
							<label>
								<input type="text" id ="storeSearch" name="storeSearch" value="${storeSearch}" placeholder="지점명 검색">
							</label>
							</c:if>
							<c:if test="${empty storeSearch}">
							<label>
								<input type="text" id ="storeSearch" name="storeSearch" value="" placeholder="지점명 검색">
							</label>
							</c:if>
							<button type="submit">검색</button>
						</div>
					</form>
					<!-- <a href="javascript:;">자주가는 매장</a> -->
				</div>
			</div>
			<ul class="store_list">
				<c:if test="${not empty notSearch}">
					<c:if test="${empty storeList}">
	        			검색된 결과가 없습니다.
	        		</c:if>
        		</c:if>
        		<c:if test="${not empty storeList}">
				<c:forEach var="dto" items="${storeList}">
					<c:choose>
						<c:when test="${dto.orderEnalbe eq 'Y'}">
							<li class="store_item">
								<a href="user_order?storeName=${dto.bucksName}&bucksId=${dto.bucksId}&pickup=Delivers&store=${bucksName}">
									<div class="img_box">
										<img src="../images/logo/starbucks_logo_black.png" alt="">
									</div>
									<div class="txt_box">
										<p class="txt_store">${dto.bucksName}</p>
										<p class="txt_location">${dto.bucksLocation}</p>
										<p class="txt_time">운영시간 ${dto.bucksStart} - ${dto.bucksEnd}</p>
									</div>
								</a>
							</li>
						</c:when>
					</c:choose>					
				</c:forEach>
				<!-- 주문 불가한 매장은 아래쪽으로 -->
				<c:forEach var="dto" items="${storeList}">
					<c:choose>
						<c:when test="${dto.orderEnalbe eq 'N'}">
							<li class="store_item pdt_dimm">
								<a href="javascript:;">
								<div class="img_box">
									<img src="../images/logo/starbucks_logo_black.png" alt="">
								</div>
								<div class="txt_box">
									<p class="txt_store">${dto.bucksName}</p>
									<p class="txt_location">${dto.bucksLocation}</p>
									<p class="txt_time">운영시간 ${dto.bucksStart} - ${dto.bucksEnd}</p>
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
		<div class="popup_box pickup_box" id="insertAddress" style="display: none;">
			<div class="tit_box">
				<p class="txt_tit">주소 설정</p>
			</div>
			<form name="f" action="" method="post">
				<!-- s: 내용 작성 -->
				<div class="select_box">
					<div class="location_box">
						<label>
							<input class="" type="text" id="address" name="addr1" size="50" placeholder="주소" readonly>
						</label>
						<label>
							<input class="" type="text" id="detailAddress" name="addr2" size="50" placeholder="상세주소">
						</label>
					</div>
					<input class="" type="button" value="주소 검색" onclick="checkPost()" style="cursor: pointer;">
					<input type="hidden" id="house_addr" name="house_addr">
				</div>
				<div class="btn_box">
					<button class="submit_btn" type="button">확인</button>
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
	/* window.onload = function() {
		// input 필드의 value 값을 가져옴
		var deliveryAddressValue = document
				.getElementById("deliveryAddress").value;

		// value 값이 비어 있으면 팝업을 띄움
		if (!deliveryAddressValue) {
			document.getElementById("insertAddress").style.display = "block";
		}
	}; */
	
	function searchCheck(){
		var searchInput = document.getElementById("deliveryAddress").value;
        if (searchInput.trim() === "") {
            alert("배달 받으실 주소지를 입력해주세요.");
            return false;  // 폼 제출을 막음
        }
        return true;  // 폼 제출을 허용
    }

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
	$(".btn_box .submit_btn").on('click', function() {
		let addr1 = $("#address").val();
		let addr2 = $("#detailAddress").val();
		
		if(addr1 === '') {
			alert("배달받을주소지를 입력해주세요.");
		}else {
			$("#deliveryAddress").val(addr1 + " " + addr2);
			$("#insertAddress").removeClass("s_active");
			$(".dimm").removeClass("s_active");
			$("input[name='addr1']").val("");
			$("input[name='addr2']").val("");
			$(".store_location").show();
		}
	})
	
	$(document).ready(function() {
        // storeSearch 입력 필드에 키 입력이 발생할 때마다 실행
        $('#storeSearch').on('focus', function() {
            var deliveryAddressValue = $('#deliveryAddress').val().trim();

            // 배달주소지 값이 비어있는 경우 경고창을 띄우고 입력을 막음
            if (deliveryAddressValue === '') {
                alert("배달 받으실 주소지를 입력해주세요.");
                $(this).blur(); // 포커스를 제거하여 입력을 방지
            }
        });
    });
	
</script>