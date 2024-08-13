<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>
<section id="admin_editstore" class="content store_info">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점 상세정보</p>
            </div>

            <div class="insert_box bg_beige">
                <form name="" action="" method="post">
                    <p>계정정보</p>
                    <div class="info_wrap">
                        <div class="info_box">
                            <label><span>아이디</span>
                                <input type="text" name="" value="${jbucks.bucksId}" readonly>
                            </label>
                            <!-- <label><span>패스워드</span>
                                <input type="password" name="" value="" readonly>
                            </label> -->
                        </div>
                    </div>

                    <p>지점정보</p>
                    <div class="info_box">
                        <label><span>지점명</span>
                            <input type="text" name="" value="${jbucks.bucksName}" >
                        </label>
                        <label><span>점주명</span>
                            <input type="text" name="" value="${jbucks.bucksOwner}" >
                        </label>
                        <div class="loca_box">
                            <label><span>지점위치</span>
                                <input type="text" name="" value="${jbucks.bucksLocation}" readonly>
                            </label>
                        </div>
                        <div class="tel_box">
                            <label><span>지점번호</span>
                                 <input type="text" name="bucksTel1" size="3" maxlength="3" value="${jbucks.bucksTel1}" required> 
                                -
                                <input type="text" name="bucksTel2" size="4" maxlength="4" value="${jbucks.bucksTel2}" required> 
                                -
                                <input type="text" name="bucksTel3" size="4" maxlength="4" value="${jbucks.bucksTel3}" required>
                            </label>
                        </div>
                        <div class="email_box">
                            <label><span>지점이메일</span>
                                <input type="text" name="" value="${jbucks.bucksEmail1}" readonly>
                            </label>
                            <select name="">
                                <option value="">@naver.com</option>
                                <option value="">@nate.com</option>
                                <option value="">@gmail.com</option>
                            </select>
                            <button type="button" style="margin-top: 0;">중복확인</button>
                        </div>
                    </div>
                    <div class="btn_box">
                        <button class="add_btn" type="submit">정보수정</button>
                        <button class="del_btn" type="button">지점삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <jsp:include page="../admin_bottom.jsp"/>
