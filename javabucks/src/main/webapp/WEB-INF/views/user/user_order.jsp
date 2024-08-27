<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/user.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../js/user.js"></script>
</head>
<body>
    <!-- s: content -->
    <section id="user_order" class="content">
        <div class="inner_wrap">
            <div class="tit_box">
                <p class="font_bold">Order</p>
            </div>

            <ul class="cate_list">
                <li><a class="tab_btn s_active" href="javascript:;" data-tab="cate_drink">음료</a></li>
                <li><a class="tab_btn" href="javascript:;" data-tab="cate_foond">푸드</a></li>
                <li><a class="tab_btn" href="javascript:;" data-tab="cate_pdt">상품</a></li>
            </ul>

            <div id="cate_drink" class="tab-content s_active">
                <ul class="menu_list">
                	<c:forEach var = "dto" items="${drinkList}">
                    <li class="menu_item">
                        <a href="user_menudetail?bucksId=${bucksId}&menuCode=${dto.menuCode}&menuoptCode=${dto.menuoptCode}&drink=drink&pickup=${pickup}">
                            <div class="img_box">
                               <img src="upload_menuImages/${dto.menuImages}" alt="">
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">${dto.menuName}</p>
                                <p class="txt_price"><fmt:formatNumber value="${dto.menuPrice}" pattern="#,###"/>원</p>
                            </div>
                        </a>
                    </li>
                   </c:forEach>
                </ul>
            </div>
            <div id="cate_foond" class="tab-content">
                <ul class="menu_list">
                	<c:forEach var = "dto" items="${foodList}">
                    <li class="menu_item">
                    	<c:choose>
	                        <c:when test="${dto.storemenuStatus eq 'Y'}">
	                            <a href="user_menudetail?store=${store}&menuCode=${dto.menuCode}&menuoptCode=${dto.menuoptCode}&drink=food&pickup=${pickup}">
	                                <div class="img_box">
	                                    <img src="upload_menuImages/${dto.menuImages}" alt="">
	                                </div>
	                                <div class="txt_box">
	                                    <p class="txt_tit">${dto.menuName}</p>
	                                    <p class="txt_price">${dto.menuPrice}</p>
	                                </div>
	                            </a>
	                          </c:when>
	                          <c:when test="${dto.storemenuStatus eq 'N'}">
	                          
	                          </c:when>
                    	</c:choose>  
                    </li>
                    </c:forEach>
                </ul>
            </div>
            
            
            <div id="cate_pdt" class="tab-content">
                <ul class="menu_list">
                	<c:forEach var = "dto" items="${productList}">
                    <li class="menu_item">
                        <a href="user_menudetail?bucksId=${bucksId}&menuCode=${dto.menuCode}&menuoptCode=${dto.menuoptCode}&drink=product&pickup=${pickup}">
                            <div class="img_box">
                               <img src="upload_menuImages/${dto.menuImages}" alt="">
                            </div>
                            <div class="txt_box">
                                <p class="txt_tit">${dto.menuName}</p>
                                <p class="txt_price">${dto.menuPrice}</p>
                            </div>
                        </a>
                    </li>
                    </c:forEach>
                </ul>
            </div>
            
            
            <div class="cart_box">
                <!-- 클릭시 매장 선택 페이지로 재이동 -->
                <c:if test="${pickup=='매장이용'}">
                <a class="select_store" href="user_store">${store} <span class="font_gray">(매장이용)</span></a>
                </c:if>
                <c:if test="${pickup=='To-go'}">
                <a class="select_store" href="user_store">${store} <span class="font_gray">(To-go)</span></a>
                </c:if>
                <c:if test="${pickup=='Delivers'}">
                <a class="select_store" href="user_delivers">${store} <span class="font_gray">(Delivers)</span></a>
                </c:if>
                <button class="cart_btn" type="button">
                    <div class="img_box">
                        <img src="../images/icons/order_basket.png" alt="">
                    </div>
                    <p class="cart_count">0</p>
                </button>
            </div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="user_bottom.jsp"%>