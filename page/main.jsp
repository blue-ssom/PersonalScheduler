<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%
    HttpSession userSession = request.getSession(false);
        String idValue = (String) userSession.getAttribute("id");
        if (idValue == null) {
            // 세션이 없으면 로그인 페이지로 리디렉션
            response.sendRedirect("../page/index.jsp");
        }
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