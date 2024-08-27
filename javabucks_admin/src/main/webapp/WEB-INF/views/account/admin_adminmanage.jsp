<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="../css/reset.css">
        <link rel="stylesheet" href="../css/admin.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../js/admin.js"></script>
    </head>
<body>
    <header class="bg_beige">
        <div class="logo_box img_box">
            <a href="javascript:;">
                <img src="../images/logo/starbucks_logo.png" alt="">
                <span>JAVABUCKS</span>
            </a>
        </div>
        
        <ul class="nav_list">
            <li class="nav_item">
                <a href="javascript:;">계정관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">관리자 계정 관리</a></li>
                    <li><a href="javascript:;">지점 계정 관리 </a></li>
                    <li><a href="javascript:;">유저 계정 관리</a></li>
                </ul>
            </li>
        <ul class="nav_list">
            <li class="nav_item">
                <a href="javascript:;">메뉴관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">커피 및 케이크</a></li>
                    <li><a href="javascript:;">케이크</a></li>
                    <li><a href="javascript:;">샌드위치</a></li>
                    <li><a href="javascript:;">텀블러</a></li>
                    <li><a href="javascript:;">원두</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">재고관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">재고현황</a></li>
                    <li><a href="javascript:;">장바구니</a></li>
                    <li><a href="javascript:;">발주내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">주문관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">배달관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">오더현환</a></li>
                    <li><a href="javascript:;">주문내역</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a href="javascript:;">정산관리</a>
                <ul class="dropdown_content">
                    <li><a href="javascript:;">매출관리</a></li>
                    <li><a href="javascript:;">발주정산</a></li>
                </ul>
            </li>
        </ul>

        <div class="store_box">
            <a href="javascript:;"><em class="font_green">${inAdmin.adminId}</em> 환영합니다.</a>
        </div>
    </header>
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
    <footer></footer>
</body>
</html>