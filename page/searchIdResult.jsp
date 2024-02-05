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
    request.setCharacterEncoding("UTF-8");// 이전 페이지에서 온 값에 대한 인코딩 설정

    // 전달된 이름과 핸드폰 번호 파라미터 가져오기
    String nameValue = request.getParameter("name_value");
    String phonenumberValue = request.getParameter("phone_number_value");

    if (nameValue.isEmpty()) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
%>
        <script>
            alert("이름을 입력해주세요.");
            window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정

        </script>
<%
        
    }else if ( !Pattern.matches("^[가-힣]{2,4}$", nameValue)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
%>
        <script>
            alert("이름은 최소 2자 이상, 최대 12자까지 입력 가능합니다.");
            window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정

        </script>
<%
        
    }else if (phonenumberValue.isEmpty()) {
        // 전화번호 길이가 11인지 확인
%>
        <script>
            alert('전화번호를 입력해 주세요.');
            window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정

        </script>
<%
    }else if (!Pattern.matches("^010-([0-9]{3,4})-([0-9]{4})$",phonenumberValue)) {
        // 전화번호가 숫자로만 이루어져 있는지 확인
%>
        <script>
            alert('유효하지 않은 전화번호 형식입니다.');
            window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정
        </script>
<%
    }

    String foundId = ""; // foundId 변수 초기화

    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver"); // Connector 파일 찾아오는 명령어
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 입력된 정보를 가진 사용자 아이디 조회
        String sql = "SELECT id FROM user WHERE name=? AND phoneNumber=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, nameValue);
        query.setString(2, phonenumberValue);

        // sql 결과 받아오기
        ResultSet result = query.executeQuery();

        // 조회된 아이디를 클라이언트에게 전송
        if (result.next()) {
            foundId = result.getString("id");
        } else {
%>
            <script>
                alert('해당 정보가 없습니다.');
                window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정
            </script>
<%
        }

    } catch (Exception e) {
%>
            <script>
                window.location.href = '../page/searchId.jsp';  // 실패 시에 다시 searchId.jsp로 이동하도록 설정
            </script>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 확인</title>
    <link rel="stylesheet" href="../css/search.css">
</head>
<body>
    <form>
        <h2>아이디 확인</h2>
        <div class="result_container">
            아이디는 
            <span><%= foundId %></span> 
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