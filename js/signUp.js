function validateForm() {

    // 아이디 입력값 가져오기
    var idInput = document.getElementById('id_value').value;

    // 아이디 유효성 검사
    if (!isValidId(idInput)) {
        alert('아이디는 최소 8글자에서 최대 12글자의 영어와 숫자로 이루어져야 합니다.');
        return false;
    }

    // 비밀번호 입력값 가져오기
    var pwInput = document.getElementById('pw_value').value;

    // 비밀번호 유효성 검사
     if (!isValidPw(pwInput)) {
        alert('비밀번호는 최소 8글자에서 최대 16글자의 영어, 숫자와 특수문자로 이루어져야 합니다.');
        return false;
    }

    // 이름 최소 2자 이상, 최대 10자
    // 입력 값이 공백이 아니고 길이 제한을 초과하지 않는지 검증
    var nameInput = document.getElementById('name').value;

    if (!isValidName(nameInput)) {
        alert('이름은 최소 2자 이상, 최대 12자까지 입력 가능합니다.');
        return false;
    }

}

// 아이디 제약조건 확인
function isValidId(id) {
    // 아이디는 최소 8글자에서 최대 12글자의 영어와 숫자로 이루어져야 함
    // 최소 한 자리 이상의 영어와 숫자
    var idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/;;

    return idRegex.test(id);
}

// 아이디 중복 확인
function checkDuplicateEvent() {

}

// 비밀번호 제약조건 확인
function isValidPw(pw) {
    // 비밀번호는 최소 8글자에서 최대 16글자의 영어, 숫자와 특수문자로 이루어져야 함
    // 최소 한 자리 이상의 영어, 숫자와 특수문자 
    var pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;

    return pwRegex.test(pw);

}

// 비밀번호 보이기/숨기기
function togglePasswordVisibilityEvent() {
    var passwordInput = document.getElementById('pw_value');

    // 현재 input 타입이 password이면 text로, text이면 password로 변경
    passwordInput.type = (passwordInput.type === 'password') ? 'text' : 'password';
}

// 이름 유효성
function isValidName(name) {
    // 이름은 최소 2글자에서 최대 10글자의 한글로 이루어져야 함
    var nameRegex = /^[가-힣]{2,10}$/;
    return nameRegex.test(name);
}