<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/user.js"></script>
        <style>
            #user_join {display: grid; place-items: center; min-height: 100dvh;}
            #user_join input {border: 1px solid #ccc; border-radius: 2px;}
            #user_join input[type="text"]:focus {border-color: #006241;}
            #user_join .join_box .input_box > label + label, 
            #user_join .join_box .input_box .pw_box label, 
            #user_join .join_box .input_box .hp_box, 
            #user_join .join_box .input_box .email_box {margin-top: 6px;}
            #user_join .join_box .input_box input {width: 100%; height: 36px; padding: 0 6px;}

            #user_join .join_box {padding: 30px 20px; border: 1px solid #eee; border-radius: 4px; box-shadow: 0 3px 7px #ccc;}
            #user_join .join_box .top_box {display: flex; align-items: center; justify-content: center; gap: 20px;}
            #user_join .join_box .top_box .img_box {width: 50px; height: 50px;}
            #user_join .join_box .top_box p {font-size: 24px; font-family: 'Santana_bold'; text-align: center;}
            #user_join .join_box form {margin-top: 10px;}
            #user_join .join_box .input_box {width: 326px;}
            #user_join .join_box .input_box label, #user_join .join_box .input_box .pw_box input {width: 312px;}

            #user_join .join_box .input_box .gender_box {margin-top: 6px; display: flex; align-items: center;}
            #user_join .join_box .input_box .gender_box label {margin-top: 0; width: 50%; display: flex; align-items: center; justify-content: center; font-size: 14px;}
            #user_join .join_box .input_box .gender_box input[type="checkbox"] {margin-right: 10px; width: 14px; height: 14px;}


            #user_join .join_box .input_box .hp_box {width: 324px; display: flex; align-items: center; justify-content: space-between;}
            #user_join .join_box .input_box .hp_box label {width: 100px; height: 36px;}
            #user_join .join_box .input_box .hp_box input, #user_join .join_box .input_box .hp_box select {width: 100%; height: 100%; padding: 0; text-align: center;}

            #user_join .join_box .input_box .email_box {width: 326px; display: flex; align-items: center; justify-content: space-between;}
            #user_join .join_box .input_box .email_box label {width: 106px; height: 36px;}
            #user_join .join_box .input_box .email_box input, #user_join .join_box .input_box .email_box select {width: 100%; height: 100%; padding: 0; text-align: center;}
            #user_join .join_box .input_box .email_box button {padding: 0 6px; height: 36px; background: #006241; border-radius: 2px; font-size: 14px; color: #fefefe;}

            #user_join .join_box .input_box .confirm_box, #user_join .join_box .input_box .id_box {margin-top: 6px; display: flex; align-items: center; justify-content: space-between;}
            #user_join .join_box .input_box .confirm_box label, #user_join .join_box .input_box .id_box label {position: relative; width: 230px;}
            #user_join .join_box .input_box .confirm_box input, #user_join .join_box .input_box .id_box input {width: 76%; height: 36px; padding: 0 6px; font-size: 14px;}
            /* #user_join .join_box .input_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;} */
            #user_join .join_box .input_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241; margin-right:4px; margin-top: 2px; position:static; } /* 타이머에서 분과 초가 겹쳐지게 나와서 margin-right, margin-top, position을 추가하였습니다! */
            #user_join .join_box .input_box .confirm_box button, #user_join .join_box .input_box .id_box button {padding: 0 10px; height: 36px; background: #006241; border-radius: 2px; font-size: 14px; color: #fefefe;}

            #user_join .join_box .join_btn {margin-top: 10px; width: 100%; height: 36px; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fefefe;}
        </style>
    </head>
<body>
    <!-- s: content -->
    <section id="user_join">
        <div class="join_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/logo/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS</p>
            </div>
            <form name="f" action="user_join" method="post" onsubmit="return check()">
                <div class="input_box">
                    <label>
                        <input type="text" class="userName" name="userName" value="" placeholder="이름 입력" required>
                    </label>
                    <label>
                        <input type="text" class="userBirth" name="userBirth" value="" placeholder="생년월일" required>
                    </label>
                    <div class="gender_box">
                        <label>
                            <input type="checkbox" name="userGender" value="F">여자
                        </label>
                        <label>
                            <input type="checkbox" name="userGender" value="M">남자
                        </label>
                    </div>
                    <div class="id_box">
                        <label>
                            <input type="text" class="id" name="userId" value="" placeholder="아이디 입력" required>
                        </label>
                        <button type="button" onclick="idCheck()">중복확인</button>
                    </div>
                    <div class="pw_box">
                        <label>
                            <input type="password" class="userPasswd" name="userPasswd" value="" placeholder="비밀번호" required>
                        </label>
                        <label>
                            <input type="password" class="userPasswdConfirm" name="userPasswdConfirm" value="" placeholder="비밀번호 확인" required>
                        </label>
                    </div>
                    <div class="hp_box">
                        <label>
                            <select name="userTel1" class="userTel1">
                                <option value="010">010</option>
                                <option value="016">016</option>
                                <option value="017">017</option>
                                <option value="018">018</option>
                                <option value="019">019</option>
                            </select>
                        </label>
                        <label>
                            <input type="text" class="userTel2" name="userTel2" value="" required>
                        </label>
                        <label>
                            <input type="text" class="userTel3" name="userTel3" value="" required>
                        </label>
                    </div>
                    <div class="email_box">
                        <label>
                            <input type="text" class="userEmail1" name="userEmail1" value="" placeholder="이메일 입력" required>
                        </label>
                        @
                        <label>
                            <select name="userEmail2" class="userEmail2">
                                <option value="naver.com">naver.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="gmail.com">gmail.com</option>
                            </select>
                        </label>
                        <button type="button" class="dupcate_btn" onclick="duplicateCheck()">중복체크</button>
                        <button type="button" class="confirm_btn" style="display:none;" onclick="sendEmail()">인증번호 발송</button>
                    </div>
                    <div class="confirm_box" style="display: none;"> 
                        <label>
                       		<input type="text" class="code" name="code" value="" placeholder="인증번호 입력" required>
                            <span id="timerMin">3</span>:<span id="timerSec">00</span> 
                        </label>
                        <button type="button" onclick="codeCheck()">인증확인</button>
                    </div>
                </div>
                <button class="join_btn" type="submit">회원가입</button>
            </form>
        </div>
    </section>
    <!-- e: content -->
</body>
<script type="text/javascript">
	//아이디 중복 확인 
	let ck = false; 
	// 이메일 인증 상태를 추적하는 변수
	let mck = false;
	
	// 이메일인증 타이머 
	let timer; 
	let timeRemaining = 180; // 3분 
	
// 중복확인 버튼 유효성검사 	
function idCheck() {
    // 입력된 아이디 값을 가져옵니다
    let name = $(".userName").val();
    let birth = $(".userBirth").val();
    let id = $(".id").val();
    
    if(name === ""){
    	alert("이름을 입력해 주세요");
    	$(".userName").focus();
    	return;
    }
    if (birth === "") {
        alert("생년월일을 입력해 주세요");  
        $(".userBirth").focus();  
        return; // 함수 종료
    }
    if (id === "") {
        alert("아이디를 입력해 주세요");  
        $(".id").focus();  
        return;  
    }

    // AJAX 요청을 통해 아이디 중복 확인을 서버에 요청
    $.ajax({
        url: "idCheck", // 요청을 보낼 서버 URL
        type: "POST", // POST 방식으로 데이터 전송
        data: { "id": id }, // 서버에 전송할 데이터
        success: function(res) {
            // 서버 응답에 따라 처리
            if (res === 'OK') {
                alert("사용 가능한 아이디입니다."); // 아이디 사용 가능
                ck = true; // 중복 확인 성공
                console.log("사용 가능");
            } else {
                alert("이미 사용중인 아이디입니다."); // 아이디가 이미 사용 중
                $(".id").val(""); // 입력 필드 비우기
                $(".id").focus(); // 아이디 입력 필드에 포커스
                ck = false; // 중복 확인 실패
                console.log("사용 불가");
            }
        },
        error: function(err) {
            console.error(err); // 오류 발생 시 콘솔에 로그
            ck = false; // 오류 발생 시 중복 확인 실패
        }
    });
}

function duplicateCheck() {
    // 인증번호 발송 버튼의 display 속성을 변경하여 보이도록 설정합니다.
    let email1 = $('.userEmail1').val().trim(); // 문자열 양 끝의 공백을 제거하면서 원본 문자열을 수정하지 않고 새로운 문자열을 반환
    let email2 = $('.userEmail2').val();
    
    if(email1 ==""){
		alert("이메일 주소를 입력해주세요")
		return $('.userEmail1').focus();
	}else if(email2 == ""){
		// $('.confirm_box').show();
		// $('.confirm_box').style.display="block";
	}
    document.querySelector('.confirm_btn').style.display = 'block';
    document.querySelector('.dupcate_btn').style.display = 'none';
     
}

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

// 이메일인증 버튼 클릭시 유효성검사
function sendEmail(){
	let email1 = $('.userEmail1').val().trim(); // 문자열 양 끝의 공백을 제거하면서 원본 문자열을 수정하지 않고 새로운 문자열을 반환
	let email2 = $('.userEmail2').val(); //  jQuery의 .val : value 데이터 넘어갈때 사용 
	
	// 인증번호 입력box 활성화 
	document.querySelector('.confirm_box').style.display = 'block';
	
	timeRemaining = 180;
	startTimer();
	
	// 이메일 입력이 안되어있으면 focus
	if(email1 ==""){
		alert("이메일 주소를 입력해주세요")
		return $('.userEmail1').focus();
		
	}else if(email2 == ""){
		// $('.confirm_box').show();
		// $('.confirm_box').style.display="block";
	}
	$.ajax({
		url : 'sendEmail',
		type : 'POST',
		data : { "userEmail1" : email1,
				"userEmail2" : email2
				 
		},
		success : function(res){
			if(res == 'OK'){
				alert("인증메일을 발송하였습니다.");
			}else{
				alert("이미 등록된 이메일입니다.");
				document.querySelector('.confirm_box').style.display = 'none';
			}
		},
		error : function(err){
			console.log(err);
			alert("서버 요청 실패! 네트워크 상태를 확인해주세요.")
		}
	})
}
 
// 이메일 인증번호  
function codeCheck(){
	let code = $('.code').val();
	$.ajax({
		url : 'codeCheck',
		type : 'POST',
		data:{"code":code},
		success : function(res){
			if(res=='OK'){
				alert("인증 성공");
				mck = true ;
			}else{
				alert("인증 실패! 다시 입력해주세요.");
				$(".code").val("");
				$(".code").focus();
				mck = false;
			}
		},
		error : function(err){
			console.error(err);
			mck = false;
		}
	});
}


 
// 회원가입 버튼 클릭시 유효성검사
function check() {
	let name = $(".userName").val();
    let birth = $(".userBirth").val();
    let id = $(".id").val();
    let passwd = $(".userPasswd").val();
    let passwdok = $(".userPasswdConfirm").val();
    let tel1 = $(".userTel1").val();
    let tel2 = $(".userTel2").val();
    let tel3 = $(".userTel3").val();
    let email1 = $(".userEmail1").val();
    
    if(name === ""){
    	alert("이름을 입력해 주세요");
    	$(".userName").focus();
    	return false; 
    }
    if (birth === "") {
        alert("생년월일을 입력해 주세요"); // 사용자에게 알림
        $(".userBirth").focus(); // 아이디 입력 필드에 포커스
        return false; // 함수 종료
    }
    if (id === "") {
        alert("아이디를 입력해 주세요"); // 사용자에게 알림
        $(".id").focus(); // 아이디 입력 필드에 포커스
        return false; // 함수 종료
    }
    if (!ck) {
        alert("아이디 중복 확인을 먼저 해 주세요");
        return false;
    }
    if(passwd === ""){
    	alert("비밀번호를 입력해 주세요");
    	$(".userPasswd").focus();
    	return false;
    }
    if(passwdok===""){
    	alert("비밀번호 확인을 입력해주세요");
    	$(".userPasswdConfirm").focus();
    	return false;
    }
    if (passwd !== passwdok) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    if(tel2==="" || tel3===""){
    	alert("전화번호를 입력해주세요");
    	return false;
    }
    if(email===""){
    	alert("이메일을 입력해주세요");
    	return false;
    }
    if (!mck) {
        alert("이메일 인증을 먼저 해 주세요");
        return false;
    }
    return true;
}


</script>
</html>

 