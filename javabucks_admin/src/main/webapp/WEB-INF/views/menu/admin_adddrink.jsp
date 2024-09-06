<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_adddrink" class="content addmenu_cont">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>메뉴등록</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="add_form" action="admin_adddrink" method="post" enctype="multipart/form-data">
                													<!-- 파일 전송시 필수작성 -->
                    <div class="info_box">
                        <label><span>구분코드</span>
                            <select name="menu_divide">
                                <option value="BD">[BD]블론드</option>
                                <option value="BL">[BL] 블랜디드</option>
                                <option value="BR">[BR] 브루드</option>
                                <option value="CB">[CB] 콜드브루</option>
                                <option value="DC">[DC] 디카페인</option>
                                <option value="ES">[ES] 에스프레소</option>
                                <option value="FP">[FP] 프라푸치노</option>
                                <option value="PJ">[PJ] 피지오</option>
                                <option value="RF">[RF] 리프레셔</option>
                                <option value="ET">[ET] 기타</option>
                            </select>
                        </label>
                        <label><span>베이스코드</span>
                            <select name="menu_base">
                                <option value="B">[B] 바닐라크림</option>
                                <option value="D">[D] 딸기</option>
                                <option value="E">[E] 멜론</option>
                                <option value="F">[F] 과일</option>
                                <option value="J">[J] 자몽</option>
                                <option value="L">[L] 라임</option>
                                <option value="M">[M] 우유</option>
                                <option value="N">[N] 에스프레소</option>
                                <option value="P">[P] 복숭아</option>
                                <option value="W">[W] 물</option>
                                <option value="Y">[Y] 요거트</option>
                                <option value="C">[C] 기타</option>
                            </select>
                        </label>
                        <div class="temp_box">
                            <span>ICE/HOT</span>
                            <label>
                                <input type="checkbox" name="menu_temp" value="I" checked>ICE
                            </label>
                            <label>
                                <input type="checkbox" name="menu_temp" value="H">HOT
                            </label>
                        </div>
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
    <script type="text/javascript">
    	// 유효성체크
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
	    
    	// 메뉴코드, 메뉴옵션 값 조합, 값넣기
	    function updateMenuOpt() {
	        let drinkDivide = $("select[name='menu_divide']").val();
	        let drinkBase = $("select[name='menu_base']").val();
	        let drinkTemp = $("input[name='menu_temp']:checked").val();
	        let drinkName = $("input[name='menuCode']").val();
	        let drinkcode = $("input[name='menu_namecode']").val().toUpperCase();
	
	        let drinkOptCodes = drinkDivide + drinkBase + drinkTemp;
	        let drinkCodes = 'B'+ drinkDivide + drinkBase + drinkTemp + drinkcode;
	        
	        $("input[name='menuoptCode']").val(drinkOptCodes);
	        $("input[name='menuCode']").val(drinkCodes);
	        
	        // 메뉴옵션코드
	        drinkOptCodes = $("input[name='menuoptCode']").val();
	        // 메뉴코드
	        drinkCodes = $("input[name='menuCode']").val();
	    }
	
	    $("select[name='menu_divide'], select[name='menu_base']").on('change', updateMenuOpt);
	
	    $('input[type="checkbox"]').on('click', function() {
	        if ($(this).prop('checked')) {
	            $('input[name="menu_temp"]').prop('checked', false);
	            $(this).prop('checked', true);
	            updateMenuOpt();
	        }
	    });

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
<jsp:include page="../admin_bottom.jsp"/>