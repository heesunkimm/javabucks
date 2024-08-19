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
		
		#store_adddrink .inner_wrap > .btn_box {margin-bottom: 20px; text-align: right;}
		#store_adddrink .inner_wrap > .btn_box a {display: inline-block; width: 120px; padding: 4px 0; border-radius: 2px; background-color: #006241; font-size: 16px; text-align: center; color: #fff;}
		
		#store_adddrink label {display: inline-flex; align-items: center; font-size: 16px;}
		#store_adddrink input[type="checkbox"] {margin-left: 12px; width: 15px; height: 15px;}
		#store_adddrink .mixed_box > label + label {margin-top: 10px;}
		#store_adddrink .mixed_box > label, #store_adddrink .code_box p {width: 100%; font-size: 18px;}
		#store_adddrink .temp_box > span, #store_adddrink .mixed_box > label span {display: inline-block; width: 100px;}
		#store_adddrink .mixed_box select {width: 100px; padding: 3px 0;}
		
		#store_adddrink .mixed_box .temp_box {margin-top: 10px;}
		#store_adddrink .mixed_box .temp_box label + label {margin-left: 6px;}
		#store_adddrink .code_box {margin-top: 20px; min-height: 55px;}
		#store_adddrink .code_box .code_list {margin-top: 10px; display: flex; flex-wrap: wrap; align-items: center; justify-content: flex-start; gap: 10px 23px;}
		
		#store_adddrink .menu_list {margin-top: 20px; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;}
		#store_adddrink .menu_list li + li {border-top: 1px solid #ccc;}
		#store_adddrink .menu_list .menu_item {display: flex; align-items: center; justify-content: space-between; padding: 16px 30px;}
		#store_adddrink .menu_list .menu_item.noMenu {justify-content: center;}
		
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
            
            <div class="btn_box">
            	<a class="listbtn" href="/store_alldrink">메뉴 목록 보기</a>
            </div>
            
            <form name="f" method="post">
	            <div class="mixed_box">
	                <label>
	                    <span>구분 코드</span>
	                    <select name="menu_divide">
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
	                    <span>베이스 코드</span>
	                    <select name="menu_base">
	                        <option value="B">B</option>
	                        <option value="C">C</option>
	                        <option value="D">D</option>
	                        <option value="E">E</option>
	                        <option value="F">F</option>
	                        <option value="J">J</option>
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
	                        <input type="checkbox" name="menu_temp" value="I" checked>
	                    </label>
	                    <label>HOT
	                        <input type="checkbox" name="menu_temp" value="H">
	                    </label>
	                </div>
	            </div>
	                <input type="hidden" name="menuoptCode" value="">
            </form>

            <ul class="menu_list">
                <li class="menu_item">
                	<!-- 해당 검색 결과에 맞는 메뉴 리스트 뿌려지는 곳 -->
                </li>
            </ul>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
<script>
	$(document).ready(function() {
	    getSelectMenu();
	});
	
	$('input[type="checkbox"]').on('click', function() {
	    if ($(this).prop('checked')) {
	        $('input[name="menu_temp"]').prop('checked', false);
	        $(this).prop('checked', true);
	    }
	    // 체크박스 변경시 메뉴 재정렬
	    getSelectMenu();
	});
	
	// select option 변경시 메뉴 재정렬
	$('select[name="menu_divide"], select[name="menu_base"]').change(getSelectMenu);
	
	// 선택된 옵션에 맞는 메뉴 실시간 리스트업
	function getSelectMenu() {
	    let selectedDivide = $('select[name="menu_divide"]').val();
	    let selectedBase = $('select[name="menu_base"]').val();
	    let selectedTemp = $('input[name="menu_temp"]:checked').val();
	    let selectedOptCode = selectedDivide + selectedBase + selectedTemp;
	    $('input[name="menuoptCode"]').val(selectedOptCode);
	    let menuOpt = $('input[name="menuoptCode"]').val();
	    
	    let data = {
	        menuoptCode: menuOpt
	    };
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/getSelectMenu.ajax',
	        type: 'POST',
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        dataType: "json",
	        success: function(res) {
	            $('.menu_list').empty();
	            
	            // 선택된 옵션에 해당하는 메뉴가 없을때
	            if(res.length === 0) {
	            	 $('.menu_list').append('<li class="menu_item noMenu">검색 결과에 해당하는 메뉴가 없습니다.</li>');
	            }else {
            	// 선택된 옵션에 해당하는 메뉴가 있을때
	                res.forEach(function(item) {
	                    $('.menu_list').append(
	                   		'<li class="menu_item">' + 
	                            '<div class="menu_info">' + 
	                                '<div class="img_box">' + 
	                                    '<img src="../../images/upload_menuImages/' + item.menuImages + '" alt="' + item.menuName + '">' + 
	                                '</div>' + 
	                                '<div class="txt_box">' + 
	                                    '<p class="txt_tit">' + item.menuName + '</p>' + 
	                                    '<p class="txt_desc">' + item.menuDesc + '</p>' + 
	                                '</div>' + 
	                            '</div>' + 
	                            '<div class="btn_box">' + 
	                                '<button class="menuAddBtn" data-store="bucks_1111" data-code="' + item.menuCode + '" type="button">메뉴 추가</button>' + 
	                            '</div>' + 
	                        '</li>'
	                    );
	                });
	            }
	        },
	        error: function(err) {
	            console.log('Error: ', err);
	        }
	    });
	}
	
	function changeBtn() {
	}
	
	// 메뉴 추가 버튼 클릭 시 이벤트
	$(document).on('click', '.menuAddBtn', function() {
	    let data = {
	    		bucksId: $(this).data('store'),
	    		menuCode: $(this).data('code')
	    }
	    
	    console.log(data.bucksId)
	    console.log(data.menuCode)
	    $.ajax({
	        url: '${pageContext.request.contextPath}/addMenu.ajax',
	        type: 'POST',
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        dataType: "text",
	        success: function(res) {
	        	console.log(res)
	        	/* changeBtn(); */
	        },
	        error: function(err) {
	            console.log('Error: ', err);
	        }
    	}); 
	});
		
		

</script>