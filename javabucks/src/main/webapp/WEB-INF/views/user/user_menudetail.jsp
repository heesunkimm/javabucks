<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
    <section id="user_menudetail" class="content">
        <div class="inner_wrap">
            <div class="menu_img img_box">
                <img src="upload_menuImages/${menu.menuImages}" alt="">
            </div>

            <div class="txt_box">
                <p class="txt_tit">${menu.menuName}</p>
                <p class="txt_desc">${menu.menuDesc}</p>
                <p class="txt_price">${menu.menuPrice}</p>
            </div>

			<c:if test="${not empty drink}">
            <div class="btn_box">
                <button type="button">퍼스널옵션</button>
            </div>
            </c:if>
            <div class="opt_wrap">
                <!-- 옵션박스 -->
                <div class="size_box opt_box">
                </div>
                
                 <!-- 옵션: 컵 -->
                <c:if test="${not empty cup}">
                <div class="opt_box">
                    <p class="opt_tit">컵</p>
                    <div class="opt_rows">
                        <div class="select_box">
                        	<c:forEach var ="cup" items="${cup}">
                        	<label>
                                <input type="button" name="cupType" value="">
                                <span>${cup.cupType}</span>
                            </label>
                            </c:forEach>                                                    
                        </div>
                    </div>
                </div>
                </c:if>

                <!-- 옵션: 커피 -->
                <c:if test="${not empty shot}">
                <div class="opt_box">
                    <p class="opt_tit">커피</p>
                    <div class="opt_rows">
                        <p>${shot}</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('shot_count')">
                            </div>
                            <label>
                                <input type="text" id= "shot_count" name="shotType" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('shot_count')">
                            </div>
                        </div>
                    </div>
                </div>
				</c:if>
				
                <!-- 옵션: 시럽 -->
                <c:if test="${not empty syrup}">
                <div class="opt_box">
                    <p class="opt_tit">시럽</p>
                    <c:forEach var ="syrup" items="${syrup}">
                    <div class="opt_rows">
                        <p>${syrup.syrupType}</p>
                        <div class="count_box">
                            <div class="minus_btn click_icon img_box">
                                <img src="../images/icons/minus.png" alt="감소 버튼" onclick="minus('${syrup.syrupType}')">
                            </div>
                            <label>
                                <input type="text" id= "${syrup.syrupType}" name="syrupType" value="0" readonly>
                            </label>
                            <div class="plus_btn click_icon img_box">
                                <img src="../images/icons/plus.png" alt="증가 버튼" onclick="plus('${syrup.syrupType}')">
                            </div>
                        </div>
                    </div>
                    </c:forEach>                                    
                </div>
                </c:if>
                
                <!-- 옵션: 얼음 -->
                <c:if test="${not empty ice}">
                <div class="opt_box">
                    <p class="opt_tit">얼음</p>
                    <div class="opt_rows">
                        <div class="select_box">
                        	<c:forEach var ="ice" items="${ice}">
                            <label>
                                <input type="button" name="iceType" value="">
                                <span>${ice.iceType}</span>
                            </label>
                            </c:forEach>                                      
                        </div>
                    </div>
                </div>
				</c:if>
				
                <!-- 옵션: 우유 -->
                <c:if test="${not empty milk}">
                <div class="opt_box">
                    <p class="opt_tit">우유</p>
                    <div class="opt_rows">
                        <div class="select_box">
                        	<c:forEach var ="milk" items="${milk}">
                            <label>
                                <input type="button" name="milkType" value="">
                                <span>${milk.milkType}</span>
                            </label>
                            </c:forEach>                            
                        </div>
                    </div>
                </div>                           
				</c:if>
				
				<!-- 옵션: 휘핑 크림 -->
				<c:if test="${not empty whip}">
                <div class="opt_box">
                    <p class="opt_tit">휘핑 크림</p>
                    <div class="opt_rows">
                        <div class="select_box">
                        	<c:forEach var ="whip" items="${whip}">
                            <label>
                                <input type="button" name="whipType" value="">
                                <span>${whip.whipType}</span>
                            </label>
                            </c:forEach>
                                                       
                        </div>
                    </div>
                </div>
                </c:if>
                
            </div>

            <div class="order_box">
                <button type="button">담기</button>
                <button type="button">주문하기</button>
                <button class="addlike" type="button">
                    <img src="../images/icons/like.png" alt="">
                </button>
            </div>

        </div>
    </section>
    <!-- e: content -->

<%@ include file="user_bottom.jsp"%>

<script type="text/javascript">
// 감소 버튼 클릭 시 호출되는 함수
	    function minus(fieldId) {
	        var input = document.getElementById(fieldId);
	        var value = parseInt(input.value, 10); // 현재 값 가져오기
	        value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	        value--; // 감소
	        if (value < 0) value = 0; // 음수 방지
	        input.value = value; // 값 적용
	    }
	
	    // 증가 버튼 클릭 시 호출되는 함수
	    function plus(fieldId) {
	        var input = document.getElementById(fieldId);
	        var value = parseInt(input.value, 10); // 현재 값 가져오기
	        value = isNaN(value) ? 0 : value; // 숫자가 아닌 경우 처리
	        value++; // 증가
	        input.value = value; // 값 적용
	    }
</script>