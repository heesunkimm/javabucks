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
                      <li class="search_item">
                        <ul class="search_toolbar">
                            <li style="width: 20%;">지점명</li>
                            <li style="width: 20%;">지점등록번호</li>
                            <li style="width: 10%;">점주명</li>
                            <li style="width: 20%;">위치</li>
                            <li style="width: 15%;">전화번호</li>
                            <li style="width: 15%;"></li>
                        </ul>
                        
                         <!--<ul class="search_cont">
                        
                            <!--<li class="store_name" style="width: 20%; text-align: center;">지점명</li>
                            <li class="store_code" style="width: 20%; text-align: center;">지점등록번호</li>
                            <li class="store_owner" style="width: 10%; text-align: center;">점주명</li>
                            <li class="store_location" style="width: 20%; text-align: center;">위치</li>
                            <li class="store_tel" style="width: 15%; text-align: center;">전화번호</li>
                            <li style="width: 15%; text-align: center;"><button class="store_btn" type="button">상세보기</button></li>
                        </ul>-->
                       
                    </li>
                </ul>
            </div>
        </div>
    </section>
<jsp:include page="../admin_bottom.jsp"/>
<script>

		$(document).ready(function() {
		    $('form[name="searchForm"]').on('submit', function(event) {
		        event.preventDefault(); // 폼의 기본 제출 동작을 막음
		        
		        
		        
		        $.ajax({
		            url: '/searchBucks.do',
		            type: 'POST',
		            data: {
		                bucksName: $('input[name="bucksName"]').val(),
		                bucksId: $('input[name="bucksId"]').val(),
		                bucksLocation: $('select[name="bucksLocation"]').val(),
		                startDate: $('input[name="startDate"]').val(),
		                endDate: $('input[name="endDate"]').val()
		            },
		            success: function(response) {
		            	// 기존 검색 결과를 리셋
				        $('.search_list').empty();
		            	
				        /* if (response.length === 0) {
				            // 검색 결과가 없을 경우 메시지 추가
				            $('.search_list').append(
				                '<li class="search_item">' +
				                '<ul class="search_toolbar">' + 
				                '<li style="width: 100%; text-align: center; padding: 20px;">검색에 맞는 지점이 없습니다.</li>' +
				                '</ul>' +
				                '</li>'
				            );
				        } else { */
		            	
		            	
		                // 서버로부터 받은 데이터를 사용해 동적으로 HTML 생성
		                $.each(response, function(index, store) {
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
		                
		                //검색필드 기록지우기. 회의 후 결정 
		                //$('form[name="searchForm"]')[0].reset();
		            },
		            error: function(xhr, status, error) {
		                console.error('AJAX Error: ' + status + error);
		            }
		        });
		    });
		});

</script>