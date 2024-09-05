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
                        <label>
                            <select name="userEmail2" class="userEmail2">
                                <option value="naver.com">@naver.com</option>
                                <option value="nate.com">@nate.com</option>
                                <option value="gmail.com">@gmail.com</option>
                            </select>
                        </label>
                        <button type="button" class="confirm_btn" onclick="sendEmail()">인증번호 발송</button>
                    </div>
                </div>
                <div class="confirm_box" style="display: none">
                    <label>
                        <input type="text" class="code" name="code" value="" placeholder="인증번호 입력">
                        <p class="timer"><span id="timerMin">3</span>:<span id="timerSec">00</span></p>
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
                <div class="confirm_box" id="confirm_box" style="display: none">
                    <label>
                        <input type="text" class="codePw" name="code" value="" placeholder="인증번호 입력">
                        <p class="timer"><span id="timerMinPw">3</span>:<span id="timerSecPw">00</span></p>
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
		
	    document.getElementById('confirm_box').style.display = 'block';
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