<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_adddessert" class="content addmenu_cont">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>메뉴등록</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="add_form" action="admin_adddessert" method="post" enctype="multipart/form-data">
                													<!-- 파일 전송시 필수작성 -->
                    <div class="info_box">
                        <label><span>구분코드</span>
                            <select name="menu_divide">
                                <option value="CK">[CK] 케이크</option>
                                <option value="SD">[SD] 샌드위치</option>
                            </select>
                        </label>
                        <label><span>메뉴코드</span>
                            <input type="text" name="menu_namecode" value="" style="text-transform: uppercase;" maxlength="3" required>
                        </label>
                        <label><span>메뉴명</span>
                            <input type="text" name=menuName value="" maxlength="30" required>
                        </label>
                        <div class="upload_box">
                            <span>메뉴 사진</span>
                            <div>
                                <div class="preview_box img_box" style="display: none;">
                                    <img id="preview_image" src="" alt="" style="display: none;" />
                                </div>
                                <div class="file_box">
                                    <input class="file_name" placeholder="첨부파일" readonly>
                                    <label for="file">사진찾기</label>
                                    <input type="file" id="file" name="uploadImages" value="" />
                                </div>
                            </div>
                        </div>
                        <label class="menu_desc"><span>메뉴설명</span>
                           <textarea cols="50" rows="10" maxlength="80" name="menuDesc" placeholder="메뉴 설명을 입력해주세요(80자제한)"></textarea>
                        </label>
                        <label><span>메뉴가격</span>
                            <input type="text" name="menuPrice" value="">
                        </label>
                    </div>
                    <!-- 메뉴코드 합친 값 넣기 -->
                    <input type="hidden" name="menuCode" value="">
                    <input type="hidden" name="menuImages" value="">
                    <input type="hidden" name="menuEnable" value="">
                    <input type="hidden" name="menuoptCode" value="Y">
                    <div class="btn_box">
                        <button class="add_btn" type="button" onclick="contCheck()">등록</button>
                        <button class="del_btn" type="button" onclick="window.location='admin_drinklist'">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- e: content -->
<jsp:include page="../admin_bottom.jsp"/>
<script type="text/javascript">
	//유효성체크
	function contCheck() {
	    let MNameCode = $("input[name='menu_namecode']").val().trim();
	    let MName = $("input[name='menuName']").val().trim();
	    let MImages = $("input[name='menuImages']").val().trim();
	    let MDesc = $("textarea[name='menuDesc']").val().trim();
	    let MPrice = $("input[name='menuPrice']").val().trim();
	    
		if (MNameCode == '') {
	        alert("메뉴코드를 입력해주세요.");
	        return false;
	    } else if (MName == '') {
	        alert("메뉴명을 입력해주세요.");
	        return false;
	    } else if (MName == '') {
	        alert("메뉴 이미지를 등록해주세요.");
	        return false;
	    } else if (MDesc == '') {
	        alert("메뉴설명을 입력해주세요.");
	        return false;
	    } else if (MPrice == '') {
	        alert("메뉴가격을 입력해주세요.");
	        return false;
	    }
		document.forms['add_form'].submit();
	    return true;
	}
	
	//메뉴코드, 메뉴옵션 값 조합, 값넣기
	function updateMenuOpt() {
	    let dessertDivide = $("select[name='menu_divide']").val();
	    let dessertName = $("input[name='menuCode']").val();
	    let dessertCode = $("input[name='menu_namecode']").val().toUpperCase();
	
	    let dessertOptCodes = dessertDivide + "NN";
	    let dessertCodes = 'C'+ dessertOptCodes + dessertCode;
	    
	    $("input[name='menuoptCode']").val(dessertOptCodes);
	    $("input[name='menuCode']").val(dessertCodes);
	    
	    // 메뉴옵션코드
	    dessertOptCodes = $("input[name='menuoptCode']").val();
	    // 메뉴코드
	    dessertCodes = $("input[name='menuCode']").val();
	}
	
	$("select[name='menu_divide']").on('change', updateMenuOpt);
	
	$('input[name="menu_namecode"]').on('input', function() {
	    // 입력값에서 영어만 남기고 제거
	    let value = $(this).val().replace(/[^a-zA-Z]/g, '');
	    $(this).val(value);
	    updateMenuOpt();
	});
	
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
    
 	// 메뉴가격 입력 이벤트
    $('input[name="menuPrice"]').on('input', function() {
        // 입력값에서 숫자만 남기고 제거
        let value = $(this).val().replace(/[^\d]/g, '');
        $(this).val(value);
    });
</script>