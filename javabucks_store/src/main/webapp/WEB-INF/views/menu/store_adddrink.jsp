<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <style>
	    /* store_adddrink */
		#store_adddrink .mixed_box, 
		#store_adddrink .code_box {padding: 20px; background-color: #f6f5ef;}
		#store_adddrink label, 
		#store_adddrink input, 
		#store_adddrink select, 
		#store_adddrink button {font-size: 18px;}
		
		#store_adddrink label {display: inline-flex; align-items: center; font-size: 16px;}
		#store_adddrink input[type="checkbox"] {margin-left: 12px; width: 15px; height: 15px;}
		#store_adddrink .mixed_box > label + label, 
		#store_adddrink .mixed_box .temp_box {margin-top: 8px;}
		#store_adddrink .mixed_box > label, 
		#store_adddrink .code_box p {width: 100%; font-size: 18px;}
		#store_adddrink .mixed_box > label span, #store_adddrink .temp_box > span {display: inline-block; width: 140px; font-size: 18px;}
		#store_adddrink .mixed_box select {width: 100px; padding: 3px 0;}
		
		#store_adddrink .mixed_box .temp_box label + label {margin-left: 6px;}
		#store_adddrink .code_box {margin-top: 20px; display: flex; flex-wrap: wrap; align-items: center; justify-content: flex-start; gap: 10px 23px;}
		
		#store_adddrink .menu_list {margin-top: 20px; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;}
		#store_adddrink .menu_list li + li {border-top: 1px solid #ccc;}
		#store_adddrink .menu_list .menu_item {display: flex; align-items: center; justify-content: space-between; padding: 16px 30px;}
		#store_adddrink .menu_list .menu_item .menu_info {display: flex; align-items: center; gap: 30px;}
		#store_adddrink .menu_list .menu_item .img_box {width: 100px; height: 100px; border: 1px solid #ccc;}
		#store_adddrink .menu_list .menu_item .txt_box {width: 820px;}
		#store_adddrink .menu_list .menu_item .txt_box .txt_tit {font-size: 17px;}
		#store_adddrink .menu_list .menu_item .txt_box .txt_price {margin-top: 6px; font-size: 15px;}
		#store_adddrink .menu_list .menu_item .txt_box .txt_desc {margin-top: 6px; font-size: 14px; color: #555;}
		#store_adddrink .menu_list .menu_item .btn_box button {width: 80px; padding: 4px 0; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fff;}
    </style>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_adddrink" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>메뉴 추가</p>
            </div>
			
			<form name="f" method="post">
	            <div class="mixed_box">
	                <label>
	                    <span>구분 코드</span>
	                    <select name="menu_divide">
	                        <option value="">-</option>
	                        <option value="BD">BD</option>
	                        <option value="BL">BL</option>
	                        <option value="BR">BR</option>
	                        <option value="CB">CB</option>
	                        <option value="DC">DC</option>
	                        <option value="ES">ES</option>
	                        <option value="ET">ET</option>
	                        <option value="FP">FP</option>
	                        <option value="PJ">PJ</option>
	                        <option value="RF">RF</option>
	                    </select>
	                </label>
	                <label>
	                    <span>베이스코드 코드</span>
	                    <select name="menu_base">
	                        <option value="">-</option>
	                        <option value="B">B</option>
	                        <option value="C">C</option>
	                        <option value="D">D</option>
	                        <option value="E">E</option>
	                        <option value="F">F</option>
	                        <option value="L">L</option>
	                        <option value="M">M</option>
	                        <option value="N">N</option>
	                        <option value="P">P</option>
	                        <option value="W">W</option>
	                        <option value="Y">Y</option>
	                    </select>
	                </label>
	                <div class="temp_box">
	                	<span>ICE/HOT</span>
	                    <label>ICE
	                        <input type="checkbox" name="menu_temp" value="I">
	                    </label>
	                    <label>HOT
	                        <input type="checkbox" name="menu_temp" value="H">
	                    </label>
	                </div>
	                <input type="hidden" name="menuoptCode" value="">
	            </div>
			</form>

            <div class="code_box">
                <p>메뉴 코드</p>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
            </div>

            <ul class="menu_list">
                <li class="menu_item">
                    <div class="menu_info">
                        <div class="img_box">
                            <!-- <img src="" alt=""> -->
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">메뉴명</p>
                            <p class="txt_price">메뉴가격</p>
                            <p class="txt_desc">메뉴설명</p>
                        </div>
                    </div>
                    <div class="btn_box">
                        <button type="button">메뉴 추가</button>
                    </div>
                </li>
            </ul>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
<script>
    $('input[type="checkbox"]').on('click', function() {
       if ($(this).prop('checked')) {
           $('input[name="menu_divide"], input[name="menu_base"], input[name="menu_temp"]').prop('checked', false);
           $(this).prop('checked', true);
       }
    });
    
    
    
    $('select[name="menu_divide"], select[name="menu_base"], input[name="menu_temp"]').change(function() {
        let menuDivide = $("select[name='menu_divide']").val();
        let menuBase = $("select[name='menu_base']").val();
        let menuTemp = '';
        
        $("input[name='menu_temp']:checked").each(function() {
            menuTemp += $(this).val();
        });

        let menuOpt = menuDivide + menuBase + menuTemp;
        
        
    });

    
    
</script>