<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>

<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>

<%-- 데이터베이스 SQL 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- Table에서 가져온 값을 처리하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>

<%
    // JSP 영역
    request.setCharacterEncoding("UTF-8"); // 이전 페이지에서 온 값에 대한 인코딩 설정
    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");
    if (idValue == null) {
            // 세션이 없으면 로그인 페이지로 리디렉션
            response.sendRedirect("../page/index.jsp");
        }
%>
    <script>
        console.log("idValue: <%= idValue %>");
    </script>
<%
    // 클라이언트로부터 전달된 날짜 파라미터 받기
    String clickedDate = request.getParameter("clicked_date");
%>
    <script>
        console.log("clickedDate: <%= clickedDate %>");
    </script>
<%
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <link rel="stylesheet" href="../css/main.css"/>
</head>
<body>
    <form>
        <div class="button_container">
            <button type="button" onclick="viewProfileEvent()"><img src="../img/account_circle.png"></button>
            <button type="button" onclick="LogoutEvent()"><img src="../img/logout.png"></button>
        </div>

        <div class="year_container">
            <button type="button" onclick="showPreviousYearEvent()"><img src="../img/arrow_back.png"></button>
            <p id="showYear"></p>
            <button type="button" onclick="showNextYearEvent()"><img src="../img/arrow_forward.png"></button>
        </div>

        <div class="month_container" id="monthContainer"></div>
        <div class="date_container" id="dateContainer"></div>
    </form>

    <!-- 모달 창 -->
    <div id="modal" class="modal">
        <div class="modal_container">
            <button type="button" class="close_button" onclick=" closeModalEvent()"><img src="../img/close.png"></button>
            <p id="modalDate">모달</p>
                
            <div id="post_container"></div>
            
            <div class="post_input_container">
                <input type="text" id="time_input" placeholder="00:00">
                <input type="text" id="post_input" placeholder="게시글을 입력하세요">
                <button type="button" onclick="savePostEvent()">저장</button>
            </div>
        </div>
    </div>

    <script src="../js/main2.js"></script>
</body>
</html>