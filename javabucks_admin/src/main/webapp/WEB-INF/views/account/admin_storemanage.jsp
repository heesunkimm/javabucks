<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<section id="admin_storelist" class="content managelist">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점관리</p>
            </div>

            <div class="search_box">
                <form name="searchForm" action="/searchBucks.do" method="post">
                    
                    <label>등록번호
                        <input type="text" name="bucksId" value="">
                    </label>
                    <label>지점명
                        <input type="text" name="bucksName" value="">
                    </label>
                    
                    <button type="submit">검색</button>
                </form>
            </div>

            <div class="list_box">
                <div class="btn_box">
                    <button type="button" onclick="location.href='/inputstore.do'">지점등록</button>
                </div>
                <ul class="search_list bg_beige">
           		<c:set var="activeClass" value="store_dimm" />
                <c:forEach items="${bucksList}" var ="bucks">
               	<li class="search_item">
                    <ul class="search_toolbar">
                        <li style="width: 12%;">지점명</li>
                        <li style="width: 13%;">등록번호</li>
                        <li style="width: 10%;">점주명</li>
                        <li style="width: 25%;">위치</li>
                        <li style="width: 15%;">전화번호</li>
                        <li style="width: 15%;">운영시간</li> 
                        <li style="width: 5%;">운영여부</li>
                        <li style="width: 12%;"></li>
                    </ul>
                    
                     <ul class="search_cont">
                       <li class="store_name" style="width: 12%; text-align: center;">${bucks.bucksName}</li>
                        <li class="store_code" style="width: 13%; text-align: center;">${bucks.bucksId}</li>
                        <li class="store_owner" style="width: 10%; text-align: center;">${bucks.bucksOwner}</li>
                        <li class="store_location" style="width: 25%; text-align: center;">${bucks.bucksLocation}</li>
                        <li class="store_tel" style="width: 15%; text-align: center;">${bucks.bucksTel1}-${bucks.bucksTel2}-${bucks.bucksTel3}</li>
                        <li class="store_start_time" style="width: 15%; text-align: center;">${fn:substring(bucks.bucksStart, 11, 16)} - ${fn:substring(bucks.bucksEnd, 11, 16)}</li>
                        <li class="store_tel" style="width: 5%; text-align: center;">${bucks.bucksEnable}</li>
                        <li style="width: 12%; text-align: center;">
                        <c:choose>
                            <c:when test="${bucks.bucksEnable == 'Y'}">
                                <button type="button" onclick="location.href='/editbucks.do?id=${bucks.bucksId}'" >상세보기</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" disabled>상세보기</button>
                            </c:otherwise>
                        </c:choose>
                        </li>
                    </ul>
               	</li>
                </c:forEach>
                </ul>  
                <!-- s: 페이징  -->
             <div class="pagination pagination">
			    <c:if test="${startPage > pageBlock}"> 
			        <a class="page_btn prev_btn" href="storemanage.do?pageNum=${startPage-3}">
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
			        <a href="storemanage.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
			    </c:forEach>
			    
			    <c:if test="${pageCount > endPage}">
			        <a class="page_btn next_btn" href="storemanage.do?pageNum=${startPage+3}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			</div>
        <!-- e:페이징 -->
              
                
            
        </div>
    </section>
<jsp:include page="../admin_bottom.jsp"/>
<script>
$(document).ready(function() {
    $('form[name="searchForm"]').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        fetchPageData(1); // 첫 페이지 데이터를 가져옴
    });

    function fetchPageData(pageNum) {
        $.ajax({
            url: '/searchBucks.do',
            type: 'POST',
            data: {
                bucksName: $('input[name="bucksName"]').val(),
                bucksId: $('input[name="bucksId"]').val(),
                bucksLocation: $('select[name="bucksLocation"]').val(),
                startDate: $('input[name="startDate"]').val(),
                endDate: $('input[name="endDate"]').val(),
                pageNum: pageNum,
                itemsPerPage: 5 // 페이지당 항목 수를 서버로 전달
            },
            success: function(response) {
                console.log("Received response: ", response);
                updateSearchResults(response); // 응답 데이터를 기반으로 검색 결과와 페이징 갱신
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            }
        });
    }

    function updateSearchResults(response) {
        $('.search_list').empty();

        if (!response.bucksList || response.bucksList.length === 0) {
            $('.search_list').append(
                '<li class="search_item">' +
                '<ul class="search_toolbar">' + 
                '<li style="width: 100%; text-align: center; padding: 20px;">검색에 맞는 지점이 없습니다.</li>' +
                '</ul>' +
                '</li>'
            );
        } else {
            $.each(response.bucksList, function(index, store) {
            	$('.search_list').append(
                        '<li class="search_item">' +
                        '<ul class="search_toolbar">' +
                            '<li style="width: 12%; text-align: center;">지점명</li>' +
                            '<li style="width: 13%; text-align: center;">지점등록번호</li>' +
                            '<li style="width: 10%; text-align: center;">점주명</li>' +
                            '<li style="width: 30%; text-align: center;">위치</li>' +
                            '<li style="width: 15%; text-align: center;">전화번호</li>' +
                            '<li style="width: 18%; text-align: center;">운영 시간</li>' +
                            '<li style="width: 5%; text-align: center;">운영여부</li>' +
                            '<li style="width: 7%;"></li>' +
                        '</ul>' +
                        '<ul class="search_cont">' +
                            '<li class="store_name" style="width: 12%; text-align: center;">' + store.bucksName + '</li>' +
                            '<li class="store_code" style="width: 13%; text-align: center;">' + store.bucksId + '</li>' +
                            '<li class="store_owner" style="width: 10%; text-align: center;">' + store.bucksOwner + '</li>' +
                            '<li class="store_location" style="width: 30%; text-align: center;">' + store.bucksLocation + '</li>' +
                            '<li class="store_tel" style="width: 15%; text-align: center;">' + store.bucksTel1 + '-' + store.bucksTel2 + '-' + store.bucksTel3 + '</li>' +
                            '<li class="store_start_time" style="width: 18%; text-align: center;">' + 
                                store.bucksStart.substring(11, 16) + ' - ' + store.bucksEnd.substring(11, 16) + 
                            '</li>' +
                            '<li class="store_tel" style="width: 5%; text-align: center;">' + store.bucksEnable + '</li>' +
                            '<li style="width: 9%; text-align: center;">' +
                                (store.bucksEnable === 'Y' 
                                    ? '<button type="button" onclick="location.href=\'/editbucks.do?id=' + store.bucksId + '\'">상세보기</button>'
                                    : '<button type="button" disabled>상세보기</button>') +
                            '</li>' +
                        '</ul>' +
                        '</li>'
                    );
                });
            }

        
     // 페이징 처리
        updatePagination(response);
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
             fetchPageData(pageNum); // 페이지 데이터를 비동기적으로 로드
         });

         $('.prev_btn, .next_btn').on('click', function() {
             var pageNum = $(this).data('page'); // pageNum으로 이름 변경
             fetchPageData(pageNum); // 페이지 데이터를 비동기적으로 로드
         });
     }
 }
 });

window.onload = function() {
    // 성공 메시지 확인 및 알림창 표시
    var message = "${message}";
    if (message) {
        alert(message);
    }
}


</script>