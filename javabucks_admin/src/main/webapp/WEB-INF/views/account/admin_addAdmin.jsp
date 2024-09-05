<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Daum Postcode API 추가 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="../admin_top.jsp"/>
<section id="admin_addstore" class="content store_info">
	<div class="inner_wrap">
		<div class="tit_box">
		    <p>관리자 계정 등록</p>
		</div>
		<div class="insert_box bg_beige">
		    <form name="adminForm" action="/addAdmin.do" method="post" onsubmit="return validateForm()">
		    	<p>계정정보</p>
	            <div class="info_wrap">
		        	<div class="info_box">
		            	<label>
		            		<span>아이디</span>
		    				<input type="text" name="userId" class="userId" value="" >
						</label>
						<label>
							<span>패스워드</span>
						    <input type="password" name="adminPasswd" class="password" value="" >
						</label>
	                 </div>
	                 <button type="button" class ="create_btn" onclick="checkAdminId()">아이디 중복확인</button>
		        </div>
		        
		        <div class="info_box">
		        	<div class="email_box">
		                <label>
		                	<span>이메일</span>
		                    <input type="text" name="adminEmail1" value="" required>
		                </label>
	                 	<input type="text" name="adminEmail2" value="@javabucks.com" readonly>
		                <button type="button" style="margin-top: 0;" onclick="checkEmail()"> 이메일 중복확인</button>
		            </div>
		        </div>
		        <div class="btn_box">
		        	<button class="add_btn" type="submit" disabled id="registerBtn">등록</button>
		        </div>
		    </form>
		</div>
	</div>
</section>
<jsp:include page="../admin_bottom.jsp"/>
<script>
	let isIdChecked = false;
	let isEmailChecked = false;
	
	// 아이디 중복확인
	function checkAdminId() {
	    var adminId = document.querySelector('input[name="userId"]').value;
	
	    // AJAX 요청 생성
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/checkAdminId?adminId=" + encodeURIComponent(adminId), true);
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            // 서버로부터의 응답 처리
	            var response = xhr.responseText;
	            if (response === 'ok') {
	                alert("이미 사용 중인 아이디입니다.");
	                isIdChecked = false;
	            } else if (response === 'nok') {
	                alert("사용 가능한 아이디입니다.");
	                isIdChecked = true;
	                document.querySelector('input[name="userId"]').readOnly = true;
	                enableRegisterButton();
	            }
	        }
	    };
	    xhr.send();
	}
	
	// 이메일 중복 확인 
	function checkEmail() {
	    var email1 = document.querySelector('input[name="adminEmail1"]').value;
	    var email2 = document.querySelector('input[name="adminEmail2"]').value;
	    var email = email1 + email2;
	
	    // AJAX 요청 생성
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "/AdmincheckEmail?email=" + encodeURIComponent(email), true);
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            // 서버로부터의 응답 처리
	            var response = xhr.responseText;
	            if (response === 'ok') {
	                alert("이미 사용 중인 이메일입니다.");
	                isEmailChecked = false;
	            } else if (response === 'nok') {
	                alert("사용 가능한 이메일입니다.");
	                isEmailChecked = true;
	                document.querySelector('input[name="adminEmail1"]').readOnly = true;
	                document.querySelector('input[name="adminEmail2"]').readOnly = true; // disabled는 여기서 사용해도 괜찮음
	                enableRegisterButton();
	            }
	        }
	    };
	    xhr.send();
	}
	
	// 등록 버튼 활성화 여부 체크
	function enableRegisterButton() {
	    if (isIdChecked && isEmailChecked) {
	        document.getElementById('registerBtn').disabled = false;
	    }
	}
	
	// 폼 제출 전에 모든 체크가 완료되었는지 확인
	function validateForm() {
	    if (!isIdChecked) {
	        alert("아이디 중복 확인을 해주세요.");
	        return false;
	    }
	    if (!isEmailChecked) {
	        alert("이메일 중복 확인을 해주세요.");
	        return false;
	    }
	    return true;
	}
	
	window.onload = function() {
	    const urlParams = new URLSearchParams(window.location.search);
	    const registerSuccess = urlParams.get('registerSuccess');
	    if (registerSuccess === "true") {
	        alert("등록이 완료되었습니다!");
	    }
	};
</script>