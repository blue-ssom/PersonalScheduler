<%-- 로그인을 위한 액션 --%>

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

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    // 아이디를 입력하지 않았을 때
    if (idValue.isEmpty()) {
        out.println("<script>alert('아이디를 입력해주세요.');</script>");
        response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
    } else if (!idValue.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$")) {
        // 아이디가 제약 조건을 만족하지 않을 때
        out.println("<script>alert('아이디는 최소 8글자에서 최대 12글자까지이며, 최소 한 자리 이상의 영어와 숫자를 포함해야 합니다.');</script>");
        response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
    } else if (pwValue.isEmpty()) {
        // 비밀번호를 입력하지 않았을 때
        out.println("<script>alert('비밀번호를 입력해주세요.');</script>");
        response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
    } else if (!pwValue.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,16}$")) {
        // 비밀번호가 제약조건을 만족하지 않을 때
        out.println("<script>alert('비밀번호는 최소 8글자에서 최대 16글자까지이며, 최소 한 자리 이상의 영어, 숫자, 특수문자를 포함해야 합니다.');</script>");
        response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
    }

    // 예외가 발생할 가능성이 있는 코드
    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver"); // Connector 파일 찾아오는 명령어
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 입력된 아이디와 비밀번호를 가진 사용자 조회
        String sql = "SELECT * FROM user WHERE id=? AND password=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, idValue); // 첫 번째 Column 읽어오기
        query.setString(2, pwValue); // 두 번째 Column 읽어오기

        // sql 결과 받아오기
        ResultSet result = query.executeQuery();

        // 로그인 성공 여부 확인
        if (!result.next()) {   // MEMO : 조건문으로는 실패의 경우를 먼저 써주는게 좋음
            // 로그인 실패 시에 필요한 처리
            out.println("<script>alert('아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.');</script>");
            response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
        } else {
            // 로그인 성공 시에 필요한 처리
            
            // 세션에 사용자 정보 저장
            HttpSession userSession = request.getSession();
            userSession.setAttribute("id", idValue); // "id"는 세션에 저장될 속성의 이름, idValue는 그에 해당하는 값

            response.sendRedirect("../page/main.jsp"); // 로그인 성공 시에 main.jsp로 이동
        }
    } catch (Exception e) {
        out.println("<script>alert('" + e.getMessage() + "');</script>");
        response.sendRedirect("../page/index.jsp");    // 실패 시에 다시 index.jsp로 이동하도록 설정
    }
%>