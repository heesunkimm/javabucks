<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <div class="email_box">
                            <label>이메일
                                <input type="text" name="adminEmail1" value="">
                            </label>
                            @
                            <label>
                                <select name="adminEmail2">
                                    <option value="">naver.com</option>
                                    <option value="">nate.com</option>
                                    <option value="">gmail.com</option>
                                </select>
                            </label>
                        </div>
                        <label>권한
                            <select name="authority">
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
                                <td>${admin.adminJoindate}</td>
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
                                            <button type="button" onclick="location.href='/editAdmin.do?adminId=${admin.adminId}'">수정</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" disabled>수정</button>
                                        </c:otherwise>
                                    </c:choose>
							   </td>
                              <td>
			                    <c:choose>
			                        <c:when test="${admin.adminEnable == 'Y'}">
			                            <a href="/deleteAdmin.do?adminId=${admin.adminId}" onclick="return confirm('정말로 이 계정을 탈퇴하시겠습니까?');">삭제</a>
			                        </c:when>
			                        <c:otherwise>
			                            <button type="button" disabled>탈퇴</button>
			                        </c:otherwise>
			                    </c:choose>
			                </td>
                            </tr>
                         </c:forEach>
                        </tbody>
                       
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${pageCount}">
					        <c:choose>
					            <c:when test="${i == currentPage}">
					                <span>${i}</span>
					            </c:when>
					            <c:otherwise>
					                <a href="?page=${i}">${i}</a>
					            </c:otherwise>
					        </c:choose>
					    </c:forEach>
                    </div>    
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
    function fetchPageData(page) {
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
                page: page,
                itemsPerPage: 5 // 페이지당 항목 수를 서버로 전달
            },
            success: function(response) {
                console.log("Received response: ", response);  // response 구조를 확인하세요.
                updateSearchResults(response);  // 응답 데이터를 기반으로 검색 결과와 페이징 갱신
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            }
        });
    }
    
    function updateSearchResults(response) {
        var $tbody = $('.search_list tbody');
        $tbody.empty(); // 기존 내용을 지움

        if (response && response.adminList && response.adminList.length > 0) {
            $.each(response.adminList, function(index, admin) {
                var enableText = admin.adminEnable === 'Y' ? '활성화' : '탈퇴';

                var rowHtml = '<tr>' +
                              '<td>' + admin.adminJoindate + '</td>' +
                              '<td>' + admin.adminId + '</td>' +
                              '<td>' + admin.adminEmail + '</td>' +
                              '<td>' + admin.adminAuthority + '</td>' +
                              '<td>' + enableText + '</td>' +
                              '<td>' +
                                  (admin.adminEnable === 'Y' 
                                  ? '<button type="button" onclick="location.href=\'/editAdmin.do?adminId=' + admin.adminId + '\'">수정</button>'
                                  : '<button type="button" disabled>수정</button>') +
                              '</td>' +
                              '<td>' +
                                  (admin.adminEnable === 'Y' 
                                  ? '<a href="/deleteAdmin.do?adminId=' + admin.adminId + '" onclick="return confirm(\'정말로 이 계정을 탈퇴하시겠습니까?\');">삭제</a>'
                                  : '<button type="button" disabled>탈퇴</button>') +
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
        $pagination.empty();

        if (response && response.pageCount > 1) {
            for (var i = 1; i <= response.pageCount; i++) {
                var pageHtml = '<a href="javascript:;" class="page-link" data-page="' + i + '">' + i + '</a>';
                $pagination.append(pageHtml);
            }

            // 페이지 클릭 이벤트 추가
            $('.page-link').on('click', function() {
                var page = $(this).data('page');
                fetchPageData(page);
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