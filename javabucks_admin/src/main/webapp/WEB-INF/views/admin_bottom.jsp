<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <footer></footer>
</body>
<script>
	function changePw(){
		const userId = document.getElementsByName('adminId')[0].value;
		const passwd1 = document.getElementsByName('passwd1')[0].value;
		const passwd2 = document.getElementsByName('passwd2')[0].value;
	
		if(passwd1 === passwd2){
			$.ajax({
				type : "POST",
				url : "adminChangePw.ajax",
				data : {
					adminId : userId,
					adminPasswd : passwd1
				},
				success : function(response){
					if(response == 'success'){
						alert("비밀번호가 변경되었습니다.");
						location.reload();
					} else {
						alert("비밀번호 변경 실패. 관리자에게 문의해주세요.")
					}
				},
				error : function(error){
					console.log(error);
				}
			});
		} else {
			alert("입력하신 비밀번호가 일치하지 않습니다.");
			document.getElementsByName('passwd1')[0].value = '';
			document.getElementsByName('passwd2')[0].value = '';
			document.getElementsByName('passwd1')[0].focus();
			
		}
	}


</script>
</html>