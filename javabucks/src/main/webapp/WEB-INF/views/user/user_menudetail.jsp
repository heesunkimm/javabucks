<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_menudetail" class="content">
				<form name="optplus" action="user_paynow" method="POST">
					<input type="hidden" name="menuCode" value="${menu.menuCode}">
					<input type="hidden" name="menuoptCode" value="${menu.menuoptCode}">
					<input type="hidden" name="bucksId" value="${bucksId}">
					<input type="hidden" name="storeName" value="${storeName}">
					<input type="hidden" name="pickup" value="${pickup}">
		        <div class="inner_wrap">
		            <div class="menu_img img_box">
		                <img src="upload_menuImages/${menu.menuImages}" alt="">
		            </div>
		
		            <div class="txt_box">
		                <p class="txt_tit">${menu.menuName}</p>
		                <p class="txt_price"><fmt:formatNumber value="${menu.menuPrice}" pattern="#,###"/>원</p>
		                <p class="txt_desc">${menu.menuDesc}</p>
						<c:if test= "${not empty mymenuCheck}" >
			                <button class="addlike" type="button" onclick="addMyMenu(this)">
			                    <img src="../images/icons/like2.png" alt="">
			                </button>
						</c:if>
						<c:if test= "${empty mymenuCheck}" >
			                <button class="addlike" type="button" onclick="addMyMenu(this)">
			                    <img src="../images/icons/like.png" alt="">
			                </button>
						</c:if>
		            </div>
					<c:if test="${drink eq 'drink'}">
		            	<p class="opt_wrap__tit">퍼스널옵션</p>
		            </c:if>
		            <div class="opt_wrap">
		                <!-- 옵션박스 -->
		                <div class="size_box opt_box">
		                </div>
		                
		                 <!-- 옵션: 컵 -->
		                <c:if test="${not empty cup}">
		                <div class="opt_box">
		                    <p class="opt_tit">사이즈 : 기본 가격은 Tall (size up +500원) </p>
		                    <div class="opt_rows">
		                        <div class="select_box">
		                        	<c:forEach var ="cup" items="${cup}">
		                        	<label>
		                                <input type="button" class ="btn" name="cupType" data-cupNum="${cup.cupNum}" data-cupType="${cup.cupType}">
		                                <span>${cup.cupType}</span>
		                            </label>
		                            </c:forEach>                                                    
		                        </div>
		                    </div>
		                </div>
		                </c:if>
		
		                <!-- 옵션: 커피 -->
		                <c:if test="${not empty shot}">
		                <div class="opt_box">
		                    <p class="opt_tit">샷추가(추가 샷당 +600원)</p>
		                    <div class="opt_rows">
		                        <p>${shot.shotType}</p>
		                        <div class="count_box">
		                            <div class="minus_btn click_icon img_box">
		                                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('shot_count')">
		                            </div>
		                            <label>
		                                <input type="text" id="shot_count" name="optShotCount" value="0" readonly>
		                                <input type="hidden" name="shotNum" value="${shot.shotNum}">
		                            </label>
		                            <div class="plus_btn click_icon img_box">
		                                <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('shot_count')">
		                            </div>
		                        </div>
		                    </div>
		                </div>
						</c:if>
						
		                <!-- 옵션: 시럽 -->
		                <c:if test="${not empty syrup}">
		                <div class="opt_box">
		                    <p class="opt_tit">시럽 추가(종류 선택 하나만, 추가 샷당 +600원)</p>
		                    <c:forEach var ="syrup" items="${syrup}">
		                    <div class="opt_rows">
		                        <p>${syrup.syrupType}</p>
		                        <div class="count_box">
		                            <div class="minus_btn click_icon img_box">
						                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('${syrup.syrupType}_count')">
						            </div>
						            <label>
						                <input type="text" id="${syrup.syrupType}_count" name="optSyrupCount_${syrup.syrupNum}" value="0" readonly>
						                <input type="hidden" id="${syrup.syrupNum}" name="" value="0">
						            </label>
						            <div class="plus_btn click_icon img_box">
						                <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('${syrup.syrupType}_count')">
						            </div>
		                        </div>
		                    </div>
		                    </c:forEach>                                    
		                </div>
		                </c:if>
		                
		                <!-- 옵션: 얼음 -->
		                <c:if test="${not empty ice}">
		                <div class="opt_box">
		                    <p class="opt_tit">얼음량</p>
		                    <div class="opt_rows">
		                        <div class="select_box">
		                        	<c:forEach var ="ice" items="${ice}">
		                            <label>
		                                <input type="button" class ="btn" name="iceType" data-iceNum="${ice.iceNum}" data-iceType="${ice.iceType}">
		                                <span>${ice.iceType}</span>
		                            </label>
		                            </c:forEach>                                      
		                        </div>
		                    </div>
		                </div>
						</c:if>
						
		                <!-- 옵션: 우유 -->
		                <c:if test="${not empty milk}">
		                <div class="opt_box">
		                    <p class="opt_tit">우유 종류 (단, 귀리는 +600원)</p>
		                    <div class="opt_rows">
		                        <div class="select_box">
		                        	<c:forEach var ="milk" items="${milk}">
		                            <label>
		                                <input type="button" class ="btn" name="milkType" data-milkNum="${milk.milkNum}" data-milkType="${milk.milkType}">
		                                <span>${milk.milkType}</span>
		                            </label>
		                            </c:forEach>                            
		                        </div>
		                    </div>
		                </div>                           
						</c:if>
						
						<!-- 옵션: 휘핑 크림 -->
						<c:if test="${not empty whip}">
		                <div class="opt_box">
		                    <p class="opt_tit">휘핑 크림 추가 (+600원)</p>
		                    <div class="opt_rows">
		                        <div class="select_box">
		                        	<c:forEach var ="whip" items="${whip}">
		                            <label>
		                                <input type="button" class ="btn" name="whipType" data-whipNum="${whip.whipNum}">
		                                <span>${whip.whipType}</span>
		                            </label>
		                            </c:forEach>
		                        </div>
		                    </div>
		                </div>
		                </c:if>
		                <input type="hidden" name="optId" id="optId">
		                <input type="hidden" name="cart" id="cart">
		                <input type="hidden" name="cupNum" id="cupNum">
		                <input type="hidden" name="iceNum" id="iceNum">
		                <input type="hidden" name="milkNum" id="milkNum">
		                <input type="hidden" name="whipNum" id="whipNum">
		                <input type="hidden" name="syrupNum" id="syrupNum">
		                <input type="hidden" name="optSyrupCount" id="optSyrupCount">
		            </div>
		        </div>
		            <div class="order_box">
		                <div class="count_box">
			                <div class="minus_btn click_icon img_box">
			                	<img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('quantity')">
			                </div>
		                	<label>
		                		<input type="text" id="quantity" name="quantity" value="1" readonly>
		                	</label>
			                <div class="plus_btn click_icon img_box">
			                	<img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('quantity')">
			                </div>
		                </div>
		                <div class="btn_box">
			                <button class="cartBtn" type="button" onclick="orderCheck('cart')">담기</button>
			                <button class="orderBtn" type="button" onclick="orderCheck('order')">주문하기</button>
		                </div>
		            </div>
			</form>
			<!-- 장바구니 팝업 -->
	        <div class="popup_box cart_popup" id="pickupselect" style="display: none;">
	            <a class="close_btn" href="javascript:;" data-popup="pickupselect" style="display: inline-block;">
	                <img src="../images/icons/close.png" alt="">
	            </a>
	            <div class="tit_box">
	                <p class="txt_tit">장바구니에 추가되었습니다.</p>
	            </div>
	            <form name="f" action="user_order" method="post">
	                <!-- s: 내용 작성 -->
	                 <input type="hidden" name="store" value="">
	                 <input type="hidden" name="pickup" value="">
	                 <input type="hidden" name="storeName" value="">
	                 <input type="hidden" name="bucksId" value="">
	                 <div class="select_box">
	                    <a class="select_btn" href="javascript:;" onclick="window.location.href='user_cart?pickup=${pickup}';">
	                    	장바구니 확인
	                    </a>
	                    <a class="select_btn" href="javascript:;" onclick="window.location.href='user_order?pickup=${pickup}&storeName=${storeName}&bucksId=${bucksId}';">
		                    둘러보기
	                    </a>
	                 </div>
	                <!-- e: 내용 작성 -->
	            </form>
	        </div>
	        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', (event) => {
	    // 서버에서 전달받은 기본값을 사용하여 버튼 선택
	    const defaultCupType = "Tall";
	    const defaultIceType = "보통";
	    const defaultMilkType = "일반 우유";
	
	    // 컵 사이즈 기본값 설정
	    document.querySelectorAll('.opt_box .btn[data-cupType]').forEach(button => {
	        if (button.getAttribute('data-cupType') === defaultCupType) {
	            button.classList.add('active');
	            button.click();
	        }
	    });
	
	    // 얼음량 기본값 설정
	    document.querySelectorAll('.opt_box .btn[data-iceType]').forEach(button => {
	        if (button.getAttribute('data-iceType') === defaultIceType) {
	            button.classList.add('active');
	            button.click();
	        }
	    });
	
	    // 우유 기본값 설정
	    document.querySelectorAll('.opt_box .btn[data-milkType]').forEach(button => {
	        if (button.getAttribute('data-milkType') === defaultMilkType) {
	            button.classList.add('active');
	            button.click();
	        }
	    });
	});

	document.querySelectorAll('.opt_box .btn').forEach(button => {
	    button.addEventListener('click', function() {
	        // 현재 버튼이 속한 .opt_box의 모든 버튼에서 active 클래스 제거
	        const optBox = this.closest('.opt_box');
	        optBox.querySelectorAll('.btn').forEach(btn => btn.classList.remove('active'));
	
	        // 클릭된 버튼에 active 클래스 추가
	        this.classList.add('active');
	    });
	});

	//팝업 열기
	function openPopup(popupId) {
	    $('#' + popupId).show();
	    $('.dimm').show();
	}
			
	// 팝업 닫기 버튼 클릭 시
	$(function() {
	    $(".close_btn").on('click', function() {
	        let popupId = $(this).data('popup');
	        $('#' + popupId).hide();
	        $('.dimm').hide();
	    });
	});
	
	// 팝업창에서 [장바구니/다른 메뉴 더보기] 경로 설정
	function submitForm(pickupType) {
	    // 선택한 pickupType (매장이용 또는 To-go)을 input에 설정
	    $("input[name='pickup']").val(pickupType);

	    // form 제출
	    $("form[name='f']").submit();
	}
			    
	// 유효성 검사
    function orderCheck(buttonType) {
    var qty = $("input[name='quantity']").val();

    if (qty < 1) {
        alert("수량은 한개 이상 선택해주세요");
        return false;
    }

    var drink = "${drink}";

   	if (drink === "drink") { 
        var isIce = "${isIce}";
        var isMilk = "${isMilk}";	        
        var cupNum = $('#cupNum').val();
        var whipNum = $('#whipNum').val();
        var iceNum = $('#iceNum').val();
        var milkNum = $('#milkNum').val();
       
       // 사이즈 체크
       if (!cupNum) {
           console.log("컵뭘까:" + cupNum);
           alert("사이즈를 선택해주세요.");
           return false;
       }
       // 얼음량 체크
       if (isIce !== 'not' || isIce === 'ok') {
           if (!iceNum) {
               alert("얼음량을 선택해주세요.");
               return false;
           }
       }
       // 우유 종류 체크
       if (isMilk !== 'not' || isMilk === 'ok') {
           if (!milkNum) {
               alert("우유 종류를 선택해주세요.");
               return false;
           }
       }       
   }		
  	updateSyrupNum();
    orderOptInsert(cupNum, whipNum, iceNum, milkNum, buttonType);
    return true;
}
	
	// orderOptInsert 요청 처리
    function orderOptInsert(cupNum, whipNum, iceNum, milkNum, buttonType) {
		var shotNum = $("input[name='shotNum']").val();
		var optShotCount = $("input[name='optShotCount']").val();
		var syrupNum = $("input[name='syrupNum']").val();
		var optSyrupCount = $("input[name='optSyrupCount']").val();
		
		console.log({
		    cupNum: cupNum,
		    whipNum: whipNum,
		    iceNum: iceNum,
		    milkNum: milkNum,
		    shotNum: shotNum,
		    syrupNum: syrupNum,
		    optShotCount: optShotCount,
		    optSyrupCount: optSyrupCount
		});
		
        $.ajax({
            url: '/orderOptInsert.ajax', // 요청할 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                cupNum: cupNum,
                whipNum: whipNum,
                iceNum: iceNum,
                milkNum: milkNum,
                shotNum: shotNum,
                syrupNum: syrupNum,
                optShotCount: optShotCount,
                optSyrupCount: optSyrupCount
            }),
            success: function(res) {
            	if (res > 0){
            		if (buttonType === 'order') {
                        orderFinal(res); // 주문 버튼을 눌렀을 때
                    } else if (buttonType === 'cart') {
                        cartFinal(res); // 담기 버튼을 눌렀을 때
                    }
            	} else {
            		console.log('처리 중 오류가 발생했습니다.');
            		return;
            	}
            },
            error: function(error) {
            	
                alert('ajax 처리 중 오류가 발생했습니다.');
                console.log(error);
                return;
            }
        });
    } // orderInsert 끝
    
    // 주문하기 어디페이지로 갈지
    function orderFinal(res){
    	alert('결제 페이지로 이동합니다.');
       	$('#optId').val(res);
       	$('#cart').val("imme");
       	// 주문정보 들고 결제페이지로
       	document.forms['optplus'].submit();
    }
    
	 // 장바구니 어디페이지로 갈지
     function cartFinal(res){
    	$('#optId').val(res);
       	$('#cart').val("imme");	    	
     	// 'optplus'라는 이름의 form 요소를 선택
        let form = document.forms['optplus'];
     	// 폼 데이터를 수집
        let formData = new FormData(form);
        

        // AJAX 요청을 사용하여 폼 데이터 전송
        $.ajax({
            url: 'user_cart2',
            type: 'POST',
            data: formData,
            processData: false,  // FormData를 사용하면 false로 설정해야 함
            contentType: false,  // FormData를 사용하면 false로 설정해야 함
            success: function(response) {
            	if (response === -1) {
                    alert('장바구니에는 같은 매장의 메뉴만 담을 수 있습니다.');
                }else if (response=== -2) {
                	alert('장바구니에는 최대 20개까지 담을 수 있습니다.');
                } else if (response > 0) {
                    let popupId = 'pickupselect';  // 명시적으로 팝업 ID를 설정
                    openPopup(popupId);
                } else {
                    alert('장바구니에 담는 중 오류가 발생했습니다.');
                }
            },
            error: function(error) {
                console.error('AJAX 요청 중 오류 발생:', error);
                alert('요청 처리 중 오류가 발생했습니다.');
            }
        });
    }
	
 	// 현재 선택된 시럽의 ID를 저장하는 변수
	var selectedSyrup = null;
	
	// 증가 버튼 클릭 시 호출되는 함수
	function plus(fieldId) {
	    // 입력 요소 가져오기
	    var input = document.getElementById(fieldId);
	    if (!input) {
	        console.error('Input element not found for fieldId:', fieldId);
	        return;
	    }
	    
	    var value = parseInt(input.value, 10); // 현재 값 가져오기
	    value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리

	    // 샷의 수량 조정
	    if (fieldId === 'shot_count') {
	        value++;  // 값 증가
	        input.value = value;

	        var hiddenInput = document.querySelector(`input[name="optShotCount"]`);
	        if (hiddenInput) {
	            hiddenInput.value = value;
	        }
	        return; // 샷 수량 조정 후 종료
	    }

	    // 수량 조정
	    if (fieldId === 'quantity') {
	        var maxQuantity = 20;
	        // 수량이 최대값보다 작은 경우만 증가
	        if (value < maxQuantity) {
	            value++;  // 값 증가
	            input.value = value;
	        } else {
	            // 최대값에 도달한 경우 경고 메시지 표시
	            alert('최대 20개까지 주문이 가능합니다.');
	        }
	        return; // 수량 조정 후 종료
	    }

	    // 시럽의 수량 조정
	    if (selectedSyrup && selectedSyrup !== fieldId) {
	        // 다른 시럽이 선택된 상태에서 시럽을 증가시키면 알림
	        alert('하나의 시럽만 선택할 수 있습니다.');
	        return;
	    }

	    // 시럽의 수량 조정이 아닌 경우
	    value++;  // 값 증가
	    input.value = value;

	    var hiddenInput = document.querySelector(`input[name="optSyrupCount"]`);
	    if (hiddenInput) {
	        hiddenInput.value = value;
	    }

	    // 선택된 시럽 설정
	    selectedSyrup = fieldId;
	}
	
		// 감소 버튼 클릭 시 호출되는 함수
		function minus(fieldId) {
        // 샷의 수량 조정
        if (fieldId === 'shot_count') {
            var input = document.getElementById(fieldId);
            var value = parseInt(input.value, 10);
            value = isNaN(value) ? 0 : value;
            value--;
            if (value < 0) value = 0;
            input.value = value;

            var hiddenInput = document.querySelector(`input[name="optShotCount"]`);
            if (hiddenInput) {
                hiddenInput.value = value;
            }
            return;
        }

        // 수량 조정
        if (fieldId === 'quantity') {
            var input = document.getElementById(fieldId);
            var value = parseInt(input.value, 10);
            value = isNaN(value) ? 1 : value;
            value--;
            if (value < 1) value = 1;  // 수량은 최소 1로 유지
            input.value = value;

            var hiddenInput = document.querySelector(`input[name="quantity"]`);
            if (hiddenInput) {
                hiddenInput.value = value;
            }
            return;
        }

        // 시럽의 수량 조정
        var input = document.getElementById(fieldId);
        var value = parseInt(input.value, 10);
        value = isNaN(value) ? 0 : value;
        value--;
        if (value < 0) value = 0;  // 음수 방지
        input.value = value;

        var hiddenInput = document.querySelector(`input[name="optSyrupCount"]`);
        if (hiddenInput) {
            hiddenInput.value = value;
        }

        // 시럽 수량이 0이 되면 선택된 시럽 해제
        if (value === 0) {
            if (selectedSyrup === fieldId) {
                selectedSyrup = null;
            }
        }	    
    } // minus함수 종료
	
		// 시럽 수량에 따라 syrupNum 필드를 업데이트하는 함수
		function updateSyrupNum() {
		    var syrupNumField = document.getElementById('syrupNum');
		    var syrupNums = []; // 수량이 0보다 큰 시럽의 syrupNum을 저장할 배열

		    // 모든 시럽 수량 입력 필드를 확인합니다.
		    document.querySelectorAll('input[name^="optSyrupCount_"]').forEach(function(input) {
		        var syrupNum = input.name.split('_').pop(); // input name에서 syrupNum 추출
		        var count = parseInt(input.value, 10);

		        // 수량이 0보다 크면 배열에 syrupNum 추가
		        if (count > 0) {
		            syrupNums.push(syrupNum);
		        }
		    });

		    // 배열을 콤마로 구분된 문자열로 변환하여 hidden 필드에 설정
		    syrupNumField.value = syrupNums.join(',');
		}
    
	    // 눌린 버튼 따라 hidden input 넣기
	    document.querySelectorAll('input[type="button"]').forEach(button => {
        button.addEventListener('click', function() {
            // 버튼의 data-* 속성 값 읽기
            const cupNum = this.getAttribute('data-cupNum');
            const iceNum = this.getAttribute('data-iceNum');
            const milkNum = this.getAttribute('data-milkNum');
            const whipNum = this.getAttribute('data-whipNum');

            // 숨겨진 필드에 값 설정
            document.getElementById('cupNum').value = cupNum || document.getElementById('cupNum').value;
            document.getElementById('iceNum').value = iceNum || document.getElementById('iceNum').value;
            document.getElementById('milkNum').value = milkNum || document.getElementById('milkNum').value;
            document.getElementById('whipNum').value = whipNum || document.getElementById('whipNum').value;
        });
    });
	    
    function addMyMenu(buttonElement) {
        // input 요소에서 값을 가져옵니다.
        var menuCode = document.querySelector('input[name="menuCode"]').value;
        var bucksId = document.querySelector('input[name="bucksId"]').value;
		
        // Ajax 요청을 보내는 부분
       	$.ajax({
	        url: '/AddMyMenu.ajax', // 요청할 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
            	menuCode: menuCode,
                bucksId: bucksId
            }),
            success: function(res) {
            	if (res > 0){
            		alert('나만의 메뉴에 추가되었습니다.');
            		// 버튼에 liked 클래스를 추가하고 이미지 변경
                    buttonElement.classList.add('liked');
                    buttonElement.querySelector('img').src = "../images/icons/like2.png";
            	
            	}else if(res === -1){
            		alert('나만의 메뉴에서 삭제되었습니다.');
            		// 버튼에서 liked 클래스를 제거하고 이미지 원래대로 변경
                    buttonElement.classList.remove('liked');
                    buttonElement.querySelector('img').src = "../images/icons/like.png";
            	
            	}else {
            	
            		console.log('처리 중 오류가 발생했습니다.');
            		return;
            	}
            },
            error: function(error) {
            	
                alert('ajax 처리 중 오류가 발생했습니다.');
                console.log(error);
                return;
            }
        });
    }        		
</script>