<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <style>
    	/* store_alldrink */
		#store_alldrink .select_box, #store_alldrink .code_box {padding: 20px; border-radius: 4px;}
		#store_alldrink span, 
		#store_alldrink label, 
		#store_alldrink input, 
		#store_alldrink select, 
		#store_alldrink button {font-size: 18px;}
		
		#store_alldrink input[type="checkbox"] {width: 14px; height: 14px;}
		#store_alldrink .select_box > label + label {margin-top: 6px;}
		#store_alldrink .select_box > label, #store_alldrink .code_box p {width: 100%;}
		#store_alldrink .select_box > label span {display: inline-block; width: 140px;}
		#store_alldrink .select_box select {width: 100px; padding: 3px 0;}
		
		#store_alldrink .select_box .tab_box {display: flex; flex-wrap: wrap; gap: 16px; padding-bottom: 20px; border-bottom: 1px solid #ccc;}
		#store_alldrink .select_box .tab_box .tab_btn {display: inline-block; width: 110px; padding: 6px 0; border-radius: 4px; background: #ddd; font-size: 18px; text-align: center; color: #fefefe;}
		#store_alldrink .select_box .tab_box .tab_btn.tab_btn.s_active {background-color: #006241;}
		
		#store_alldrink .select_box .select_list {margin-top: 20px; display: flex; flex-wrap: wrap; align-items: center; gap: 10px 39px; padding: 20px; background-color: #f6f5ef;}
		#store_alldrink .select_box .select_list label {display: flex; align-items: center; gap: 12px; width: 180px;}
		
		#store_alldrink .select_box .cont_box {margin-top: 20px;}
		#store_alldrink .select_box .cont_box .select_tit {padding: 20px; background-color: #f6f5ef; font-size: 20px;}
		
		#store_alldrink #menu_cont form {padding: 20px 20px 0 20px;}
		#store_alldrink #menu_cont input {width: 300px; height: 27px; padding: 0 6px;}
		#store_alldrink #menu_cont button {width: 80px; padding: 4px 0; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fff;}
		
		#store_alldrink .menu_list {margin-top: 20px; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;}
		#store_alldrink .menu_list li + li {border-top: 1px solid #ccc;}
		#store_alldrink .menu_list .menu_item {display: flex; align-items: center; justify-content: space-between; padding: 16px 30px;}
		#store_alldrink .menu_list .menu_item .menu_info {display: flex; align-items: center; justify-content: space-between; gap: 30px;}
		#store_alldrink .menu_list .menu_item .img_box {width: 100px; height: 100px; border: 1px solid #ccc;}
		#store_alldrink .menu_list .menu_item .menu_info {display: flex; align-items: center; width: 760px;}
		#store_alldrink .menu_list .menu_item .txt_box {width: 600px;}
		#store_alldrink .menu_list .menu_item .txt_box .txt_tit {font-size: 16px;}
		#store_alldrink .menu_list .menu_item .txt_box .txt_desc {margin-top: 6px; font-size: 14px; color: #555;}
		#store_alldrink .menu_list .menu_item .btn_box button {width: 80px; padding: 4px 0; border-radius: 2px; background-color: #006241; font-size: 16px; color: #fff;}
    </style>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_alldrink" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>커피 및 음료</p>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_cont">카테고리</a>
                    <a class="tab_btn" href="javascript:;" data-tab="base_cont">베이스</a>
                    <a class="tab_btn" href="javascript:;" data-tab="menu_cont">메뉴명</a>
                </div>

                <div id="cate_cont" class="tab-content s_active">
                    <form name="" action="" method="post">
                        <div class="select_list">
                            <label>
                                <input type="checkbox" name="menu_divide" value="" checked>전체
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="ES">에스프레소
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="CB">콜드브루
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="BD">블론드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="DC">디카페인
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="PJ">피지오
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="RF">리프레셔
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="FP">프라푸치노
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="BL">블렌디드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="BR">브루드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_divide" value="ET">기타
                            </label>
                        </div>
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <!-- <img src="" alt=""> -->
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="base_cont" class="tab-content">
                    <form name="" action="" method="post">
                        <div class="select_list">
                            <label>
                                <input type="checkbox" name="menu_base" value="" checked>전체
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="W">물
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="M">우유
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="N">에스프레소
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="B">바닐라 크림
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="Y">요거트
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="">과일
                            </label>
                            <label>
                                <input type="checkbox" name="menu_base" value="C">기타
                            </label>
                        </div>
                        <input type="hidden" name="menu_base" value="D">
                        <input type="hidden" name="menu_base" value="E">
                        <input type="hidden" name="menu_base" value="F">
                        <input type="hidden" name="menu_base" value="J">
                        <input type="hidden" name="menu_base" value="L">
                        <input type="hidden" name="menu_base" value="P">
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <!-- <img src="" alt=""> -->
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="menu_cont" class="tab-content">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <!-- <img src="" alt=""> -->
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
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