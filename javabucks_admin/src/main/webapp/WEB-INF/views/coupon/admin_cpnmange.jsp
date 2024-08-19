<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_cpnmange" class="content accountmanage">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>쿠폰관리</p>
            </div>

            <div class="select_box">
                <form name="" action="" method="post">
                    <div class="search_box">
                        <div style="width: 100%;">
                            <label>
                                <select name="">
                                    <option value="">쿠폰발급일</option>
                                    <option value="">쿠폰만료일</option>
                                    <option value="">쿠폰사용일</option>
                                </select>
                            </label>
                            <label>
                                <input type="date" name="" value="">
                            </label>
                            <label>~
                                <input type="date" name="" value="">
                            </label>
                            <label>쿠폰상태
                                <select name="">
                                    <option value="">전체</option>
                                    <option value="">사용완료</option>
                                    <option value="">기한만료</option>
                                </select>
                            </label>
                        </div>
                        <label>유저아이디
                            <input type="text" name="" value="">
                        </label>
                        <label>쿠폰번호
                            <input type="text" name="" value="">
                        </label>
                        <label>쿠폰명
                            <input type="text" name="" value="">
                        </label>
                        <button type="button">검색</button>
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
                                <th>쿠폰발급일</th>
                                <th>쿠폰번호</th>
                                <th>유저아이디</th>
                                <th>쿠폰명</th>
                                <th>쿠폰만료일</th>
                                <th>쿠폰사용일</th>
                                <th>쿠폰상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>쿠폰발급일</td>
                                <td>쿠폰번호</td>
                                <td>유저아이디</td>
                                <td>쿠폰명</td>
                                <td>쿠폰만료일</td>
                                <td>쿠폰사용일</td>
                                <td>쿠폰상태</td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
                    </div>    
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
                           	<option value="${cpn.cpnCode}">${cpn.cpnName}</option>
	                        </c:forEach>
                            </select>
                        </label>
                        <label>유저ID
                            <input type="text" name="userId" value="">
                        </label>
                    </div>
                    <div class="pbtn_box">
                        <button class="delBtn" type="button" onclick="delCpn()">쿠폰삭제</button>
                        <button type="submit">쿠폰전송</button>
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
        // 입력값에서 영어, 숫자, _만 남기고 제거
        let value = $(this).val().replace(/[^A-Za-z0-9_]/g, '');
        $(this).val(value);
        $(this).val().toUpperCase();
    });
	
	$('input[name="cpnPrice"]').on('input', function() {
	    // 입력값에서 숫자만 남기고 제거
	    let value = $(this).val().replace(/[^\d]/g, '');
	    $(this).val(value);
    });
	
	// 쿠폰 등록/삭제 후 새로고침없이 리스트 다시 가져오기
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
	        	if (res === "중복 쿠폰 확인") {
	                alert("해당하는 쿠폰명 또는 쿠폰코드로 등록된 쿠폰이 존재합니다.");
	            } else {
	                alert(couponName + " 쿠폰이 등록되었습니다.");
	                $(".cpn_popup").removeClass("s_active");
	                $(".dimm").removeClass("s_active");
	                $("input[type='text']").val("");
	                $("textarea").val("");
		        	
		        	// 쿠폰 등록후 리스트 다시 가져오기
		        	loadCpnList();
	        	}
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

		if (confirm('쿠폰을 삭제하시겠습니까?')) {
			$.ajax({
		        url: '${pageContext.request.contextPath}/deleteCoupon.ajax',
		        type: "POST",
		        data: JSON.stringify(data),
		        contentType: "application/json",
		        dataType: "text",
		        success: function (res) {
		        	alert(cpnName +" 쿠폰이 삭제되었습니다.");
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
</script>