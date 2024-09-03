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
                    <div style="width: 100%;">
                        <label>등록일
                            <input type="date" name="startDate" value="">
                        </label>
                        <label>~
                            <input type="date" name="endDate" value="">
                        </label>
                    </div>
                    <label>지점등록번호
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
                <c:forEach items="${bucksList}" var ="bucks">
                      <li class="search_item">
                        <ul class="search_toolbar">
                            <li style="width: 12%;">지점명</li>
                            <li style="width: 13%;">지점등록번호</li>
                            <li style="width: 10%;">점주명</li>
                            <li style="width: 30%;">위치</li>
                            <li style="width: 15%;">전화번호</li>
                            <li style="width: 18%;">운영 시간</li> 
                            <li style="width: 5%;">운영여부</li>
                            <li style="width: 7%;"></li>
                        </ul>
                        
                         <ul class="search_cont">
                           <li class="store_name" style="width: 12%; text-align: center;">${bucks.bucksName}</li>
                            <li class="store_code" style="width: 13%; text-align: center;">${bucks.bucksId}</li>
                            <li class="store_owner" style="width: 10%; text-align: center;">${bucks.bucksOwner}</li>
                            <li class="store_location" style="width: 30%; text-align: center;">${bucks.bucksLocation}</li>
                            <li class="store_tel" style="width: 15%; text-align: center;">${bucks.bucksTel1}-${bucks.bucksTel2}-${bucks.bucksTel3}</li>
                            <li class="store_start_time" style="width: 18%; text-align: center;">
                                ${fn:substring(bucks.bucksStart, 11, 16)} - ${fn:substring(bucks.bucksEnd, 11, 16)}
                                 </li>
                            <li class="store_tel" style="width: 3%; text-align: center;">${bucks.bucksEnable}</li>
                            
                            <li style="width: 9%; text-align: center;">
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
              <c:set var="startPage" value="${currentPage <= 2 ? 1 : (currentPage % 3 == 0 ? currentPage - 2 : (currentPage - (currentPage % 3) + 1))}"/>
				<c:set var="endPage" value="${startPage + 2 > pageCount ? pageCount : startPage + 2}"/>
				
				<div class="pagination">
				    <c:if test="${startPage > 1}">
				        <a class="page_btn prev_btn" href="?page=${startPage - 1}">
				            <img src="../../images/icons/arrow.png">
				        </a>
				    </c:if>
				
				    <c:forEach var="i" begin="${startPage}" end="${endPage}">
				        <c:choose>
				            <c:when test="${i == currentPage}">
				                <a href="?page=${i}" class="page_active">${i}</a>
				            </c:when>
				            <c:otherwise>
				                <a href="?page=${i}" class="page">${i}</a>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				
				    <c:if test="${endPage < pageCount}">
				        <a class="page_btn next_btn" href="?page=${startPage + 3}">
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

    function fetchPageData(page) {
        $.ajax({
            url: '/searchBucks.do',
            type: 'POST',
            data: {
                bucksName: $('input[name="bucksName"]').val(),
                bucksId: $('input[name="bucksId"]').val(),
                bucksLocation: $('select[name="bucksLocation"]').val(),
                startDate: $('input[name="startDate"]').val(),
                endDate: $('input[name="endDate"]').val(),
                page: page,
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
        updatePagination(response.currentPage, response.pageCount);
    }

    function updatePagination(currentPage, pageCount) {
        $('.pagination').empty(); // 기존 페이지네이션을 비움

        let startPage = currentPage <= 2 ? 1 : (currentPage % 3 === 0 ? currentPage - 2 : (currentPage - (currentPage % 3) + 1));
        let endPage = startPage + 2 > pageCount ? pageCount : startPage + 2;

        if (startPage > 1) {
            $('.pagination').append('<a class="page_btn prev_btn" href="#" data-page="' + (startPage - 1) + '"><img src="../../images/icons/arrow.png"></a>');
        }

        for (let i = startPage; i <= endPage; i++) {
            if (i === currentPage) {
                $('.pagination').append('<a href="#" class="page_active" data-page="' + i + '">' + i + '</a>');
            } else {
                $('.pagination').append('<a href="#" class="page" data-page="' + i + '">' + i + '</a>');
            }
        }

        if (endPage < pageCount) {
            $('.pagination').append('<a class="page_btn next_btn" href="#" data-page="' + (startPage + 3) + '"><img src="../../images/icons/arrow.png"></a>');
        }

        // 페이징 버튼 클릭 이벤트 핸들러 설정
        $('.pagination a').on('click', function(event) {
            event.preventDefault();
            let page = $(this).data('page');
            fetchPageData(page); // 클릭한 페이지로 데이터를 다시 로드
        });
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