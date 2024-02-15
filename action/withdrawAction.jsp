<%-- 회원탈퇴를 위한 액션 --%>

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
        out.println("<script>location.href='../page/index.jsp';</script>");
    }
%>
    <script>
        console.log("idValue: <%= idValue %>");
    </script>
<%

    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 사용자 삭제
        String sql = "DELETE FROM user WHERE id=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, idValue);

        // sql 결과 받아오기
        int result = query.executeUpdate();
        out.println("<script>location.href='../page/index.jsp';</script>");// 회원 탈퇴 후 이동할 페이지

    } catch (Exception e) {
        out.println("<script>alert('" + e.getMessage() + "');</script>");
        out.println("<script>location.href='../page/viewProfile.jsp';</script>"); // 실패 시에 다시 viewProfile.jsp로 이동하도록 설정
        e.printStackTrace();
    }
%>
