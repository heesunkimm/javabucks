<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<section id="admin_editstore" class="content store_info">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>관리자 상세정보</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="editForm" action="/editUpdateAdmin.do" method="post" onsubmit="return validateForm()">
                    <p>계정정보</p>
                    <div class="info_wrap">
                        <div class="info_box">
                            <label><span>아이디</span>
                                <input type="text" name="userId" value="${jadmin.adminId}" readonly>
                            </label>
                            <p class="id_noti">* 아이디 수정 불가</p>
                        </div>
                    </div>

                    <div class="info_box">
                        
                        <div class="email_box">
                            <label><span>지점이메일</span>
                                <input type="text" name="adminEmail1" value="${adminEmail1}" >
                            </label>
                            <input type="text" name="adminEmail2" value="@javabucks.com" required>
                            <button type="button" style="margin-top: 0;" onclick="checkAdminEmail()">중복확인</button>
                        </div>
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

 // 이메일 중복 확인 
 function checkAdminEmail() {
     var email1 = document.querySelector('input[name="adminEmail1"]').value;
     var email2 = document.querySelector('input[name="adminEmail2"]').value;
     var adminId = document.querySelector('input[name="userId"]').value;
     var email = email1 + email2;

     // AJAX 요청 생성
     var xhr = new XMLHttpRequest();
     xhr.open("GET", "/editCheckAdminEmail?email=" + encodeURIComponent(email) + "&adminId=" + encodeURIComponent(adminId), true);
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
                 document.querySelector('input[name="adminEmail2"]').readOnly = true;
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
	
 
</script>
