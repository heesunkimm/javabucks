<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ include file="../store_top.jsp"%>
    <!-- s: content -->
    <section id="store_salesmanage" class="content management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>매출관리</p>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_all">전체</a>
                    <a class="tab_btn" href="javascript:;" data-tab="cate_drink">음료</a>
                    <a class="tab_btn" href="javascript:;" data-tab="cate_disert">디저트</a>
                    <a class="tab_btn" href="javascript:;" data-tab="cate_Md">MD 상품 </a>
                </div>

                <div id="cate_all" class="tab-content s_active">
                        
                        <div class="search_box">
                            <label>기간
                                <input type="date" name="startDate" class="startDate" required>
                            ~
                         	   <input type="date" name="endDate" class="endDate" required>

                            </label>
                            <div class="period_box"></div>
                            <button type="button" class="search-btn">검색</button>
                        </div>

                    <div class="list_box">
                        <p class="totabl_sales">매출액:<span class="totalSalesAmount"><fmt:formatNumber value="${totalSalesAmount}" pattern="#,###"/>원</span></p>
                        <table class="search_list s_table">
                            <thead>
                                <tr>
                                    <th>결제일시</th>
                                    <th>결제번호</th>
                                    <th>주문번호</th>
                                    <th>주문내역</th>
                                    <th>결제금액</th>
                                   <!--  <th>결제취소</th> -->
                                </tr>
                            </thead>
                            <tbody class="salesList">
                                <c:choose>
						            <c:when test="${empty salesList}">
						                <tr><td colspan="6">매출 내역이 없습니다.</td></tr>
						            </c:when>
						            <c:otherwise>
						                <c:forEach var="item" items="${salesList}">
						                    <tr>
						                        <td>${item.payhistoryDate}</td>
						                        <td>${item.payhistoryNum}</td>
						                        <td>${item.extractedOrderCode}</td>
						                        <td>${item.menuName}</td>
						                        <td><fmt:formatNumber value="${item.payhistoryPrice}" pattern="#,###"/>원</td>
						                     <!--   <td><a href="javascript:;">취소</a></td> --> 
						                    </tr>
						                </c:forEach>
						            </c:otherwise>
						        </c:choose>
                            </tbody>
                        </table>
                        <!-- 페이징 -->
                      <div class="pagination pagination">
			        <c:if test="${startPage > pageBlock}"> 
			            <a class="page_btn prev_btn" href="store_sales.do?pageNum=${startPage-3}">
			                <img src="../../images/icons/arrow.png">
			            </a>
			        </c:if>
			        
			        <c:forEach var="i" begin="${startPage}" end="${endPage}">
			            <c:set var="activeClass" value=""/>
			            <c:choose>
			                <c:when test="${empty param.pageNum and i == 1}">
			                    <c:set var="activeClass" value="page_active"/>
			                </c:when>
			                <c:when test="${param.pageNum == i}">
			                    <c:set var="activeClass" value="page_active"/>
			                </c:when>
			            </c:choose>
			            <a href="store_sales.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
			        </c:forEach>
			        
			        <c:if test="${pageCount > endPage}">
			            <a class="page_btn next_btn" href="store_sales.do?pageNum=${startPage+3}">
			                <img src="../../images/icons/arrow.png">
			            </a>
			        </c:if>
			    </div>
                    </div>
                </div>
                <div id="cate_drink" class="tab-content">
                    <div class="select_list">
                            <label>
                            <input type="checkbox" name="menu_cate" value="B" checked>전체
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="ES">에스프레소
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="CB">콜드브루
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BD">블론드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="DC">디카페인
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="PJ">피지오
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="RF">리프레셔
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="FP">프라푸치노
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BL">블렌디드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="BR">브루드
                        </label>
                        <label>
                            <input type="checkbox" name="menu_cate" value="ET">기타
                        </label>
                        </div>
                        <div class="list_box">
                        <p class="totabl_sales">매출액:<span class="totalSalesAmount"><fmt:formatNumber value="${totalSalesAmount}" pattern="#,###"/>원</span></p>
                        <table class="search_list s_table">
                            <thead>
                                <tr>
                                    <th>결제일시</th>
                                    <th>결제번호</th>
                                    <th>주문번호</th>
                                    <th>주문내역</th>
                                    <th>결제금액</th>
                                   <!--  <th>결제취소</th> -->
                                </tr>
                            </thead>
                            <tbody class="salesList">
                            </tbody>
                            
                            </table>
                            <div class="pagination"></div>
                        </div>
                        
                </div>
                
                
                <div id="cate_disert" class="tab-content">
                        <div class="select_list">
                            <label>
                            <input type="checkbox" name="disert_cate" value="C" checked>전체
                        </label>
                        <label>
                            <input type="checkbox" name="disert_cate" value="CK">케이크
                        </label>
                        <label>
                            <input type="checkbox" name="disert_cate" value="SD">샌드위치
                        </label>
                        </div>
                        <div class="list_box">
                        <p class="totabl_sales">매출액:<span class="totalSalesAmount"><fmt:formatNumber value="${totalSalesAmount}" pattern="#,###"/>원</span></p>
                        <table class="search_list s_table">
                            <thead>
                                <tr>
                                    <th>결제일시</th>
                                    <th>결제번호</th>
                                    <th>주문번호</th>
                                    <th>주문내역</th>
                                    <th>결제금액</th>
                                   <!--  <th>결제취소</th> -->
                                </tr>
                            </thead>
                            <tbody class="salesList">
                            </tbody>
                            </table>
                            <div class="pagination"></div>
                            
                        </div>
                </div>
                
                <div id="cate_Md" class="tab-content">
                    <div class="select_list">
                            <label>
                            <input type="checkbox" name="Md_cate" value="M" checked>전체
                        </label>
                        <label>
                            <input type="checkbox" name="Md_cate" value="TB">텀블러
                        </label>
                        <label>
                            <input type="checkbox" name="Md_cate" value="WD">원두
                        </label>
                        </div>
                        <div class="list_box">
                        <p class="totabl_sales">매출액:<span class="totalSalesAmount"><fmt:formatNumber value="${totalSalesAmount}" pattern="#,###"/>원</span></p>
                        <table class="search_list s_table">
                            <thead>
                                <tr>
                                    <th>결제일시</th>
                                    <th>결제번호</th>
                                    <th>주문번호</th>
                                    <th>주문내역</th>
                                    <th>결제금액</th>
                                   <!--  <th>결제취소</th> -->
                                </tr>
                            </thead>
                            <tbody class="salesList">
                            </tbody>
                            </table>
                        
                        <div class="pagination"></div>
                        </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="bucksId" value="${inBucks.bucksId}">
    </section>
    <!-- e: content -->
  <%@ include file="../store_bottom.jsp"%>
  
 <script>
 $(document).ready(function() {
	    // 현재 로컬 날짜 가져오기
	    let today = new Date();
	    let year = today.getFullYear();
	    let month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
	    let day = ('0' + today.getDate()).slice(-2);

	    // 포맷된 날짜 문자열
	    let formattedDate = year + '-' + month + '-' + day;

	    // 시작일과 종료일을 현재 날짜로 설정
	    $(".startDate").val(formattedDate);
	    $(".endDate").val(formattedDate);

    let bucksId = $("input[name='bucksId']").val();

    // 검색 버튼 클릭 시 searchSalesData 함수 호출
    $("button.search-btn").on("click", function() {
        searchSalesData(); // 페이지 넘버 없이 호출할 경우 기본 1페이지로 설정됨
    });

    function searchSalesData(pageNum=1) {
        let startDate = $(".startDate").val();
        let endDate = $(".endDate").val();

        // 날짜 입력 필드가 비어 있을 경우 경고 메시지 표시
        if (!startDate || !endDate) {
            alert("날짜를 모두 입력해 주세요.");
            return; // 함수 실행 중단
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/store_searchSales.ajax',
            type: 'GET',
            data: {
                bucksId: bucksId,
                pageNum: pageNum,
                startDate: startDate,
                endDate: endDate
            },
            success: function(res) {
                let salesListBody = $('.salesList');
                salesListBody.empty();

                if (res.salesList.length === 0) {
                    salesListBody.append('<tr><td colspan="6">매출 내역이 없습니다.</td></tr>');
                } else {
                    res.salesList.forEach(function(item) {
                        salesListBody.append(
                            '<tr>'+
                                '<td>'+item.payhistoryDate +'</td>'+
                                '<td>'+ item.payhistoryNum+'</td>'+
                                '<td>'+ item.extractedOrderCode+'</td>'+
                                '<td>'+item.menuName+'</td>'+
                                '<td>'+item.payhistoryPrice.toLocaleString()+'원</td>'+
                            '</tr>'
                        );
                    });
                }

                // 총 매출액 갱신
                $('.totalSalesAmount').text(res.totalSalesAmount.toLocaleString() + '원');

                // 페이징 처리 갱신
                updatePagination(res);
            },
            error: function(err) {
                console.error("Error: ", err);
            }
        });
    }

 // 페이지네이션을 업데이트하는 함수
    function updatePagination(response) {
     var $pagination = $('.pagination');
     $pagination.empty(); // 기존 페이징 요소를 모두 제거

     if (response && response.pageCount > 0) {
         var currentPage = response.currentPage ; // 현재 페이지 번호
         var totalPages = response.pageCount; // 전체 페이지 수
         var startPage =  response.startPage; // 현재 페이지 블록의 시작 페이지
         var endPage = response.endPage; // 현재 페이지 블록의 끝 페이지

         // 이전 페이지 블록으로 이동하는 버튼
         if (totalPages <= 1) {
            $pagination.append('<a href="javascript:;" class="page_active" data-page="1">1</a>');
        } else {

	         if (startPage > 1) {
	             $pagination.append('<a class="page_btn prev_btn" href="javascript:;" data-page="' + (startPage - 3) + '"><img src="../../images/icons/arrow.png"></a>');
	         }

         // 페이지 번호 링크 생성
         for (var i = startPage; i <= endPage; i++) {
             if (i == currentPage) {
                 $pagination.append('<a href="javascript:;" class="page_active" data-page="' + i + '">' + i + '</a>');
             } else {
                 $pagination.append('<a href="javascript:;" class="page-link" data-page="' + i + '">' + i + '</a>');
             }
         }

         // 다음 페이지 블록으로 이동하는 버튼
         if (endPage < totalPages) {
             $pagination.append('<a class="page_btn next_btn" href="javascript:;" data-page="' + (startPage + 3) + '"><img src="../../images/icons/arrow.png"></a>');
         }
        }
         // 페이지 클릭 이벤트 추가
         $('.page-link').on('click', function() {
             var pageNum = $(this).data('page'); // pageNum으로 이름 변경
             searchSalesData(pageNum); // 페이지 데이터를 비동기적으로 로드
         });

         $('.prev_btn, .next_btn').on('click', function() {
             var pageNum = $(this).data('page'); // pageNum으로 이름 변경
             searchSalesData(pageNum); // 페이지 데이터를 비동기적으로 로드
         });
     }
 
 };
 


    // 카테고리 선택에 따른 데이터 로드 함수
    function selectCate(pageNum = 1) {
        let menuCate = $('input[name="menu_cate"]:checked').val() || '';
        let disertCate = $('input[name="disert_cate"]:checked').val() || '';
        let mdCate = $('input[name="Md_cate"]:checked').val() || '';

        $.ajax({
            url: '${pageContext.request.contextPath}/store_selectCate.ajax',
            type: 'GET',
            data: {
                bucksId: bucksId,
                menu_cate: menuCate,
                disert_cate: disertCate,
                Md_cate: mdCate,
                pageNum: pageNum
            },
            success: function(res) {
                let salesListBody = $('.salesList');
                salesListBody.empty();

                if (res.salesList.length === 0) {
                    salesListBody.append('<tr><td colspan="6">매출 내역이 없습니다.</td></tr>');
                } else {
                    res.salesList.forEach(function(item) {
                        salesListBody.append(
                            '<tr>'+
                                '<td>'+item.payhistoryDate +'</td>'+
                                '<td>'+ item.payhistoryNum+'</td>'+
                                '<td>'+ item.extractedOrderCode+'</td>'+
                                '<td>'+item.menuName+'</td>'+
                                '<td>'+item.totalItemPrice.toLocaleString()+'원</td>'+
                            '</tr>'
                        );
                    });
                }

                // 총 매출액 갱신
                $('.totalSalesAmount').text(res.totalSalesAmount.toLocaleString() + '원');

                // 페이징 처리 갱신
                updatePagination(res.totalPageCount, res.currentPage);
            },
            error: function(err) {
                console.error("Error: ", err);
            }
        });
    }

    // 탭 변경 시 검색 창, 리스트 리셋 및 카테고리 초기화
    $(".tab_btn").each(function() {
        $(this).click(function(e) {
            let $btn = $(this).data('tab');

            // '전체' 탭을 누르면 특정 경로로 이동
            if ($btn === 'cate_all') {
                window.location.href = '${pageContext.request.contextPath}/store_sales.do';
                return; // 함수 종료
            }

            // 모든 체크박스 초기화
            $('input[type="checkbox"]').prop('checked', false);

            // 탭에 따라 해당하는 "전체" 체크박스 선택
            if ($btn === 'cate_drink') {
                $('input[name="menu_cate"][value="B"]').prop('checked', true);
            } else if ($btn === 'cate_disert') {
                $('input[name="disert_cate"][value="C"]').prop('checked', true);
            } else if ($btn === 'cate_Md') {
                $('input[name="Md_cate"][value="M"]').prop('checked', true);
            }

            // 선택된 탭의 컨텐츠 활성화
            $('.tab-content').removeClass('s_active');
            $('#'+$btn).addClass('s_active');

            // 탭 변경 시 리스트와 매출액 초기화
            $('.salesList').empty();
            $('.salesList').append('<tr><td colspan="6">매출 내역이 없습니다.</td></tr>');
            $('.totalSalesAmount').text('0원');

            // 페이징도 초기화
            $('.pagination').empty();

            // 탭 변경 시 새로운 데이터 로드 및 페이지네이션 갱신
            selectCate(); // 카테고리에 따라 데이터를 다시 가져오고 페이지네이션 갱신
        });
    });

    // 음료 카테고리 체크박스 조건 선택 시 메뉴 리스트 재정렬
    $('input[name="menu_cate"]').on('change', function() {
        $('input[name="menu_cate"]').not(this).prop('checked', false);
        if ($('input[name="menu_cate"]:checked').length === 0) {
            $(this).prop('checked', true);
        }
        selectCate();
    });

    // 디저트 카테고리 체크박스 조건 선택 시 메뉴 리스트 재정렬
    $('input[name="disert_cate"]').on('change', function() {
        $('input[name="disert_cate"]').not(this).prop('checked', false);
        if ($('input[name="disert_cate"]:checked').length === 0) {
            $(this).prop('checked', true);
        }
        selectCate();
    });

    // MD 카테고리 체크박스 조건 선택 시 메뉴 리스트 재정렬
    $('input[name="Md_cate"]').on('change', function() {
        $('input[name="Md_cate"]').not(this).prop('checked', false);
        if ($('input[name="Md_cate"]:checked').length === 0) {
            $(this).prop('checked', true);
        }
        selectCate();
    });

    // 다른 탭 이동 시 검색 창, 리스트 리셋
    $(".tab_btn").each(function() {
        $(this).click(function(e) {
            let $btn = $(this).data('tab');
            $('.tab-content').removeClass('s_active');
            $('#'+$btn).addClass('s_active');
        });
    });
});
</script>