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
                <form name="f" action="" method="post">
                    <!-- s: 내용 작성 -->
                    <div class="select_period">
                        <button type="button">1개월</button>
                        <button type="button">1년</button>
                        <button type="button">기간 설정</button>
                    </div>
                     <div class="date_box">
                         <label>
                             <input type="date" name="" value="">
                         </label>
                         <label>
                             <input type="date" name="" value="">
                         </label>
                     </div>

                     <div class="select_pay">
                        <label>
                            거래 유형
                            <select name="">
                                <option value="">전체</option>
                                <option value="">충전</option>
                                <option value="">결제</option>
                            </select>
                        </label>
                        <label>
                            결제 수단
                            <select name="">
                                <option value="">스타벅스 카드</option>
                                <option value="">카카오페이</option>
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
                    <p class="font_gray">사용합계 <span class="font_green">${totalPrice}원</span></p>
                </div>
                <ul class="add_list">
                	<c:forEach var="dto" items="${recepitList}">
                    <li>
                        <div class="txt_box">
                            <p class="txt_store">${dto.bucksName}</p>
                            <div class="font_gray">
                                <p class="txt_date">${dto.payhistoryDate}</p>
                                <p class="txt_pay">결제</p>
                            </div>
                            <p class="txt_price font_green">${dto.payhistoryPrice}원</p>
                        </div>
                        <a class="popup_btn" href="javascript:void(0);" onclick="fetchReceiptData('${dto.bucksId}', '${dto.payhistoryNum}');" data-popup="recepitbox">
                            <div class="img_box">
                                <img src="../images/icons/receipt.png" alt="">
                            </div>
                        </a>
                    </li>
                    </c:forEach>
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
                    <li class="order_item">
                        <span>메뉴명</span>
                        <div>
                            <span>가격</span>
                            <span>수량</span>
                        </div>
                        <span>합계</span>
                    </li>
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
	
    // 메뉴 정보 표시
    const orderList = document.querySelector("#recepitbox .order_list");
    orderList.innerHTML = ""; // 기존 항목 제거
    data.items.forEach(item => {
        const listItem = document.createElement("li");
        listItem.className = "order_item";
        listItem.innerHTML = `<span>${item.menuName}</span><div><span>${item.price}원</span><span>${item.quantity}개</span></div><span>${item.totalPrice}원</span>`;
        orderList.appendChild(listItem);
    });


	// 팝업 닫기 버튼 이벤트 추가
	document.querySelector(".close_btn").addEventListener('click', function() {
	    document.getElementById("recepitbox").style.display = 'none';
	});

	$(".toggle_btn").on('click', function(){
		$(".period_date").toggle();
	})
</script>