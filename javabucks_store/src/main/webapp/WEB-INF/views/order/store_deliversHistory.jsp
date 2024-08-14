<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../store_top.jsp"%>
<!-- s: content -->
<section id="store_delivershistory" class="content orderhistory">
    <div class="inner_wrap">
        <div class="tit_box">
            <p>배달주문내역</p>
        </div>

        <div class="search_box">
            <form name="" action="" method="post">
                <label>주문일
                    <input type="date" name="" value="">
                </label>
                <label>주문번호
                    <input type="text" name="" value="">
                </label>
                <button type="submit">검색</button>
            </form>
        </div>

        <div class="list_box">
            <ul class="search_list bg_beige">
                <li class="search_item">
                    <div class="search_toolbar">
                        <p style="width: 14%;">주문번호</p>
                        <p style="width: 50%;">주문내역</p>
                        <p style="width: 18%;">주문금액</p>
                        <p style="width: 18%;">주문일시</p>
                    </div>
                    <p class="order_num" style="width: 14%; text-align: center;">A-01</p>
                    <ul class="menu_list" style="width: 50%;">
                        <li class="menu_item">메뉴명 * 1</li>
                        <li class="menu_opt">- 샷추가 + 2</li>
                    </ul>
                    <p class="order_price" style="width: 18%; text-align: center;">23,000원</p>
                    <p class="order_date" style="width: 18%; text-align: center;">2024-08-02 16:22:22</p>
                </li>
            </ul>
        </div>
    </div>
</section>
<%@ include file="../store_bottom.jsp"%>