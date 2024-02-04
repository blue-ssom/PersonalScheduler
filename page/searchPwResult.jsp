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
    request.setCharacterEncoding("UTF-8");// 이전 페이지에서 온 값에 대한 인코딩 설정

    // 전달된 아이디, 이름과 핸드폰 번호 파라미터 가져오기
    String id = request.getParameter("id_value");
    String name = request.getParameter("name_value");
    String phonenumber = request.getParameter("phone_number_value");

    String foundPw = ""; // foundPw 변수 초기화

    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver"); // Connector 파일 찾아오는 명령어
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 입력된 정보를 가진 사용자 비밀번호  조회
        String sql = "SELECT password FROM user WHERE id=? AND name=? AND phoneNumber=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, name);
        query.setString(3, phonenumber);

        // sql 결과 받아오기
        ResultSet result = query.executeQuery();

        // 조회된 비밀번호를 클라이언트에게 전송
        if (result.next()) {
            foundPw = result.getString("password");
        } else {
%>
            <script>
                alert('해당 정보가 없습니다.');
                window.location.href = '../page/searchPw.jsp';  // 실패 시에 다시 searchPw.jsp로 이동하도록 설정
            </script>
<%
        }

    } catch (Exception e) {
        response.sendRedirect("../page/searchPw.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 확인</title>
    <link rel="stylesheet" href="../css/search.css">
</head>
<body>
    <form>
        <h2>비밀번호 확인</h2>
        <div class="result_container">
            비밀번호는 
            <span><%= foundPw %></span> 
            입니다.
        </div>

        <button type="button" onclick="returnToHomeEvent()">홈</button>
    </form>
</body>
    <script>
        function returnToHomeEvent() {
        // 홈 버튼 누르면
        window.location.href = "index.jsp";
        }
    </script>
</html>