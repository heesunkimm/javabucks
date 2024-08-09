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
                <form name="f" action="insertDrink" method="post" enctype="multipart/form-data">
                													<!-- 파일 전송시 필수작성 -->
                    <div class="info_box">
                        <label><span>구분코드</span>
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
                        <label><span>베이스코드</span>
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
                            <label>
                                <input type="checkbox" name="menu_temp" value="I" checked>ICE
                            </label>
                            <label>
                                <input type="checkbox" name="menu_temp" value="H">HOT
                            </label>
                        </div>
                        <label><span>메뉴코드</span>
                            <input type="text" name="menu_namecode" value="" style="text-transform: uppercase;" required>
                        </label>
                        <label><span>메뉴명</span>
                            <input type="text" name=menuName value="" maxlength="30" required>
                        </label>
                        <div class="upload_box">
                            <span>메뉴 사진</span>
                            <div>
                                <div class="preview_box img_box" style="display: none;">
                                    <img id="preview_image" src="/static/images/upload_menu/" alt="" style="display: none;" />
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
                        <button class="add_btn" type="submit">등록</button>
                        <button class="del_btn" type="button" onclick="window.location='admin_drinklist'">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- e: content -->
    <script type="text/javascript">
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

	        // 3자리마다 , 표시
	        if (value) {
	            value = parseInt(value, 10).toLocaleString('en-US');
	        }
	        $(this).val(value);
	    });
	    // 데이터 전송시 , 제거
	    $('#admin_adddrink form').on('submit', function(event) {
	        $('input[name="menuPrice"]').val(function(i, value) {
	            return value.replace(/,/g, '');
	        });
	    });
    </script>
<jsp:include page="../admin_bottom.jsp"/>