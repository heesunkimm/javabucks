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
<<<<<<< HEAD
            /* #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;} */
            #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241; margin-right:4px; margin-top: 2px; position:static; } /* 타이머에서 분과 초가 겹쳐지게 나와서 margin-right, margin-top, position을 추가하였습니다! */
            
=======
            
            /* #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;} */ 
            #user_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241; margin-right:4px; margin-top: 2px; position:static; } /* 타이머에서 분과 초가 겹쳐지게 나와서 margin-right, margin-top, position을 추가하였습니다! */
>>>>>>> dev-user-mihyun
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
            <form name="f" action="Logincheck" method="post">
                <div class="input_box">
                    <label>
                    	<c:if test="${empty cookie['saveId']}">
<<<<<<< HEAD
                        	<input type="text" id="userId" name="userId" value="" placeholder="아이디 입력" required>
=======
                        	<input type="text" name="userId" value="" placeholder="아이디 입력" required>
>>>>>>> dev-user-mihyun
                    	</c:if>
                    	<c:if test="${not empty cookie['saveId']}">
                        	<input type="text" name="userId" value="${cookie['saveId'].value}" placeholder="아이디 입력" required>
                    	</c:if>
                    </label>
                    <label>
                        <input type="password" id="userPasswd" name="userPasswd" value="" placeholder="비밀번호 입력" required>
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
            <form name="f" action="" method="POST">
                <div class="input_box">
                    <div class="email_box">
                        <label>
                            <input type="text" class="userEmail1" name="userEmail1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
<<<<<<< HEAD
                            <select class="userEmail2" name="userEmail2">
=======
                            <select class="userEmail2" name="userEmail2" >
>>>>>>> dev-user-mihyun
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                    </div>
                </div>
                <div class="confirm_box">
                    <label>
<<<<<<< HEAD
                        <input type="text" class="code1" name="code1" value="" placeholder="인증번호 입력" required>
                        <span id="timerMin">3</span>:<span id="timerSec">00</span>
                    </label>
                    <button class="confirm_btn1" type="button"  onclick="sendEmail_id()">인증번호 발송</button>
                    <button class="verify_btn1" type="button" onclick="verifyCode_id()">인증번호 확인</button>
=======
                        <input type="text" name="code" value="" placeholder="인증번호 입력" required>
                        <!-- <span>00:00</span> -->
                        <span id="timerMin">3</span>:
                        <span id="timerSec">00</span>
                    </label>
                    <button class="confirm_btn" type="button" onclick="sendEmail()">인증번호 발송</button>
>>>>>>> dev-user-mihyun
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit">확인</button>
                </div>
            </form>
        </div>
        <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="" method="POST">
                <div class="input_box">
                    <label>
                        <input type="text" class="pw_id" name="pw_id" value="" placeholder="아이디 입력" required>
                    </label>
                    <div class="email_box">
                        <label>
                            <input type="text" class="pw_email1" name="pw_email1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
<<<<<<< HEAD
                            <select class="pw_email2" name="pw_email2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gamil.com">gmail.com</option>
=======
                            <select name="">
                                <option value="">naver.com</option>
                                <option value="">nate.com</option>
                                <option value="">gmail.com</option>
>>>>>>> dev-user-mihyun
                            </select>
                        </label>
                    </div>
                </div>
                <div class="confirm_box">
                    <label>
<<<<<<< HEAD
                        <input type="text" class="code" name="code" value="" placeholder="인증번호 입력" required>
                        <span id="pwTimerMin">3</span> : <span id="pwTimerSec">00</span>
=======
                        <input type="text" name="" value="" placeholder="인증번호 입력" required>
                        <!-- <span>00:00</span> -->
                        <span id="timerMin">3</span>:
                        <span id="timerSec">00</span>
>>>>>>> dev-user-mihyun
                    </label>
                    <button class="confirm_btn" type="button" onclick="sendEmail()">인증번호 발송</button>
					<button class="verify_btn" type="button" onclick="verifyCode()">인증번호 확인</button>
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit" onclick="submitForm()">확인</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>  
    </section>
    <!-- e: content -->
</body>
<<<<<<< HEAD

<script type="text/javascript">

	// 타이머 객체
	let timers = {
		idTimer: null,
		pwTimer: null
	}; 
	
	let timersRemaining = {
		idTimeRemaining: 180, // 3분
		pwTimeRemaining: 180  // 3분
	}; 
	
	// 아이디 타이머 
	function startIdTimer() {
	    clearTimer(timers.idTimer); // 기존 타이머를 정리
	    
	    timers.idTimer = setInterval(() => {
	        if (timersRemaining.idTimeRemaining <= 0) {
	            clearTimer(timers.idTimer);
	            alert("인증 시간이 초과되었습니다.");
	            return;
	        }
	        timersRemaining.idTimeRemaining--;
	        
	        let minutes = Math.floor(timersRemaining.idTimeRemaining / 60);
	        let seconds = timersRemaining.idTimeRemaining % 60;
	        
	        document.getElementById('timerMin').textContent = minutes;
	        document.getElementById('timerSec').textContent = seconds < 10 ? '0' + seconds : seconds;
	    }, 1000);
	}

	// 비밀번호 타이머 
	function startPwTimer() {
	    clearTimer(timers.pwTimer); // 기존 타이머를 정리
	    
	    timers.pwTimer = setInterval(() => {
	        if (timersRemaining.pwTimeRemaining <= 0) {
	            clearTimer(timers.pwTimer);
	            alert("인증 시간이 초과되었습니다.");
	            return;
	        }
	        timersRemaining.pwTimeRemaining--;
	        
	        let minutes = Math.floor(timersRemaining.pwTimeRemaining / 60);
	        let seconds = timersRemaining.pwTimeRemaining % 60;
	        
	        document.getElementById('pwTimerMin').textContent = minutes;
	        document.getElementById('pwTimerSec').textContent = seconds < 10 ? '0' + seconds : seconds;
	    }, 1000);
	}

	// 타이머 초기화 
	function clearTimer(timer) {
	    if (timer) {
	        clearInterval(timer);
	    }
	}
 
	// 아이디 -----------------------------------------------------------------------------------
	
	// 아이디 찾기 - 이메일 발송 
	function sendEmail_id(){
		let email1 = $('input[name="userEmail1"]').val().trim();
		let email2 = $('select[name="userEmail2"]').val().trim();
		
		timersRemaining.idTimeRemaining = 180;
		// startIdTimer();
		
		if (email1 === '' || email2 === '') {
			alert("이메일 입력란을 모두 입력해주세요.");
			return; // 빈 필드가 있을 경우, AJAX 요청을 보내지 않음
		}
 
	    $.ajax({
	        url: 'findById',
	        type: 'POST',
	        data: {
	            "userEmail1": email1,
	            "userEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                startIdTimer();
	                console.log("인증메일 발송완료");
	            } else {
	                alert("이메일 전송에 실패하였습니다. 아이디를 다시 확인해주세요");
	                console.log("email1: " + email1 + ", email2: " + email2);
	            }
	        },
	        error: function(err) {
	            console.log(err);
	        }
	    })
	}
	
	function verifyCode_id(){
	    let codeInput = $('.code1').val();
	    let storedCode = getCookie('checkCode1'); // 쿠키에서 인증번호 가져오기
	    //alert('aaa')
		//alert(codeInput)
		//alert(storedCode)
	    if (codeInput === storedCode) {
	        // 인증번호가 일치하는 경우 비밀번호 이메일 전송 요청
	        // alert('bbb')
	        $.ajax({
	            url: 'verifyCode_id',
	            type: 'POST',
	            data: {
	                "userEmail1": $('.userEmail1').val(),
	                "userEmail2": $('.userEmail2').val()
	            },
	            success: function(res) {
	                if (res === 'OK') {
	                    alert("인증번호가 일치합니다. \n아이디를 메일로 발송하였습니다. 이메일을 통해 아이디를 확인해주세요. ");
	                    
	                } else {
	                    alert("아이디 전송에 실패하였습니다. 이메일을 다시 확인해주세요.");
	                }
	            },
	            error: function(err) {
	                console.log(err);
	            }
	        });
	    } else {
	        alert("email인증번호가 일치하지 않습니다.");
	    }
	}
	
	// 쿠키 값을 가져오는 함수
 	function getCookie(name) {
	    let cookieArr = document.cookie.split(";");
	    for (let i = 0; i < cookieArr.length; i++) {
	        let cookiePair = cookieArr[i].split("=");
	        if (name === cookiePair[0].trim()) {
	            return decodeURIComponent(cookiePair[1]);
	        }
	    }
	    return null;
	} 
	
	// 비밀번호 -----------------------------------------------------------------------------------
	
	// 비밀번호 찾기 - 이메일 발송 
	function sendEmail(){
		let id = $('.pw_id').val(); // 문자열 양 끝의 공백을 제거하면서 원본 문자열을 수정하지 않고 새로운 문자열을 반환
		let email1 = $('.pw_email1').val(); 
		let email2 = $('.pw_email2').val(); 
		
		timersRemaining.pwTimeRemaining = 180;
    	// startPwTimer();
 
	    $.ajax({
	        url: 'findByPw',
	        type: 'POST',
	        data: {
	        	"pw_id": id,
	            "pw_email1": email1,
	            "pw_email2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                startPwTimer();
	                console.log("인증메일 발송완료");
	            } else {
	                alert("이메일 전송에 실패하였습니다. 아이디를 다시 확인해주세요");
	                console.log("email1: " + email1 + ", email2: " + email2);
	            }
	        },
	        error: function(err) {
	            console.log(err);
	        }
	    })
	}
	
	function verifyCode(){
	    let codeInput = $('.code').val();
	    let storedCode = getCookie('checkCode1'); // 쿠키에서 인증번호 가져오기
	    console.log("pw1 "+codeInput);
	    console.log("pw2 "+storedCode); 

	    if (codeInput === storedCode) {
	        // 인증번호가 일치하는 경우 비밀번호 이메일 전송 요청
	        $.ajax({
	            url: 'verifyCode',
	            type: 'POST',
	            data: {
	                "pw_id": $('.pw_id').val(),
	                "pw_email1": $('.pw_email1').val(),
	                "pw_email2": $('.pw_email2').val()
	            },
	            success: function(res) {
	                if (res === 'OK') {
	                    alert("인증번호가 일치합니다. \n비밀번호를 메일로 발송하였습니다. 이메일을 통해 비밀번호 확인해주세요. ");
	                    
	                } else {
	                    alert("비밀번호 전송에 실패하였습니다. 아이디와 이메일을 다시 확인해주세요.");
	                }
	            },
	            error: function(err) {
	                console.log(err);
	            }
	        });
	    } else {
	        alert("pw인증번호가 일치하지 않습니다.");
	    }
	}
	
	// 쿠키 값을 가져오는 함수
 	function getCookie(name) {
	    let cookieArr = document.cookie.split(";");
	    for (let i = 0; i < cookieArr.length; i++) {
	        let cookiePair = cookieArr[i].split("=");
	        if (name === cookiePair[0].trim()) {
	            return decodeURIComponent(cookiePair[1]);
	        }
	    }
	    return null;
	} 
	
 	 // 이벤트 핸들러 등록
    $('.verify_btn').on('click', verifyCode);
 
</script>
</html>  
=======
<script type="text/javascript">
	let timer;
	let timeRemaining = 180;

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
	
	function sendEmail(){
		let email1 = $('.userEmail1').val().trim(); // 문자열 양 끝의 공백을 제거하면서 원본 문자열을 수정하지 않고 새로운 문자열을 반환
		let email2 = $('.userEmail2').val();
		
		// 이메일 입력이 안되어있으면 focus
		if(email1 ==""){
			alert("이메일 주소를 입력해주세요")
			return $('.userEmail1').focus();
			
		}else if(email2 == ""){
			// $('.confirm_box').show();
			// $('.confirm_box').style.display="block";
		}
		timeRemaining = 180;
		startTimer();
		
		$.ajax({
			url : 'findId',
			type : 'POST',
			data : { "userEmail1" : email1,
					"userEmail2" : email2
			},
			success : function(res){
				if(res == 'OK'){
					alert("인증메일을 발송하였습니다.");
				} 
			},
			error : function(err){
				console.log(err);
				alert("서버 요청 실패! 네트워크 상태를 확인해주세요.")
			}
		})
	}
</script>
</html>
>>>>>>> dev-user-mihyun
