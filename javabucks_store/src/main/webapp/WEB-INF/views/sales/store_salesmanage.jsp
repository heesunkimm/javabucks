<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ include file="../store_top.jsp"%>
    <!-- s: content -->
    <section id="store_salesmanage" class="content management">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>매출관리</p>
            </div>

            <div class="select_box">
                <div class="tab_box">
                    <a class="tab_btn s_active" href="javascript:;" data-tab="cate_all">전체</a>
                    <a class="tab_btn" href="javascript:;" data-tab="cate_drink">음료</a>
                    <a class="tab_btn" href="javascript:;" data-tab="cate_disert">디저트</a>
                   <!--  <a class="tab_btn" href="javascript:;" data-tab="cate_sandwich">샌드위치</a>  -->
                    <a class="tab_btn" href="javascript:;" data-tab="cate_Md">MD 상품 </a>
                   <!-- <a class="tab_btn" href="javascript:;" data-tab="cate_beans">원두</a>  --> 
                </div>

                <div id="cate_all" class="tab-content s_active">
                    <form name="" action="" method="post">
                        
                        <div class="search_box">
                            <label>기간
                                <input type="date" name="startDate" value="" required>
                            ~
                         	   <input type="date" name="endDate" value="" required>

                            </label>
                            <div class="period_box"></div>
                            <button type="button">검색</button>
                        </div>
                    </form>

                    <div class="list_box">
                        <p class="totabl_sales">매출액:<span>000,000,000원</span></p>
                        <table class="search_list s_table">
                            <thead>
                                <tr>
                                    <th>결제일</th>
                                    <th>결제번호</th>
                                    <th>주문번호</th>
                                    <th>주문내역</th>
                                    <th>결제금액</th>
                                    <th>결제취소</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>결제일</td>
                                    <td>결제번호</td>
                                    <td>주문번호</td>
                                    <td>주문내역</td>
                                    <td>결제금액</td>
                                    <td><a href="javascript:;">취소</a></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- 페이징 -->
                        <div class="pagination">
                        </div>    
                    </div>
                </div>
                <div id="cate_drink" class="tab-content">
                    <div class="select_list">
                            <label>
                                <input type="checkbox" name="" value="">전체
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">에스프레소
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">콜드브루
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">블론드
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">디카페인
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">피지오
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">리프레셔
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">프라푸치노
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">블랜디드
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">브루드
                            </label>
                            <label>
                                <input type="checkbox" name="" value="">기타음료
                            </label>
                        </div>
                </div>
                <div id="cate_cake" class="tab-content">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                </div>
                <div id="cate_sandwich" class="tab-content">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                </div>
                <div id="cate_tumbler" class="tab-content">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                </div>
                <div id="cate_beans" class="tab-content">
                    <form name="" action="" method="post">
                        <label>
                            <input type="text" name="" value="" placeholder="메뉴명을 입력하세요.">
                        </label>
                        <button type="submit">검색</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- e: content -->
  <%@ include file="../store_bottom.jsp"%>