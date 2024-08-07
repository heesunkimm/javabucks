<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin_top.jsp"/>

<section id="admin_storelist" class="content managelist">
        <div class="inner_wrap">
            <div class="tit_box">
                <p>지점관리</p>
            </div>

            <div class="search_box">
                <form name="" action="" method="post">
                    <div style="width: 100%;">
                        <label>등록일
                            <input type="date" name="" value="">
                        </label>
                        <label>~
                            <input type="date" name="" value="">
                        </label>
                    </div>
                    <label>지점등록번호
                        <input type="text" name="" value="">
                    </label>
                    <label>지점명
                        <input type="text" name="" value="">
                    </label>
                    <label>위치
                        <select name="">
                            <option value="">서울</option>
                        </select>
                    </label>
                    <button type="submit">검색</button>
                </form>
            </div>

            <div class="list_box">
                <div class="btn_box">
                    <button type="button" onclick="location.href='/inputstore.do'">지점등록</button>
                </div>
                <ul class="search_list bg_beige">
                    <li class="search_item">
                        <ul class="search_toolbar">
                            <li style="width: 20%;">지점명</li>
                            <li style="width: 20%;">지점등록번호</li>
                            <li style="width: 10%;">점주명</li>
                            <li style="width: 20%;">위치</li>
                            <li style="width: 15%;">전화번호</li>
                            <li style="width: 15%;"></li>
                        </ul>
                        <ul class="search_cont">
                            <li class="store_name" style="width: 20%; text-align: center;">지점명</li>
                            <li class="store_code" style="width: 20%; text-align: center;">지점등록번호</li>
                            <li class="store_owner" style="width: 10%; text-align: center;">점주명</li>
                            <li class="store_location" style="width: 20%; text-align: center;">위치</li>
                            <li class="store_tel" style="width: 15%; text-align: center;">전화번호</li>
                            <li style="width: 15%; text-align: center;"><button class="store_btn" type="button">상세보기</button></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </section>
