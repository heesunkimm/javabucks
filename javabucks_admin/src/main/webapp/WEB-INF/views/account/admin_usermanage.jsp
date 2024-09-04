<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- s: content -->
    <section id="admin_usermanage" class="content accountmanage">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>유저 계정관리</p>
            </div>

            <div class="select_box">
                <form name="searchForm" action="/searchUser.do" method="post">
                    <div class="search_box">
                        <div style="width: 100%;">
                            <label>등록일
                                <input type="date" name="startDate" value="">
                            </label>
                            <label>~
                                <input type="date" name="endDate" value="">
                            </label>
                            <label style="display: inline-flex; align-items: center;">탈퇴회원 포함
                                <input type="checkbox" name="enable" value="">
                            </label>
                        </div>
                        <label>아이디
                            <input type="text" name="userId" value="">
                        </label>
                        <label>닉네임
                            <input type="text" name="userNickname" value="">
                        </label>
                        <label>등급
                            <select name="gradeCode">
                            	<option value="">전체</option>
                                <option value="welcome">Welcome</option>
                                <option value="green">Green</option>
                                <option value="gold">Gold</option>
                            </select>
                        </label>
                        <button type="submit">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>등록일</th>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>닉네임</th>
                                <th>이메일</th>
                                <th>핸드폰번호</th>
                                <th>등급</th>
                                <th>탈퇴여부</th>
                                <th>수정</th>
                                <th>탈퇴</th>
                            </tr>
                        </thead>
                        
                        <tbody >
                        <c:forEach items="${userList}" var ="user">
                            <tr>
                                <td>${fn:substring(user.userJoindate, 0, 10)}</td>
                                <td>${user.userId}</td>
                                <td>${user.userName}</td>
                                <td>${user.userNickname != null ? user.userNickname : '-'}</td>
						        <td>${user.fullEmail != null ? user.fullEmail : '-'}</td>
						        <td>${user.fullPhoneNumber != null ? user.fullPhoneNumber : '-'}</td>
                                <td>${user.gradeCode}</td>
                                <td>
                                	<c:choose>
								       <c:when test="${user.userEnable == 'Y'}">
								           활성화
								       </c:when>
								       <c:otherwise>
								           탈퇴
								       </c:otherwise>
								   </c:choose>
							   </td>
							   <td>
							    <c:choose>
                                        <c:when test="${user.userEnable == 'Y'}">
                                            <button type="button" onclick="location.href='/editUser.do?userId=${user.userId}'">수정</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" disabled>수정</button>
                                        </c:otherwise>
                                    </c:choose>
							   </td>
                              <td>
			                    <c:choose>
			                        <c:when test="${user.userEnable == 'Y'}">
			                            <a href="/deleteUser.do?userId=${user.userId}" onclick="return confirm('정말로 이 계정을 탈퇴하시겠습니까?');">삭제</a>
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
                    <c:set var="startPage" value="${1}"/>
					<c:set var="endPage" value="${3}"/>
					
					<c:if test="${currentPage > endPage}">
					    <c:set var="startPage" value="${currentPage}"/>
					    <c:set var="endPage" value="${currentPage + 2}"/>
					</c:if>
					
					<c:if test="${endPage > pageCount}">
					    <c:set var="endPage" value="${pageCount}"/>
					</c:if>
					
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
					        <a class="page_btn next_btn" href="?page=${startPage+3}">
					            <img src="../../images/icons/arrow.png">
					        </a>
					    </c:if>
					</div>
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
            url: '/searchUser.do',
            type: 'POST',
            data: {
                startDate: $('input[name="startDate"]').val(),
                endDate: $('input[name="endDate"]').val(),
                enable: $('input[name="enable"]').is(':checked') ? '' : 'Y',
                userId: $('input[name="userId"]').val(),
                userNickname: $('input[name="userNickname"]').val(),
                gradeCode: $('select[name="gradeCode"]').val(),
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

        if (response && response.userList && response.userList.length > 0) { // userList 확인
            $.each(response.userList, function(index, user) {
                var enableText = user.userEnable === 'Y' ? '활성화' : '탈퇴';
                var userJoindateFormatted = user.userJoindate.substring(0, 10);
                
                var userNickname = user.userNickname ? user.userNickname : '-';
                var fullEmail = user.fullEmail ? user.fullEmail : '-';
                var fullPhoneNumber = user.fullPhoneNumber ? user.fullPhoneNumber : '-';

                var rowHtml = '<tr>' +
                              '<td>' + userJoindateFormatted + '</td>' +
                              '<td>' + user.userId + '</td>' +
                              '<td>' + user.userName + '</td>' +
                              '<td>' + userNickname + '</td>' +
                              '<td>' + fullEmail + '</td>' +
                              '<td>' + fullPhoneNumber + '</td>' +
                              '<td>' + user.gradeCode + '</td>' +
                              '<td>' + enableText + '</td>' +
                              '<td>' +
                                  (user.userEnable === 'Y' 
                                  ? '<button type="button" onclick="location.href=\'/editUser.do?userId=' + user.userId + '\'">수정</button>'
                                  : '<button type="button" disabled>수정</button>') +
                              '</td>' +
                              '<td>' +
                                  (user.userEnable === 'Y' 
                                  ? '<a href="/deleteUser.do?userId=' + user.userId + '" onclick="return confirm(\'정말로 이 계정을 탈퇴하시겠습니까?\');">탈퇴</a>'
                                  : '<button type="button" disabled>탈퇴</button>') +
                              '</td>' +
                              '</tr>';
                $tbody.append(rowHtml);
            });
        } else {
            $tbody.append('<tr><td colspan="10">검색 결과가 없습니다.</td></tr>');
        }

        // 페이지네이션을 업데이트
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

    // 오류 메시지 확인 및 알림창 표시
    var errorMessage = "${errorMessage}";
    if (errorMessage) {
        alert(errorMessage);
    }
}



</script>