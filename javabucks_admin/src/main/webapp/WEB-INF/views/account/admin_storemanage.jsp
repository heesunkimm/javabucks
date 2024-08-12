<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                    <label>위치
                        <select name="bucksLocation">
                            <option value="">전체</option>
                            <option value="서울">서울</option>
                            <option value="광주">광주</option>
                            <option value="대구">대구</option>
                            <option value="대전">대전</option>
                            <option value="부산">부산</option>
                            <option value="울산">울산</option>
                            <option value="인천">인천</option>
                            <option value="창원">창원</option>
                            <option value="수원">수원</option>
                        </select>
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
                            <li style="width: 20%;">지점명</li>
                            <li style="width: 20%;">지점등록번호</li>
                            <li style="width: 10%;">점주명</li>
                            <li style="width: 20%;">위치</li>
                            <li style="width: 15%;">전화번호</li>
                            <li style="width: 15%;"></li>
                        </ul>
                        
                         <ul class="search_cont">
                           <li class="store_name" style="width: 20%; text-align: center;">${bucks.bucksName}</li>
                            <li class="store_code" style="width: 20%; text-align: center;">${bucks.bucksId}</li>
                            <li class="store_owner" style="width: 10%; text-align: center;">${bucks.bucksOwner}</li>
                            <li class="store_location" style="width: 20%; text-align: center;">${bucks.bucksLocation}</li>
                            <li class="store_tel" style="width: 15%; text-align: center;">${jbuck.bucksTel1} - ${bucks.bucksTel2} - ${bucks.bucksTel3}</li>
                            <li style="width: 15%; text-align: center;"><button class="store_btn" type="button" onclick="location.href='/editbucks.do?id=${bucks.bucksId}'" >상세보기</button></li>
                        </ul>
                       
                    </li>
                    </c:forEach>
                
                
                <!-- s: 페이징  -->
                <div class="pagination">
            	<c:if test="${pageCount > 1}">
                	<c:set var="startPage" value="${currentPage - 2}"/>
                	
                <c:if test="${startPage lt 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                
                	<c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${endPage gt pageCount}">
                    <c:set var="endPage" value="${pageCount}"/>
                </c:if>
                
                <c:url value="/storemanage.do" var="firstPageUrl">
                    <c:param name="page" value="1"/>
                </c:url>
                
                <c:url value="/storemanage.do" var="prevPageUrl">
                    <c:param name="page" value="${currentPage - 1}"/>
                </c:url>
                
                <a href="${firstPageUrl}">First</a>
                <c:if test="${currentPage > 1}">
                    <a href="${prevPageUrl}">Previous</a>
                </c:if>
                
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
                    <c:url value="/storemanage.do" var="pageUrl">
                        <c:param name="page" value="${pageNumber}"/>
                    </c:url>
                    <a href="${pageUrl}" class="${pageNumber == currentPage ? 'active' : ''}">${pageNumber}</a>
                </c:forEach>
                <c:url value="/storemanage.do" var="nextPageUrl">
                    <c:param name="page" value="${currentPage + 1}"/>
                </c:url>
                <c:if test="${currentPage lt pageCount}">
                    <a href="${nextPageUrl}">Next</a>
                </c:if>
                <c:url value="/storemanage.do" var="lastPageUrl">
                    <c:param name="page" value="${pageCount}"/>
                </c:url>
                <a href="${lastPageUrl}">End</a>
            </c:if>
        </div>
        <!-- e:페이징 -->
             </ul>   
                
            
        </div>
    </section>
<jsp:include page="../admin_bottom.jsp"/>
<script>



function loadPage(pageNumber) {
    $.ajax({
        url: '/searchBucks.do',
        type: 'POST',
        data: {
            bucksName: $('input[name="bucksName"]').val(),
            bucksId: $('input[name="bucksId"]').val(),
            bucksLocation: $('select[name="bucksLocation"]').val(),
            startDate: $('input[name="startDate"]').val(),
            endDate: $('input[name="endDate"]').val(),
            page: pageNumber
        },
        success: function(response) {
            // 기존 검색 결과를 완전히 초기화
            $('.search_list').empty();

            // 새로운 검색 결과 추가
            $.each(response.bucksList, function(index, store) {
                $('.search_list').append(
                    '<li class="search_item">' +
                    '<ul class="search_toolbar">' +
                    '<li style="width: 20%;">지점명</li>' +
                    '<li style="width: 20%;">지점등록번호</li>' +
                    '<li style="width: 10%;">점주명</li>' +
                    '<li style="width: 20%;">위치</li>' +
                    '<li style="width: 15%;">전화번호</li>' +
                    '<li style="width: 15%;"></li>' +
                    '</ul>' +
                    '<ul class="search_cont">' +
                    '<li class="store_name" style="width: 20%; text-align: center;">' + store.bucksName + '</li>' +
                    '<li class="store_code" style="width: 20%; text-align: center;">' + store.bucksId + '</li>' +
                    '<li class="store_owner" style="width: 10%; text-align: center;">' + store.bucksOwner + '</li>' +
                    '<li class="store_location" style="width: 20%; text-align: center;">' + store.bucksLocation + '</li>' +
                    '<li class="store_tel" style="width: 15%; text-align: center;">' + store.bucksTel1 + '-' + store.bucksTel2 + '-' + store.bucksTel3 + '</li>' +
                    '<li style="width: 15%; text-align: center;"><button class="store_btn" type="button" onclick="location.href=\'/editbucks.do?id=' + store.bucksId + '\'">상세보기</button></li>' +
                    '</ul>' +
                    '</li>'
                );
            });

            // 페이징 정보 업데이트
            createPagination(pageNumber, response.pageCount);
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error: ' + status + ' - ' + error);
        }
    });
}

$(document).ready(function() {
    // 검색 폼 제출 시 AJAX 요청 처리
    $('form[name="searchForm"]').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음

        // 첫 페이지를 로드 (검색 후 처음 페이지로 이동)
        loadPage(1);
    });

    // 초기 페이지 로드
   loadPage(1);  // 페이지를 처음 로드할 때 첫 페이지부터 로드
});

function createPagination(currentPage, pageCount) {
    var pagination = $('.pagination');
    pagination.empty(); // 기존 페이징 제거

    if (pageCount > 1) {
        // 첫 페이지 버튼
        pagination.append('<a href="#" data-page="1">First</a>');

        // 이전 페이지 버튼
        if (currentPage > 1) {
            pagination.append('<a href="#" data-page="' + (currentPage - 1) + '">Previous</a>');
        }

        // 페이지 번호 버튼
        for (var i = 1; i <= pageCount; i++) {
            var pageLink = $('<a href="#" data-page="' + i + '">' + i + '</a>');
            if (i === currentPage) {
                pageLink.addClass('active');
            }
            pagination.append(pageLink);
        }

        // 다음 페이지 버튼
        if (currentPage < pageCount) {
            pagination.append('<a href="#" data-page="' + (currentPage + 1) + '">Next</a>');
        }

        // 마지막 페이지 버튼
        pagination.append('<a href="#" data-page="' + pageCount + '">End</a>');
    }

    // 페이지 링크 클릭 이벤트 핸들러
    $('.pagination a').click(function (e) {
        e.preventDefault();
        var page = $(this).data('page');
        loadPage(page);
    });
}



</script>