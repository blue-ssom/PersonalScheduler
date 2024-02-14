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
    request.setCharacterEncoding("UTF-8"); // 이전 페이지에서 온 값에 대한 인코딩 설정

    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");

    if (idValue == null) {
        // 세션이 없으면 로그인 페이지로 리디렉션
        out.println("<script>location.href='../page/index.jsp';</script>"); // 실패 시에 다시 index.jsp로 이동하도록 설정  

    }
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

        // 조회된 정보르 클라이언트에게 전송
        if (result.next()) {
            userId = result.getString("id");
            password = result.getString("password");
            name = result.getString("name");
            phoneNumber = result.getString("phoneNumber");
        }
    } catch (Exception e) {
        out.println("<script>alert('" + e.getMessage() + "');</script>");
        out.println("<script>location.href='../page/main.jsp';</script>"); // 실패 시에 다시 main.jsp로 이동하도록 설정  
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 보기</title>
    <link rel="stylesheet" href="../css/profile.css">
</head>
<body>
    <div class="form_container">
        <h2>내 정보 보기</h2>
        <table>
            <tr>
                <td>아이디</td>
                <td><%= userId %></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><%= password %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><%= phoneNumber %></td>
            </tr>
        </table>

        <div class="button_container">
            <form action="../page/modifyProfile.jsp" method="post">
                <button class="update" type="submit">수정하기</button>
            </form>

            <form action="../page/withdraw.jsp" method="post">
                <button class="delete" type="submit">탈퇴하기</button>
            </form>
        </div>
    </div>
</body>
</html>
