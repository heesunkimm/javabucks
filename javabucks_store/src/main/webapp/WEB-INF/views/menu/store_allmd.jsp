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
                                <input type="checkbox" name="menu_cate" value="TB">텀블러
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="WD">원두
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
    <input type="hidden" name="bucksId" value="bucks_1111">
    </section>
    <!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
<script>
	// 로그인 매장 변수 선언
	let bucksId =$("input[name='bucksId']").val();
	
	// 디폴트 옵션 - 전체보기
	let defaultMenuCate = '';
	
	// 화면 접속완료 시 메뉴 리스트 로딩 함수 실행하여 디폴트 옵션 표출
	$(document).ready(function() {
        loadMenuList(defaultMenuCate);
    });
	
	// 메뉴 리스트 로딩 함수
    function loadMenuList(menuCate) {
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
                        /* let btnDisabled = item.storeStatus === 'Y' ? 'disabled' : ''; */
                        
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
                                        '<button class="holdBtn' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storeStatus + '">주문막기</button>' +
                                        '<button class="delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
                                    '</div>' +
                                '</div>' +
                            '</li>'
                        );
                    });
                }
                bindEvents();
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
	        	let menuCate = $('input[name="menu_cate"]:checked').val();

	            if (menuCate === '') {
	                menuCate = defaultMenuCate;
	            }

	            loadMenuList(menuCate, '');
	        },
    	    error: function(err) {
    	        console.log("Error: ", err);
    	    }
    	});
    });
	
	// 키워드 검색 시 일치하는 메뉴 리스트 불러오기 함수
	function searchKeyword() {
        let searchCont = $("input[name='menu_name']").val();

        $.ajax({
            url: '${pageContext.request.contextPath}/searchMdList.ajax',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                menuName: searchCont,
                bucksId: bucksId
            }),
            success: function(res) {
                console.log(res);
                
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
                                    '<button class="holdBtn' + btnClass + '" type="button" data-code="' + item.menuCode + '" data-status="' + item.storeStatus + '">주문막기</button>' +
                                    '<button class="delBtn" type="button" data-code="' + item.menuCode + '">메뉴삭제</button>' +
                                    '</div>' +
                                '</div>' +
                            '</li>'
                        );
                    });
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
			
			if($btn === 'cate_cont') {
				$(".searchbox_cont .search_list input").val("");
				$(".searchbox_cont .menu_list").empty();
				$('.searchbox_cont .menu_list').append('<li class="menu_item noMenu">메뉴명을 검색하세요.</li>');
			}
		});
	})
	
	function bindEvents() {
		// 주문막기 버튼 선택 시 이벤트 처리
		$('.menu_list .holdBtn').off('click').on('click', function() {
			let menuCode = $(this).data('code');
			let menuStatus = $(this).data('status');
				console.log("메뉴코드: " + menuCode)
				console.log("메뉴상태: " + menuStatus)
			
			$.ajax({
	    	    url: '${pageContext.request.contextPath}/menuStatusUpdate.ajax',
	    	    type: 'POST',
	    	    data: JSON.stringify({
	    	    	menuCode: menuCode,
	    	    	storemenuStatus: menuStatus,
	    	        bucksId: bucksId
	    	    }),
	    	    contentType: 'application/json',
		        dataType: "text",
		        success: function(res) {
		        	// 메뉴 삭제 alert
		        	console.log(res)
		        	//alert(res);
		        	//loadMenuList();
		        },
	    	    error: function(err) {
	    	        console.log("Error: ", err);
	    	    }
	    	});
		})
		
		// 메뉴삭제 버튼 클릭 시 이벤트 처리
		$('.menu_list .delBtn').off('click').on('click', function() {
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
	                loadMenuList(menuCate, menuBase);
	            },
	            error: function(err) {
	                console.log("Error: ", err);
	            }
	        });
	    });
    }
</script>