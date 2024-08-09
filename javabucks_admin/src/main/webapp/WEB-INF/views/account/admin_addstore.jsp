<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- Daum Postcode API 추가 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <jsp:include page="../admin_top.jsp"/>
<body>    
<section id="admin_addstore" class="content store_info">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점등록</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="storeForm" action="/addStore.do" method="post">
                    <p>계정정보</p>
                    <div class="info_wrap">
                        <div class="info_box">
                            <label><span>아이디</span>
							    <input type="text" name="userId" class="userId" value="" readonly>
							</label>
							<label><span>패스워드</span>
							    <input type="password" name="password" class="password" value="" readonly>
							</label>
                            <p>* 초기 패스워드는 아이디와 동일</p>
                        </div>
                        <button type="button" class ="create_btn" onclick="generateAccount()">계정생성</button>
                    </div>

                    <p>지점정보</p>
                    <div class="info_box">
                        <label><span>지점명</span>
                            <input type="text" name="storeName" value="" required>
                        </label>
                        <label><span>점주명</span>
                            <input type="text" name="ownerName" value="" required>
                        </label>
                        <div class="loca_box">
                            <label><span>지점위치</span>
	                            	<!-- s: 우편번호 -->
		                            <input type="text" name="postcode" class="postcode" placeholder="우편번호" title="우편번호" >
		            				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" >
                               <input type="text" name="location" class="address" value="" required>
                               <input type="text" name="detailaddress" class="detailAddress" placeholder="상세주소" title="상세주소" >
                            </label>
                            
                            
                            
                        </div>
                        <div class="tel_box">
                            <label><span>지점번호</span>
                                <input type="text" name="storePhone1" size="3" maxlength="3" value="" required> 
                                -
                                <input type="text" name="storePhone2" size="4" maxlength="4" value="" required> 
                                -
                                <input type="text" name="storePhone3" size="4" maxlength="4" value="" required>
                            </label>
                            
                        </div>
                        <div class="email_box">
                            <label><span>지점이메일</span>
                                <input type="text" name="storeEmail" value="" required>
                            </label>
                            <select name="emailDomain">
                                <option value="naver.com">@naver.com</option>
                                <option value="nate.com">@nate.com</option>
                                <option value="gmail.com">@gmail.com</option>
                            </select>
                            <button type="button" style="margin-top: 0;" onclick="checkEmail()">중복확인</button>
                        </div>
                    </div>
                    <div class="btn_box">
                        <button class="add_btn" type="submit">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

<jsp:include page="../admin_bottom.jsp"/>

<script>
		//랜덤 id생성 
		function generateAccount() {
		    // XMLHttpRequest 객체 생성
		    var xhr = new XMLHttpRequest();
		    xhr.open("GET", "/generateUserId", true); 
		    
		    xhr.onreadystatechange = function () {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            // 서버에서 받은 랜덤 아이디를 입력 필드에 설정
		            var userId = xhr.responseText;
		            // class로 요소 선택
		            var userIdInput = document.querySelector('.userId');
	                var passwordInput = document.querySelector('.password');
	                var createButton = $(".create_btn");
	                if (userIdInput && passwordInput && createButton.length) {
	                    userIdInput.value = userId;
	                    passwordInput.value = userId; // 패스워드는 아이디와 동일
	                    createButton.prop("disabled", true);
	                    alert(userId + " 로 계정이 생성되었습니다. ");
	                } else {
	                    // 요소를 찾지 못했을 때의 디버깅 메시지
	                    alert("Error: Cannot find input fields or button.");
	                }
	            } else if (xhr.readyState === 4) {
	                // 서버 요청에 실패했을 때의 디버깅 메시지
	                alert("Error: Failed to generate ID. Status: " + xhr.status);
	            }
	        };
		
		    xhr.send();
		}
		
		//우편번호찾기
		function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // jQuery를 사용하여 클래스 요소의 값을 설정
	                $(".postcode").val(data.zonecode);
	                $(".address").val(addr);
	                $(".detailAddress").focus();
	            }
	        }).open();
	    }
		
		
					
</script>