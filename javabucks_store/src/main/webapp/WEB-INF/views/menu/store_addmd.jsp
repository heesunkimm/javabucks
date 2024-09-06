<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_addmd" class="content addmenu">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>메뉴 추가</p>
            </div>
            
            <div class="btn_box">
            	<a class="listbtn" href="/store_allmd">메뉴 목록 보기</a>
            </div>
            
            <form name="f" method="post">
	            <div class="mixed_box">
	                <label>
	                    <span>구분 코드</span>
	                    <select name="menu_divide">
	                        <option value="TB">[TB] 텀블러</option>
	                        <option value="WD">[WD] 원두</option>
	                    </select>
	                </label>
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
	    updateStatus();
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
		let bucksId = `${inBucks.bucksId}`;
		let selectedDivide = $('select[name="menu_divide"]').val();
	    let selectedOptCode = selectedDivide + 'NN'
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
	            
	            if(res.length === 0) {
	                $('.menu_list').append('<li class="menu_item noMenu">검색 결과에 해당하는 메뉴가 없습니다.</li>');
	            } else {
	                res.forEach(function(item) {
	                    let btnClass = item.storeEnable === 'N' ? 'btn_disable' : '';
	                    
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
	                                '<button class="menuAddBtn ' + btnClass + 
	                                '" data-store="' + bucksId + '" data-code="' + item.menuCode + 
	                                '" data-name="' + item.menuName + '" data-status="' + (item.storeEnable === 'N' ? 'N' : 'Y') + 
	                                '" type="button">메뉴 추가</button>' + 
	                            '</div>' + 
	                        '</li>'
	                    );
	                });
	            }

	            // 버튼 상태 업데이트
	            updateStatus();
	        },
	        error: function(err) {
	            console.log('Error: ', err);
	        }
	    });
	}
	
	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	function updateStatus() {
	    let bucksId = `${inBucks.bucksId}`;
	
	    $.ajax({
	        url: '${pageContext.request.contextPath}/getSelectedMenu.ajax',
	        type: 'GET',
	        data: { bucksId: bucksId },
	        dataType: 'json',
	        success: function(res) {
	            $('.menu_list .menu_item').each(function () {
	                let $btn = $(this).find('.menuAddBtn');
	                let menuCode = $btn.data('code');
	
	                let item = res.find(item => item.menuCode === menuCode);
	
	                if (item) {
	                    // 상태에 따라 버튼 클래스와 data-status 업데이트
	                    if (item.storeEnable === 'N') {
	                        $btn.addClass('btn_disable').attr('data-status', 'N');
	                    } else if (item.storeEnable === 'Y') {
	                        $btn.removeClass('btn_disable').attr('data-status', 'Y');
	                    }
	                }
	            });
	        },
	        error: function(err) {
	            console.log('Error: ', err);
	        }
	    });
	}
	
	// 메뉴 추가 버튼 클릭 시 이벤트
	$(document).on('click', '.menuAddBtn', function() {
	    let $btn = $(this);
	    let menuName = $btn.data('name');
	    let storeId = $btn.data('store');
	    let menuCode = $btn.data('code');
	
	    let data = {
	        bucksId: storeId,
	        menuCode: menuCode
	    };
	
	    // 이미 비활성화된 버튼 클릭 불가
	    if ($btn.hasClass('btn_disable')) {
	        return;
	    }
	
	    $.ajax({
	        url: '${pageContext.request.contextPath}/addMenu.ajax',
	        type: 'POST',
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        dataType: "json",
	        success: function(res) {
	        	// 지점 메뉴추가 알람
	            alert(res.status === "updated" ? "메뉴 상태가 업데이트되었습니다." : menuName + "지점 메뉴에 추가되었습니다.");
	            
	            if (res.status === "updated" || res.status === "added") {
	                // 버튼 상태 변경
	                if (res.storeEnable === "Y") {
	                    $btn.removeClass('btn_disable').attr('data-status', 'Y');
	                } else {
	                    $btn.addClass('btn_disable').attr('data-status', 'N');
	                }
	            }
                updateStatus();
	        },
	        error: function(err) {
	            console.log('Error: ', err);
	        }
	    });
	});
</script>