<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
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
    <div id="modal_container" class="modal_container">
        <div class="modal-content">
            <button type="button" onclick=" closeModalEvent()"><img src="../img/close.png"></button>
            <p id="modalContent">모달 내용이 여기에 들어갑니다.</p>
        </div>
    </div>

    <script src="../js/main2.js"></script>
</body>
</html>