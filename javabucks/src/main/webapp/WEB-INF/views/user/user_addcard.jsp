<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_top.jsp"%>
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
                        <button class="submitBtn" type="submit">등록하기</button>
                    </div>
                </form>
            </div>

        </div>
    </section>
    <!-- e: content -->
	<script type="text/javascript">
		//카드번호 유효성 검사
		function cardCheck(){
			let cardRegNum = $("#cardRegNum").val();
			let userId = '${inUser.userId}';
			if (cardRegNum == ""){
				alert("카드번호를 입력해 주세요");
				$("#cardRegNum").focus();
				return false;
			} else if (cardRegNum.length !== 19){
				alert("카드번호를 정확하게 입력해주세요");
				$("#cardRegNum").focus();
				return false;
			} else {
		        $.ajax({
		            url: '/cardCount.ajax',
		            type: 'POST',
		            data: { userId: userId },
		            success: function (cardCount) {
		            	if (cardCount >= 5) {
		                    alert("더 이상 카드를 추가할 수 없습니다. 최대 5개의 카드만 등록 가능합니다.");
		                    return false;
		                } else {
		                    // 카드 개수가 5개 미만이면 '-'를 제거한 카드 번호로 업데이트하고 폼을 제출
		                    let cleanCardNumber = cardRegNum.replace(/-/g, '');
		                    $('input[name=cardRegNum]').val(cleanCardNumber);
		                    document.forms["f"].submit(); // 폼 제출
		                }
		            },
		            error: function () {
		                alert("카드 개수 확인 중 오류가 발생했습니다.");
		                return false;
		            }
		        });
		
		        return false;
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
<%@ include file="user_bottom.jsp" %>