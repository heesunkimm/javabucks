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
                <form name="" action="" method="post">
                    <div class="read_box">
                        <label>아이디
                            <input type="text" name="" value="" readonly>
                        </label>
                        <label>이름
                            <input type="text" name="" value="" readonly>
                        </label>
                        <label>생년월일
                            <input type="text" name="" value="" readonly>
                        </label>
                        <div class="gender_box">
                            <span>여자</span>
                            <span>남자</span>
                        </div>
                    </div>

                    <div class="edit_box">
                        <div class="nickname_box">
                            <p>닉네임설정</p>
                            <label>
                                <input type="text" name="" value="" placeholder="닉네임을 입력해주세요. (한글 최대 6자)">
                            </label>
                        </div>
                        <a class="toggle_btn" href="javascript:;">비밀번호 변경 ▽</a>
                        <div class="change_pw" style="display: none;">
                            <label>
                                <input type="password" name="" value="" placeholder="새 비밀번호 (10~20자리 이내)">
                            </label>
                            <label>
                                <input type="password" name="" value="" placeholder="새 비밀번호 확인">
                            </label>
                        </div>
                        <div class="tel_box">
                            <p>휴대폰</p>
                            <label>
                                <select name="">
                                    <option value="">010</option>
                                    <option value="">016</option>
                                    <option value="">017</option>
                                    <option value="">018</option>
                                    <option value="">019</option>
                                </select>
                            </label>
                            <label>
                                <input type="text" name="" value="">
                            </label>
                            <label>
                                <input type="text" name="" value="">
                            </label>
                        </div>
                        <div class="mail_box">
                            <p>이메일</p>
                            <label>
                                <input type="text" name="" value="" placeholder="메일 입력">
                            </label>
                            <label>
                                <select name="">
                                    <option value="">@naver.com</option>
                                    <option value="">@nate.com</option>
                                    <option value="">@gmail.com</option>
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
