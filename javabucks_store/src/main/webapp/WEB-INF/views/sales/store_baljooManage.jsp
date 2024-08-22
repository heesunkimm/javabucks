<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_orderaccount" class="content management">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>발주내역</p>
        </div>

        <div class="select_box">
            <div id="" class="tab-content s_active">
                <form name="" action="" method="post">
                    <div class="search_box">
                        <label>발주기간
                            <select name="">
                                <option value="">2024</option>
                                <option value="">2023</option>
                                <option value="">2022</option>
                                <option value="">2021</option>
                                <option value="">2020</option>
                            </select>
                        </label>
                        <label>
                            <select name="">
                                <option value="">1월</option>
                                <option value="">2월</option>
                                <option value="">3월</option>
                                <option value="">4월</option>
                                <option value="">5월</option>
                                <option value="">6월</option>
                                <option value="">7월</option>
                                <option value="">8월</option>
                                <option value="">9월</option>
                                <option value="">10월</option>
                                <option value="">11월</option>
                                <option value="">12월</option>
                            </select>
                        </label>
                        <label>발주번호
                            <input type="text" name="" value="">
                        </label>
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
        </div>
    </div>
</section>
<!-- e: content -->
<%@ include file="../store_bottom.jsp"%>
