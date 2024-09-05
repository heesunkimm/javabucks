<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_starhistory" class="content">
        <div class="inner_wrap">
                <div class="tit_box">
                    <p class="font_bold">별 히스토리</p>
                </div>

            <div class="star_count div_box">
                <dl>
                    <dt>기간 내 적립한 누적 별</dt>
                    <dd class="font_green">${star}개</dd>
                </dl>
                <ul class="star_noti">
                    <li>※ 거래 변경, 별 소멸 및 기타 사유로 인해 실제 별 개수와 다소 차이가 있을 수 있습니다.</li>
                </ul>
            </div>

            <div class="view_date div_box">
                <p class="font_gray">${period_setting}</p>
                <a class="popup_btn font_green" href="javascript:;" data-popup="periodselect">기간 설정</a>
            </div>

            <div>
            	<c:forEach var = "dto" items="${starHistory}">
                <ul class="add_list">
                    <li>
                        <div class="add_box">
                            <div class="img_box">
                                <img src="../images/icons/star_line.png" alt="">
                            </div>
                            <p>+${dto.frequencyCount}</p>
                        </div>
                        <div class="txt_box">
                            <p class="txt_tit">적립</p>
                            <!-- 일자 =적립시간 / 유효기간 = 1년 -->
                             <ul class="txt_desc">
                                 <li>일자 <span>${dto.frequencyRegDate}</span></p>
                                 <li>유효기간 <span>${dto.frequencyEndDate}</span></p>
                             </ul>
                        </div>
                    </li>
                </ul>
               </c:forEach>
                
                <ul class="addlist_noti">
                    <li>최근 3개월까지의 별 히스토리를 조회가능합니다.</li>
                    <li>전체 별 히스토리는 홈페이지에서 조회하실 수 있습니다.</li>
                </ul>
            </div>
        </div>
        <!-- 기간설정 팝업 -->
        <div class="popup_box period_date" id="periodselect" style="display: none;">
            <div class="tit_box">
                <p class="txt_tit">기간 설정</p>
            </div>
            <form name="f" action="user_starhistory?mode=search" method="post">
                <!-- s: 내용 작성 -->
                 <div class="date_box">
                     <label>시작일
                         <input type="date" name="startDate" value="">
                     </label>
                     <label>종료일
                         <input type="date" name="endDate" value="">
                     </label>
                 </div>
                <div class="select_period">
                    <label>
                        <input type="radio" name="period_startdate" value="1month">
                        1개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="3months">
                        3개월
                    </label>
                    <label>
                        <input type="radio" name="period_startdate" value="custom" checked>
                        기간설정
                    </label>
                </div>
                <ul class="date_noti">
                    <li>* 최근 3개월까지의 이력만 조회 가능합니다.</li>
                </ul>
                <!-- e: 내용 작성 -->
                <div class="pbtn_box">
                    <button class="close_btn" type="button" data-popup="periodselect">취소</button>
                    <button type="submit">완료</button>
                </div>
            </form>
        </div>
        <div class="dimm"></div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp" %>

<script>
    function toggleDateInputs() {
        const startDateInput = document.querySelector('input[name="startDate"]');
        const endDateInput = document.querySelector('input[name="endDate"]');
        const periodRadioButtons = document.querySelectorAll('input[name="period_startdate"]');
        
		// 선택된 라디오 버튼에 따라 날짜 입력 필드 활성화/비활성화 처리
        if (selectedRadio && (selectedRadio.value === '1month' || selectedRadio.value === '3months')) {
            startDateInput.disabled = true;
            endDateInput.disabled = true;
        } else {
            startDateInput.disabled = false;
            endDateInput.disabled = false;
        }
    }

		// 팝업이 열릴 때 선택된 라디오 버튼에 따라 날짜 입력 필드 비활성화
        const selectedRadio = document.querySelector('input[name="period_startdate"]:checked');
        if (selectedRadio && (selectedRadio.value === '1month' || selectedRadio.value === '3months')) {
            startDateInput.disabled = true;
            endDateInput.disabled = true;
        } else {
            startDateInput.disabled = false;
            endDateInput.disabled = false;
        }
	
        startDateInput.addEventListener('change', function() {
            const selectedDate = new Date(this.value);

            // 최소값 설정 (startDate와 동일)
            endDateInput.min = this.value;

            // 최대값 설정 (startDate에서 3개월 후)
            const maxDate = new Date(selectedDate);
            maxDate.setMonth(maxDate.getMonth() + 3);

            // 날짜 불일치 보정 (예: 31일이 없는 경우)
            if (maxDate.getDate() !== selectedDate.getDate()) {
                maxDate.setDate(0);
            }

            // maxDate 객체를 yyyy-mm-dd 형식으로 변환
            const maxYear = maxDate.getFullYear();
            const maxMonth = String(maxDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
            const maxDay = String(maxDate.getDate()).padStart(2, '0');
            endDateInput.max = `${maxYear}-${maxMonth}-${maxDay}`;
			
            // EndDate가 최대값을 초과하면 비활성화
            if (new Date(endDateInput.value) > maxDate) {
                endDateInput.value = ''; // 값을 비움
                endDateInput.disabled = true; // 비활성화
            } else {
                endDateInput.disabled = false; // 활성화
            }
        });
	}
	// 팝업 열림 시 toggleDateInputs 호출
	    document.querySelectorAll('[data-popup="periodselect"]').forEach(element => {
	        element.addEventListener('click', function() {
	            toggleDateInputs(); // 팝업이 열릴 때마다 라디오 버튼 상태를 확인하여 필드 비활성화 처리
	        });
	    });

	    // 페이지 로드 시에도 초기 설정을 적용
	    window.addEventListener('load', function() {
	        toggleDateInputs(); // 팝업이 열리지 않더라도 처음 로드 시 라디오 버튼 상태를 확인
	    });
</script>