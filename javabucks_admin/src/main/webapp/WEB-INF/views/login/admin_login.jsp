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
        <link rel="stylesheet" href="../css/admin.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../js/admin.js"></script>
        <style>
            #admin_login {display: grid; place-items: center; min-height: 100dvh;}
            #admin_login input {border: 1px solid #ccc; border-radius: 2px;}
            #admin_login input[type="text"]:focus {border-color: #006241;}
            #admin_login .login_box .input_box label + label, 
            #admin_login .popup_box .input_box > label + label {margin-top: 6px;}
            #admin_login .login_box .input_box input {width: 312px; height: 36px; padding: 0 6px; font-size: 18px;}

            #admin_login .login_box {padding: 30px 20px; border: 1px solid #eee; border-radius: 4px; box-shadow: 0 3px 7px #ccc;}
            #admin_login .login_box .top_box {display: flex; align-items: center; justify-content: center; gap: 20px;}
            #admin_login .login_box .top_box .img_box {width: 50px; height: 50px;}
            #admin_login .login_box .top_box p {font-size: 24px; font-family: 'Santana_bold'; text-align: center;}
            #admin_login .login_box form {margin-top: 10px;}
            #admin_login .login_box .input_box, #admin_login .login_box .input_box label {width: 326px;}

            #admin_login .login_box .login_btn {margin-top: 10px; width: 100%; height: 36px; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fefefe;}

            #admin_login .login_box .find_box {margin-top: 14px; text-align: center;}
            #admin_login .login_box .find_box label {margin-right: 16px; font-size: 14px;}
            #admin_login .login_box .find_box a {font-size: 14px; line-height: 18px; color: #555; border-bottom: 1px solid #555;}

            #admin_login .popup_box > p {font-size: 20px; font-weight: 700; color: #006241; text-align: left;}
            #admin_login .popup_box .close_btn {position: absolute; top: 6px; right: 6px; display: inline-block; width: 30px; height: 30px;}
            #admin_login .popup_box .input_box {width: 320px;}

            #admin_login .popup_box .input_box > label {width: 312px; height: 38px;}
            #admin_login .popup_box .input_box > label input {width: 100%; height: 100%; padding: 0 6px; font-size: 16px;}
            #admin_login .popup_box .email_box {width: 312px; display: flex; align-items: center; justify-content: space-between;}
            #admin_login .popup_box .email_box label {width: 154px; display: flex; align-items: center;}
            #admin_login .popup_box .email_box input {width: 100%; height: 36px; padding: 0 6px; font-size: 16px;}
            #admin_login .popup_box .email_box select {width: 100%; height: 36px; font-size: 16px;}
            #admin_login .popup_box .submit_btn {width: 80px; height: 32px; border-radius: 2px; background-color: #006241; font-size: 18px; color: #fff;}

            #admin_login .popup_box .confirm_box {margin-top: 10px;}
            #admin_login .popup_box .confirm_box label {position: relative;}
            #admin_login .popup_box .confirm_box input { width: 200px; height: 36px; padding: 0 6px; font-size: 14px;}
            #admin_login .popup_box .confirm_box span {position: absolute; top: 50%; transform: translateY(-50%); right: 8px; font-size: 14px; color: #006241;}
            #admin_login .popup_box .confirm_box button {padding: 0 10px; height: 36px; background: #006241; border-radius: 2px; font-size: 14px; color: #fefefe;}
            #admin_login .popup_box .btn_box {text-align: center;}
            #admin_login .popup_box .btn_box .setting_btn {position: relative; font-size: 14px; line-height: 18px; color: #555;}
            #admin_login .popup_box .btn_box .setting_btn::after {content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 1px; background-color: #555;}
        </style>
    </head>
<body>
    <!-- s: content -->
    <section id="admin_login" class="content">
        <div class="login_box">
            <div class="top_box">
                <div class="img_box">
                    <img src="../images/logo/starbucks_logo.png" alt="">
                </div>
            <p style="font-family: 'Santana_bold';">JAVABUCKS</p>
            </div>
            <form name="f" action="admin_index" method="post">
                <div class="input_box">
                    <label>
                        <input type="text" name="adminId" value="" placeholder="아이디 입력" required>
                    </label>
                    <label>
                        <input type="password" name="adminPasswd" value="" placeholder="비밀번호 입력" required>
                    </label>
                </div>
                <button class="login_btn" type="submit">로그인</button>
            </form>
            <div class="find_box">
                <label>
                <input type="checkbox" name="adminId" value=""> 아이디 저장
                </label>
                <a class="popup_btn" href="javascript:;" data-popup="findbypw">비밀번호 재설정</a>
            </div> 
        </div>
        <div id="findbypw" class="popup_box" style="display: none;">
            <p class="popup_title">비밀번호 재설정</p>
            <a class="close_btn" href="javascript:;" data-popup="findbypw"><img src="../images/icons/close.png" alt=""></a>
            <form name="f" action="" method="">
                <div class="input_box">
                    <label>
                        <input type="text" name="" value="" placeholder="새비밀번호 입력" required>
                    </label>
                    <label>
                        <input type="text" name="" value="" placeholder="새비밀번호 확인" required>
                    </label>
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
</html>