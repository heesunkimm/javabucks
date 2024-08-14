<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		#store_adddrink .mixed_box > label + label {margin-top: 6px;}
		#store_adddrink .mixed_box > label, #store_adddrink .code_box p {width: 100%; font-size: 18px;}
		#store_adddrink .mixed_box > label span {display: inline-block; width: 140px;}
		#store_adddrink .mixed_box select {width: 100px; padding: 3px 0;}
		
		#store_adddrink .mixed_box .temp_box label + label {margin-left: 6px;}
		#store_adddrink .mixed_box .temp_box {margin-top: 6px;}
		#store_adddrink .code_box {margin-top: 20px; display: flex; flex-wrap: wrap; align-items: center; justify-content: flex-start; gap: 10px 23px;}
		
		#store_adddrink .menu_list {margin-top: 20px; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;}
		#store_adddrink .menu_list li + li {border-top: 1px solid #ccc;}
		#store_adddrink .menu_list .menu_item {display: flex; align-items: center; justify-content: space-between; padding: 16px 30px;}
		#store_adddrink .menu_list .menu_item .menu_info {display: flex; align-items: center; gap: 30px;}
		#store_adddrink .menu_list .menu_item .img_box {width: 100px; height: 100px; border: 1px solid #ccc;}
		#store_adddrink .menu_list .menu_item .txt_box {width: 740px;}
		#store_adddrink .menu_list .menu_item .txt_box .txt_tit {font-size: 16px;}
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

            <div class="mixed_box">
                <label>
                    <span>구분 코드</span>
                    <select name="">
                        <option value=""></option>
                        <option value=""></option>
                    </select>
                </label>
                <label>
                    <span>베이스코드 코드</span>
                    <select name="">
                        <option value=""></option>
                        <option value=""></option>
                    </select>
                </label>
                <div class="temp_box">
                    <label>ICE
                        <input type="checkbox" name="" value="">
                    </label>
                    <label>HOT
                        <input type="checkbox" name="" value="">
                    </label>
                </div>
            </div>

            <div class="code_box">
                <p>메뉴 코드</p>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
                <label>FWH  아이스 플랫화이트
                    <input type="checkbox" name="" value="">
                </label>
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
           $('input[name="menu_divide"], input[name="menu_base"]').prop('checked', false);
           $(this).prop('checked', true);
       }
   });
</script>