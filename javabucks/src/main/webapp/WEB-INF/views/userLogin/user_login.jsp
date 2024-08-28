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
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/user.js"></script>
        <style>
            #user_login {display: grid; place-items: center; min-height: 100dvh;}
            #user_login input {border: 1px solid #ccc; border-radius: 2px;}
            #user_login input[type="text"]:focus {border-color: #006241;}
            #user_login .login_box .input_box label + label, 
            #user_login .popup_box .input_box > label + label {margin-top: 6px;}
            #user_login .login_box .input_box input {width: 312px; height: 36px; padding: 0 6px; font-size: 18px;}

            #user_login .login_box {padding: 30px 20px; border: 1px solid #eee; border-radius: 4px; box-shadow: 0 3px 7px #ccc;}
            #user_login .login_box .top_box {display: flex; align-items: center; justify-content: center; gap: 20px;}
            #user_login .login_box .top_box .img_box {width: 50px; height: 50px;}
            #user_login .login_box .top_box p {font-size: 24px; font-family: 'Santana_bold'; text-align: center;}
            #user_login .login_box form {margin-top: 10px;}
            #user_login .login_box .input_box, #user_login .login_box .input_box label {width: 326px;}

            #user_login .login_box .login_btn {margin-top: 10px; width: 100%; height: 36px; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fefefe;}

            #user_login .login_box .find_box {margin-top: 14px; text-align: center;}
            #user_login .login_box .find_box label {margin-right: 16px; font-size: 14px;}
            #user_login .login_box .find_box a {font-size: 14px; line-height: 18px; color: #555; border-bottom: 1px solid #555;}

            #user_login .popup_box > p {font-size: 20px; font-weight: 700; color: #006241; text-align: left;}
            #user_login .popup_box .close_btn {position: absolute; top: 6px; right: 6px; display: inline-block; width: 30px; height: 30px;}
            #user_login .popup_box .input_box {width: 326px;}

            #user_login .popup_box .input_box > label {margin-bottom: 10px; width: 312px; height: 38px;}
            #user_login .popup_box .input_box > label input {width: 100%; height: 100%; padding: 0 6px; font-size: 16px;}
            #user_login .popup_box .email_box {width: 326px; display: flex; align-items: center; justify-content: space-between;}
            #user_login .popup_box .email_box label {width: 160px; display: flex; align-items: center;}
            #user_login .popup_box .email_box input {width: 100%; height: 36px; padding: 0 6px; font-size: 16px;}
            #user_login .popup_box .email_box select {width: 100%; height: 38px; font-size: 16px;}
            #user_login .popup_box .submit_btn {width: 80px; height: 32px; border-radius: 2px; background-color: #006241; font-size: 18px; color: #fff;}

            #user_login .popup_box .confirm_box {margin-top: 10px;}
            #user_login .popup_box .confirm_box label {position: relative;}
            #user_login .popup_box .confirm_box input { width: 200px; height: 36px; padding: 0 6px; font-size: 14px;}
            /* #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;} */
            #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241; margin-right:4px; margin-top: 2px; position:static; } /* 타이머에서 분과 초가 겹쳐지게 나와서 margin-right, margin-top, position을 추가하였습니다! */
            
            #user_login .popup_box .confirm_box button {padding: 0 10px; height: 36px; background: #006241; border-radius: 2px; font-size: 14px; color: #fefefe;}
            #user_login .popup_box .btn_box {text-align: center;}
            #user_login .popup_box .btn_box .setting_btn {position: relative; font-size: 14px; line-height: 18px; color: #555;}
            #user_login .popup_box .btn_box .setting_btn::after {content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 1px; background-color: #555;}
        </style>
    </head>
<body>
    <!-- s: content -->
    <section id="user_login" class="content">
        <div class="login_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/logo/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS</p>
            </div>
            <form name="f" action="logincheck" method="post">
                <div class="input_box">
                    <label>
                    	<c:if test="${empty cookie['saveId']}">
                        	<input type="text" name="userId" value="" placeholder="아이디 입력" required>
                    	</c:if>
                    	<c:if test="${not empty cookie['saveId']}">
                        	<input type="text" name="userId" value="${cookie['saveId'].value}" placeholder="아이디 입력" required>
                    	</c:if>
                    </label>
                    <label>
                        <input type="password" name="userPasswd" value="" placeholder="비밀번호 입력" required>
                    </label>
                </div>
                <button class="login_btn" type="submit">로그인</button>
            <div class="find_box">
                <label>
                	<c:if test="${empty cookie['saveId']}">
                		<input type="checkbox" name="saveId"> 아이디 저장 
                	</c:if>
                	
                	<c:if test="${not empty cookie['saveId']}">
                		<input type="checkbox" name="saveId" value="on" checked> 아이디 저장 
                    </c:if>
                </label>
                <a class="popup_btn" href="find_id" data-popup="findbyid">아이디 찾기</a>
                <a class="popup_btn" href="find_password" data-popup="findbypw">비밀번호 찾기</a>
                <a href="user_join">회원가입</a>
            </div>
            </form>
        </div>
        <div id="findbyid" class="popup_box" style="display: none;">
            <p class="popup_title">아이디 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbyid"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="emailForId" method="POST">
                <div class="input_box">
                    <div class="email_box">
                        <label>
                            <input type="text" name="userEmail1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
                            <select name="userEmail2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                    </div>
                </div>
                <div class="confirm_box">
                    <label>
                        <input type="text" name="" value="" placeholder="인증번호 입력" required>
                        <span id="timerMin">3</span>:<span id="timerSec">00</span>
                    </label>
                    <button class="confirm_btn" type="button" onclick="emailForId()">인증번호 발송</button>
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit" onclick="LoginPage(event)">확인</button>
                </div>
            </form>
        </div>
        <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="emailForPw" method="POST">
                <div class="input_box">
                    <label>
                        <input type="text" name="findbypw_id" value="" placeholder="아이디 입력" required>
                    </label>
                    <div class="email_box">
                        <label>
                            <input type="text" name="findbypw_email1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
                            <select name="findbypw_email2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gamil.com">gmail.com</option>
                            </select>
                        </label>
                    </div>
                </div>
                <div class="confirm_box">
                    <label>
                        <input type="text" name="" value="" placeholder="인증번호 입력" required>
                        <span id="timerMin">3</span>:<span id="timerSec">00</span>
                    </label>
                    <button class="confirm_btn" type="button" onclick="emailForPw()">인증번호 발송</button>
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit">확인</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>  
    </section>
    <!-- e: content -->
</body>

<script type="text/javascript">
	
	// 3분 타이머 
	function startTimer(){
	let timerMinId = document.getElementById('timerMin');
	let timerSecId = document.getElementById('timerSec');
	
	timer = setInterval(()=>{
		if(timeRemaining<=0){
			clearInterval(timer);
			alert("인증 시간이 초과되었습니다.");
			return;
		}
		timeRemaining--;
		
		let minutes = Math.floor(timeRemaining / 60);
		let seconds = timeRemaining % 60;
		
		timerMinId.textContent = minutes;
		timerSecId.textContent = seconds < 10 ? '0' + seconds : seconds;
	},1000);
}
	// 아이디 찾기 
	function emailForId() {
	    let email1 = $('input[name="userEmail1"]').val();
	    let email2 = $('select[name="userEmail2"]').val();
 
	    timeRemaining = 180;
	    startTimer();

	    // 이메일 입력이 안 되어 있으면 focus
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('input[name="userEmail1"]').focus();
	    }
	    if (email2 === "") {
	        
	    }

	    $.ajax({
	        url: 'emailForId',
	        type: 'POST',
	        data: {
	            "userEmail1": email1,
	            "userEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                console.log("인증메일 발송완료");
	            } else {
	                alert("이메일 전송에 실패하였습니다.");
	                console.log("email1: " + email1 + ", email2: " + email2);
	            }
	        },
	        error: function(err) {
	            console.log(err);
	            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
	        }
	    });
	}
	
	// 비밀번호 찾기
	function emailForPw(){
		 
		let id = $('input[name="findbypw_id"]').val().trim();
		let email1 = $('input[name="findbypw_email1"]').val().trim();
	    let email2 = $('select[name="findbypw_email2"]').val().trim();
	    
	    alert(id)
	    alert(email1)
	    alert(email2)
	    
	    timeRemaining = 180;
	    startTimer();
	    
	 // 이메일 입력이 안 되어 있으면 focus
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('input[name="findbypw_email1"]').focus();
	    }
	    if (email2 === "") {
	        
	    }
	    console.log("아이디:"+id);
	    
	    $.ajax({
	        url: 'emailForPw',
	        type: 'POST',
	        data: {
	        	"findbypw_id" : id,
	            "findbypw_email1": email1,
	            "findbypw_email2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                console.log("인증메일 발송완료");
	            } else {
	                alert("이메일 전송에 실패하였습니다.");
	                 
	            }
	        },
	        error: function(err) {
	            console.log(err);
	            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
	        }
	    });
	     
	}
	
	
	
	// 확인 버튼을 누를때 발생하는 이벤트 처리 
	function LoginPage(event){
		
		// 기본 폼 제출 동작을 막음
		if(event){
			event.preventDefault(); // 기본동작취소 // preventDefault : 주로 이벤트 핸들러 내에서 사용되어 특정 이벤트가 발생할 때 브라우저의 기본 동작을 막고, 개발자가 원하는 커스텀 동작을 수행
		}
		
		let email1 = $('input[name="userEmail1"]').val();
		
	    // 입력 필드 검증
	    if (email1.trim() === "") {
	        alert("아이디를 입력해 주세요.");
	        $('input[name="userEmail1"]').focus(); // 입력 필드에 포커스 이동
	        return; // 함수 종료
	    }
	    
	    // 유효성 검사 완료되면 login 페이지로 이동
		window.location.href = 'user_login';
	    
	    // 인증번호 일치해야 아이디 알려주기 
		alert("찾으시는 아이디는 "+ email1 + "입니다.");
	}
 
</script>
</html>  