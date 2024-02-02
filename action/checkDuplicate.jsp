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
    String idValue = request.getParameter("id");

    // 아이디를 입력하지 않았을 때
    if (idValue.equals("")) {
%>
        <script>
            alert('아이디를 입력해 주세요.');
            window.location.href = '../page/signUp.jsp';  // 실패 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    } else if (!idValue.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$")) {
        // 아이디가 제약 조건을 만족하지 않을 때
%>
        <script>
            alert('아이디는 최소 8글자에서 최대 12글자까지이며, 최소 한 자리 이상의 영어와 숫자를 포함해야 합니다.');
            window.location.href = '../signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    } 
    // 예외가 발생할 가능성이 있는 코드
    // 예외 발생 시 예외 객체가 생성되고, 해당 예외 객체가 catch 블록으로 전달됨
    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver"); // Connector 파일 찾아오는 명령어
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 아이디 존재 여부 조회
        String sql = "SELECT * FROM user WHERE id=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, idValue); // 첫 번째 Column 읽어오기

        // sql 결과 받아오기
        ResultSet result = query.executeQuery();
        
        // 아이디가 존재하지 않을 때
        // ResultSet에 결과 집합에서 다음 행으로 이동하고, 이동한 행이 존재하면 true를 반환
        if (result.next()) {
%>
            <script>
                alert('사용 불가능한 아이디입니다.');
                window.location.href = '../page/signUp.jsp';  // 다시 signUp.jsp로 이동하도록 설정

            </script>
<%
        } else {
            // 아이디가 존재할 때
%>
            <script>
                alert('사용 가능한 아이디입니다.');
                window.location.href = '../page/signUp.jsp';  // 다시 signUp.jsp로 이동하도록 설정
            </script>
<%
        }
    } catch (Exception e) {
%>
        window.location.href = '../page/signUp.jsp';  // 실패 시에 다시 signUp.jsp로 이동하도록 설정
<%
    }
%>