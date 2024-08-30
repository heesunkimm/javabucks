<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/user.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../js/user.js"></script>
</head>
<body>
    <!-- s: content -->
    <section id="user_info" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">개인정보 관리</p>
            </div>
            <div class="edit_form">
                <form name="info_f" action="updateUserInfo.do" method="post" onsubmit="returm check()">
                    <div class="read_box">
                        <label>아이디
                            <input type="text" name="userId" value="${inUser.userId}" readonly>
                        </label>
                        <label>이름
                            <input type="text" name="userName" value="${inUser.userName}" readonly>
                        </label>
                        <label>생년월일
                        	<c:set var="parsedDate" value="${inUser.userBirth}" />	                       
							<fmt:parseDate var="date" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            <input type="text" name="userBirth" value="<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />	" readonly>
                        </label>
                        <div class="gender_box">
                        	<c:if test="${inUser.userGender eq 'F' }">
                            <span>♀ 여자</span>
                            </c:if>
                            <c:if test="${inUser.userGender eq 'M' }">
                            <span>♂ 남자</span>
                            </c:if>
                        </div>
                    </div>

                    <div class="edit_box">
                        <div class="nickname_box">
                            <p>닉네임설정</p>
                            <label>
                                <input type="text" name="userNickname" value="${inUser.userNickname }" placeholder="닉네임을 입력해주세요. (한글 최대 6자)" oninput="validateNn(this)">
                            </label>
                        </div>
                        <a class="toggle_btn" href="javascript:">비밀번호 변경 ▼</a>
                        <div class="change_pw" style="display: none;">
                            <label>
                                <input type="password" name="userPassword" value="" placeholder="새 비밀번호 (10~20자리 이내)" oninput="validatePw(this)">
                            </label>
                            <label>
                                <input type="password" name="userPasswordChanged" value="" placeholder="새 비밀번호 확인" oninput="validatePw(this)">
                            </label>
                        </div>
                        <div class="tel_box">
                            <p>휴대폰</p>
                            <label>
                                <select name="userTel1">
                                    <option value="010">010</option>
                                </select>
                            </label>
                            <label>
                                <input type="text" name="userTel2" value="${inUser.userTel2}" oninput="validateTel(this)">
                            </label>
                            <label>
                                <input type="text" name="userTel3" value="${inUser.userTel3}" oninput="validateTel(this)">
                            </label>
                        </div>
                        <div class="mail_box">
                            <p>이메일</p>
                            <label>
                                <input type="text" name="userEmail1" value="${inUser.userEmail1}" placeholder="메일 입력" oninput="validateEmail(this)">
                            </label>
                            <label>
                                <select name="userEmail2">
                                    <option value="@naver.com">@naver.com</option>
                                    <option value="@nate.com">@nate.com</option>
                                    <option value="@gmail.com">@gmail.com</option>
                                </select>
                            </label>
                        </div>
                    </div>

                    <div class="btn_box">
                        <button type="submit">개인정보 수정</button>
                        <button type="button">회원탈퇴</button>
                    </div>
                </form>
            </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script type="text/javascript">
	document.querySelector('.toggle_btn').addEventListener('click', function() {
	    var changePwDiv = document.querySelector('.change_pw');
	    if (changePwDiv.style.display === 'none') {
	        changePwDiv.style.display = 'block';
	    } else {
	        changePwDiv.style.display = 'none';
	    }
	});

	function validateTel(input) {
		input.value = input.value.replace(/[^0-9]/g, '');

	    if (input.value.length > 4) {
	        input.value = input.value.slice(0, 4);
	    }
	}
	
	function validateEmail(input) {
		input.value = input.value.replace(/[^0-9a-zA-Z]/g, '');
	}
	
	function validatePw(input) {
		input.value = input.value.replace(/[^0-9a-zA-Z]/g, '');
		
		if (input.value.length < 10) {
	        input.setCustomValidity("비밀번호는 10자리 이상이어야 합니다.");
	    } else if (input.value.length >= 20) {
	        input.value = input.value.slice(0, 20);
	    } else {
	        input.setCustomValidity("");
	    }
	}
	
	function validateNn(input){
		if (input.value.length > 6) {
	        input.value = input.value.slice(0, 6);
	    }
	}
	
	function check(){
		const passwd = document.getElementsByName('userPassword');
		console.log(passwd);
	}
</script>