<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>        
<%@ include file="user_top.jsp"%>
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
                                <option value="card">자바벅스 카드</option>
                                <option value="kakao">카카오페이</option>
                            </select>
                        </label>
                     </div>
                    
                    <!-- e: 내용 작성 -->
                    <div class="pbtn_box">
                        <button class="cancel_btn" type="button">취소</button>
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
                		<li class="nolist">조회 결과가 없습니다.</li>
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
					
	              <!--  ajax로 메뉴 리스트 들어올 예정-->      

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
	$(".cancel_btn").on("click", function(){
		$(".period_date").hide();
	})
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
    const bucksNameElement = document.querySelector("#recepitbox .store_info li:nth-child(1) span:first-child");
    if (bucksNameElement) {
        bucksNameElement.textContent = data.bucksName;
    }
    // 지점전화번호
    const bucksTelElement = document.querySelector("#recepitbox .store_info li:nth-child(1) span:last-child");
    if (bucksTelElement) {
        bucksTelElement.textContent = 'T: ' + data.bucksTel1 + '-' + data.bucksTel2 + '-' + data.bucksTel3;
    }
    // 지점위치
    const bucksLocationElement = document.querySelector("#recepitbox .store_info li:nth-child(2)");
    if (bucksLocationElement) {
        bucksLocationElement.textContent = data.bucksLocation;
    }
    // 대표: 점주명
    const bucksOwnerElement = document.querySelector("#recepitbox .store_info li:nth-child(3) span:first-child");
    if (bucksOwnerElement) {
        bucksOwnerElement.textContent = '대표: ' + data.bucksOwner;
    }
    // 지점코드
    const bucksCodeElement = document.querySelector("#recepitbox .store_info li:nth-child(3) span:last-child");
    if (bucksCodeElement) {
        bucksCodeElement.textContent = data.bucksCode;
    }
    // 결제시간
    const payhistoryDateElement = document.querySelector("#recepitbox .store_info li:nth-child(4)");
    if (payhistoryDateElement) {
        payhistoryDateElement.textContent = data.payhistoryDate;
    }
    // 닉네임 설정
    const userNicknameElement = document.querySelector("#recepitbox .user_info .order_num p:first-child");
    if (userNicknameElement) {
        userNicknameElement.textContent = data.userNickname;
    }
    // 주문번호 설정
    const orderCodeElement = document.querySelector("#recepitbox .user_info .order_num p:last-child");
    if (orderCodeElement) {
        orderCodeElement.textContent = data.orderCode;
    }
    // 합계 및 결제 정보 업데이트
    const totalPriceElement = document.querySelector("#recepitbox .total_box span:last-child");
    if (totalPriceElement) {
        totalPriceElement.textContent = data.payhistoryPrice.toLocaleString() + '원';
    }
    const addVatElement = document.querySelector("#recepitbox .addvat_box em:last-child");
    if (addVatElement) {
        addVatElement.textContent = data.payhistoryPrice.toLocaleString() + '원';
    }
    const payPriceElement = document.querySelector("#recepitbox .pay_box dl:nth-child(1) dd");
    if (payPriceElement) {
        payPriceElement.textContent = data.payhistoryPrice.toLocaleString() + '원';
    }
    const cardRegNumElement = document.querySelector("#recepitbox .pay_box dl:nth-child(2) dd");
    if (cardRegNumElement) {
        cardRegNumElement.textContent = data.cardRegNum;
    }
    const cardPriceElement = document.querySelector("#recepitbox .pay_box dl:nth-child(3) dd");
    if (cardPriceElement) {
        cardPriceElement.textContent = data.cardPrice.toLocaleString() + '원';
    }
		
	 	// <dl> 요소가 없는 경우, 직접 생성하여 추가
	    const payBoxElement = document.querySelector('.pay_box');

	    // dl, dt, dd를 생성하여 추가하는 함수
	    const createDlElement = (dtText, ddText) => {
	        const dl = document.createElement('dl');
	        const dt = document.createElement('dt');
	        const dd = document.createElement('dd');
	        
	        dt.textContent = dtText;
	        dd.textContent = ddText;

	        dl.appendChild(dt);
	        dl.appendChild(dd);

	        return dl;
	    };

	    // 기존 pay_box 내부 내용 제거 (필요에 따라 사용)
	    payBoxElement.innerHTML = '';

	    // 첫 번째 항목: 결제수단과 결제금액
	    if (data.payhistoryPayWay === '카카오페이') {
	        payBoxElement.appendChild(createDlElement(data.payhistoryPayWay, data.payhistoryPrice.toLocaleString() + '원'));
	    } else {
	    	// 첫 번째 항목: 결제유형
	        payBoxElement.appendChild(createDlElement('스타벅스카드', data.payhistoryPrice.toLocaleString() + '원'));
	   
	    	 // 카드번호에 4자리마다 '-'를 추가하는 함수
	        const formatCardNumber = (cardNumber) => {
	            if (!cardNumber) return '카드번호'; // cardNumber가 없을 경우 기본값 반환
	            return cardNumber.replace(/(\d{4})(?=\d)/g, '$1-'); // 4자리마다 '-' 추가
	        };
	        
		    // 두 번째 항목: 카드번호
		    payBoxElement.appendChild(createDlElement('카드번호', formatCardNumber(data.cardRegNum) || '카드번호'));
	
		    // 세 번째 항목: 카드잔액
		    payBoxElement.appendChild(createDlElement('카드잔액', data.cardPrice.toLocaleString() + '원'));
	    }
		
		const orderList = document.querySelector("#recepitbox .order_list");
		// 기존의 주문 목록을 초기화
	    orderList.innerHTML = '';
		// AJAX로 받은 데이터 배열이 data.items라고 가정합니다
		data.items.forEach(item => {
		    // 리스트 항목(li) 생성
		    const li = document.createElement('li');
		    li.className = 'order_item';
		    // 메뉴 이름(span) 생성
		    const span = document.createElement('span');
		    span.textContent = item.menuname;
		    li.appendChild(span);

		    // 가격과 수량을 포함하는 div 생성
		    const div = document.createElement('div');
		    
		    // 가격(span) 생성
		    const priceSpan = document.createElement('span');
		    priceSpan.textContent = item.menuprice.toLocaleString(); // 화폐 단위 또는 포맷을 추가
		    div.appendChild(priceSpan);
		    
		    // 수량(span) 생성
		    const countSpan = document.createElement('span');
		    countSpan.textContent = item.cartCnt;
		    div.appendChild(countSpan);
		    
		    li.appendChild(div);

		    // 총 가격(span) 생성
		    const totalPriceSpan = document.createElement('span');
		    totalPriceSpan.textContent = (item.menuprice * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
		    li.appendChild(totalPriceSpan);

		    // 리스트 항목을 리스트에 추가
		    orderList.appendChild(li);

		    // 선택적 필드를 확인하고 추가
		    if (item.cupType) {
		        // 컵 항목(li) 생성
		        const cupLi = document.createElement('li');
		        cupLi.className = 'order_item';
		        
		        // 컵 타입(span) 생성
		        const cupSpan = document.createElement('span');
		        cupSpan.textContent = "┖" + item.cupType;
		        cupLi.appendChild(cupSpan);
		        
		        // 가격과 수량을 포함하는 div 생성
		        const cupDiv = document.createElement('div');
		        
		        // 컵 가격(span) 생성
		        const cupPriceSpan = document.createElement('span');
		        cupPriceSpan.textContent = item.cupPrice.toLocaleString(); // 화폐 단위 또는 포맷을 추가
		        cupDiv.appendChild(cupPriceSpan);
		        
		        // 수량(span) 생성
		        const cupCountSpan = document.createElement('span');
		        cupCountSpan.textContent = item.cartCnt;
		        cupDiv.appendChild(cupCountSpan);
		        cupLi.appendChild(cupDiv);
		        
		        // 컵 총 가격(span) 생성
		        const cupTotalPriceSpan = document.createElement('span');
		        cupTotalPriceSpan.textContent = (item.cupPrice * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
		        cupLi.appendChild(cupTotalPriceSpan);
		        
		        // 컵 항목을 리스트에 추가
		        orderList.appendChild(cupLi);
			   }

			    if (item.iceType) {
			        // 얼음 항목(li) 생성
			        const iceLi = document.createElement('li');
			        iceLi.className = 'order_item';
			        
			        // 얼음 타입(span) 생성
			        const iceSpan = document.createElement('span');
			        iceSpan.textContent = "┖얼음 "+ item.iceType;
			        iceLi.appendChild(iceSpan);
			        
			        // 가격과 수량을 포함하는 div 생성
			        const iceDiv = document.createElement('div');
			        
			        // 얼음 가격(span) 생성
			        const icePriceSpan = document.createElement('span');
			        icePriceSpan.textContent = item.icePrice.toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        iceDiv.appendChild(icePriceSpan);
			        
			        // 수량(span) 생성
			        const iceCountSpan = document.createElement('span');
			        iceCountSpan.textContent = item.cartCnt;
			        iceDiv.appendChild(iceCountSpan);
			        
			        iceLi.appendChild(iceDiv);
			        
			        // 얼음 총 가격(span) 생성
			        const iceTotalPriceSpan = document.createElement('span');
			        iceTotalPriceSpan.textContent = (item.icePrice * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        iceLi.appendChild(iceTotalPriceSpan);
			        
			        // 얼음 항목을 리스트에 추가
			        orderList.appendChild(iceLi);
			    }

			    if (item.shotType) {
			        // 샷 항목(li) 생성
			        const shotLi = document.createElement('li');
			        shotLi.className = 'order_item';
			        
			        // 샷 타입(span) 생성
			        const shotSpan = document.createElement('span');
			        shotSpan.textContent = "┖" + item.shotType+ "X"+ item.shotCount;
			        shotLi.appendChild(shotSpan);
			        
			        // 가격과 수량을 포함하는 div 생성
			        const shotDiv = document.createElement('div');
			        
			        // 샷 가격(span) 생성
			        const shotPriceSpan = document.createElement('span');
			        shotPriceSpan.textContent = (item.shotPrice * item.shotCount).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        shotDiv.appendChild(shotPriceSpan);
			        
			        // 수량(span) 생성
			        const shotCountSpan = document.createElement('span');
			        shotCountSpan.textContent = item.cartCnt;
			        shotDiv.appendChild(shotCountSpan);
			        
			        shotLi.appendChild(shotDiv);
			        
			        // 샷 총 가격(span) 생성
			        const shotTotalPriceSpan = document.createElement('span');
			        shotTotalPriceSpan.textContent = (item.shotPrice * item.shotCount * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        shotLi.appendChild(shotTotalPriceSpan);
			        
			        // 샷 항목을 리스트에 추가
			        orderList.appendChild(shotLi);
			    }

			    if (item.syrupType) {
			        // 시럽 항목(li) 생성
			        const syrupLi = document.createElement('li');
			        syrupLi.className = 'order_item';
			        
			        // 시럽 타입(span) 생성
			        const syrupSpan = document.createElement('span');
			        syrupSpan.textContent = "┖" + item.syrupType+ "X"+ item.syrupCount;
			        syrupLi.appendChild(syrupSpan);
			        
			        // 가격과 수량을 포함하는 div 생성
			        const syrupDiv = document.createElement('div');
			        
			        // 시럽 가격(span) 생성
			        const syrupPriceSpan = document.createElement('span');
			        syrupPriceSpan.textContent = (item.syrupPrice * item.syrupCount).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        syrupDiv.appendChild(syrupPriceSpan);
			        
			        // 수량(span) 생성
			        const syrupCountSpan = document.createElement('span');
			        syrupCountSpan.textContent = item.cartCnt;
			        syrupDiv.appendChild(syrupCountSpan);
			        
			        syrupLi.appendChild(syrupDiv);
			        
			        // 시럽 총 가격(span) 생성
			        const syrupTotalPriceSpan = document.createElement('span');
			        syrupTotalPriceSpan.textContent = (item.syrupPrice * item.syrupCount * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        syrupLi.appendChild(syrupTotalPriceSpan);
			        
			        // 시럽 항목을 리스트에 추가
			        orderList.appendChild(syrupLi);
			    }

			    if (item.whipType) {
			        // 휘핑 항목(li) 생성
			        const whipLi = document.createElement('li');
			        whipLi.className = 'order_item';
			        
			        // 휘핑 타입(span) 생성
			        const whipSpan = document.createElement('span');
			        whipSpan.textContent = "┖휘핑 " + item.whipType;
			        whipLi.appendChild(whipSpan);
			        
			        // 가격과 수량을 포함하는 div 생성
			        const whipDiv = document.createElement('div');
			        
			        // 휘핑 가격(span) 생성
			        const whipPriceSpan = document.createElement('span');
			        whipPriceSpan.textContent = item.whipPrice.toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        whipDiv.appendChild(whipPriceSpan);
			        
			        // 수량(span) 생성
			        const whipCountSpan = document.createElement('span');
			        whipCountSpan.textContent = item.cartCnt;
			        whipDiv.appendChild(whipCountSpan);
			        
			        whipLi.appendChild(whipDiv);
			        
			        // 휘핑 총 가격(span) 생성
			        const whipTotalPriceSpan = document.createElement('span');
			        whipTotalPriceSpan.textContent = (item.whipPrice * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        whipLi.appendChild(whipTotalPriceSpan);
			        
			        // 휘핑 항목을 리스트에 추가
			        orderList.appendChild(whipLi);
			    }

			    if (item.milkType) {
			        // 우유 항목(li) 생성
			        const milkLi = document.createElement('li');
			        milkLi.className = 'order_item';
			        
			        // 우유 타입(span) 생성
			        const milkSpan = document.createElement('span');
			        milkSpan.textContent = "┖" + item.milkType;
			        milkLi.appendChild(milkSpan);
			        
			        // 가격과 수량을 포함하는 div 생성
			        const milkDiv = document.createElement('div');
			        
			        // 우유 가격(span) 생성
			        const milkPriceSpan = document.createElement('span');
			        milkPriceSpan.textContent = item.milkPrice.toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        milkDiv.appendChild(milkPriceSpan);
			        
			        // 수량(span) 생성
			        const milkCountSpan = document.createElement('span');
			        milkCountSpan.textContent = item.cartCnt;
			        milkDiv.appendChild(milkCountSpan);
			        
			        milkLi.appendChild(milkDiv);
			        
			        // 우유 총 가격(span) 생성
			        const milkTotalPriceSpan = document.createElement('span');
			        milkTotalPriceSpan.textContent = (item.milkPrice * item.cartCnt).toLocaleString(); // 화폐 단위 또는 포맷을 추가
			        milkLi.appendChild(milkTotalPriceSpan);
			        
			        // 우유 항목을 리스트에 추가
			        orderList.appendChild(milkLi);
			    }
			});
	}
	
		// 팝업 닫기 버튼 이벤트 추가
		document.querySelector(".close_btn").addEventListener('click', function() {
		    document.getElementById("recepitbox").style.display = 'none';
		});
	
		$(".toggle_btn").on('click', function(){
			$(".period_date").toggle();
		})
</script>