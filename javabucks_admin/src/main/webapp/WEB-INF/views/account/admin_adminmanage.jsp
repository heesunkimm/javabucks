<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <!-- s: content -->
    <section id="admin_adminmanage" class="content accountmanage">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>관리자 계정관리</p>
            </div>

            <div class="select_box">
                <form name="searchForm" action="/searchAdmin.do" method="post">
                    <div class="search_box">
                        <div style="width: 100%;">
                            <label>등록일
	                            <input type="date" name="startDate" value="">
	                        </label>
	                        <label>~
	                            <input type="date" name="endDate" value="">
	                        </label>
                            <label style="display: inline-flex; align-items: center;">삭제회원 포함
                                <input type="checkbox" name="enable" value="" onchange="toggleEnableValue(this)">
                            </label>
                        </div>
                        <label>아이디
                            <input type="text" name="userId" value="">
                        </label>
                        
                        <label>권한
                            <select name="authority">
                            	<option value="">전체</option>
                                <option value="Normal">기본권한</option>
                                <option value="admin">관리자권한</option>
                            </select>
                        </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
	                <div class="btn_box">
	                    <button type="button" onclick="location.href='/inputAdmin.do'">관리자계정등록</button>
	                </div>
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>등록일</th>
                                <th>아이디</th>
                                <th>이메일</th>
                                <th>권한</th>
                                <th>삭제여부</th>
                                <th>수정</th>
                                <th>탈퇴</th>
                            </tr>
                        </thead>
                        
                        <tbody >
                        <c:forEach items="${adminList}" var ="admin">
                            <tr>
                                <td>${fn:substring(admin.adminJoindate, 0, 10)}</td>
                                <td>${admin.adminId}</td>
                                <td>${admin.adminEmail}</td>
                                <td>${admin.adminAuthority}</td>
                                <td>
                                	<c:choose>
								       <c:when test="${admin.adminEnable == 'Y'}">
								           활성화
								       </c:when>
								       <c:otherwise>
								           탈퇴
								       </c:otherwise>
								   </c:choose>
							   </td>
							   <td>
							    <c:choose>
                                        <c:when test="${admin.adminEnable == 'Y'}">
                                            <button class="editBtn" type="button" onclick="location.href='/editAdmin.do?adminId=${admin.adminId}'">수정</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="editBtn disabled_btn" type="button" disabled>수정</button>
                                        </c:otherwise>
                                    </c:choose>
							   </td>
                              <td>
			                    <c:choose>
			                        <c:when test="${admin.adminEnable == 'Y'}">
			                            <a class="delBtn" href="/deleteAdmin.do?adminId=${admin.adminId}" onclick="return confirm('정말로 이 계정을 탈퇴하시겠습니까?');">삭제</a>
			                        </c:when>
			                        <c:otherwise>
			                            <button class="delBtn disabled_btn" type="button" disabled>탈퇴</button>
			                        </c:otherwise>
			                    </c:choose>
			                </td>
                            </tr>
                         </c:forEach>
                        </tbody>
                       
                    </table>
                    <!--  페이징 -->
			<div class="pagination pagination">
			    <c:if test="${startPage > pageBlock}"> 
			        <a class="page_btn prev_btn" href="admin_adminmanage.do?pageNum=${startPage-3}">
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
			        <a href="admin_adminmanage.do?pageNum=${i}" class="${activeClass} page_num">${i}</a>
			    </c:forEach>
			    
			    <c:if test="${pageCount > endPage}">
			        <a class="page_btn next_btn" href="admin_adminmanage.do?pageNum=${startPage+3}">
			        	<img src="../../images/icons/arrow.png">
			        </a>
			    </c:if>
			</div>
                    
					<!-- e:페이징 -->
                </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
    <jsp:include page="../admin_bottom.jsp"/>
    
<script>

$(document).ready(function() {
    

    // 기존 코드
    $('form[name="searchForm"]').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        fetchPageData(1); // 첫 페이지 데이터를 가져옴
    });
    function fetchPageData(pageNum) { // pageNum으로 이름 변경
        $.ajax({
            url: '/searchAdmin.do',
            type: 'POST',
            data: {
                startDate: $('input[name="startDate"]').val(),
                endDate: $('input[name="endDate"]').val(),
                enable: $('input[name="enable"]').is(':checked') ? '' : 'Y',
                adminId: $('input[name="userId"]').val(),
                adminEmail1: $('input[name="adminEmail1"]').val(),
                adminEmail2: $('select[name="adminEmail2"]').val(),
                authority: $('select[name="authority"]').val(),
                pageNum: pageNum, // 여기에서 pageNum으로 데이터 전송
                itemsPerPage: 5 // 페이지당 항목 수를 서버로 전달
            },
            success: function(response) {
              //  console.log("Received response: ", response);  // response 구조를 확인하세요.
                updateSearchResults(response);  // 응답 데이터를 기반으로 검색 결과와 페이징 갱신
            },
            error: function(xhr, status, error) {
                console.error('페이지 데이터를 불러오는 중 오류 발생:', error);
            }
        });
    }
    
    function updateSearchResults(response) {
        var $tbody = $('.search_list tbody');
        $tbody.empty(); // 기존 내용을 지움

        if (response && response.adminList && response.adminList.length > 0) {
            $.each(response.adminList, function(index, admin) {
                var enableText = admin.adminEnable === 'Y' ? '활성화' : '탈퇴';
                var adminJoindateFormatted = admin.adminJoindate.substring(0, 10);

                var rowHtml = '<tr>' +
                              '<td>' + adminJoindateFormatted + '</td>' +
                              '<td>' + admin.adminId + '</td>' +
                              '<td>' + admin.adminEmail + '</td>' +
                              '<td>' + admin.adminAuthority + '</td>' +
                              '<td>' + enableText + '</td>' +
                              '<td>' +
                                  (admin.adminEnable === 'Y' 
                                  ? '<button class="editBtn" type="button" onclick="location.href=\'/editAdmin.do?adminId=' + admin.adminId + '\'">수정</button>'
                                  : '<button class="editBtn disabled_btn" type="button" disabled>수정</button>') +
                              '</td>' +
                              '<td>' +
                                  (admin.adminEnable === 'Y' 
                                  ? '<a class="delBtn" href="/deleteAdmin.do?adminId=' + admin.adminId + '" onclick="return confirm(\'정말로 이 계정을 탈퇴하시겠습니까?\');">삭제</a>'
                                  : '<button class="delBtn disabled_btn" type="button" disabled>탈퇴</button>') +
                              '</td>' +
                              '</tr>';
                $tbody.append(rowHtml);
            });
        } else {
            $tbody.append('<tr><td colspan="7">검색 결과가 없습니다.</td></tr>');
        }

        // 페이지네이션을 업데이트
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
            $pagination.append('<a href="javascript:;" class="page_num" data-page="1">1</a>');
        } else {
            // 이전 페이지 블록으로 이동하는 버튼
            if (startPage > 1) {
                $pagination.append('<a class="page_num prev_btn" href="javascript:;" data-page="' + (startPage - 3) + '"><img src="../../images/icons/arrow.png"></a>');
            }

        // 페이지 번호 링크 생성
        for (var i = startPage; i <= endPage; i++) {
            if (i == currentPage) {
                $pagination.append('<a href="javascript:;" class="page_active page_num" data-page="' + i + '">'+ i + '</a>');
            } else {
                $pagination.append('<a href="javascript:;" class="page_num" data-page="' + i + '">' + i + '</a>');
            }
        }

        // 다음 페이지 블록으로 이동하는 버튼
        if (endPage < totalPages) {
            $pagination.append('<a class="page_num next_btn" href="javascript:;" data-page="' + (startPage + 3) + '"><img src="../../images/icons/arrow.png"></a>');
        }
        }

        // 페이지 클릭 이벤트 추가
        $('.page_num	').on('click', function() {
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

    // 오류 메시지 확인 및 알림창 표시
    var errorMessage = "${errorMessage}";
    if (errorMessage) {
        alert(errorMessage);
    }
}


</script>