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
	            <form name="f" action="searchDrink" method="post">
	                <div style="width: 100%;">
	                    <label>카테고리
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
	                            <option value="J" <c:if test="${searchParams.menu_base eq 'J'}">selected</c:if>>J</option>
	                            <option value="L" <c:if test="${searchParams.menu_base eq 'L'}">selected</c:if>>L</option>
	                            <option value="M" <c:if test="${searchParams.menu_base eq 'M'}">selected</c:if>>M</option>
	                            <option value="N" <c:if test="${searchParams.menu_base eq 'N'}">selected</c:if>>N</option>
	                            <option value="P" <c:if test="${searchParams.menu_base eq 'P'}">selected</c:if>>P</option>
	                            <option value="W" <c:if test="${searchParams.menu_base eq 'W'}">selected</c:if>>W</option>
	                            <option value="Y" <c:if test="${searchParams.menu_base eq 'Y'}">selected</c:if>>Y</option>
	                        </select>
	                    </label>
	                    <label>주문막기 메뉴 확인
	                    	<input type="checkbox" name="menuEnable" value="Y" <c:if test="${searchParams.menuEnable eq 'Y'}">checked</c:if>>
						</label>
	                </div>
	                <label>메뉴명
        				<input type="text" name="menuName" value="${searchParams.menuName}">
	                </label>
	                
	                <button type="submit">검색</button>
	            </form>
	        </div>
	
	        <div class="list_box">
	            <div class="btn_box">
	                <button type="button" onclick="window.location='admin_adddrink'">메뉴등록</button>
	            </div>
	            
	            <table class="search_list s_table">
	                <thead class="bg_green font_white">
	                    <tr>
	                        <th>카테고리</th>
	                        <th>베이스</th>
	                        <th>ICE/HOT</th>
	                        <th>메뉴코드</th>
	                        <th>메뉴명</th>
	                        <th>가격</th>
	                        <th>주문막기</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:if test="${empty drinkList}">
	                	<tr>
	                		<td colspan="7">등록된 메뉴가 없습니다. 메뉴를 등록해주세요.</td>
	                	</tr>
	                	</c:if>
	                	<c:if test="${noList}">
	                	<tr>
	                		<td colspan="7">검색조건에 해당하는 메뉴가 없습니다.</td>
	                	</tr>
					    </c:if>
	                    <c:forEach var="dto" items="${drinkList}">
	                        <tr>
	                            <td></td>
	                            <td></td>
	                            <td></td>
	                            <td>${dto.menuCode}</td>
	                            <td><a href="javascript:;">${dto.menuName}</a></td>
	                            <td><fmt:formatNumber value="${dto.menuPrice}" pattern="###,###"/></td>
	                            <td><button type="button">주문막기</button></td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	            <!-- 페이징 -->
	            <div class="pagination">
	            </div>    
	        </div>
	    </div>
	</section>
    <!-- e: content -->
<jsp:include page="../admin_bottom.jsp"/>