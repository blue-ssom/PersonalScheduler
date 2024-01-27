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
    <form action="../action/login.jsp" method="post" onsubmit="return validateForm()">
        <!-- 아이디의 길이가 최소 1자 이상, 최대 12자 -->
        <input type="text" name="id_value" placeholder="아이디를 입력하세요" pattern=".{1,12}" required>
        <!-- 비밀번호의 길이가 최소 1자 이상, 최대 16자 -->
        <input type="password" name="pw_value" placeholder="비밀번호를 입력하세요" pattern=".{1,16}" required>

        <button type="submit">로그인</button>
        <button type="button" onclick="signUpEvent()">회원가입</button>
        <button type="button" onclick="searchIdEvent()">아이디 찾기</button>
        <button type="button" onclick="searchPwEvent()">비밀번호 찾기</button>
    </form>
    
    <script>
        function validateForm() {
        // 폼 검증 로직
        var id_value = document.getElementsByName("id_value")[0].value;

        // 아이디 예외 처리
        if (id_value.length < 1 || id_value.length > 12) {
            alert("아이디는 1자 이상 12자 이하로 입력하세요.");
            return false; // 폼 제출 중단
        }

        // 비밀번호 예외처리
        if (pw_value.length < 1 || pw_value.length > 16) {
            alert("비밀번호는 1자 이상 16자 이하로 입력하세요.");
            return false; // 폼 제출 중단
        }

        // 유효한 경우 폼을 제출
        return true;

        }
    
        function signUpEvent() {
            // 회원가입 버튼 누르면
            window.location.href = "signUp.jsp";
        }
    
        function searchIdEvent() {
            // 아이디 찾기 버튼 누르면
            window.location.href = "searchId.jsp";
        }
    
        function searchPwEvent() {
            // 비밀번호 찾기 버튼 누르면 
            window.location.href = "searchPw.jsp";
        }
    </script>
</body>
</html>
