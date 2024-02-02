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

// 아이디 중복 확인
function checkDuplicateEvent() {
    // 아이디 입력값 가져오기
    var idValue = document.getElementById("id_value").value;

    if (!idValue.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/)) {
        alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
    } else {
        // 페이지 이동 및 아이디 값 전달
        window.location.href = "../action/checkDuplicate.jsp?id=" + encodeURIComponent(idValue);
    }
}

// 비밀번호 보이기/숨기기
function togglePasswordVisibilityEvent() {
    // 비밀번호 입력 필드 엘리먼트 가져오기
    var passwordInput = document.getElementById('pw_value');
    console.log("pw_value: ", passwordInput.value);
    
    // 비밀번호 입력값 가져오기
    var pwValue = document.getElementById('pw_value').value;

    // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
    if (!pwValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/)) {
        alert("비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.");
    } else {
            // 현재 input 타입이 password이면 text로, text이면 password로 변경
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }
}
