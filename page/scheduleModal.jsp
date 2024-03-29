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
    // 데이터베이스에서 일정 정보를 가져오는 부분
    String time = "";
    String content = "";
    ResultSet result = null;
    boolean success = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // 아이디를 기반으로 user_idx 가져오기
        String getUserIdxQuery = "SELECT idx FROM user WHERE id = ?";
        PreparedStatement getUserIdx = conn.prepareStatement(getUserIdxQuery);
        getUserIdx.setString(1, idValue); // 첫 번째 Column 읽어오기

        // sql 결과 받아오기
        ResultSet userIdxResult = getUserIdx.executeQuery();

        // user_idx 값을 가져오기
        int user_idx = 0;// 변수 초기화
        if (userIdxResult.next()) {
            user_idx = userIdxResult.getInt("idx");
        }

        // user_idx와 clickedDate 기반으로 시간, 내용 가져오기
        String sql = "SELECT * FROM schedule WHERE idx = ? AND creationDate = ?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setInt(1, user_idx); // 첫 번째 Column 읽어오기
        query.setString(2, clickedDate); // 두 번째 Column 읽어오기

        // sql 결과 받아오기
        result = getUserIdx.executeQuery();

        if (result.next()) {
            time = result.getString("creationTime");
            content = result.getString("content");
            success = true;
    %>
            <script>
                alert("일정 불러오기 성공!!");
                window.history.back(); // 브라우저의 이전 페이지로 이동
            </script>
    <%
        }
    } catch (Exception e) {
%>
        <script>
            alert("뭔가 잘못됨");
            window.history.back(); // 브라우저의 이전 페이지로 이동
        </script>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 상세 보기 모달창</title>
    <link rel="stylesheet" href="../css/main.css"/>
</head>
<body>
    <div id="modal" class="modal">
        <div class="modal_container">
            <button type="button" class="close_button" onclick=" closeModalEvent()"><img src="../img/close.png"></button>
            <p id="modalDate">모달</p>
<% 
    if (success) {
        do {
%>
            <div class="post_container">
                <p><%= result.getString("creationTime") %></p>
                <p><%= result.getString("content") %></p>
            </div>
<%
        } while (result.next());
    }
%>

            
            <div class="post_input_container">
                <input type="text" id="time_input" placeholder="00:00">
                <input type="text" id="post_input" placeholder="게시글을 입력하세요">
                <button type="button" onclick="savePostEvent()">저장</button>
            </div>
        </div>
    </div>
</body>
</html>