<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ include file="user_top.jsp"%>
    <!-- s: content -->
    <section id="user_cpnhistory" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">쿠폰 히스토리</p>
            </div>
             <c:if test="${empty couponlist}">
           	 사용 가능한 쿠폰이 없어요
            </c:if>
			<c:forEach var ="dto" items="${couponlist}">
				<c:choose>
					<c:when test="${dto.cpnListStatus eq '발급완료'}">
			            <ul class="cpn_list">
			                <li class="cpn_item">
			                    <div class="img_box">
			                        <img src="../images/icons/javabucks_cupon.png" alt="">
			                    </div>
			                    <div class="txt_box">
			                        <p class="txt_sub">JavaBucks</p>
			                        <p class="txt_tit">${dto.cpnName}</p>
			                        <p class="txt_desc">${dto.cpnDesc}</p>
			                        <ul class="txt_noti">
			                            <li>${dto.cpnListEndDate}까지</li>
			                        </ul>
			                    </div>
			                </li>
			            </ul>
		            </c:when>
	            </c:choose>
            </c:forEach>
           	<c:forEach var ="dto" items="${couponlist}">
           		<c:choose>
		            <c:when test="${dto.cpnListStatus eq '사용완료' || dto.cpnListStatus eq '기간만료'}">
		            	<ul class="cpn_list">
		            		<c:if test="${dto.cpnListStatus eq '기간만료'}">
		                		<li class="cpn_item use_dimm use_end">
			                </c:if>
			                	<li class="cpn_item use_dimm use_complete">
			                    <div class="img_box">
			                        <img src="../images/icons/javabucks_cupon.png" alt="">
			                    </div>
			                    <div class="txt_box">
			                        <p class="txt_sub">JavaBucks</p>
			                        <p class="txt_tit">${dto.cpnName}</p>
			                        <p class="txt_desc">${dto.cpnDesc}</p>
			                        <ul class="txt_noti">
			                            <li>${dto.cpnListEndDate}까지</li>
			                        </ul>
			                    </div>
			                </li>
			            </ul>
		            </c:when>
	            </c:choose>
            </c:forEach>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>