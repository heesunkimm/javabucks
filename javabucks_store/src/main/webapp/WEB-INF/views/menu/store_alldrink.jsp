<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_alldrink" class="content allMenu">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>커피 및 음료</p>
            </div>
            
            <div class="btn_box">
            	<a class="addbtn" href="/store_adddrink">메뉴추가</a>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_cont">카테고리</a>
                    <a class="tab_btn" href="javascript:;" data-tab="base_cont">베이스</a>
                    <a class="tab_btn" href="javascript:;" data-tab="menu_cont">메뉴명</a>
                </div>

                <div id="cate_cont" class="tab-content s_active">
                    <form name="menuCateForm" method="post">
                        <div class="select_list">
                            <label>
                                <input type="checkbox" name="menu_cate" value="" checked>전체
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="ES">에스프레소
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="CB">콜드브루
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BD">블론드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="DC">디카페인
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="PJ">피지오
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="RF">리프레셔
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="FP">프라푸치노
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BL">블렌디드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BR">브루드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="ET">기타
                            </label>
                        </div>
                        <input type="hidden" name="menuoptCode" value="">
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <img src="../../images/upload_menuImages" alt="">
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                        <button class="delBtn" type="button">메뉴삭제</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="base_cont" class="tab-content">
                    <form name="menuBaseForm" method="post">
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
                                    <img src="../../images/upload_menuImages" alt="">
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                        <button type="button">메뉴삭제</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="menu_cont" class="tab-content">
                    <form name="menuNameForm" method="post">
                        <label>
                            <input type="text" name="menuName" value="" placeholder="메뉴명을 입력하세요.">
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
                                    <img src="../../images/upload_menuImages" alt="">
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                        <button type="button">메뉴삭제</button>
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
	/* $('input[type="checkbox"]').on('change', function() {
		if ($(this).prop('checked')) {
	        $('input[name="menu_cate"], input[name="menu_base"]').prop('checked', false);
	        $(this).prop('checked', true);
	    }
		
	    let formData = $('form[name="menuCateForm"], form[name="menuBaseForm"]').serialize();
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/searchDrinks.ajax',
	        type: 'POST',
	        data: formData,
	        dataType: 'json',
	        success: function(res) {
	        	console.log(res)
	        	
	            if (res.noList) {
	                $('.menu_list').html('<p>검색 결과가 없습니다.</p>');
	            } else {
	                let html = '';
	                response.drinkList.forEach(drink => {
	                    html += `<li class="menu_item">
	                                <div class="menu_img img_box">
	                                    <img src="../../images/upload_menuImages" alt="">
	                                </div>
	                                <div class="menu_info">
	                                    <div class="txt_box">
	                                        <p class="txt_tit">${drink.menuName}</p>
	                                        <p class="txt_desc">${drink.menuDescription}</p>
	                                    </div>
	                                    <div class="btn_box">
	                                        <button type="button">주문막기</button>
	                                        <button class="delBtn" type="button">메뉴삭제</button>
	                                    </div>
	                                </div>
	                            </li>`;
	                });
	                $('.menu_list').html(html);
	            }
	        },
	        error: function(err) {
	            console.error('Error:', err);
	        }
	    });
	}); */
	
	// 검색창에서 입력 후 검색 버튼 클릭 시 메뉴 리스트를 불러오는 함수
	/* $('form[name="menuNameForm"]').on('submit', function(e) {
	    e.preventDefault();
	    
	    $('input[name="menu_cate"], input[name="menu_base"]').prop('checked', false);
	    
	    let formData = $(this).serialize();
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/searchDrinks.ajax',
	        type: 'POST',
	        data: formData,
	        dataType: 'json',
	        success: function(res) {
	            if (res.noList) {
	                $('.menu_list').html('<p>검색 결과가 없습니다.</p>');
	            } else {
	                let html = '';
	                response.drinkList.forEach(drink => {
	                    html += `<li class="menu_item">
	                                <div class="menu_img img_box">
	                                    <img src="../../images/upload_menuImages" alt="">
	                                </div>
	                                <div class="menu_info">
	                                    <div class="txt_box">
	                                        <p class="txt_tit">${drink.menuName}</p>
	                                        <p class="txt_desc">${drink.menuDescription}</p>
	                                    </div>
	                                    <div class="btn_box">
	                                        <button type="button">주문막기</button>
	                                        <button type="button">메뉴삭제</button>
	                                    </div>
	                                </div>
	                            </li>`;
	                });
	                $('.menu_list').html(html);
	            }
	        },
	        error: function(err) {
	            console.error('Error:', err);
	        }
	    });
	}); */
</script>