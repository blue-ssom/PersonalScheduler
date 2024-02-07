<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
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

        // user_idx와 clickedDate와 일치하는 값 가져오기
        String sql = "SELECT * FROM post WHERE idx = ? AND creationDate = ?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setInt(1, user_idx); // 첫 번째 Column 읽어오기
        query.setString(2, clickedDate); // 두 번째 Column 읽어오기

        // sql 결과 받아오기
        ResultSet result = getUserIdx.executeQuery();

        // 값 가져오기 및 변수 초기화
        String time = "";
        String content = "";
        if (result.next()) {
            time = result.getString("creationTime");
            content = result.getString("content");
    %>
            <script>
                alert("일정 불러오기 성공!!");
                window.history.back(); // 브라우저의 이전 페이지로 이동
            </script>
    <%
        }

    }catch (Exception e) {
%>
        <script>
            alert("뭔가 잘못됨");
            window.history.back(); // 브라우저의 이전 페이지로 이동
        </script>
<%
    }
%>
