<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <footer></footer>
</body>
<script>
	function changePasswd(){
		const storePasswd = document.getElementsByName('storePasswd')[0];
	    const storePasswd2 = document.getElementsByName('storePasswd2')[0];
		
	    $.ajax({
            url: "changePasswd.ajax",
            type: "POST",
            data: { 
            	"storePasswd": storePasswd,
            	"storePasswd2": storePasswd2
            },
            success: function (res) {
            	if(res === 'success'){
            		alert("비밀번호가 변경되었습니다.")
            	}else{
            		alert("비밀번호 변경에 실패했습니다. 관리자에게 문의해주세요.")
            	}
            },
            error: function (err) {
            	alert("에러 발생. 관리자에게 문의해주세요.")
                console.error(err);
            }
        });
	}
</script>
</html>
