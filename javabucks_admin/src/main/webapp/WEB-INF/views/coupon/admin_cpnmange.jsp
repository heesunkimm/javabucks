<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../admin_top.jsp"/>
	<!-- s: content -->
    <section id="admin_cpnmange" class="content accountmanage">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>쿠폰관리</p>
            </div>

            <div class="select_box">
                <form name="" action="" method="post">
                    <div class="search_box">
                        <div style="width: 100%;">
                            <label>
                                <select name="">
                                    <option value="">쿠폰발급일</option>
                                    <option value="">쿠폰만료일</option>
                                    <option value="">쿠폰사용일</option>
                                </select>
                            </label>
                            <label>
                                <input type="date" name="" value="">
                            </label>
                            <label>~
                                <input type="date" name="" value="">
                            </label>
                            <label>쿠폰상태
                                <select name="">
                                    <option value="">전체</option>
                                    <option value="">사용완료</option>
                                    <option value="">기한만료</option>
                                </select>
                            </label>
                        </div>
                        <label>유저아이디
                            <input type="text" name="" value="">
                        </label>
                        <label>쿠폰번호
                            <input type="text" name="" value="">
                        </label>
                        <label>쿠폰명
                            <input type="text" name="" value="">
                        </label>
                        <button type="button">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <div class="btn_box">
                        <button class="popup_btn" type="button" data-popup="sendcpn">쿠폰전송</button>
                        <button class="popup_btn" type="button" data-popup="addcpn">쿠폰등록</button>
                    </div>
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>쿠폰발급일</th>
                                <th>쿠폰번호</th>
                                <th>유저아이디</th>
                                <th>쿠폰명</th>
                                <th>쿠폰만료일</th>
                                <th>쿠폰사용일</th>
                                <th>쿠폰상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>쿠폰발급일</td>
                                <td>쿠폰번호</td>
                                <td>유저아이디</td>
                                <td>쿠폰명</td>
                                <td>쿠폰만료일</td>
                                <td>쿠폰사용일</td>
                                <td>쿠폰상태</td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
                    </div>    
                </div>
            </div>
            <!-- 쿠폰등록 팝업 -->
            <div id="addcpn" class="cpn_popup popup_box" style="display: none;">
                <p class="popup_title">쿠폰등록</p>
                <a class="close_btn" href="javascript:;" data-popup="addcpn"><img src="../images/icons/close.png" alt=""></a>
                <form name="f" action="insertCoupon" method="post">
                    <div class="input_box">
                        <label>쿠폰코드
                            <input type="text" name="cpnCode" value="">
                        </label>
                        <label>쿠폰명
                            <input type="text" name="cpnName" value="" required>
                        </label>
                        <label>쿠폰설명
                            <textarea name="cpnDesc" cols="50" rows="10" value="" maxlength="100" required></textarea>
                        </label>
                        <label>쿠폰금액
                            <input type="text" name="cpnPrice" value="" required>
                        </label>
                    </div>
                    <div class="pbtn_box">
                        <button type="submit">쿠폰생성</button>
                    </div>
                </form>
            </div>
            <!-- 쿠폰전송 팝업 -->
            <div id="sendcpn" class="cpn_popup popup_box" style="display: none;">
                <p class="popup_title">쿠폰전송</p>
                <a class="close_btn" href="javascript:;" data-popup="sendcpn"><img src="../images/icons/close.png" alt=""></a>
                <form name="f" action="insertCoupon" method="post">
                    <div class="input_box">
                        <label>유저ID
                            <input type="text" name="userId" value="">
                        </label>
                        <label>쿠폰코드
                            <select name="">
                            	<option value=""></option>
                            </select>
                        </label>
                    </div>
                    <div class="pbtn_box">
                        <button type="submit">쿠폰전송</button>
                    </div>
                </form>
            </div>
            <div class="dimm"></div>
        </div>
    </section>
    <!-- e: content -->
<jsp:include page="../admin_bottom.jsp"/>