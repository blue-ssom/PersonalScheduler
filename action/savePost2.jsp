<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>

<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>

<%-- 데이터베이스 SQL 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- Table에서 가져온 값을 처리하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>

<%-- java에서 정규 표현식을 사용하기 위한 Pattern 클래스를 import --%>
<%@ page import="java.util.regex.Pattern" %>
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

    // 전달받은 데이터 처리
    String postText = request.getParameter("post_text");
    String postTime = request.getParameter("post_time");
    String clickedDate = request.getParameter("clicked_date");
%>
    <script>
        console.log("postText: <%= postText %>");
    </script>
<%
%>
    <script>
        console.log("postTime: <%= postTime %>");
    </script>
<%
%>
    <script>
        console.log("clickedDate: <%= clickedDate %>");
    </script>
<%

// TO DO 2가지
    if(!Pattern.matches("^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$", postTime)){
%>
        <script>
            alert("올바른 시간 형식으로 입력해주세요. (예: HH:mm)");
            window.history.back(); // 브라우저의 이전 페이지로 이동
        </script>
<%
    }else if (!Pattern.matches("^.{1,100}$", postText)){
%>
        <script>
            alert("1자 이상 100자 이하의 메시지를 입력하세요.");
            window.history.back(); // 브라우저의 이전 페이지로 이동
        </script>
<%
    }else if(!Pattern.matches("^\\d{4}-\\d{2}-\\d{2}$", clickedDate)){
%>
        <script>
            alert("올바른 날짜 형식으로 입력해주세요. (예: YYYY-MM-DD)");
            window.history.back(); // 브라우저의 이전 페이지로 이동
        </script>
<%
    }else {
        // 예외가 발생할 가능성이 있는 코드
        // 예외 발생 시 예외 객체가 생성되고, 해당 예외 객체가 catch 블록으로 전달됨
        try {
            // DB 연결
            Class.forName("com.mysql.jdbc.Driver"); // Connector 파일 찾아오는 명령어
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

            // sql 준비 및 전송
            // 입력된 시간과 내용 추가
            String sql = "INSERT INTO schedule (user_idx, creationDate, creationTime, content) VALUES (?, ?, ?, ?)";
            PreparedStatement query = conn.prepareStatement(sql);
            query.setInt(1, user_idx); // 첫 번째 Column 읽어오기
            query.setString(2, clickedDate); // 두 번째 Column 읽어오기
            query.setString(3, postTime); // 세 번째 Column 읽어오기
            query.setString(4, postText); // 네 번째 Column 읽어오기

            // sql 결과 받아오기
            int result = query.executeUpdate();
            if (result > 0) {
            // 데이터 추가 성공
    %>
            <script>
                alert("일정 추가 성공!!");
                window.history.back(); // 브라우저의 이전 페이지로 이동
            </script>
    <%
            } else {
            // 데이터 추가 실패
    %>
            <script>
                alert("일정 추가에 실패하였습니다.");
                window.history.back(); // 브라우저의 이전 페이지로 이동
            </script>
    <%
            }

        } catch (Exception e) {
    %>
            <script>
                window.history.back(); // 브라우저의 이전 페이지로 이동
            </script>
    <%
        }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디버깅</title>
</head>
<body>
</body>
</html>