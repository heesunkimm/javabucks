<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JAVABUCKS_ADMIN</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/admin.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../js/admin.js"></script>
        <script>
	        $(document).ready(function(){
	    		$.ajax({
	    			url: "sessionUserCheck",
	    			type: "get",
	    			success: function(resp){
	    				if(!resp){
	    					alert("올바르지 않은 경로입니다. 로그인 후 이용해주세요.");
	    					window.location.href = 'login.do';
	    				}
	    			},
	    			error: function(err){
	    				console.log(err);
	    			}
	    		});
	    	});
    	</script>
    </head>
<body>
    <header class="bg_beige">
        <div class="logo_box">
            <a href="/admin_adminmanage.do">
            	<div class="img_box">
                    <img src="../images/icons/starbucks_logo.png" alt="">
                </div>
                <span>JAVABUCKS ADMIN</span>
            </a>
        </div>

        <ul class="nav_list">
            <li class="nav_item">
                <a href="admin_adminmanage.do">계정관리</a>
                <ul class="dropdown_content">
                    <li><a href="admin_adminmanage.do">관리자 계정 관리</a></li>
                    <li><a href="storemanage.do">지점 계정 관리 </a></li>
                    <li><a href="admin_usermanage.do">유저 계정 관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="admin_drinklist">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="admin_drinklist">커피 및 음료</a></li>
                    <li><a href="admin_dessertlist">디저트</a></li>
                    <li><a href="admin_mdlist">MD</a></li>
                </ul>
            </li>
			
            <li class="nav_item">
                <a href="adminStoreOrder.do">발주관리</a>
                <ul class="dropdown_content">
                    <li><a href="adminStoreOrder.do">지점 발주현황</a></li>
                    <li><a href="adminStockList.do">본사 재고관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="bucksSalesM.do">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="bucksSalesM.do">월별 지점 매출 관리</a></li>
                    <li><a href="bucksSalesD.do">일별 지점 매출 관리</a></li>
                    <li><a href="bucksOrderSales.do">발주 정산관리</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="admin_cpnmange">쿠폰관리</a>
                <ul class="dropdown_content">
                    <li><a href="admin_cpnmange">쿠폰관리</a></li>
                </ul>
            </li>

        </ul>

        <div class="store_box">
        	<p><em class="font_green">${inAdmin.adminId}</em> 로그인하셨습니다.</p>
            <a class="setBtn" href="javascript:;"><img src="../images/icons/setting.png" alt=""></a>
	        <ul class="setting_box">
	        	<li><a class="popup_btn" href="javascript:;" data-popup="passwdEdit">비밀번호 변경</a></li>
	        	<li><a href="adminLogout.do">로그아웃</a></li>
	        </ul>
        </div>
    </header>
    <!-- 비밀번호 변경 팝업 -->
    <div id="passwdEdit" class="popup_box" style="display: none;">
        <p class="popup_title">비밀번호 변경</p>
        <form name="f" action="" method="post">
            <div class="input_box">
                <label>신규 비밀번호
                    <input type="password" name="passwd1" value="">
                </label>
                <label>신규 비밀번호 확인
                    <input type="password" name="passwd2" value="">
                </label>
            </div>
            <div class="pbtn_box">
            	<input type="hidden" name="adminId" value="${inAdmin.adminId}">
                <button class="editBtn" type="button" onclick="changePw()">비밀번호 변경</button>
                <button class="close_btn" type="button" data-popup="passwdEdit">취소</button>
            </div>
        </form>
    </div>
    <div class="dimm"></div>
    