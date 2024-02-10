<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%
    // 사용 가능한 아이디면 입력한 아이디 그대로 유지
    String idValue = request.getParameter("id");
%>
    <script>
        console.log("signUp.jsp");
        console.log("idValue: <%= idValue %>");
    </script>
<%
    // disabled 변수가 'true'인지 확인하여 입력 필드의 상태를 결정
    boolean disabled = request.getParameter("disabled") != null && request.getParameter("disabled").equals("true");
%>
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
            <input type="text" name="id_value" id="id_value" placeholder="아이디를 입력하세요" maxlength='12'  value="<%= (idValue != null) ? idValue : "" %>"<%= disabled ? "disabled" : "" %>>
            <!-- 숨겨진 필드 추가 -->
            <input type="hidden" name="id_value_hidden" id="id_value_hidden" value="<%= request.getParameter("id") %>">
            <button type="button" id="checkButton" onclick="checkDuplicateEvent()"<%= disabled ? "disabled" : "" %>>중복확인</button>
        </div>
        
        <div class="input_container">
            <input type="password" name="pw_value" id="pw_value" placeholder="비밀번호를 입력하세요" maxlength='16'>
            <button type="button" onclick="togglePasswordVisibilityEvent()">확인</button>
        </div>

        <input type="text" name="name_value" id="name" class="custom-input" placeholder="이름을 입력하세요" maxlength='10'>
        <input type="text" name="phonenumber_value" id="phonenumber" class="custom-input" placeholder="전화번호를 입력하세요" oninput="autoHyphen(this)" maxlength="13">

        <div>
            <button type="submit" class="button_container">회원가입</button>
            <button type="button" class="button_container" onclick="returnToHomeEvent()">홈</button>
        </div>
    </form>
    <script src="../js/signUp.js?checkedId=<%= idValue %>"></script>
     <script>
        function returnToHomeEvent() {
        // 홈 버튼 누르면
        window.location.href = "index.jsp";
        }
    </script>
</body>
</html>