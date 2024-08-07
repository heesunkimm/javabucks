<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_stocks" class="content">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>재고현황</p>
        </div>

        <div class="select_box">
            <div class="tab_box">
                <a class="tab_btn s_active" href="javascript:;" data-tab="stocks_drink">음료</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_food">푸드</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_cup">컵</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_syrup">시럽</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_whip">휘핑크림</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_milk">우유</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_tumbler">텀블러</a>
                <a class="tab_btn" href="javascript:;" data-tab="stocks_beans">원두</a>
            </div>

            <div id="stocks_drink" class="tab-content s_active">
                <div class="ttit_box">
                    <p>음료</p>
                </div>

                <ul class="stocks_list">
                    <li class="stocks_item">
                        <div class="img_box">
                            <!-- <img src="" alt=""> -->
                        </div>
                        <div class="txt_box">
                            <dl>
                                <dt>품목이름</dt>
                                <dd>품목설명</dd>
                            </dl>
                            <dl>
                                <dt>발주가격</dt>
                                <dd>13,000원</dd>
                            </dl>
                            <dl>
                                <dt>재고</dt>
                                <dd>10개</dd>
                            </dl>
                            <div class="add_box">
                                <div class="count_box">
                                    <div class="minus_btn img_box">
                                        <img src="../images/icons/minus.png" alt="">
                                    </div>
                                    <label>
                                        <input type="text" name="" value="20" readonly>
                                    </label>
                                    <div class="minus_btn img_box">
                                        <img src="../images/icons/minus.png" alt="">
                                    </div>
                                </div>
                                <button type="button">담기</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div id="stocks_food" class="tab-content">
                <div class="ttit_box">
                    <p>푸드</p>
                </div>
            </div>
            <div id="stocks_cup" class="tab-content">
                <div class="ttit_box">
                    <p>컵</p>
                </div>
            </div>
            <div id="stocks_syrup" class="tab-content">
                <div class="ttit_box">
                    <p>시럽</p>
                </div>
            </div>
            <div id="stocks_whip" class="tab-content">
                <div class="ttit_box">
                    <p>휘핑크림</p>
                </div>
            </div>
            <div id="stocks_milk" class="tab-content">
                <div class="ttit_box">
                    <p>우유</p>
                </div>
            </div>
            <div id="stocks_tumbler" class="tab-content">
                <div class="ttit_box">
                    <p>텀블러</p>
                </div>
            </div>
            <div id="stocks_beans" class="tab-content">
                <div class="ttit_box">
                    <p>원두</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>