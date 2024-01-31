<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정하기</title>
    <link rel="stylesheet" href="../css/signUp.css"/>
</head>
<body>
    <form action="../jsp/signup.jsp" method="post">
        <h2>내 정보 수정하기</h2>
        <div class="input-group">
            <input type="text" name="id_value" value="아이디" required>
            <button onclick="checkDuplicateEvent()">중복확인</button>
        </div>
        
        <div class="input-group">
            <input type="password" name="pw_value" value="비밀번호" required>
            <button onclick="togglePasswordVisibilityEvent()">확인</button>
        </div>

        <input type="text" name="name_value"  class="custom-input" value="이름" required>
        <input type="text" name="phone_number_value"  class="custom-input" value="전화번호" required>

        <button type="submit">수정하기</button>
    </form>
</body>
</html>
