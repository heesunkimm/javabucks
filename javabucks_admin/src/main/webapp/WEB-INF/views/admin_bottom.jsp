<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <footer></footer>
</body>
<script>
$(document).ready(function(){
	$.ajax({
		url: "sessionUserCheck",
		type: "get",
		success: function(resp){
			if(!resp){
				alert("올바르지 않은 경로입니다. 로그인 후 이용해주세요.");
				window.location.href = 'admin_login';
			}
		},
		error: function(err){
			console.log(err);
		}
	});
});
</script>
</html>