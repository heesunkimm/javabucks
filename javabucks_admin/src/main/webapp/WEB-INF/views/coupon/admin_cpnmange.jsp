	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<jsp:include page="../admin_top.jsp"/>
		<!-- s: content -->
	    <section id="admin_cpnmange" class="content accountmanage">
	        <div class="inner_wrap">
	            <div class="tit_box">
	                <p>쿠폰관리</p>
	            </div>
	
	            <div class="select_box">
	                <form name="f" action="/admin_cpnmange" method="post">
					    <div class="search_box">
					        <div style="width: 100%;">
					            <label>
					                <select name="searchDate">
					                    <option value="cpnListStartDate" ${searchParams.searchDate == 'cpnListStartDate' ? 'selected' : ''}>쿠폰발급일</option>
					                    <option value="cpnListEndDate" ${searchParams.searchDate == 'cpnListEndDate' ? 'selected' : ''}>쿠폰만료일</option>
					                    <option value="cpnListUseDate" ${searchParams.searchDate == 'cpnListUseDate' ? 'selected' : ''}>쿠폰사용일</option>
					                </select>
					            </label>
					            <label>
					                <input type="date" name="searchStartDate" value="${searchParams.searchStartDate}">
					            </label>
					            <label>~
					                <input type="date" name="searchEndDate" value="${searchParams.searchEndDate}">
					            </label>
					            <label>쿠폰상태
					                <select name="cpnListStatus">
					                    <option value="">전체</option>
					                    <option value="발급완료" ${searchParams.cpnListStatus == '발급완료' ? 'selected' : ''}>발급완료</option>
					                    <option value="사용완료" ${searchParams.cpnListStatus == '사용완료' ? 'selected' : ''}>사용완료</option>
					                    <option value="기한만료" ${searchParams.cpnListStatus == '기한만료' ? 'selected' : ''}>기한만료</option>
					                </select>
					            </label>
					        </div>
					        <label>유저아이디
					            <input type="text" name="userId" value="${searchParams.userId}">
					        </label>
					        <label>쿠폰명
					            <select name="cpnName">
					                <option value="">-</option>
					                <c:forEach var="name" items="${cpnInfo}">
					                    <option value="${name.cpnName}" ${searchParams.cpnName == name.cpnName ? 'selected' : ''}>[${name.cpnCode}] ${name.cpnName}</option>
					                </c:forEach>
					            </select>
					        </label>
					        <button class="search_btn" type="submit">검색</button>
					    </div>
					</form>
	
	                <div class="list_box">
	                    <div class="btn_box">
	                        <button class="popup_btn" type="button" data-popup="listcpn">쿠폰현황</button>
	                        <button class="popup_btn" type="button" data-popup="addcpn">쿠폰등록</button>
	                    </div>
	                    <table class="search_list s_table">
	                        <thead>
	                            <tr>
	                                <th>쿠폰명</th>
	                                <th>유저아이디</th>
	                                <th>쿠폰발급일</th>
	                                <th>쿠폰만료일</th>
	                                <th>쿠폰사용일</th>
	                                <th>쿠폰상태</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<c:forEach var="list" items="${searchList}">
	                            <tr>
	                                <td>[${list.cpnCode}] ${list.cpnName}</td>
	                                <td>${list.userId}</td>
	                                <td><c:out value="${fn:substring(list.cpnListStartDate, 0, 10)}"/></td>
	                                <td><c:out value="${fn:substring(list.cpnListEndDate, 0, 10)}"/></td>
                                	<td>
                                	<c:choose>
								        <c:when test="${not empty list.cpnListUseDate}">
								        	<c:out value="${fn:substring(list.cpnListUseDate, 0, 10)}"/>
								        </c:when>
								        <c:otherwise>
								            미사용
								        </c:otherwise>
								    </c:choose>
                                	</td>
	                                <td>${list.cpnListStatus}</td>
	                            </tr>
	                        	</c:forEach>
	                        	<c:if test="${nolist}">
	                        	<tr>
	                        		<td colspan="6">해당 조건의 검색결과가 없습니다.</td>
	                        	</tr>
	                        	</c:if>
	                        </tbody>
	                    </table>
	                    <!-- 페이징 -->
	                    <c:if test="${not empty searchList}">
						<div class="pagination">
						    <c:if test="${startPage > 1}">
						        <a class="page_btn prev_btn" href="admin_cpnmange?pageNum=${startPage - pageBlock}&searchDate=${searchParams.searchDate}&searchStartDate=${searchParams.searchStartDate}&searchEndDate=${searchParams.searchEndDate}&cpnListStatus=${searchParams.cpnListStatus}&userId=${searchParams.userId}&cpnName=${searchParams.cpnName}">
						            <img src="../../images/icons/arrow.png">
						        </a>
						    </c:if>
						    <c:forEach var="i" begin="${startPage}" end="${endPage}">
						        <c:set var="activeClass" value=""/>
						        <c:choose>
						            <c:when test="${param.pageNum == i || (param.pageNum eq '' && i == 1)}">
						                <c:set var="activeClass" value="page_active"/>
						            </c:when>
						        </c:choose>
						        <a href="admin_cpnmange?pageNum=${i}&searchDate=${searchParams.searchDate}&searchStartDate=${searchParams.searchStartDate}&searchEndDate=${searchParams.searchEndDate}&cpnListStatus=${searchParams.cpnListStatus}&userId=${searchParams.userId}&cpnName=${searchParams.cpnName}" class="${activeClass} page_num">${i}</a>
						    </c:forEach>
						    <c:if test="${pageCount > endPage}">
						        <a class="page_btn next_btn" href="admin_cpnmange?pageNum=${endPage + 1}&searchDate=${searchParams.searchDate}&searchStartDate=${searchParams.searchStartDate}&searchEndDate=${searchParams.searchEndDate}&cpnListStatus=${searchParams.cpnListStatus}&userId=${searchParams.userId}&cpnName=${searchParams.cpnName}">
						            <img src="../../images/icons/arrow.png">
						        </a>
						    </c:if>
						</div>
	                    </c:if>
	                </div>
	            </div>
	            <!-- 쿠폰등록 팝업 -->
	            <div id="addcpn" class="cpn_popup popup_box" style="display: none;">
	                <p class="popup_title">쿠폰등록</p>
	                <a class="close_btn" href="javascript:;" data-popup="addcpn"><img src="../images/icons/close.png" alt=""></a>
	                <form name="f" method="post">
	                    <div class="input_box">
	                        <label>쿠폰코드
	                            <input type="text" name="cpnCode" value="" required style="text-transform: uppercase;">
	                        </label>
	                        <label>쿠폰명
	                            <input type="text" name="cpnName" value="" required>
	                        </label>
	                        <label>쿠폰설명
	                            <textarea name="cpnDesc" cols="50" rows="10" value="" maxlength="100" required></textarea>
	                        </label>
	                        <label>쿠폰금액
	                            <input type="text" name="cpnPrice" value="" required>
	                        </label>
	                    </div>
	                    <div class="pbtn_box">
	                        <button class="createBtn" type="button">쿠폰생성</button>
	                    </div>
	                </form>
	            </div>
	            <!-- 쿠폰현황 팝업 -->
	            <div id="listcpn" class="cpn_popup popup_box" style="display: none;">
	                <p class="popup_title">쿠폰현황</p>
	                <a class="close_btn" href="javascript:;" data-popup="listcpn"><img src="../images/icons/close.png" alt=""></a>
	                <form name="f" action="admin_delCpn" method="post">
	                    <div class="input_box">
	                    	<label>쿠폰코드
	                            <select id="cpnList" name="cpnCode">
		                        <c:forEach var="cpn" items="${cpnList}">
	                           	<option value="${cpn.cpnCode}">[${cpn.cpnCode}] ${cpn.cpnName}</option>
		                        </c:forEach>
	                            </select>
	                        </label>
	                        <label>유저ID
	                            <input type="text" name="userId" value="">
	                        </label>
	                    </div>
	                    <div class="pbtn_box">
	                        <button class="delBtn" type="button" onclick="delCpn()">쿠폰삭제</button>
	                        <button class="sendBtn" type="button" onclick="sendCpn()">쿠폰전송</button>
	                    </div>
	                </form>
	            </div>
	            <div class="dimm"></div>
	        </div>
	    </section>
	    <!-- e: content -->
	<jsp:include page="../admin_bottom.jsp"/>
	<script type="text/javascript">
		$('input[name="cpnCode"]').on('input', function() {
	        // 입력값에서 영어, 숫자, -만 남기고 제거
	        let value = $(this).val().replace(/[^A-Za-z0-9-]/g, '');
	        $(this).val(value);
	        $(this).val().toUpperCase();
	    });
		
		$('input[name="cpnPrice"]').on('input', function() {
		    // 입력값에서 숫자만 남기고 제거
		    let value = $(this).val().replace(/[^\d]/g, '');
		    $(this).val(value);
	    });
		
		// 어드민 쿠폰 생성/삭제 후 새로고침없이 리스트 다시 가져오기
		function loadCpnList() {
			$.ajax({
		        url: '${pageContext.request.contextPath}/getCouponList.ajax',
		        type: "GET",
		        dataType: "json",
		        success: function (response) {
		            // 기존 옵션 제거
		            $("#cpnList").empty();
	
		            // 새로운 옵션 추가
		            $.each(response, function (index, coupon) {
		                $("#cpnList").append(
		                    $("<option>", {
		                        value: coupon.cpnCode,
		                        text: coupon.cpnName
		                    })
		                );
		            });
		        },
		        error: function (xhr, status, err) {
		            console.error('AJAX 요청 실패:', status, err);
		        }
		    });
		}
		
		// 쿠폰생성
		function insertCpn() {
			let couponCode = $("input[name='cpnCode']").val().trim();
			let couponName = $("input[name='cpnName']").val().trim();
			let couponDesc = $("textarea[name='cpnDesc']").val().trim();
			let couponPrice = $("input[name='cpnPrice']").val().trim();
			
			let data = {
				cpnCode: couponCode,
				cpnName: couponName,
				cpnDesc: couponDesc,
				cpnPrice: couponPrice
		    };
			
			if(couponCode === '') {
				alert("쿠폰코드를 입력해주세요");
				return false;
			}else if(couponName === '') {
				alert("쿠폰이름을 입력해주세요");
				return false;
			}else if(couponDesc === '') {
				alert("쿠폰설명을 입력해주세요");
				return false;
			}else if(couponPrice === '') {
				alert("쿠폰가격을 입력해주세요");
				return false;
			}
			
			$.ajax({
		        url: '${pageContext.request.contextPath}/insertCoupon.ajax',
		        type: "POST",
		        data: JSON.stringify(data),
		        contentType: "application/json",
		        dataType: "text",
		        success: function (res) {
		        	// 쿠폰명, 쿠폰코드 중복체크
	                alert(res);
	                $(".cpn_popup").removeClass("s_active");
	                $(".dimm").removeClass("s_active");
	                $("input[type='text']").val("");
	                $("textarea").val("");
		        	
		        	// 쿠폰 등록후 리스트 다시 가져오기
		        	loadCpnList();
		        },
		        error: function (xhr, status, err) {
		            console.error('AJAX 요청 실패:', status, err);
		        }
		    });
		}
		// 쿠폰생성 버튼 클릭시 쿠폰 생성 함수 작동
		$(".createBtn").on('click', function(){
			insertCpn();
		})
		
		// 쿠폰삭제
		function delCpn() {
			let cpnName = $("#cpnList option:selected").text();
			let data = {
				cpnCode: $("#cpnList").val()
		    };
	
			if (confirm(cpnName + '명의 쿠폰을 삭제하시겠습니까?')) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/deleteCoupon.ajax',
			        type: "POST",
			        data: JSON.stringify(data),
			        contentType: "application/json",
			        dataType: "text",
			        success: function (res) {
			        	alert(res);
			        	$(".cpn_popup").removeClass("s_active");
			        	$(".dimm").removeClass("s_active");
			        	$("input[type='text']").val("");
			        	
			        	// 쿠폰 삭제 후 리스트 다시 가져오기
			        	loadCpnList();
			        	
			        },
			        error: function (xhr, status, err) {
			            console.error('AJAX 요청 실패:', status, err);
			        }
				});
	        }
		}
		
		// 특정 유저에게 쿠폰 전송
		function sendCpn() {
			let userId = $("#listcpn input[name='userId']").val().trim();
			let cpnCode = $("#cpnList option:selected").val();
			
			let data = {
				userId: userId,
				cpnCode: cpnCode,
		    };
			
			if(userId == "" || userId == null) {
				alert("쿠폰을 발급받을 유저ID를 입력해주세요.");
				$('input[type="userId"]').focus();
				return;
			}
			
			if (confirm(userId + '에게 쿠폰을 발급하시겠습니까?')) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/sendUserCoupon.ajax',
			        type: "POST",
			        data: JSON.stringify(data),
			        contentType: "application/json",
			        dataType: "text",
			        success: function (res) {
			        	alert(res);
			        	$(".cpn_popup").removeClass("s_active");
			        	$(".dimm").removeClass("s_active");
			        	$("input[type='text']").val("");
			        	
			        	window.location.reload();
			        },
			        error: function (xhr, status, err) {
			            console.error('AJAX 요청 실패:', status, err);
			        }
			    });
	        }
		}
	</script>