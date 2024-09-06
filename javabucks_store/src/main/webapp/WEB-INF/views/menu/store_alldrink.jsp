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

                <div id="cate_cont" class="checkbox_cont tab-content s_active">
                    <div class="select_list">
                        <label>
                            <input type="checkbox" name="menu_cate" value="" checked>전체
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="ES">[ES] 에스프레소
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="CB">[CB] 콜드브루
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BD">[BD] 블론드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="DC">[DC] 디카페인
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="PJ">[PJ] 피지오
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="RF">[RF] 리프레셔
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="FP">[FP] 프라푸치노
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BL">[BL] 블렌디드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BR">[BR] 브루드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="ET">[ET] 기타
                        </label>
                    </div>
                    <input type="hidden" name="menuoptCode" value="">

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                        	<!-- 카테고리 조건에 해당하는 음료 리스트 -->
                        </ul>
                    </div>
                </div>
                <div id="base_cont" class="checkbox_cont tab-content">
                    <div class="select_list">
                        <label>
                            <input type="checkbox" name="menu_base" value="" checked>전체
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="W">[W] 물
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="M">[M] 우유
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="N">[N] 에스프레소
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="B">[B] 바닐라 크림
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="Y">[Y] 요거트
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="F">[F] 과일
                        </label>
                        <label>
                            <input type="checkbox" name="menu_base" value="C">[C] 기타
                        </label>
                    </div>
                    <input type="hidden" name="menu_base" value="D">
                    <input type="hidden" name="menu_base" value="E">
                    <input type="hidden" name="menu_base" value="F">
                    <input type="hidden" name="menu_base" value="J">
                    <input type="hidden" name="menu_base" value="L">
                    <input type="hidden" name="menu_base" value="P">

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>베이스</p>
                        </div>

                        <ul class="menu_list">
                        	<!-- 베이스 조건에 해당하는 음료 리스트 -->
                        </ul>
                    </div>
                </div>
                <div id="menu_cont" class="searchbox_cont tab-content">
                	<div class="search_list">
                        <label>
                            <input type="text" name="menu_name" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button class="menuSearch" type="button">검색</button>
                	</div>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>메뉴</p>
                        </div>

                        <ul class="menu_list">
                        	<li class="menu_item noMenu">메뉴명을 검색하세요.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
<script>
	// 화면 접속완료 시 메뉴 리스트 로딩 함수 실행하여 디폴트 옵션 표출
	$(document).ready(function() {
        loadMenuList();
        checkAdminDisabledMenus();
		setInterval(checkAdminDisabledMenus, 10000);
    });
	
	// 체크박스 메뉴 리스트 로딩 함수
    function loadMenuList() {
    	let bucksId = `${inBucks.bucksId}`;
	    let menuCate = $('input[name="menu_cate"]:checked').val() || '';
	    let menuBase = $('input[name="menu_base"]:checked').val() || '';
	    
        $.ajax({
            url: '${pageContext.request.contextPath}/searchDrinks.ajax',
            type: 'POST',
            data: JSON.stringify({
                menu_cate: menuCate,
                menu_base: menuBase,
                bucksId: bucksId
            }),
            contentType: 'application/json',
            dataType: "json",
            success: function(res) {
                $('.checkbox_cont .menu_list').empty();
                
                // 선택된 옵션에 해당하는 메뉴가 없을때
                if(res.length === 0) {
                    $('.checkbox_cont .menu_list').append('<li class="menu_item noMenu">해당 조건에 부합하는 메뉴가 없습니다.</li>');
                } else {
                    // 선택된 옵션에 해당하는 메뉴가 있을때
                    res.forEach(function(item) {
                        let btnClass = item.storemenuStatus === 'N' ? 'btn_disable' : '';
                        let btnText = item.storemenuStatus === 'N' ? '주문풀기' : '주문막기';
                        
                        $('.checkbox_cont .menu_list').append(
                            '<li class="menu_item">' +
                                '<div class="menu_img img_box">' +
                                    '<img src="../../images/upload_menuImages/' + item.menuImages + '" alt="' + item.menuName + '">' +
                                '</div>' +
                                '<div class="menu_info">' +
                                    '<div class="txt_box">' +
                                        '<p class="txt_tit">' + item.menuName + '</p>' +
                                        '<p class="txt_desc">' + item.menuDesc + '</p>' +
                                    '</div>' +
                                    '<div class="btn_box">' +
                                        '<button class="btns holdBtn ' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storemenuStatus + '">' + btnText + '</button>' +
                                        '<button class="btns delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
                                    '</div>' +
                                '</div>' +
                            '</li>'
                        );
                    });
                }
                bindEvents();
	        	updateStatus();
	        	checkAdminDisabledMenus();
            },
            error: function(err) {
                console.log("Error: ", err);
            }
        });
    }
	
	// 카테고리 체크박스 조건 선택시 메뉴 리스트 재정렬
	$('input[name="menu_cate"]').on('change', function() {
    	let menuCate = $(this).val();

    	$('input[name="menu_cate"]').not(this).prop('checked', false);
        if ($('input[name="menu_cate"]:checked').length === 0) {
            $(this).prop('checked', true);
        }
        
        loadMenuList();
    });

	// 카테고리 체크박스 조건 선택시 메뉴 리스트 재정렬
    $('input[name="menu_base"]').on('change', function() {
   		let menuBase = $(this).val();
   		
       	$('input[name="menu_base"]').not(this).prop('checked', false);
        if ($('input[name="menu_base"]:checked').length === 0) {
			$(this).prop('checked', true);
        }
        
        loadMenuList();
	});

	// 키워드 검색 시 일치하는 메뉴 리스트 불러오기 함수
	function searchKeyword() {
		let bucksId = `${inBucks.bucksId}`;
        let searchCont = $("input[name='menu_name']").val();

        $.ajax({
            url: '${pageContext.request.contextPath}/searchDrinksList.ajax',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
            	menu_name: searchCont,
                bucksId: bucksId
            }),
            success: function(res) {
                $(".searchbox_cont .menu_list").empty(); // 기존 리스트 비우기

                if (res.length > 0) {
                    res.forEach(function(item) {
                        let btnClass = item.storemenuStatus === 'N' ? 'btn_disable' : '';

                        $('.searchbox_cont .menu_list').append(
                            '<li class="menu_item">' +
	                            '<div class="menu_img img_box">' +
	                            	'<img src="../../images/upload_menuImages/' + item.menuImages + '" alt="' + item.menuName + '">' +
	                            '</div>' +
	                            '<div class="menu_info">' +
		                            '<div class="txt_box">' +
			                            '<p class="txt_tit">' + item.menuName + '</p>' +
			                            '<p class="txt_desc">' + item.menuDesc + '</p>' +
		                            '</div>' +
		                            '<div class="btn_box">' +
			                            '<button class="btns holdBtn ' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storemenuStatus + '">주문막기</button>' +
			                            '<button class="btns delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
		                            '</div>' +
	                            '</div>' +
                            '</li>'
                        );
                    });
                    bindEvents();
                    updateStatus();
                } else {
                    $(".searchbox_cont .menu_list").append('<li class="menu_item noMenu">해당하는 검색어와 일치하는 메뉴가 없습니다.</li>');
                }
            },
            error: function(err) {
                console.log("Error: ", err);
            }
        });
    }
	
	 // 검색 버튼 클릭 시 메뉴 리스트 불러오기 함수 실행
    $(".search_list .menuSearch").on('click', function() {
    	searchKeyword();
    });

    // 엔터키 클릭 시 메뉴 리스트 불러오기 함수 실행
    $(".search_list input").on('keydown', function(e) {
        if (e.which === 13) {
            e.preventDefault();
            searchKeyword();
        }
    });
    
    // 다른 탭 이동시 검색 창, 리스트 리셋
    $(".tab_btn").each(function() {
        $(this).click(function(e) {
            let $btn = $(this).data('tab');

            if ($btn === 'cate_cont' || $btn === 'base_cont') {
                loadMenuList();
            } else if ($btn === 'menu_cont') {
                $(".searchbox_cont .search_list input").val("");
                $(".searchbox_cont .menu_list").empty();
                $('.searchbox_cont .menu_list').append('<li class="menu_item noMenu">메뉴명을 검색하세요.</li>');
            }
        });
    })
	
	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	function updateStatus() {
    	let bucksId = `${inBucks.bucksId}`;
    	
	    $.ajax({
	        url: '${pageContext.request.contextPath}/getSelectedMenu.ajax',
	        type: 'GET',
	        data: {bucksId: bucksId},
	        dataType: 'json',
	        success: function(res) {
	            // 메뉴 리스트 새로 업데이트
	            $('.menu_list .menu_item').each(function () {
                    let $btn = $(this).find('.holdBtn');
                    let menuCode = $btn.data('code');
                    let menuStatus = $btn.data('status');
                    

                    let item = res.find(item => item.menuCode === menuCode);
                    
                    if (item) {
                        let btnClass = menuStatus === 'N' ? 'btn_disable' : '';
                        if(menuStatus === 'N'){
                        	$btn.addClass("btn_disable").text("주문풀기");
                        }else {
                        	$btn.removeClass("btn_disable").text("주문막기");
                        }
                    }
                });
	        },
	        error: function(err) {
	            console.error('AJAX 요청 실패:', err);
	        }
	    });
	}
    
    // 주문막기, 메뉴삭제 함수
	function bindEvents() {
		// 주문막기 버튼 선택 시 이벤트 처리
		$('.menu_list .holdBtn').off('click').on('click', function() {
			let bucksId = `${inBucks.bucksId}`;
			let $btn = $(this);
			let menuCode = $(this).data('code');
			let menuStatus = $(this).data('status');
	        let newStatus = menuStatus === 'N' ? 'Y' : 'N'; // 메뉴 상태 변경
	        let menuCate = $('input[name="menu_cate"]:checked').val() || '';
	        let menuBase = $('input[name="menu_base"]:checked').val() || '';
			
			$.ajax({
	    	    url: '${pageContext.request.contextPath}/menuStatusUpdate.ajax',
	    	    type: 'POST',
	    	    data: JSON.stringify({
	    	    	menuCode: menuCode,
	    	    	storemenuStatus: newStatus, // 변경된 상태 전송
	    	        bucksId: bucksId
	    	    }),
	    	    contentType: 'application/json',
		        dataType: "text",
		        success: function(res) {
		        	// 메뉴 주문막기 alert
		        	alert(res);
		        	if ($('#menu_cont').hasClass('s_active')) {
		            	// 메뉴명탭 활성화시 실행
	                    searchKeyword();
	                } else {
		            	// 카테고리, 베이스 탭 활성화시 실행
	                    loadMenuList();
	                }
		        },
	    	    error: function(err) {
	    	        console.log("Error: ", err);
	    	    }
	    	});
		})
		
		// 메뉴삭제 버튼 클릭 시 이벤트 처리
		$('.menu_list .delBtn').off('click').on('click', function() {
			let bucksId = `${inBucks.bucksId}`;
	        let menuCode = $(this).data('code');
	        let menuCate = $('input[name="menu_cate"]:checked').val() || '';
	        let menuBase = $('input[name="menu_base"]:checked').val() || '';
	    
	        $.ajax({
	            url: '${pageContext.request.contextPath}/deleteMenu.ajax',
	            type: 'POST',
	            data: JSON.stringify({
	                menuCode: menuCode,
	                bucksId: bucksId
	            }),
	            contentType: 'application/json',
	            dataType: "text",
	            success: function(res) {
	            	// 메뉴 삭제 alert
	                alert(res);
	                if ($('#menu_cont').hasClass('s_active')) {
		            	// 메뉴명탭 활성화시 실행
	                    searchKeyword();
	                } else {
		            	// 카테고리, 베이스 탭 활성화시 실행
	                    loadMenuList();
	                }
	            },
	            error: function(err) {
	                console.log("Error: ", err);
	            }
	        });
	    });
    }
    
    // 어드민에서 주문막기 처리된 메뉴 딤처리 함수
	function checkAdminDisabledMenus() {
	    let bucksId = `${inBucks.bucksId}`;
	
	    $.ajax({
	        url: '${pageContext.request.contextPath}/adminMenuDisableCheck.ajax',
	        type: 'POST',
	        data: JSON.stringify({ bucksId: bucksId }),
	        contentType: 'application/json',
	        dataType: 'json',
	        success: function(res) {
	            res.forEach(function(item) {
	                $('.menu_list .menu_item').each(function() {
	                    let btns = $(this).find('.btns');
	                    let menuCode = $(this).find('.holdBtn').data('code');
	
	                    if (item.menuCode === menuCode) {
	                        $(this).addClass('menu_dimm');
	                        btns.prop('disabled', true);
	                    }
	                });
	            });
	        },
	        error: function(err) {
	            console.error('AJAX 요청 실패:', err);
	        }
	    });
	};
</script>