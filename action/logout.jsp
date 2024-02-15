<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");
    
    if (idValue == null) {
        // 세션이 없으면 로그인 페이지로 리디렉션
        out.println("<script>location.href='../page/index.jsp';</script>"); 
    }

    if (userSession != null) {
        // 세션이 존재하면  무효화(로그아웃)
        userSession.invalidate();
        out.println("<script>location.href='../page/index.jsp';</script>"); // 로그아웃 후 로그인 페이지로 이동
    }
%>
