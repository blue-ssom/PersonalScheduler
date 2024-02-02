<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="../css/index.css"/>
</head>
<body>
    <form  id="loginForm" action="../action/login.jsp" method="post" onsubmit="return validateForm()">
        <!-- 아이디의 길이가 최소 1자 이상, 최대 12자 -->
        <input type="text" name="id_value" id="id_value" placeholder="아이디를 입력하세요" maxlength='12'>
        <!-- 비밀번호의 길이가 최소 1자 이상, 최대 16자 -->
        <input type="password" name="pw_value" id="pw_value" placeholder="비밀번호를 입력하세요" maxlength='16'>

        <button type="submit">로그인</button>
        <button type="button" onclick="signUpEvent()">회원가입</button>
        <button type="button" onclick="searchIdEvent()">아이디 찾기</button>
        <button type="button" onclick="searchPwEvent()">비밀번호 찾기</button>
    </form>

    <script src="../js/index.js"></script>
</body>
</html>