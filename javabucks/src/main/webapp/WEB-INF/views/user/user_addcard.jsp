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
    <section id="user_addcard" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">카드 등록</p>
            </div>

            <div class="addcard_box">
                <form name="" action="" method="post">
                	<input type="hidden" name="userId" value="${inUser.userId}">
                    <label>카드명
                        <input type="text" name="cardName" value="" placeholder="카드명 최대 20자 (선택)">
                    </label>
                    <label>카드번호
                        <input type="text" name="cardRegNum" value="" placeholder="JAVABUCKS 카드번호 16자리 (필수)" required>
                    </label>
                    <div class="btn_box">
                        <button type="submit" disabled>등록하기</button>
                    </div>
                </form>
            </div>

        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>