<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="../css/signUp.css"/>
</head>
<body>
    <form action="../action/signUpAction.jsp" method="post" onsubmit="return validateForm()">
        <h2>회원가입</h2>
        <div class="input_container">
            <input type="text" name="id_value" id="id_value" placeholder="아이디를 입력하세요" maxlength='12'>
            <button type="button" onclick="checkDuplicateEvent()">중복확인</button>
        </div>
        
        <div class="input_container">
            <input type="password" name="pw_value" id="pw_value" placeholder="비밀번호를 입력하세요" maxlength='16'>
            <button type="button" onclick="togglePasswordVisibilityEvent()">확인</button>
        </div>

        <input type="text" name="name_value" id="name" class="custom-input" placeholder="이름을 입력하세요" maxlength='10'>
        <input type="text" name="phonenumber_value" id="phonenumber" class="custom-input" placeholder="전화번호를 입력하세요" maxlength='13' oninput="formatPhoneNumber(this)">

        <button type="submit">회원가입</button>
    </form>
    <script src="../js/signUp.js"></script>
</body>
</html>