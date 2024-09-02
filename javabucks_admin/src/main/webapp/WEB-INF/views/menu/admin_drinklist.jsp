<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_drinklist" class="content">
	    <div class="inner_wrap">
	        <div class="tit_box">
	            <p>커피 및 음료</p>
	        </div>
	
	        <div class="search_box">
	            <form name="f" action="admin_drinklist" method="post">
	                <div style="width: 100%;">
	                    <label>구분코드
	                        <select name="menu_cate">
	                            <option value="">-</option>
	                            <option value="BD" <c:if test="${searchParams.menu_cate eq 'BD'}">selected</c:if>>BD</option>
	                            <option value="BL" <c:if test="${searchParams.menu_cate eq 'BL'}">selected</c:if>>BL</option>
	                            <option value="BR" <c:if test="${searchParams.menu_cate eq 'BR'}">selected</c:if>>BR</option>
	                            <option value="CB" <c:if test="${searchParams.menu_cate eq 'CB'}">selected</c:if>>CB</option>
	                            <option value="DC" <c:if test="${searchParams.menu_cate eq 'DC'}">selected</c:if>>DC</option>
	                            <option value="ES" <c:if test="${searchParams.menu_cate eq 'ES'}">selected</c:if>>ES</option>
	                            <option value="ET" <c:if test="${searchParams.menu_cate eq 'ET'}">selected</c:if>>ET</option>
	                            <option value="FP" <c:if test="${searchParams.menu_cate eq 'FP'}">selected</c:if>>FP</option>
	                            <option value="PJ" <c:if test="${searchParams.menu_cate eq 'PJ'}">selected</c:if>>PJ</option>
	                            <option value="RF" <c:if test="${searchParams.menu_cate eq 'RF'}">selected</c:if>>RF</option>
	                        </select>
	                    </label>
	                    <label>베이스
	                        <select name="menu_base">
	                            <option value="">-</option>
	                            <option value="B" <c:if test="${searchParams.menu_base eq 'B'}">selected</c:if>>B</option>
	                            <option value="C" <c:if test="${searchParams.menu_base eq 'C'}">selected</c:if>>C</option>
	                            <option value="D" <c:if test="${searchParams.menu_base eq 'D'}">selected</c:if>>D</option>
	                            <option value="E" <c:if test="${searchParams.menu_base eq 'E'}">selected</c:if>>E</option>
	                            <option value="F" <c:if test="${searchParams.menu_base eq 'F'}">selected</c:if>>F</option>
	                            <option value="L" <c:if test="${searchParams.menu_base eq 'L'}">selected</c:if>>L</option>
	                            <option value="M" <c:if test="${searchParams.menu_base eq 'M'}">selected</c:if>>M</option>
	                            <option value="N" <c:if test="${searchParams.menu_base eq 'N'}">selected</c:if>>N</option>
	                            <option value="P" <c:if test="${searchParams.menu_base eq 'P'}">selected</c:if>>P</option>
	                            <option value="W" <c:if test="${searchParams.menu_base eq 'W'}">selected</c:if>>W</option>
	                            <option value="Y" <c:if test="${searchParams.menu_base eq 'Y'}">selected</c:if>>Y</option>
	                        </select>
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
	                </div>
	                <label>메뉴명
        				<input type="text" name="menuName" value="${searchParams.menuName}">
	                </label>
	                
	                <button class="search_btn" type="submit">검색</button>
	            </form>
	        </div>
	
	        <div class="list_box">
	            <div class="btn_box">
	                <button class="add_btn" type="button" onclick="window.location='admin_adddrink'">메뉴등록</button>
	            </div>
	            
	            <table class="search_list s_table">
	                <thead class="bg_green font_white">
	                    <tr>
	                        <th>구분</th>
	                        <th>베이스</th>
	                        <th>ICE/HOT</th>
	                        <th>메뉴코드</th>
	                        <th>메뉴명</th>
	                        <th>가격</th>
	                        <th>주문막기</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:choose>
						    <c:when test="${empty drinkList}">
						        <tr>
						            <td colspan="7">등록된 메뉴가 없습니다. 메뉴를 등록해주세요.</td>
						        </tr>
						    </c:when>
						    <c:when test="${noList && not empty drinkList}">
						        <tr>
						            <td colspan="7">검색조건에 해당하는 메뉴가 없습니다.</td>
						        </tr>
						    </c:when>
						</c:choose>

	                    <c:forEach var="dto" items="${drinkList}">
	                        <tr>
	                            <td>${fn:substring(dto.menuCode,1,3)}</td>
	                            <td>${fn:substring(dto.menuCode,3,4)}</td>
	                            <td>${fn:substring(dto.menuCode,4,5)}</td>
	                            <td>${dto.menuCode}</td>
	                            <td><a class="menu_btn" href="admin_editdrink?menuCode=${dto.menuCode}" data-menucode="${dto.menuCode}">${dto.menuName}</a></td>
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
	            <c:if test="${not empty drinkList}">
	            <div class="pagination">
		            <c:if test="${startPage > pageBlock}"> 
			        	<a class="page_btn prev_btn" href="admin_drinklist?pageNum=${startPage-3}&menu_cate=${param.menu_cate}&menu_base=${param.menu_base}&menuStatus=${param.menuStatus}&menuName=${param.menuName}"><img src="../../images/icons/arrow.png"></a>
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
					    <a href="admin_drinklist?pageNum=${i}&menu_cate=${param.menu_cate}&menu_base=${param.menu_base}&menuStatus=${param.menuStatus}&menuName=${param.menuName}" class="${activeClass} page_num">${i}</a>
					</c:forEach>
				    
				    <c:if test="${pageCount > endPage}">
				        <a class="page_btn next_btn" href="admin_drinklist?pageNum=${startPage+3}&menu_cate=${param.menu_cate}&menu_base=${param.menu_base}&menuStatus=${param.menuStatus}&menuName=${param.menuName}"><img src="../../images/icons/arrow.png"></a>
				    </c:if>
	            </div>
	            </c:if>
	        </div>
	    </div>
	</section>
    <!-- e: content -->
<jsp:include page="../admin_bottom.jsp"/>
<script type="text/javascript">
	// 메뉴 주문막기 상태 변경
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