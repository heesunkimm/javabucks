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
                <form name="" action="" method="post">
                    <div class="search_box">
                        <div style="width: 100%;">
                            <label>등록일
                                <input type="date" name="" value="">
                            </label>
                            <label>~
                                <input type="date" name="" value="">
                            </label>
                            <label style="display: inline-flex; align-items: center;">삭제회원 포함
                                <input type="checkbox" name="" value="">
                            </label>
                        </div>
                        <label>아이디
                            <input type="text" name="" value="">
                        </label>
                        <div class="email_box">
                            <label>이메일
                                <input type="text" name="" value="">
                            </label>
                            @
                            <label>
                                <select name="">
                                    <option value="">naver.com</option>
                                    <option value="">nate.com</option>
                                    <option value="">gmail.com</option>
                                </select>
                            </label>
                        </div>
                        <label>권한
                            <select name="">
                                <option value="">기본권한</option>
                                <option value="">관리자권한</option>
                            </select>
                        </label>
                        <button type="button">검색</button>
                    </div>
                </form>

                <div class="list_box">
                    <table class="search_list s_table">
                        <thead>
                            <tr>
                                <th>등록일</th>
                                <th>아이디</th>
                                <th>지점명</th>
                                <th>이메일</th>
                                <th>폐업여부</th>
                                <th>패스워드 초기화</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>등록일</td>
                                <td>아이디</td>
                                <td>지점명</td>
                                <td>이메일</td>
                                <td>폐업여부</td>
                                <td><a href="javascript:;">초기화</a></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div class="pagination">
                    </div>    
                </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
    <jsp:include page="../admin_bottom.jsp"/>