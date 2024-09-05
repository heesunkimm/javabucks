<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/store.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/store.js"></script>
        <style>
            #store_login {display: grid; place-items: center; min-height: 100dvh;}
            #store_login input {border: 1px solid #ccc; border-radius: 2px;}
            #store_login input[type="text"]:focus {border-color: #006241;}
            #store_login .login_box .input_box label + label, 
            #store_login .popup_box .input_box > label + label {margin-top: 6px;}
            #store_login .login_box .input_box input {width: 312px; height: 36px; padding: 0 6px; font-size: 18px;}

            #store_login .login_box {padding: 30px 20px; border: 1px solid #eee; border-radius: 4px; box-shadow: 0 3px 7px #ccc;}
            #store_login .login_box .top_box {display: flex; align-items: center; justify-content: center; gap: 20px;}
            #store_login .login_box .top_box .img_box {width: 50px; height: 50px;}
            #store_login .login_box .top_box p {font-size: 24px; font-family: 'Santana_bold'; text-align: center;}
            #store_login .login_box form {margin-top: 10px;}
            #store_login .login_box .input_box, #store_login .login_box .input_box label {width: 326px;}

            #store_login .login_box .login_btn {margin-top: 10px; width: 100%; height: 36px; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fefefe;}

            #store_login .login_box .find_box {margin-top: 14px; text-align: center;}
            #store_login .login_box .find_box label {margin-right: 16px; font-size: 14px;}
            #store_login .login_box .find_box a {font-size: 14px; line-height: 18px; color: #555; border-bottom: 1px solid #555;}

            #store_login .popup_box > p {font-size: 20px; font-weight: 700; color: #006241; text-align: left;}
            #store_login .popup_box .close_btn {position: absolute; top: 6px; right: 6px; display: inline-block; width: 30px; height: 30px;}
            #store_login .popup_box .input_box {width: 326px;}

            #store_login .popup_box .input_box > label {margin-bottom: 10px; width: 312px; height: 38px;}
            #store_login .popup_box .input_box > label input {width: 100%; height: 100%; padding: 0 6px; font-size: 16px;}
            #store_login .popup_box .email_box {width: 326px; display: flex; align-items: center; justify-content: space-between;}
            #store_login .popup_box .email_box label {width: 160px; display: flex; align-items: center;}
            #store_login .popup_box .email_box input {width: 100%; height: 36px; padding: 0 6px; font-size: 16px;}
            #store_login .popup_box .email_box select {width: 100%; height: 38px; font-size: 16px;}
            #store_login .popup_box .submit_btn {width: 80px; height: 32px; border-radius: 2px; background-color: #006241; font-size: 18px; color: #fff;}

            #store_login .popup_box .confirm_box {margin-top: 10px;}
            #store_login .popup_box .confirm_box label {position: relative;}
            #store_login .popup_box .confirm_box input { width: 200px; height: 36px; padding: 0 6px; font-size: 14px;}
            #store_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;}
            #store_login .popup_box .confirm_box button {padding: 0 10px; height: 36px; background: #006241; border-radius: 2px; font-size: 14px; color: #fefefe;}
            #store_login .popup_box .btn_box {text-align: center;}
            #store_login .popup_box .btn_box .setting_btn {position: relative; font-size: 14px; line-height: 18px; color: #555;}
            #store_login .popup_box .btn_box .setting_btn::after {content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 1px; background-color: #555;}
        </style>
    </head>
<body>
    <!-- s: content -->
    <section id="store_login" class="content">
        <div class="login_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/icons/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS STORE</p>
            </div>
            <form name="f" action="store_index" method="POST">
                <div class="input_box">
                    <label>
                    	 <c:if test="${empty cookie['saveId']}">
                        	<input type="text" name="storeId" value="" placeholder="아이디 입력" required>
                    	</c:if>
                    	<c:if test="${not empty cookie['saveId']}">
                        	<input type="text" name="storeId" value="${cookie['saveId'].value}" placeholder="아이디 입력" required>
                    	</c:if>
                    </label>
                    <label>
                        <input type="password" name="storePw" value="" placeholder="비밀번호 입력" required>
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
                <a class="popup_btn" href="javascript:;" data-popup="findbyid">아이디 찾기</a>
                <a class="popup_btn" href="javascript:;" data-popup="findbypw">비밀번호 찾기</a>
            </div>
            </form>
        </div>
        
        <div id="findbyid" class="popup_box" style="display: none;">
            <p class="popup_title">아이디 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbyid"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="findStoreIdbyEmail.do" method="POST" onsubmit="return checkId()">
                <div class="input_box">
                    <div class="email_box">
                        <label>
                            <input type="text" class="bucksEmail1" name="bucksEmail1" value="" placeholder="이메일입력" required>
                        </label>
                        @
                        <label>
                            <select class="bucksEmail2" name="bucksEmail2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                        <button class="confirm_btn1" type="button" onclick="sendEmailId()">인증번호 발송</button>
                    </div>
                </div>
                <div class="confirm_box" style="display:none;">
                	<label>
                        <input type="text" class = "code" name="code" value="" placeholder="인증번호 입력" required>
                        <span id="timerMin">3</span> : <span id="timerSec">00</span>
                    </label>
                    <button class="verify_btn1" type="button" onclick="codeCheckId()">인증확인</button>
                </div>
	                <div class="pbtn_box">
	                    <button class="submit_btn" type="submit">확인</button>
	                </div>
            </form> 
        </div>
        
        <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 찾기</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="findStorePwbyEmail.do" method="POST" onsubmit="return checkPw()">
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
                            <select class="pw_email2" name="pw_email2"">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                        <button class="confirm_btn" type="button" onclick="sendEmailPw()">인증번호 발송</button>
                    </div>
                </div>
                <div class="confirm_box" style="display:none;">
                    <label>
                        <input type="text" class="codePw" name="codePw" value="" placeholder="인증번호 입력" required>
                        <span id="pwTimerMin">3</span> : <span id="pwTimerSec">00</span>
                    </label>
                    <button class="verify_btn" type="button" onclick="codeCheckPw()">인증확인</button>
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
	let idsck = false; // 발송
	let idcck = false; // 인증
	
	let pwsck = false;
	let pwcck = false;
	
	let idTimeout = false;
	let pwTimeout = false;
	
	let timeRemaining = 180;
	let pwtimeRemaining = 180;


	// 아이디 찾기 타이머 시작
	function startTimerId() {
	    const timerMinId = document.getElementById('timerMin');
	    const timerSecId = document.getElementById('timerSec');
	
	    timer = setInterval(() => {
	        if (timeRemaining <= 0) {
	            clearInterval(timer);
	            alert("인증 시간이 초과되었습니다.");
	            idTimeout = true;
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
	function stopTimerId() {
	    if (timer) {
	        clearInterval(timer);
	        timer = null;
	    }
	}

	// 아이디찾기 이메일 보내기
	function sendEmailId() {
	    const email1 = $('.bucksEmail1').val();
	    const email2 = $('.bucksEmail2').val();
	
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('.bucksEmail1').focus();
	    }
	    document.querySelector('.confirm_box').style.display = 'block';
	    timeRemaining = 180;
	    startTimerId();
	
	    $.ajax({
	        url: "findStoreIdSendEmail.ajax",
	        type: "POST",
	        data: {
	            "bucksEmail1": email1,
	            "bucksEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                const button = document.querySelector("button[onclick='sendEmailId()']");
	                if (button) {
	                    button.textContent = "인증번호 재발송";
	                }
	                idsck = true;
	            } else {
	                alert("해당하는 이메일 주소로 가입된 계정이 없습니다.");
	                document.querySelector('.confirm_box').style.display = 'none';
	                idsck = false;
	            }
	        },
	        error: function(err) {
	            console.log(err);
	            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
	        }
	    });
	}
	
	// 아이디 찾기 인증번호 확인
	function codeCheckId() {
	    const code = $('.code').val();
	    if(!idTimeout){
	    	$.ajax({
	            url: "codeCheck.ajax",
	            type: "POST",
	            data: { "code": code },
	            success: function (res) {
	                if (res === 'OK') {
	                    alert("인증 성공");
	                    stopTimerId();
	                    const button = document.querySelector("button[onclick='codeCheckId()']");
	                    if (button) {
	                        button.textContent = "인증완료";
	                        button.style.backgroundColor = "grey";
	                        button.disabled = true;
	                    }
	                    idcck = true;
	                } else {
	                    alert("인증 실패! 다시 입력해주세요.");
	                    $(".code").val("");
	                    $(".code").focus();
	                    idcck = false;
	                }
	            },
	            error: function (err) {
	                console.error(err);
	            }
	        });
	    } else{
	    	alert("인증시간이 초과되어 재인증이 필요합니다.")
	    }
	    
	}
	
	// 아이디 찾기 최종 체크
	function checkId(){
		console.log(idsck);
		console.log(idcck);
		
		 if (!idsck) {
		     alert("이메일 인증번호를 발송하여 확인해주세요.");
		     return false;
		 }
		 const confirmBoxVisible = $(".confirm_box").is(':visible');
		 if (confirmBoxVisible && !idcck) {
		     alert("발송된 인증번호를 입력하고 인증확인 해주세요.");
		     return false;
		 }
		 
		 return true;
	}
	
	// 비밀번호 찾기 타이머
	function startTimerPw() {
	    const timerMinPw = document.getElementById('pwTimerMin');
	    const timerSecPw = document.getElementById('pwTimerSec');

	    timer = setInterval(() => {
	        if (pwtimeRemaining <= 0) {
	            clearInterval(timer);
	            alert("인증 시간이 초과되었습니다.");
	            pwTimeout = true;
	            return;
	        }
	        pwtimeRemaining--;
	        const pwminutes = Math.floor(pwtimeRemaining / 60);
	        const pwseconds = pwtimeRemaining % 60;
	
	        timerMinPw.textContent = pwminutes;
	        timerSecPw.textContent = pwseconds < 10 ? '0' + pwseconds : pwseconds;
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
		const inputId = $('.pw_id').val();
	    const email1 = $('.pw_email1').val();
	    const email2 = $('.pw_email2').val();
		
	    if(inputId === ""){
	    	alert("아이디를 입력해주세요");
	    	return $('.pw_id').focus();
	    }
	    
	    if (email1 === "") {
	        alert("이메일 주소를 입력해주세요");
	        return $('.pw_email1').focus();
	    }
		
	    document.querySelector('#findbypw .confirm_box').style.display = 'block';
	    pwtimeRemaining = 180;
	    startTimerPw();
	
	    $.ajax({
	        url: "findStorePwSendEmail.ajax",
	        type: "POST",
	        data: {
	        	"bucksId": inputId,
	            "bucksEmail1": email1,
	            "bucksEmail2": email2
	        },
	        success: function(res) {
	            if (res === 'OK') {
	                alert("인증메일을 발송하였습니다.");
	                const button = document.querySelector("button[onclick='sendEmailPw()']");
	                if (button) {
	                    button.textContent = "인증번호 재발송";
	                }
	                pwsck = true;
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
	    if(!pwTimeout){
	    	$.ajax({
	            url: "codeCheck.ajax",
	            type: "POST",
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
	                    pwcck = true;
	                } else {
	                    alert("인증 실패! 다시 입력해주세요.");
	                    $(".codePw").val("");
	                    $(".codePw").focus();
	                }
	            },
	            error: function (err) {
	                console.error(err);
	            }
	        });
	    } else{
	    	alert("인증시간이 초과되어 재인증이 필요합니다.")
	    }
	}
	
	// 비밀번호 찾기 최종 체크
	function checkPw(){
		console.log(pwsck);
		console.log(pwcck);
		
		 if (!pwsck) {
		     alert("이메일 인증번호를 발송하여 확인해주세요.");
		     return false;
		 }
		 const confirmBoxVisible = $(".confirm_box").is(':visible');
		 if (confirmBoxVisible && !pwcck) {
		     alert("발송된 인증번호를 입력하고 인증확인 해주세요.");
		     return false;
		 }
		 
		 return true;
	}


	

</script>

</html>