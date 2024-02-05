<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // request: 현재 요청에 대한 HttpServletRequest 객체
    // getSession(false): 세션이 없으면 새로운 세션을 생성하지 않고(null을 반환) 세션이 이미 존재하면 해당 세션을 반환
    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");
    if (idValue == null) {
        // 세션이 없으면 로그인 페이지로 리디렉션
        response.sendRedirect("../page/index.jsp");
    }

    if (userSession != null) {
        // 세션이 존재하면  무효화(로그아웃)
        userSession.invalidate();
    }
%>

<script>
    window.location.href = "../page/index.jsp"; // 로그아웃 후 로그인 페이지로 이동
</script>