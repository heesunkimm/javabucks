<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/user.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../js/user.js"></script>
</head>
<body>
    <!-- s: content -->
    <section id="user_menudetail" class="content">
				<form name="optplus" action="user_paynow" method="post">
				<input type="hidden" name="menuCode" value="${menu.menuCode}">
				<input type="hidden" name="menuoptCode" value="${menu.menuoptCode}">
				<input type="hidden" name="store" value="${store}">
				<input type="hidden" name="pickup" value="${pickup}">
		        <div class="inner_wrap">
		            <div class="menu_img img_box">
		                <img src="upload_menuImages/${menu.menuImages}" alt="">
		            </div>
		
		            <div class="txt_box">
		                <p class="txt_tit">${menu.menuName}</p>
		                <p class="txt_desc">${menu.menuDesc}</p>
		                <p class="txt_price">${menu.menuPrice} 원</p>
		            </div>
					<c:if test="${not empty drink}">
		            <div class="btn_box">
		                <button type="button">퍼스널옵션</button>
		            </div>
		            </c:if>
		            <div class="opt_wrap">
		                <!-- 옵션박스 -->
		                <div class="size_box opt_box">
		                </div>
		                
		                 <!-- 옵션: 컵 -->
		                <c:if test="${not empty cup}">
		                <div class="opt_box">
		                    <p class="opt_tit">사이즈 (필수) : 기본 가격은 Tall (size up +500원) </p>
		                    <div class="opt_rows">
		                        <div class="select_box">
		                        	<c:forEach var ="cup" items="${cup}">
		                        	<label>
		                                <input type="button" name="cupType" data-cupNum="${cup.cupNum}">
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
		                                <input type="text" id= "shot_count" name="optShotCount" value="0" readonly>
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
		                                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('${syrup.syrupType}')">
		                            </div>
		                            <label>
		                                <input type="text" id= "${syrup.syrupType}" name="optSyrupCount" value="0" readonly>
		                                <input type="hidden" name="syrupNum" value="${syrup.syrupNum}">
		                            </label>
		                            <div class="plus_btn click_icon img_box">
		                                <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('${syrup.syrupType}')">
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
		                                <input type="button" name="iceType" data-iceNum="${ice.iceNum}">
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
		                                <input type="button" name="milkType" data-milkNum="${milk.milkNum}">
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
		                                <input type="button" name="whipType" data-whipNum="${whip.whipNum}">
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
		            </div>
		        </div>
		            <div class="order_box">
		                <button type="button">담기</button>
		                <div class="minus_btn click_icon img_box">
		                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('quantity')">
		                </div>
		                	<label>
		                		수량<input type="text" id="quantity" name="quantity" value="1" readonly>
		                	</label>
		                <div class="plus_btn click_icon img_box">
		                	<img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('quantity')">
		                </div>
		                <button type="button" onclick="orderCheck()">주문하기</button>
		                <button class="addlike" type="button">
		                    <img src="../images/icons/like.png" alt="">
		                </button>
		            </div>
			</form>
    </section>
    <!-- e: content -->

<%@ include file="user_bottom.jsp"%>

<script type="text/javascript">
		// 감소 버튼 클릭 시 호출되는 함수
	    function minus(fieldId) {
	        var input = document.getElementById(fieldId);
	        var value = parseInt(input.value, 10); // 현재 값 가져오기
	        value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	        value--; // 감소
	        if (value < 0) value = 0; // 음수 방지
	        input.value = value; // 값 적용
	    }
	
	    // 증가 버튼 클릭 시 호출되는 함수
	    function plus(fieldId) {
	        var input = document.getElementById(fieldId);
	        var value = parseInt(input.value, 10); // 현재 값 가져오기
	        value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	        value++; // 증가
	        input.value = value; // 값 적용
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
	    
		// 유효성 검사
	    function orderCheck() {
			var qty = $("input[name='quantity']").val();
			if (qty < 1) {
				alert("수량은 한개 이상 선택해주세요");
				return;
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
		            alert("사이즈를 선택해주세요.");
		            return;
		        }
		        // 얼음량 체크 (ice 리스트가 비어 있지 않을 때만)
		        if (isIce !== 'not' || isIce === 'ok') {
		            if (!iceNum) {
		                alert("얼음량을 선택해주세요.");
		                return;
		            }
		        }
		        // 우유 종류 체크 (milk 리스트가 비어 있지 않을 때만)
		        if (isMilk !== 'not' || isMilk === 'ok') {
		            if (!milkNum) {
		                alert("우유 종류를 선택해주세요.");
		                return;
		            }
		        }
			}
			orderOptInsert(cupNum, whipNum, iceNum, milkNum);
	    }
		
		// orderOptInsert 요청 처리
	    function orderOptInsert(cupNum, whipNum, iceNum, milkNum) {
			var shotNum = $("input[name='shotNum']").val();
			var optShotCount = $("input[name='optShotCount']").val();
			var syrupNum = $("input[name='syrupNum']").val();
			var optSyrupCount = $("input[name='optSyrupCount']").val();
			
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
	                	alert('결제 페이지로 이동합니다.');
	                	$('#optId').val(res);
	                	$('#cart').val("imme");
	                	document.forms['optplus'].submit();
	            	} else {
	            		console.log('처리 중 오류가 발생했습니다.');
	            		return;
	            	}
	            },
	            error: function(error) {
	                alert('처리 중 오류가 발생했습니다.');
	                return;
	            }
	        });
	    }
	    
</script>