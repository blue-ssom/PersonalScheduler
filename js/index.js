function hasWhiteSpace(str) {
    // 정규식을 사용하여 문자열에 공백이 있는지 확인
    return /\s/.test(str);
}

function validateForm() {
    // 아이디와 비밀번호 입력값 가져오기
    var idInput = document.getElementById('id_value').value;
    var pwInput = document.getElementById('pw_value').value;
    console.log("id_value", idInput);
    console.log("ipw_value", pwInput);

    // 입력 값이 공백이 아니고 길이 제한을 초과하지 않는지 검증
    if (hasWhiteSpace(idInput) || idInput.length > 12) {
        alert('아이디를 다시 확인해주세요.');
        return false;
    }

    if (hasWhiteSpace(pwInput) || pwInput.length > 16) {
        alert('비밀번호를 다시 확인해주세요.');
        return false;
    }

    // 유효성 검사를 통과하면 true 반환하여 폼 제출 허용
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