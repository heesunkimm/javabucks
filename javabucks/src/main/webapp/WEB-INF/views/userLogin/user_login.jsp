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
            <form name="f" action="logincheck.do" method="post">
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
            <form name="f" action="findIdbyEmail.do" method="POST" onsubmit="return check()">
                <div class="input_box">
                    <div class="email_box">
                        <label>
                            <input type="text" class="userEmail1" name="userEmail1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
                            <select name="userEmail2" class="userEmail2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                        <button type="button" class="confirm_btn" onclick="sendEmail()">인증번호 발송</button>
                    </div>
                </div>
                <div class="confirm_box" style="display: none">
                    <label>
                        <input type="text" class="code" name="code" value="" placeholder="인증번호 입력">
                        <span id="timerMin">3</span>:<span id="timerSec">00</span>
                    </label>
                    <button type="button" onclick="codeCheck()">인증확인</button>
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit">확인</button>
                </div>
            </form>
        </div>
        
        
        <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="findPwbyEmail.do" method="POST" onsubmit="return checkPw()">
                <div class="input_box">
                    <label>
                        <input type="text" class="userInputId" name="findbypw_id" value="" placeholder="아이디 입력" required>
                    </label>
                    <div class="email_box">
                        <label>
                            <input type="text" class="userInputEmail1" name="findbypw_email1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
                            <select name="findbypw_email2" class="userInputEmail2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                        <button class="confirm_btn" type="button" onclick="sendEmailPw()">인증번호 발송</button>
                    </div>
                </div>
                <div class="confirm_box">
                    <label>
                        <input type="text" class="codePw" name="code" value="" placeholder="인증번호 입력">
                        <span id="timerMinPw">3</span>:<span id="timerSecPw">00</span>
                    </label>
                    <button type="button" onclick="codeCheckPw()">인증확인</button>
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
	let sck = false; // 이메일 인증번호 발송
	let cck = false; // 이메일 인증번호 확인
	let timeout = false;
	let timer; // 타이머 변수
	let timeRemaining = 180; // 3분 (180초)
	
	// 아이디 찾기 타이머 시작
	function startTimer() {
	    const timerMinId = document.getElementById('timerMin');
	    const timerSecId = document.getElementById('timerSec');
	
	    timer = setInterval(() => {
	        if (timeRemaining <= 0) {
	            clearInterval(timer);
	            alert("인증 시간이 초과되었습니다.");
	            timeout = true;
	            return;
	        }
	        timeRemaining--;
	        const minutes = Math.floor(timeRemaining / 60);
	        const seconds = timeRemaining % 60;
	
	        timerMinId.textContent = minutes;
	        timerSecId.textContent = seconds < 10 ? '0' + seconds : seconds;
	    }, 1000);
	}
	
	// 아이디 찾기 타이머 멈춤
	function stopTimer() {
	    if (timer) {
	        clearInterval(timer);
	        timer = null;
	    }
	}
	
	// 아이디찾기 이메일 보내기
	function sendEmail() {
	    const email1 = $('.userEmail1').val();
	    const email2 = $('.userEmail2').val();
	
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('.userEmail1').focus();
	    }
	    document.querySelector('.confirm_box').style.display = 'block';
	    timeRemaining = 180;
	    startTimer();
	
	    $.ajax({
	        url: "findIdSendEmail.ajax",
	        type: "POST",
	        data: {
	            "userEmail1": email1,
	            "userEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                const button = document.querySelector("button[onclick='sendEmail()']");
	                if (button) {
	                    button.textContent = "인증번호 재발송";
	                }
	                sck = true;
	            } else {
	                alert("이메일 전송에 실패하였습니다.");
	                document.querySelector('.confirm_box').style.display = 'none';
	            }
	        },
	        error: function(err) {
	            console.log(err);
	            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
	        }
	    });
	}
	
	// 아이디 찾기 인증번호 확인
	function codeCheck() {
	    const code = $('.code').val();
	    if(!timeout){
	    	$.ajax({
	            url: 'codeCheck.ajax',
	            type: 'POST',
	            data: { "code": code },
	            success: function (res) {
	                if (res === 'OK') {
	                    alert("인증 성공");
	                    stopTimer();
	                    const button = document.querySelector("button[onclick='codeCheck()']");
	                    if (button) {
	                        button.textContent = "인증완료";
	                        button.style.backgroundColor = "grey";
	                        button.disabled = true;
	                    }
	                    cck = true;
	                } else {
	                    alert("인증 실패! 다시 입력해주세요.");
	                    $(".code").val("");
	                    $(".code").focus();
	                }
	            },
	            error: function (err) {
	                console.error(err);
	                mck = false;
	            }
	        });
	    } else{
	    	alert("인증시간이 초과되어 재인증이 필요합니다.")
	    }
	    
	}
	
	// 아이디 찾기 최종 체크
	function check(){
		console.log(sck);
		console.log(cck);
		
		 if (!sck) {
		     alert("이메일 인증번호를 발송하여 확인해주세요.");
		     return false;
		 }
		 const confirmBoxVisible = $(".confirm_box").is(':visible');
		 if (confirmBoxVisible && !cck) {
		     alert("발송된 인증번호를 입력하고 인증확인 해주세요.");
		     return false;
		 }
	 return true;
	}
	
	// 비밀번호 찾기 타이머
	function startTimerPw() {
	    const timerMinId = document.getElementById('timerMinPw');
	    const timerSecId = document.getElementById('timerSecPw');
	
	    timer = setInterval(() => {
	        if (timeRemaining <= 0) {
	            clearInterval(timer);
	            alert("인증 시간이 초과되었습니다.");
	            timeout = true;
	            return;
	        }
	        timeRemaining--;
	        const minutes = Math.floor(timeRemaining / 60);
	        const seconds = timeRemaining % 60;
	
	        timerMinId.textContent = minutes;
	        timerSecId.textContent = seconds < 10 ? '0' + seconds : seconds;
	    }, 1000);
	}
	
	// 비밀번호 찾기 타이머 멈춤
	function stopTimerPw() {
	    if (timer) {
	        clearInterval(timer);
	        timer = null;
	    }
	}
	
	
	// 비밀번호 찾기 메일 발송
	function sendEmailPw() {
		const inputId = $('.userInputId').val();
	    const email1 = $('.userInputEmail1').val();
	    const email2 = $('.userInputEmail2').val();
		
	    if(inputId === ""){
	    	alert("아이디를 입력해주세요");
	    	return $('.inputId').focus();
	    }
	    
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('.userEmail1').focus();
	    }
		
	    document.querySelector('.confirm_box').style.display = 'block';
	    timeRemaining = 180;
	    startTimerPw();
	
	    $.ajax({
	        url: "findPwSendEmail.ajax",
	        type: "POST",
	        data: {
	        	"userId": inputId,
	            "userEmail1": email1,
	            "userEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                const button = document.querySelector("button[onclick='sendEmailPw()']");
	                if (button) {
	                    button.textContent = "인증번호 재발송";
	                }
	                sck = true;
	            } else {
	                alert("해당 이메일로 등록된 계정정보가 없습니다.");
	                document.querySelector('.confirm_box').style.display = 'none';
	            }
	        },
	        error: function(err) {
	            console.log(err);
	            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
	        }
	    });
	}
	
	// 비밀번호 찾기 인증번호 확인
	function codeCheckPw() {
	    const code = $('.codePw').val();
	    if(!timeout){
	    	$.ajax({
	            url: 'codeCheck.ajax',
	            type: 'POST',
	            data: { "code": code },
	            success: function (res) {
	                if (res === 'OK') {
	                    alert("인증 성공");
	                    stopTimerPw();
	                    const button = document.querySelector("button[onclick='codeCheckPw()']");
	                    if (button) {
	                        button.textContent = "인증완료";
	                        button.style.backgroundColor = "grey";
	                        button.disabled = true;
	                    }
	                    cck = true;
	                } else {
	                    alert("인증 실패! 다시 입력해주세요.");
	                    $(".codePw").val("");
	                    $(".codePw").focus();
	                }
	            },
	            error: function (err) {
	                console.error(err);
	                mck = false;
	            }
	        });
	    } else{
	    	alert("인증시간이 초과되어 재인증이 필요합니다.")
	    }
	}
	
	// 비밀번호 찾기 최종 체크
	function checkPw(){
		console.log(sck);
		console.log(cck);
		
		 if (!sck) {
		     alert("이메일 인증번호를 발송하여 확인해주세요.");
		     return false;
		 }
		 const confirmBoxVisible = $(".confirm_box").is(':visible');
		 if (confirmBoxVisible && !cck) {
		     alert("발송된 인증번호를 입력하고 인증확인 해주세요.");
		     return false;
		 }
		 return true;
	}
 
</script>
</html>  