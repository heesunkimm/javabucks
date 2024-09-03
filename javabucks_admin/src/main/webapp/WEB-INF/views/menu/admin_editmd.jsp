<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_editdessert" class="content addmenu_cont">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>메뉴 상세정보</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="edit_from" action="admin_editmd" method="post" enctype="multipart/form-data">
                    <div class="info_box">
                        <label><span>메뉴코드</span>
                        	<input type="text" name="menuCode" value="${menu.menuCode}" readOnly>
                        </label>
                        <label><span>메뉴명</span>
                            <input type="text" name="menuName" value="${menu.menuName}" required>
                        </label>
                        <div class="upload_box">
                            <span>메뉴 사진</span>
                            <div>
                                <div class="img_box">
                                    <img id="preview_image" src="../../upload_menuImages/${menu.menuImages}" alt="" />
                                </div>
                                <div class="file_box">
                                    <input class="file_name" placeholder="첨부파일" readonly>
                                    <label for="file">사진찾기</label>
                                    <input type="file" id="file" name="uploadImages" value="" />
                                </div>
                    			<input type="hidden" name="menuImages" value="${menu.menuImages}">
                            </div>
                        </div>
                        <label class="menu_desc"><span>메뉴설명</span>
                           <textarea cols="50" rows="10" maxlength="80" name="menuDesc" placeholder="메뉴 설명을 입력해주세요(80자제한)" required>${menu.menuDesc}</textarea>
                        </label>
                        <label><span>메뉴가격</span>
                            <input type="text" name="menuPrice" value="${menu.menuPrice}">
                        </label>
                    </div>
                    <div class="btn_box">
                        <button class="add_btn" type="button" onclick="contCheck()">메뉴수정</button>
                        <button class="del_btn" type="button">메뉴삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- e: content -->
    <script>
    	// 유효성 체크
    	function contCheck() {
    	    let MCode = $("input[name='menuCode']").val().trim();
    	    let MName = $("input[name='menuName']").val().trim();
    	    let MDesc = $("textarea[name='menuDesc']").val().trim();
    	    let MPrice = $("input[name='menuPrice']").val().trim();
    	    
    		if (MCode == '') {
    	        alert("메뉴코드를 입력해주세요.");
    	        return false;
    	    } else if (MName == '') {
    	        alert("메뉴명을 입력해주세요.");
    	        return false;
    	    } else if (MDesc == '') {
    	        alert("메뉴설명을 입력해주세요.");
    	        return false;
    	    } else if (MPrice == '') {
    	        alert("메뉴가격을 입력해주세요.");
    	        return false;
    	    }
    		document.forms['edit_from'].submit();
    	    return true;
    	}
    
        // input 파일 커스텀
        $('#file').on('change', function() {
            var fileName = $(this).val().split('\\').pop();
            $('.file_name').val(fileName);
        });

	     // 이미지 미리보기 기능
	    $('#file').on('change', function() {
	        var file = this.files[0];
	        var reader = new FileReader();

	        reader.onload = function(e) {
	        	$('.preview_box').show();
	            $('#preview_image').attr('src', e.target.result).show();
	            let imagesName = $("input[name='uploadImages']").val();
				let fileName = imagesName.replace("C:\\fakepath\\", "");
				let menuImgs = $("input[name='menuImages']").val();
				
				$("input[name='menuImages']").val(fileName);
				menuImgs = $("input[name='menuImages']").val();
	        };
	        if (file) {
	            reader.readAsDataURL(file);
	        }
	    });
	    
		// 메뉴삭제 (상태업데이트)		
		$(".del_btn").on('click', function() {
			let menuCode = $("input[name='menuCode']").val();

		    let data = {
		        menuCode: menuCode
		    };
			
			$.ajax({
		        url: '${pageContext.request.contextPath}/delMd.ajax',
		        type: "POST",
		        data: JSON.stringify(data),
		        contentType: "application/json",
		        dataType: "text",
		        success: function (res) {
					if(res == "해당 메뉴가 삭제되었습니다.") {
						alert(res);
						window.location.href = '/admin_mdlist';
					}else {
						alert(res);
					}
		        },
		        error: function (xhr, status, err) {
		            console.error('AJAX 요청 실패:', status, err);
		        }
		    });
		});
    </script>
<jsp:include page="../admin_bottom.jsp"/>