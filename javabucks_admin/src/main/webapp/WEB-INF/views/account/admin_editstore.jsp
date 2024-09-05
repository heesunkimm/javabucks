<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<section id="admin_editstore" class="content store_info">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>지점 상세정보</p>
        </div>

        <div class="insert_box bg_beige">
            <form name="editForm" action="/editStore.do" method="post">
                <p>계정정보</p>
                <div class="info_wrap">
                    <div class="info_box">
                        <label><span>아이디</span>
                            <input type="text" name="bucksId" value="${jbucks.bucksId}" readonly>
                        </label>
                        <p class="id_noti">* 지점아이디 수정 불가</p>
                    </div>
                </div>

                <p>지점정보</p>
                <div class="info_box">
                    <label><span>지점명</span>
                        <input type="text" name="bucksName" value="${jbucks.bucksName}" >
                    </label>
                    <label><span>점주명</span>
                        <input type="text" name="bucksOwner" value="${jbucks.bucksOwner}" >
                    </label>
                    <div class="loca_box">
                        <label><span>지점위치</span>
                            <input type="text" name="bucksLocation" value="${jbucks.bucksLocation}" readonly>
                        </label>
                    </div>
                    <div class="tel_box">
                        <label><span>지점번호</span>
                             <input class="tel" type="text" name="bucksTel1" size="3" maxlength="3" value="${jbucks.bucksTel1}" required> 
                            -
                            <input class="tel" type="text" name="bucksTel2" size="4" maxlength="4" value="${jbucks.bucksTel2}" required> 
                            -
                            <input class="tel" type="text" name="bucksTel3" size="4" maxlength="4" value="${jbucks.bucksTel3}" required>
                        </label>
                    </div>
                    <div class="email_box">
                        <label><span>지점이메일</span>
                            <input type="text" name="bucksEmail1" value="${jbucks.bucksEmail1}" >
                        </label>
                        <select name="bucksEmail2">
                            <option value="naver.com">@naver.com</option>
                            <option value="nate.com">@nate.com</option>
                            <option value="gmail.com">@gmail.com</option>
                        </select>
                        <button type="button" style="margin-top: 0;" onclick="checkEmail()">중복확인</button>
                    </div>
                    <div class=operating_hours>
                     <label><span>운영 시작 시간</span>
                         <input type="time" name="startTime" value="${fn:substring(jbucks.bucksStart, 11, 16)}">
                     </label>
                     <label><span>운영 종료 시간</span>
                         <input type="time" name="endTime" value="${fn:substring(jbucks.bucksEnd, 11, 16)}">
                     </label>
                	</div>
                </div>
                <div class="btn_box">
                    <button class="add_btn" type="submit">정보수정</button>
                    <button class="del_btn" type="button" onclick="deleteBucks()">지점삭제</button>
                </div>
            </form>
        </div>
    </div>
</section>
<jsp:include page="../admin_bottom.jsp"/>
 <script>
	//이메일 중복 확인 
	function checkEmail() {
	     var email1 = document.querySelector('input[name="bucksEmail1"]').value;
	     var email2 = document.querySelector('select[name="bucksEmail2"]').value;
		 var bucksId = document.querySelector('input[name="bucksId"]').value;
	     // AJAX 요청 생성
	     var xhr = new XMLHttpRequest();
	     xhr.open("GET", "/editCheckEmail?email1=" + encodeURIComponent(email1) + "&email2=" + encodeURIComponent(email2) + "&bucksId=" + encodeURIComponent(bucksId), true);
	     xhr.onreadystatechange = function () {
	         if (xhr.readyState === 4 && xhr.status === 200) {
	             // 서버로부터의 응답 처리
	         	 var response = xhr.responseText;
	              if (response === 'ok') {
	                  alert("이미 사용 중인 이메일입니다.");
	              } else if (response === 'nok') {
	                  alert("사용 가능한 이메일입니다.");
	              }
	          }
	      };
	      xhr.send();
	 }
	
	//지점 삭제 버튼 이벤트
	function deleteBucks() {
	    var bucksId = document.querySelector('input[name="bucksId"]').value;
	    
	    if(confirm("정말로 이 지점을 삭제하시겠습니까?")) {
	        var form = document.createElement("form");
	        form.setAttribute("method", "post");
	        form.setAttribute("action", "/deleteBucks.do");
	
	        var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", "bucksId");
	        hiddenField.setAttribute("value", bucksId);
	
	        form.appendChild(hiddenField);
	        document.body.appendChild(form);
	        form.submit();
	    }
	}
</script>
