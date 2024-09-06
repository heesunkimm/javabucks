<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JAVABUCKS ADMIN</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/admin.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/admin.js"></script>
    </head>
<body>
    <!-- s: content -->
    <section id="admin_login" class="content">
        <div class="login_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/icons/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS ADMIN</p>
            </div>
            <form name="f" action="adminLogin.do" method="post">
                <div class="input_box">
                    <label>
                        <c:if test="${empty cookie['saveId']}">
                        	<input type="text" name="adminId" value="" placeholder="아이디 입력" required>
                    	</c:if>
                    	<c:if test="${not empty cookie['saveId']}">
                        	<input type="text" name="adminId" value="${cookie['saveId'].value}" placeholder="아이디 입력" required>
                    	</c:if>
                    </label>
                    <label>
                        <input type="password" name="adminPasswd" value="" placeholder="비밀번호 입력" required>
                    </label>
                </div>
                <button class="login_btn" type="submit">로그인</button>
            <div class="find_box">
                <label>
                	<c:if test="${empty cookie['saveId']}">
                		<input type="checkbox" name="saveId" value="on"> 아이디 저장
                	</c:if>
                	<c:if test="${not empty cookie['saveId']}">
                		<input type="checkbox" name="saveId" value="on" checked> 아이디 저장 
                    </c:if>
                </label>
                <!-- <a class="popup_btn" href="javascript:;" data-popup="findbypw">비밀번호 재설정</a> -->
            </div> 
            </form>
        </div>
        <%-- <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 재설정</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="admin_ChangePw" method="post">
                <div class="input_box">
               		 <label>
                        <input type="text" name="adminId" value="<c:out value='${cookie.saveId != null ? cookie.saveId.value : ""}'/>" placeholder="아이디 입력" required>
                    </label>
                    <label>
                        <input type="password" class="changePw1" name="changePw1" value="" placeholder="새비밀번호 입력" required>
                    </label>
                    <label>
                        <input type="password" class="changePw2" name="changePw2" value="" placeholder="새비밀번호 확인" required>
                    </label>
                </div>
                <div class="pbtn_box">
                    <button class="submit_btn" type="submit">확인</button>
                </div>
            </form>
        </div> --%>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
</body>
</html>