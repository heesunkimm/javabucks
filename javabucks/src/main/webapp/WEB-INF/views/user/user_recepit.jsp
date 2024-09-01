<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>        
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
    <section id="user_recepit" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">전자영수증</p>
            </div>

            <div class="view_date div_box">
                <p>전체</p>
                <div>
                    <p class="font_gray">${period_setting}</p>
                    <a class="toggle_btn font_green" href="javascript:;">▽</a>
                </div>
            </div>
            <!-- 기간설정 토글 -->
            <div class="period_date" id="" style="display: none;">
                <form name="f" action="user_recepit?mode=search" method="post">
               		 <input type="hidden" name="period" id="periodInput" value="">
                    <!-- s: 내용 작성 -->
                    <div class="select_period">
                       	<button type="button" class="btn" id= "1month" name="period" value="1month" onclick="setPeriod('1month')">1개월</button>
                        <button type="button" class="btn" id= "1year" name="period" value="1year" onclick="setPeriod('1year')">1년</button>
                        <button type="button" class="btn" id= "setperiod">기간 설정</button>
                    </div>
                     <div class="date_box">
                         <label>
                             <input type="date" id="startDate" name="startDate" value="${startDate}" disabled>
                         </label>
                         <label>
                             <input type="date" id="endDate" name="endDate" value="${endDate}" disabled>
                         </label>
                     </div>

                     <div class="select_pay">
                        <label>
                            거래 유형
                            <select name="paytype">
                                <option value="all">전체</option>
                                <option value="charge">충전</option>
                                <option value="pay">결제</option>
                            </select>
                        </label>
                        <label>
                            결제 수단
                            <select name="payway">
                                <option value="card">스타벅스 카드</option>
                                <option value="kakao">카카오페이</option>
                            </select>
                        </label>
                     </div>
                    
                    <!-- e: 내용 작성 -->
                    <div class="pbtn_box">
                        <button type="button">취소</button>
                        <button type="submit">조회</button>
                    </div>
                </form>
            </div>

            <div class="list_box">
                <div class="count_box">
                    <p class="font_gray">총 <span class="font_green">${number}건</span></p>
                    <p class="font_gray">사용합계 <span class="font_green"><fmt:formatNumber value="${totalPrice}" pattern="###,###" />원</span></p>
                </div>
                <ul class="add_list">
                	<c:if test="${empty recepitList}">
                		<p class="txt_store">조회 결과가 없습니다.</p>
					</c:if>
					<c:if test="${not empty recepitList}">
                	<c:forEach var="dto" items="${recepitList}">
                    <li>
                        <div class="txt_box">
                            <p class="txt_store">${dto.bucksName}</p>
                            <div class="font_gray">
                                <p class="txt_date">${dto.payhistoryDate}</p>
                                <p class="txt_pay">결제</p>
                            </div>
                            <p class="txt_price font_green"><fmt:formatNumber value="${dto.payhistoryPrice}" pattern="###,###" />원</p>
                        </div>
                        <a class="popup_btn" href="javascript:void(0);" onclick="fetchReceiptData('${dto.bucksId}', '${dto.payhistoryNum}');" data-popup="recepitbox">
                            <div class="img_box">
                                <img src="../images/icons/receipt.png" alt="">
                            </div>
                        </a>
                    </li>
                    </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- 영수증 팝업 -->
        <div class="popup_box recepit_detail" id="recepitbox" style="display: none;">
            <div class="tit_box">
                <p>JAVABUCKS</p>
            </div>
            <!-- s: 내용 작성 -->
             <ul class="store_info">
                <li>
                    <span>지점명</span>
                    <span>지점전화번호</span>
                </li>
                <li>지점위치</li>
                <li>
                    <span>대표: 점주명</span>
                    <span>지점코드</span>
                </li>
                <li>결제시간</li>
             </ul>
             <div class="user_info">
                <div class="order_num">
                    <p>닉네임</p>
                    <p>(주문번호)</p>
                </div>
                <ul class="order_list"> 
                	<c:forEach var="item" items="${items}">
	                    <li class="order_item">
	                        <span>${item.menuname}</span>
	                        <div>
	                            <span>${item.menuprice}</span>
	                            <span>${item.cartCnt}</span>
	                        </div>
	                        <span>${item.menuprice*item.cartCnt}</span>
	                    </li>
	                    
	                <!-- 컵타입 -->
                    <c:if test = "${not empty item.cupType}"> 
                    	<li class="order_item">
                        <span> -${item.cupType}</span>
                        <div>
                            <span>${item.cupPrice}</span>
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.cupPrice*item.cartCnt}</span>
                    </li>
                    </c:if>
                    
                    <!-- 얼음 -->
                    <c:if test = "${not empty item.iceType}"> 
                    	<li class="order_item">
                        <span> -${item.iceType}</span>
                        <div>
                            <span>${item.icePrice}</span>
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.icePrice*item.cartCnt}</span>
                    </li>
                    </c:if>
                    
                     <!-- 샷 -->
                    <c:if test = "${not empty item.shotType}"> 
                    	<li class="order_item">
                        <span> -${item.shotType} X ${item.shotCount}</span>
                        <div>
                            <span>${item.shotPrice*item.shotCount}</span>
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.shotPrice*item.shotCount*item.cartCnt}</span>
                    </li>
                    </c:if>
                    
                     <!-- 시럽 -->
                    <c:if test = "${not empty item.syrupType}"> 
                    	<li class="order_item">
                        <span> -${item.syrupType} X ${item.syrupCount}</span>
                        <div>
                            <span>${item.syrupPrice*item.syrupCount}</span> 
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.syrupPrice*item.syrupCount*item.cartCnt}</span>
                    </li>
                    </c:if>
                    
                     <!-- 휘핑 -->
                    <c:if test = "${not empty item.whipType}"> 
                    	<li class="order_item">
                        <span> -${item.whipType}</span>
                        <div>
                            <span>${item.whipPrice}</span>
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.whipPrice*item.cartCnt}</span>
                    </li>
                    </c:if>
                    
                     <!-- 우유 -->
                    <c:if test = "${not empty item.milkType}"> 
                    	<li class="order_item">
                        <span> -${item.milkType}</span>
                        <div>
                            <span>${item.milkPrice}</span>
                            <span>${item.cartCnt}</span>
                        </div>
                        <span>${item.milkPrice*item.cartCnt}</span>
                    </li>
                    </c:if>
                    </c:forEach>
                </ul>
                <div class="total_box">
                    <span>합계</span>
                    <span>총금액</span>
                </div>
                <div class="addvat_box">
                    <span><em>결제금액</em><br/><span>(부가세포함)</span></span>
                    <em>총금액</em>
                </div>
                <div class="pay_box">
                    <dl>
                        <dt>스타벅스카드</dt>
                        <dd>결제금액</dd>
                    </dl>
                    <dl>
                        <dt>스타벅스카드</dt>
                        <dd>카드번호</dd>
                    </dl>
                    <dl>
                        <dt>카드잔액</dt>
                        <dd>카드잔액</dd>
                    </dl>
                </div>
                <div class="reward_box">
                    
                </div>
             </div>
            <!-- e: 내용 작성 -->
            <div class="pbtn_box">
                <button class="close_btn" type="button" data-popup="recepitbox">닫기</button>
            </div>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->	
<%@ include file="user_bottom.jsp"%>
<script>
	// 버튼 클릭시 클래스 먹이기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//버튼 클릭 이벤트 설정
	document.querySelectorAll('.btn').forEach(button => {
	    button.addEventListener('click', function() {
	        // 모든 버튼에서 active 클래스 제거
	        document.querySelectorAll('.btn').forEach(btn => btn.classList.remove('active'));
	        
	        // 클릭된 버튼에 active 클래스 추가
	        this.classList.add('active');
	    });
	});
	
	// 날짜를 YYYY-MM-DD 형식으로 변환
    const formatDate = (date) => date.toISOString().split('T')[0];
 	// 1개월 버튼 클릭 이벤트
    document.getElementById('1month').addEventListener('click', function() {
        const today = new Date();
        const startDate = new Date(today);
        startDate.setMonth(today.getMonth() - 1);
        
        document.getElementById('startDate').value = formatDate(startDate);
        document.getElementById('endDate').value = formatDate(today);
    });
 	// 1년 버튼 클릭 이벤트
    document.getElementById('1year').addEventListener('click', function() {
        const today = new Date();
        const startDate = new Date(today);
        startDate.setFullYear(today.getFullYear() - 1);
        
        document.getElementById('startDate').value = formatDate(startDate);
        document.getElementById('endDate').value = formatDate(today);
    });

 	// 기간 설정 버튼 클릭 이벤트
    document.getElementById('setperiod').addEventListener('click', function() {
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        
        // disabled 속성을 토글
        const isDisabled = startDateInput.disabled;
        startDateInput.disabled = !isDisabled;
        endDateInput.disabled = !isDisabled;
    });
 	
 	// 버튼 클릭 시 숨겨진 input에 값을 설정하고 폼을 제출하는 함수
    function setPeriod(periodValue) {
        document.getElementById('periodInput').value = periodValue;
        
    }
	
	function fetchReceiptData(bucksId, payhistoryNum) {
	    $.ajax({
	        url: 'user_recepit.ajax',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            bucksId: bucksId,
	            payhistoryNum: payhistoryNum
	        }),
	        success: function(response) {
	            // 서버에서 받은 데이터를 이용해 팝업을 업데이트합니다.
	            updatePopup(response);
	            // 팝업을 보여줍니다.
	            document.getElementById("recepitbox").style.display = 'block';
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 요청 실패:', error);
	        }
	    });
	}
	
	function updatePopup(data) {
	    // 서버에서 받은 JSON 데이터를 사용해 팝업 내용을 업데이트합니다.
	    // 지점명
		document.querySelector("#recepitbox .store_info li:nth-child(1) span:first-child").textContent = data.bucksName;
		// 지점전화번호
		document.querySelector("#recepitbox .store_info li:nth-child(1) span:last-child").textContent = 'T: ' + data.bucksTel1 + '-' + data.bucksTel2 + '-' + data.bucksTel3;
		// 지점위치
		document.querySelector("#recepitbox .store_info li:nth-child(2)").textContent = data.bucksLocation;
		// 대표: 점주명
		document.querySelector("#recepitbox .store_info li:nth-child(3) span:first-child").textContent = '대표: ' + data.bucksOwner;
		// 지점코드
		document.querySelector("#recepitbox .store_info li:nth-child(3) span:last-child").textContent = data.bucksCode;
		// 결제시간
		document.querySelector("#recepitbox .store_info li:nth-child(4)").textContent = data.payhistoryDate;
		// 닉네임 설정
		document.querySelector("#recepitbox .user_info .order_num p:first-child").textContent = data.userNickname;
		// 주문번호 설정
		document.querySelector("#recepitbox .user_info .order_num p:last-child").textContent = data.orderCode;
	
		
	    // 합계 및 결제 정보 업데이트
	    document.querySelector("#recepitbox .total_box span:last-child").textContent = data.payhistoryPrice.toLocaleString() + '원';
	    document.querySelector("#recepitbox .addvat_box em:last-child").textContent = data.payhistoryPrice.toLocaleString() + '원'; // 부가세 포함 금액
	    document.querySelector("#recepitbox .pay_box dl:nth-child(1) dd").textContent = data.payhistoryPrice.toLocaleString() + '원';
	    document.querySelector("#recepitbox .pay_box dl:nth-child(2) dd").textContent = data.cardRegNum;
	    document.querySelector("#recepitbox .pay_box dl:nth-child(3) dd").textContent = data.cardPrice.toLocaleString() + '원';
		}
		
	// 	//메뉴 정보 표시
	// 	const orderList = document.querySelector("#recepitbox .order_list");
	// 	orderList.innerHTML = ""; // 기존 항목 제거
	// 	data.items.forEach(item => {
	// 	    const listItem = document.createElement("li");
	// 	    listItem.className = "order_item";
	// 	    listItem.innerHTML = `<span>${item.menuName}</span>
	// 	                          <div>
	// 	                              <span>${item.price.toLocaleString()}원</span>
	// 	                              <span>${item.quantity}개</span>
	// 	                          </div>
	// 	                          <span>${item.totalPrice.toLocaleString()}원</span>`;
	// 	    orderList.appendChild(listItem);
	// 	});
	
	
		// 팝업 닫기 버튼 이벤트 추가
		document.querySelector(".close_btn").addEventListener('click', function() {
		    document.getElementById("recepitbox").style.display = 'none';
		});
	
		$(".toggle_btn").on('click', function(){
			$(".period_date").toggle();
		})
</script>