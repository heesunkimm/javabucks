<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
	<!-- s: content -->
    <section id="store_alldessert" class="content allMenu">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>디저트</p>
            </div>
            
            <div class="btn_box">
            	<a class="addbtn" href="/store_adddessert">메뉴추가</a>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_cont">카테고리</a>
                    <a class="tab_btn" href="javascript:;" data-tab="menu_cont">메뉴명</a>
                </div>

                <div id="cate_cont" class="tab-content s_active">
                    <form name="menuCateForm" method="post">
                        <div class="select_list">
                            <label>
                                <input type="checkbox" name="menu_cate" value="" checked>전체
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="ES">에스프레소
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="CB">콜드브루
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BD">블론드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="DC">디카페인
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="PJ">피지오
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="RF">리프레셔
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="FP">프라푸치노
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BL">블렌디드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="BR">브루드
                            </label>
                            <label>
                                <input type="checkbox" name="menu_cate" value="ET">기타
                            </label>
                        </div>
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <img src="../../images/upload_menuImages" alt="">
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                        <button class="delBtn" type="button">메뉴삭제</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="menu_cont" class="tab-content">
                    <form name="menuNameForm" method="post">
                        <label>
                            <input type="text" name="menuName" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>

                    <div class="cont_box">
                        <div class="select_tit">
                            <p>카테고리</p>
                        </div>

                        <ul class="menu_list">
                            <li class="menu_item">
                                <div class="menu_img img_box">
                                    <img src="../../images/upload_menuImages" alt="">
                                </div>
                                <div class="menu_info">
                                    <div class="txt_box">
                                        <p class="txt_tit">메뉴명</p>
                                        <p class="txt_desc">메뉴설명</p>
                                    </div>
                                    <div class="btn_box">
                                        <button type="button">주문막기</button>
                                        <button type="button">메뉴삭제</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
<%@ include file="../store_bottom.jsp"%>