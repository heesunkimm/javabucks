<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.paging {
    display: flex;
    justify-content: center;
    margin: 20px 0;
}

.paging a {
    margin: 0 3px; /* 좌우 간격을 줄여 버튼 사이의 간격을 좁힘 */
    padding: 5px 10px; /* 패딩을 줄여 버튼을 작게 만듦 */
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    text-decoration: none;
    color: #333;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    font-size: 14px; /* 폰트 크기를 줄여 버튼을 더 작게 만듦 */
}

.paging a.active {
    background-color: #006242;
    color: white;
    border-color: #006242;
}

.paging a:hover {
    background-color: #0056b3;
    color: white;
}

</style>
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
                            <li style="width: 32%;">위치</li>
                            <li style="width: 15%;">전화번호</li>
                            <li style="width: 8%;">영업상태</li>
                            <li style="width: 10%;"></li>
                        </ul>
                        
                         <ul class="search_cont">
                           <li class="store_name" style="width: 12%; text-align: center;">${bucks.bucksName}</li>
                            <li class="store_code" style="width: 13%; text-align: center;">${bucks.bucksId}</li>
                            <li class="store_owner" style="width: 10%; text-align: center;">${bucks.bucksOwner}</li>
                            <li class="store_location" style="width: 32%; text-align: center;">${bucks.bucksLocation}</li>
                            <li class="store_tel" style="width: 15%; text-align: center;">${bucks.bucksTel1}-${bucks.bucksTel2}-${bucks.bucksTel3}</li>
                            <li class="store_tel" style="width: 8%; text-align: center;">
                            	<c:choose>
								       <c:when test="${bucks.bucksEnable == 'Y'}">
								           영업중
								       </c:when>
								       <c:otherwise>
								           영업정지
								       </c:otherwise>
								   </c:choose>
                            </li>
                            <li style="width: 10%; text-align: center;">
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
                <div class="paging">
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
                    '<ul class="search_toolbar">'+
                    '<li style="width: 20%;">지점명</li>'+
                    '<li style="width: 20%;">지점등록번호</li>'+
                    '<li style="width: 10%;">점주명</li>'+
                    '<li style="width: 20%;">위치</li>'+
                    '<li style="width: 15%;">전화번호</li>'+
                    '<li style="width: 15%;"></li>'+
                '</ul>'+
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
        }

        

        $('.paging').empty(); // 기존 페이지네이션을 비움

        if (response.pageCount > 1) {
            let startPage = response.currentPage - 2;
            let endPage = response.currentPage + 2;

            if (startPage < 1) startPage = 1;
            if (endPage > response.pageCount) endPage = response.pageCount;

            console.log("Creating pagination from", startPage, "to", endPage);

            $('.paging').append('<a href="#" class="firstPage" data-page="1">First</a>');

            if (response.currentPage > 1) {
                $('.paging').append('<a href="#" class="prevPage" data-page="' + (response.currentPage - 1) + '">Previous</a>');
            }

            for (let i = startPage; i <= endPage; i++) {
                $('.paging').append('<a href="#" class="pageNumber ' + (i === response.currentPage ? 'active' : '') + '" data-page="' + i + '">' + i + '</a>');
            }

            if (response.currentPage < response.pageCount) {
                $('.paging').append('<a href="#" class="nextPage" data-page="' + (response.currentPage + 1) + '">Next</a>');
            }

            $('.paging').append('<a href="#" class="lastPage" data-page="' + response.pageCount + '">End</a>');

            console.log("Pagination HTML:", $('.paging').html());  // 페이징 HTML을 콘솔에 출력
        }

        $(document).on('click', '.paging a', function(event) {
            event.preventDefault();
            let page = $(this).data('page');
            fetchPageData(page); // 선택한 페이지로 다시 AJAX 요청
        });
    }
});


</script>