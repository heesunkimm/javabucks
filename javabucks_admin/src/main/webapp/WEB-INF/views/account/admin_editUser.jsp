<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<section id="admin_editstore" class="content store_info">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>사용자 상세정보</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="editForm" action="/editUpdateUser.do" method="post" onsubmit="return validateForm()">
                    <p>계정정보</p>
                    <div class="info_wrap">
                        <div class="info_box">
                            <label><span>아이디</span>
                                <input type="text" name="userId" value="${juser.userId}" readonly>
                            </label>
                            <p class="id_noti">* 아이디 수정 불가</p>
                        </div>
                    </div>

                    <div class="info_box">
                        <label><span>이름</span>
                            <input type="text" name="userName" value="${juser.userName}" >
                        </label>
                        <label><span>닉네임</span>
                           <input type="text" name="userNickname" value="${juser.userNickname}" maxlength="6">
                        </label>
                        <label><span>생년월일</span>
                            <input type="text" name="userBirth" value="${juser.userBirth}" >
                        </label>
                        
                        <div class="tel_box">
                            <label><span>번호</span>
                                 <input class="tel" type="text" name="userTel1" size="3" maxlength="3" value="${juser.userTel1}" required> 
                                -
                                <input class="tel" type="text" name="userTel2" size="4" maxlength="4" value="${juser.userTel2}" required> 
                                -
                                <input class="tel" type="text" name="userTel3" size="4" maxlength="4" value="${juser.userTel3}" required>
                            </label>
                        </div>
                        <div class="email_box">
                            <label><span>이메일</span>
                                <input type="text" name="userEmail1" value="${juser.userEmail1}" >
                            </label>
                            <select name="userEmail2">
                                <option value="naver.com">@naver.com</option>
                                <option value="nate.com">@nate.com</option>
                                <option value="gmail.com">@gmail.com</option>
                            </select>
                            <button type="button" style="margin-top: 0;" onclick="checkEmail()">중복확인</button>
                        </div>
                        <label><span>등급</span>
                            <input type="text" name="gradeCode" value="${juser.gradeCode}" readonly>
                        </label>
                    </div>
                    <div class="btn_box">
                        <button class="add_btn" type="submit">정보수정</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <jsp:include page="../admin_bottom.jsp"/>
  
 <script >
 let isEmailChecked = false;
 
		//이메일 중복 확인 
		function checkEmail() {
		     var email1 = document.querySelector('input[name="userEmail1"]').value;
		     var email2 = document.querySelector('select[name="userEmail2"]').value;
			 var userId = document.querySelector('input[name="userId"]').value;
		     // AJAX 요청 생성
		     var xhr = new XMLHttpRequest();
		     xhr.open("GET", "/editCheckUserEmail?email1=" + encodeURIComponent(email1) + "&email2=" + encodeURIComponent(email2) + "&userId=" + encodeURIComponent(userId), true);
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
		                  document.querySelector('input[name="userEmail1"]').readOnly = true;
		                  document.querySelector('select[name="userEmail2"]').readOnly = true;
		                  enableSubmitButton();
		              }
		          }
		      };
		      xhr.send();
		 }
		
		// 수정 버튼 활성화 여부 체크
		 function enableSubmitButton() {
		     if (isEmailChecked) {
		         document.getElementById('submitBtn').disabled = false;
		     }
		 }

		 // 폼 제출 전에 이메일 중복 확인이 완료되었는지 확인
		 function validateForm() {
		     if (!isEmailChecked) {
		         alert("이메일 중복 확인을 해주세요.");
		         return false;
		     }
		     return true;
		 }
		 
		 window.onload = function() {
			    // 성공 메시지 확인 및 알림창 표시
			    var message = "${message}";
			    if (message) {
			        alert(message);
			    }
			}
		
 
 
</script>
