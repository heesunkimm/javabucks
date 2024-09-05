<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <section id="user_join">
        <div class="join_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/logo/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS</p>
            </div>
            <form name="f" action="userRegister.do" method="POST" onsubmit="return userRegister()">
                <div class="input_box">
                <input type="hidden" name="gradeCode" id="gradeCode" value="welcome">
                    <label>
                        <input type="text" class="userName" name="userName" value="" placeholder="이름 입력" required>
                    </label>
                    <label>
                        <input type="text" class="userBirth" name="userBirth" value="" placeholder="생년월일 입력 : 예) 19900101" maxlength="8" oninput="validateBirth(this)" required>
                    </label>
                    <div class="gender_box">
                        <label>
                            <input type="radio" name="userGender" value="F">여자
                        </label>
                        <label>
                            <input type="radio" name="userGender" value="M">남자
                        </label>
                    </div>
                    <div class="id_box">
                        <label>
                            <input type="text" class="id" name="userId" value="" placeholder="아이디 입력" maxlength="10" oninput="validateId(this)" required onfocus="showTooltip(this)" onblur="hideTooltip(this)" required>
                        </label>
                       	<span class="tooltip">* 아이디는 영문자와 숫자로 10자 이내로만 가능합니다.</span>
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
                            </select>
                        </label>
                        <label>
                            <input type="text" class="userTel2" name="userTel2" value="" oninput="validateTel(this)" required>
                        </label>
                        <label>
                            <input type="text" class="userTel3" name="userTel3" value="" oninput="validateTel(this)" required>
                        </label>
                    </div>
                    <div class="email_box">
                        <label>
                            <input type="text" class="userEmail1" name="userEmail1" value="" placeholder="이메일 입력" oninput="validateEmail(this)" required>
                        </label>
                        <label>
                            <select name="userEmail2" class="userEmail2">
                                <option value="naver.com">@naver.com</option>
                                <option value="nate.com">@nate.com</option>
                                <option value="gmail.com">@gmail.com</option>
                            </select>
                        </label>
                        <button type="button" class="dupcate_btn" onclick="emailCheck()">중복확인</button>
                        <button type="button" class="confirm_btn" style="display:none;" onclick="sendEmail()">인증번호 발송</button>
                    </div>
                    <div class="confirm_box" style="display: none;"> 
                        <label>
                       		<input type="text" class="code" name="code" value="" placeholder="인증번호 입력" >
                       		<p class="timer"><span id="timerMin">3</span>:<span id="timerSec">00</span></p>
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
function validateBirth(input) {
    input.value = input.value.replace(/[^0-9]/g, '');

    if (input.value.length > 8) {
        input.value = input.value.slice(0, 8);
    }
}

function validateId(input) {
	input.value = input.value.replace(/[^0-9a-zA-Z]/g, '');

    if (input.value.length > 8) {
        input.value = input.value.slice(0, 8);
    }
}

function validateEmail(input) {
	input.value = input.value.replace(/[^0-9a-zA-Z]/g, '');
}

function validateTel(input) {
	input.value = input.value.replace(/[^0-9]/g, '');

    if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
    }
}

function showTooltip(input) {
    const tooltip = input.nextElementSibling;
    tooltip.style.visibility = 'visible';
    tooltip.style.opacity = '1';
}

function hideTooltip(input) {
    const tooltip = input.nextElementSibling;
    tooltip.style.visibility = 'hidden';
    tooltip.style.opacity = '0';
}

let ck = false; // 아이디 중복 확인 상태
let mck = false; // 이메일 중복 확인 상태
let sck = false; // 이메일 인증번호 발송
let cck = false; // 이메일 인증번호 확인
let timeout = false;
let timer; // 타이머 변수
let timeRemaining = 180; // 3분 (180초)

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

function idCheck() {
    const id = $(".id").val();
    if (id === "") {
        alert("아이디를 입력해 주세요");
        $(".id").focus();
        return;
    }

    $.ajax({
        url: "idCheck.ajax",
        type: "POST",
        data: { "id": id },
        success: function (res) {
            if (res === 'OK') {
                alert("사용 가능한 아이디입니다.");
                ck = true;

                const button = document.querySelector("button[onclick='idCheck()']");
                if (button) {
                    button.disabled = true;
                    button.textContent = "확인완료";
                    button.style.backgroundColor = "grey";
                }
            } else {
                alert("이미 사용 중인 아이디입니다.");
                $(".id").val("");
                $(".id").focus();
                ck = false;
            }
        },
        error: function (err) {
            console.error(err);
            ck = false;
        }
    });
}

function emailCheck() {
    const email1 = $(".userEmail1").val();    
    const email2 = $('.userEmail2').val();
    
    if (email1 === "") {
        alert("이메일 주소를 입력해주세요");
        return $('.userEmail1').focus();
    }
    
    $.ajax({
        url: "mailCheck.ajax",
        type: "POST",
        data: { 
            email1: email1,
            email2: email2
        },
        success: function (res) {
            if (res === 'OK') {
                alert("사용 가능한 이메일 주소입니다.");
                const button = document.querySelector("button[onclick='emailCheck()']");
                if (button) {
                    button.disabled = true;
                    button.textContent = "확인완료";
                    button.style.backgroundColor = "grey";
                }
                mck = true;
            } else {
                alert("이미 사용 중인 이메일입니다.");
                $(".userEmail1").val("");
                $(".userEmail1").focus();
            }
        },
        error: function (err) {
            console.error(err);
        }
    });
    document.querySelector('.confirm_btn').style.display = 'inline-block';
    document.querySelector('.dupcate_btn').style.display = 'none';
}

function sendEmail() {
    const email1 = $('.userEmail1').val().trim();
    const email2 = $('.userEmail2').val();

    if (email1 === "") {
        alert("이메일 주소를 입력해주세요");
        return $('.userEmail1').focus();
    }

    document.querySelector('.confirm_box').style.display = 'inline-block';
    timeRemaining = 180;
    startTimer();

    $.ajax({
        url: "sendEmail.ajax",
        type: "POST",
        data: { "userEmail1": email1, "userEmail2": email2 },
        success: function (res) {
            if (res === 'OK') {
                alert("인증메일을 발송하였습니다.");
                const button = document.querySelector("button[onclick='sendEmail()']");
                if (button) {
                    button.textContent = "인증번호 재발송";
                }
                sck = true;
            } else {
                alert("이미 등록된 이메일입니다.");
                document.querySelector('.confirm_box').style.display = 'none';
            }
        },
        error: function (err) {
            console.log(err);
            alert("서버 요청 실패! 네트워크 상태를 확인해주세요.");
        }
    });
}

function stopTimer() {
    if (timer) {
        clearInterval(timer);
        timer = null;
    }
}

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

function userRegister() {
    const name = $(".userName").val();
    const birth = $(".userBirth").val();
    const gender = $("input[name='userGender']:checked").val();
    const id = $(".id").val();
    const passwd = $(".userPasswd").val();
    const passwdok = $(".userPasswdConfirm").val();
    const tel2 = $(".userTel2").val();
    const tel3 = $(".userTel3").val();
    const email = $(".userEmail1").val();

    if (name === "") {
        alert("이름을 입력해 주세요");
        $(".userName").focus();
        return false;
    }
    if (birth === "") {
        alert("생년월일을 입력해 주세요");
        $(".userBirth").focus();
        return false;
    }
    if (id === "") {
        alert("아이디를 입력해 주세요");
        $(".id").focus();
        return false;
    }    
    if (gender === undefined) {
        alert("성별을 선택해 주세요");
        return false;
    }
    if (!ck) {
        alert("아이디 중복확인 버튼을 눌러 확인해주세요");
        return false;
    }
    if (passwd === "") {
        alert("비밀번호를 입력해 주세요");
        $(".userPasswd").focus();
        return false;
    }
    if (passwdok === "") {
        alert("비밀번호 확인을 입력해주세요");
        $(".userPasswdConfirm").focus();
        return false;
    }
    if (passwd !== passwdok) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    if (tel2 === "" || tel3 === "") {
        alert("전화번호를 입력해주세요");
        return false;
    }
    if (email === "") {
        alert("이메일을 입력해주세요");
        return false;
    }
    if (!mck) {
        alert("이메일 중복확인 버튼을 클릭하여 확인해주세요");
        return false;
    }
    if (!sck) {
        alert("이메일 인증번호를 발송하여 확인해주세요");
        return false;
    }
    const confirmBoxVisible = $(".confirm_box").is(':visible');
    if (confirmBoxVisible && !cck) {
        alert("발송된 인증번호를 입력하고 인증확인 해주세요");
        return false;
    }
    return true;
}
 </script>

</html>

 