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
                <form name="f" action="uesr_addcard" method="post" onsubmit="return cardCheck()">
                	<input type="hidden" name="userId" value="${inUser.userId}">
                    <label>카드명
                        <input type="text" name="cardName" value="" placeholder="카드명 최대 20자 (선택)" maxlength="20">
                    </label>
                    <label>카드번호
                        <input type="text" id="cardRegNum" name="cardRegNum" value="" placeholder="JAVABUCKS 카드번호 16자리 (필수)" maxlength="19">
                    </label>
                    <div class="btn_box">
                        <button type="submit" >등록하기</button>
                    </div>
                </form>
            </div>

        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>
<script type="text/javascript">
	let ck = false;
	// 카드번호 체크
	function cardCheck(){
		let cardRegNum = $("#cardRegNum").val();
		if (cardRegNum == ""){
			alert("카드번호를 입력해 주세요")
			$("#cardRegNum").focus();
			return false;
		} else if (cardRegNum.length !== 19){
			alert("카드번호를 정확하게 입력해주세요")
			$("#cardRegNum").focus();
			return false;
		} else {
			 // '-'를 제거한 카드 번호로 업데이트
	        let cleanCardNumber = cardRegNum.replace(/-/g, '');
	        // 서버로 전송하기 전에 input 값 업데이트
	        $('input[name=cardRegNum]').val(cleanCardNumber);
	        // 폼을 제출
	        this.submit(); // 폼 제출
		}
		
		
	}
	
	// 카드번호 하이픈 넣기
	document.getElementById('cardRegNum').addEventListener('input', function (e) {
		let value = e.target.value.replace(/-/g, ''); // 기존의 '-'를 제거
	    let formattedValue = '';
	    for (let i = 0; i < value.length; i++) {
	        if (i > 0 && i % 4 === 0) {
	            formattedValue += '-'; // 4자리마다 '-' 추가
	        }
	        formattedValue += value[i];
	    }
	    e.target.value = formattedValue;
	});
	
	// 숫자만 입력
	$('input[name=cardRegNum]').on('input',function () {
		   $(this).val($(this).val().replace(/[^0-9\-]/g, ''));
	 })
</script>