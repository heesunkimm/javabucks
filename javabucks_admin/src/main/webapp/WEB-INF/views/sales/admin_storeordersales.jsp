<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<section id="admin_storeordersales" class="content tab_management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점별 발주정산</p>
            </div>

            <div class="select_box">
                <form name="" action="/searchOrderSales.do" method="post">
                    <div class="count_box">
                        <span>연월</span>
                        <div class="minus_btn img_box">
                            <img src="../images/icons/minus.png" alt="minus" class="minusBtn">
                        </div>
                        <input type="text" class="dateInput" name="orderDate" value="" readonly>
                        <div class="plus_btn img_box">
                            <img src="../images/icons/plus.png" alt="plus" class="plusBtn">
                        </div>
                       <label>지점명
                        <input type="text" name="bucksName" value="" style="border: 1px solid #666; width: 200px;">
                    </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead class="bg_green font_white">
                            <tr>
                                <th style="width: 50%">지점명</th>
                                <th style="width: 50%">발주금액</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${bucksBal}" var="blist">
	                         
						     <tr>
						       	<td><a class="tab_btn" href="javascript:;" data-tab="${blist.bucksName}">${blist.bucksName}</a></td>
						        <td><fmt:formatNumber value="${blist.totalOrderAmount}" type="number" maxFractionDigits="0"/>원</td>
						     </tr>
						       
                         </c:forEach>
                            <!-- <tr class="bg_green font_white">
                                <td>총계</td>
                                <td><fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/>원</td> 
                            </tr> -->
                        </tbody>
                    </table>

                    <ul id="${blist.baljooNum}" class="s_active tab-content">
                        <li>
                            <ul class="cont_toolbar">
                                <li>발주번호</li>
                                <li>발주일</li>
                                <li>발주품목</li>
                                <li>발주금액</li>
                            </ul>
                        </li>
                        <li>
                            <ul class="cont_details">
                                <li>발주번호</li>
                                <li>발주일</li>
                                <li>발주품목</li>
                                <li>발주금액</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
 <jsp:include page="../admin_bottom.jsp"/>
 <script>
 
 	//검색 기능시간 
 	document.addEventListener('DOMContentLoaded', function() {
	    const dateInput = document.querySelector('.dateInput');
	    const minusBtn = document.querySelector('.minusBtn');
	    const plusBtn = document.querySelector('.plusBtn');

	    // 현재 날짜로 초기화
	    const now = new Date();
	    let year = now.getFullYear();
	    let month = now.getMonth() + 1; // 0부터 시작하므로 +1

	    // 월이 한 자리 숫자일 경우 앞에 0을 추가
	    month = month < 10 ? "0" + month : month;

	    // 초기 값 설정
	    dateInput.value = year + "-" + month;

	    function updateDate(offset) {
	        month = parseInt(month) + offset;

	        if (month > 12) {
	            month = 1;
	            year++;
	        } else if (month < 1) {
	            month = 12;
	            year--;
	        }

	        // 월이 한 자리 숫자일 경우 앞에 0을 추가
	        month = month < 10 ? "0" + month : month;

	        dateInput.value = year + "-" + month;
	    }

	    minusBtn.addEventListener('click', function() {
	        updateDate(-1);
	    });

	    plusBtn.addEventListener('click', function() {
	        updateDate(1);
	    });
	});
 	
 // 발주 내역 상세보기
 	document.querySelectorAll('.tab_btn').forEach(function(tabBtn) {
    tabBtn.addEventListener('click', function() {
        const baljooNum = this.getAttribute('data-tab'); // 클릭한 링크의 baljooNum 값
        const baljooDate = this.innerText.trim(); // 클릭한 날짜 (trim()으로 공백 제거)
        const bucksId = document.querySelector('select[name="bucksId"]').value; // 선택된 지점 ID
        
        // baljooNum이 유효한 값인지 확인
        if (!baljooNum || !baljooDate || !bucksId) {
            console.error('Invalid data:', { baljooNum, baljooDate, bucksId });
            return;
        }

        // 서버로 AJAX 요청 보내기
        fetch('/getOrderDetails.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ 
                baljooNum: baljooNum, // baljooNum 값을 서버로 전송
                baljooDate: baljooDate,
                bucksId: bucksId
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            // 서버에서 받은 데이터로 DOM 업데이트
            const tabContent = document.getElementById(baljooNum); // 해당 baljooNum에 맞는 id를 사용

            if (tabContent) {
                tabContent.innerHTML = ''; // 기존 내용 지우기

                for (const [key, value] of Object.entries(data)) {
                    const listItem = document.createElement('li');
                    listItem.innerHTML = `
                        <ul class="cont_details">
                            <li>${key}</li>
                            <li>${value}</li>
                        </ul>
                    `;
                    tabContent.appendChild(listItem);
                }
            } else {
                console.error('No element found with ID:', baljooNum);
            }
        })
        .catch(error => console.error('Error during fetch:', error));
    });
});
 </script>