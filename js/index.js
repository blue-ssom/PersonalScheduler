function validateForm() {
    // 아이디 입력값 가져오기
    var idValue = document.getElementById("id_value").value;
    console.log("id_value: ", idValue);

    // 아이디의 길이가 최소 8자 이상, 최대 12자이고, 영어와 숫자를 포함하는지 확인
    if (!idValue.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/)) {
        alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
        return false;
    }

    // 비밀번호 입력값 가져오기
    var pwValue = document.getElementById('pw_value').value;
    console.log("pw_value: ", pwValue);
    // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
    var pwValue = document.getElementById("pw_value").value;
    if (!pwValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/)) {
        alert("비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.");
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