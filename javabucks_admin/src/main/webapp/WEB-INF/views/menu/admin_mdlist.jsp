<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../admin_top.jsp"/>
<!-- s: content -->
    <section id="admin_mdlist" class="content menuList">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>MD</p>
            </div>

            <div class="search_box">
                <form name="f" action="admin_mdlist" method="post">
	                <label>메뉴명
	                    <input type="text" name="menuName" value="${searchParams.menuName}">
	                </label>
	                <label>주문막기 메뉴 확인
		                <c:choose>
						    <c:when test="${searchParams.menuStatus eq 'Y'}">
						        <input type="checkbox" name="menuStatus" value="Y" checked>
						    </c:when>
						    <c:when test="${searchParams.menuStatus eq 'N'}">
						        <input type="checkbox" name="menuStatus" value="N">
						    </c:when>
						    <c:otherwise>
						    	<input type="checkbox" name="menuStatus" value="N">
						    </c:otherwise>
						</c:choose>
					</label>
	                <button type="submit">검색</button>
	            </form>
            </div>

            <div class="list_box">
                <div class="btn_box">
                    <button type="button" onclick="window.location='admin_addmd'">메뉴등록</button>
                </div>
                
                <table class="search_list s_table">
                    <thead class="bg_green font_white">
                        <tr>
                            <th>구분코드</th>
                            <th>메뉴코드</th>
                            <th>메뉴명</th>
                            <th>가격</th>
                            <th>주문막기</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:if test="${empty mdList}">
                    	<tr>
                            <td colspan="5">등록된 음료가 없습니다.</td>
                        </tr>
                    	</c:if>
                    	<c:forEach var="dto" items="${mdList}">
                        <tr>
                            <td>${fn:substring(dto.menuCode,1,3)}</td>
                            <td>${dto.menuCode}</td>
                            <td><a href="admin_editmd?menuCode=${dto.menuCode}">${dto.menuName}</a></td>
                            <td><fmt:formatNumber value="${dto.menuPrice}" pattern="###,###"/>원</td>
                            <td>
                                <c:choose>
								    <c:when test="${dto.menuStatus eq 'N'}">
								        <button class="updateBtn disable_order" type="button" 
								        	data-menu-name="${dto.menuName}" 
									        data-menu-code="${dto.menuCode}" 
									        data-menu-status="${dto.menuStatus}">주문풀기
								        </button>
								    </c:when>
								    <c:when test="${dto.menuStatus eq 'Y'}">
								    	<button class="updateBtn enable_btn" type="button" 
										    	data-menu-name="${dto.menuName}" 
										    	data-menu-code="${dto.menuCode}" 
										    	data-menu-status="${dto.menuStatus}">주문막기
								        </button>
								    </c:when>
						        </c:choose>
                            </td>
                        </tr>
                    	</c:forEach>
                    </tbody>
                </table>
                <!-- 페이징 -->
                <c:if test="${not empty mdList}">
                <div class="pagination">
		            <c:if test="${startPage > pageBlock}"> 
			        	<a class="page_btn prev_btn" href="admin_mdlist?pageNum=${startPage-3}&menuName=${param.menuName}&menuStatus=${param.menuStatus}"><img src="../../images/icons/arrow.png"></a>
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
					    <a href="admin_mdlist?pageNum=${i}&menuName=${param.menuName}&menuStatus=${param.menuStatus}" class="${activeClass} page_num">${i}</a>
					</c:forEach>
				    
				    <c:if test="${pageCount > endPage}">
				        <a class="page_btn next_btn" href="admin_mdlist?pageNum=${startPage+3}&menuName=${param.menuName}&menuStatus=${param.menuStatus}"><img src="../../images/icons/arrow.png"></a>
				    </c:if>
	            </div>   
                </c:if>
            </div>
        </div>
    </section>
    <!-- e: content -->
<jsp:include page="../admin_bottom.jsp"/>
<script type="text/javascript">
	//메뉴 주문막기 상태 변경
	$(".updateBtn").on("click",function(){
		let $btn = $(this);
	    let btnCode = $btn.data('menu-code');
	    let btnMenu = $btn.data('menu-name');
	    let menuStatus = $btn.data('menu-status');
	    
	    let newStatus = menuStatus === 'N' ? 'Y' : 'N';
	
	    let data = {
	        menuCode: btnCode,
	        menuStatus: newStatus
	    };
		
		$.ajax({
	        url: '${pageContext.request.contextPath}/menuStatusUpdate.ajax',
	        type: "POST",
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        dataType: "text",
	        success: function (res) {
	            let updateBtn;
	
	            if (newStatus === 'N') {
	            	let updateBtn = $btn.text('주문풀기').removeClass('enable_btn').addClass('disable_order').attr('data-menu-status', 'N');
	            	$btn.replaceWith(updateBtn);
	            	alert(btnMenu + "의 주문을 막았습니다.");
	            } else {
	            	updateBtn = $btn.text('주문막기').removeClass('disable_order').addClass('enable_btn').attr('data-menu-status', 'Y');
	            	$btn.replaceWith(updateBtn);
	            	alert(btnMenu + "의 주문을 풀었습니다.");
	            }
	            window.location.reload();
	        },
	        error: function (xhr, status, err) {
	            console.error('AJAX 요청 실패:', status, err);
	        }
	    });
	})
</script>