<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_allmd" class="content allMenu">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>MD</p>
            </div>
            
            <div class="btn_box">
            	<a class="addbtn" href="/store_addmd">메뉴추가</a>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_cont">카테고리</a>
                    <a class="tab_btn" href="javascript:;" data-tab="menu_cont">메뉴명</a>
                </div>

                <div id="cate_cont" class="checkbox_cont tab-content s_active">
                    <form name="menuCateForm" method="post">
                        <div class="select_list">
                            <label>
                                <input type="checkbox" name="menu_cate" value="" checked>전체
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="TB">[TB] 텀블러
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="WD">[WD] 원두
                            </label>
                        </div>
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                        </ul>
                    </div>
                </div>
                <div id="menu_cont" class="searchbox_cont tab-content">
                    <div class="search_list">
                        <label>
                            <input type="text" name="menu_name" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button class="menuSearch" type="submit">검색</button>
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
	    
        $.ajax({
            url: '${pageContext.request.contextPath}/searchMd.ajax',
            type: 'POST',
            data: JSON.stringify({
                menu_cate: menuCate,
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
                        let btnClass = item.storeStatus === 'N' ? 'btn_disable' : '';
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
                                        '<button class="holdBtn' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storemenuStatus + '">' + btnText + '</button>' +
                                        '<button class="delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
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

	// 키워드 검색 시 일치하는 메뉴 리스트 불러오기 함수
	function searchKeyword() {
		let bucksId = `${inBucks.bucksId}`;
        let searchCont = $("input[name='menu_name']").val();

        $.ajax({
            url: '${pageContext.request.contextPath}/searchMdList.ajax',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
            	menu_name: searchCont,
                bucksId: bucksId
            }),
            success: function(res) {
                $(".searchbox_cont .menu_list").empty();  // 기존 리스트 비우기

                if (res.length > 0) {
                    res.forEach(function(item) {
                        let btnClass = item.storeStatus === 'N' ? 'btn_disable' : '';

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
			                            '<button class="holdBtn' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storemenuStatus + '">주문막기</button>' +
			                            '<button class="delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
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

            if ($btn === 'cate_cont') {
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