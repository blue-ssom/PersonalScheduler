<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 보기</title>
    <link rel="stylesheet" href="../css/profile.css">
</head>
<body>
    <div class="form-container">
        <h2>내 정보 보기</h2>
        <div class="info-box">아이디</div>
        <div class="info-box">비밀번호</div>
        <div class="info-box">이름</div>
        <div class="info-box">전화번호</div>

        <div class="button-container">
            <form action="../jsp/updateProfile.jsp" method="post">
                <button class="update" type="submit">수정하기</button>
            </form>

            <form action="../jsp/withdraw.jsp" method="post">
                <button class="delete" type="submit">탈퇴하기</button>
            </form>
        </div>
    </div>
</body>
</html>
