<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!-- s: nav -->
     <section id="user_nav" class="bg_beige">
        <ul class="nav_list">
            <li>
                <a href="user_index">
                    <div class="nav_icon img_box">
                        <img src="/images/icons/menu_home.png" alt="">
                    </div>
                    <p class="nav_tit">Home</p>
                </a>
            </li>
            <li>
                <a href="user_pay">
                    <div class="nav_icon img_box">
                        <img src="../images/icons/menu_pay.png" alt="">
                    </div>
                    <p class="nav_tit">Pay</p>
                </a>
            </li>
            <li>
                <a href="user_store">
                    <div class="nav_icon img_box">
                        <img src="../images/icons/menu_order.png" alt="">
                    </div>
                    <p class="nav_tit">Order</p>
                </a>
            </li>
            <li>
                <a href="user_delivers">
                    <div class="nav_icon img_box">
                        <img src="../images/icons/delivers.png" alt="">
                    </div>
                    <p class="nav_tit">Delivers</p>
                </a>
            </li>
            <li>
                <a href="user_other">
                    <div class="nav_icon img_box">
                        <img src="../images/icons/menu_other.png" alt="">
                    </div>
                    <p class="nav_tit">Other</p>
                </a>
            </li>
        </ul>
    </section>
    <!-- e: nav -->
</body>

<script>
	$(document).ready(function(){
		$.ajax({
			url: "sessionUserCheck",
			type: "get",
			success: function(resp){
				if(!resp){
					alert("올바르지 않은 경로입니다. 로그인 후 이용해주세요.");
					window.location.href = 'user_login';
				}
			},
			error: function(err){
				console.log(err);
			}
		});
	});
	</script>
</html>