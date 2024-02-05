<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    request.setCharacterEncoding("UTF-8");
    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");
    if (idValue == null) {
        // 세션이 없으면 로그인 페이지로 리디렉션
        response.sendRedirect("../page/index.jsp");
    }
    
    // 세션 디버깅
%>
    <script>
        console.log("idValue: <%= idValue %>");
    </script>
<%

    String userId="";
    String password="";
    String name="";
    String phoneNumber="";

    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // 세션으로 사용자 아이디 조회
        String sql = "SELECT * FROM user WHERE id=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, idValue);

        // sql 결과 받아오기
        ResultSet result = query.executeQuery();

        // 조회된 정보 출력
        if (result.next()) {
            userId = result.getString("id");
            password = result.getString("password");
            name = result.getString("name");
            phoneNumber = result.getString("phoneNumber");
        } 
    } catch (Exception e) {
%>
    <script>
        window.location.href = '../page/main.jsp'; 
    </script>
<%
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정하기</title>
    <link rel="stylesheet" href="../css/signUp.css"/>
</head>
<body>
    <form action="../action/modifyProfileAction.jsp" method="post" onsubmit="return validateForm()">
        <h2>내 정보 수정하기</h2>
        <div><%= userId %></div>
        <div class="input_container">
            <input type="password" name="pw_value" id="pw_value" value="<%= password %>">
            <button type="button" onclick="togglePasswordVisibilityEvent()">확인</button>
        </div>

        <input type="text" name="name_value" id="name" class="custom-input" value="<%= name %>">
        <input type="text" name="phone_number_value" id="phonenumber" class="custom-input" value="<%= phoneNumber %>">

        <button type="submit">수정하기</button>
    </form>
    <script src="../js/modifyProfile.js"></script>
</body>
</html>
