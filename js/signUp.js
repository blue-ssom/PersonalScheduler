function validateForm() {
    // 아이디 입력값 가져오기
    var idValue = document.getElementById("id_value").value;
    console.log("id_value: ", idValue);

    // 비밀번호 입력값 가져오기
    var pwValue = document.getElementById('pw_value').value;
    console.log("pw_value: ", pwValue);

    // 이름 입력값 가져오기
    var nameValue = document.getElementById('name').value;
    console.log("name: ", nameValue);


    // 전화번호 입력값 가져오기
    var phoneNumberValue = document.getElementById('phonenumber').value;
    console.log("phonenumber: ", phoneNumberValue);


    if (!idValue.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/)) {
         // 아이디의 길이가 최소 8자 이상, 최대 12자이고, 영어와 숫자를 포함하는지 확인
        alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
        return false;
    }else if (!pwValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/)) {
        // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
        alert("비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.");
        return false;
    }else if (!nameValue.match(/^[\uAC00-\uD7A3]{2,10}$/)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
        alert("이름은 최소 2자 이상, 최대 10자까지이며, 한글로 입력되어야 합니다.");
        return false;
    }else if (!phoneNumberValue.match(/^010-([0-9]{3,4})-([0-9]{4})$/)) {
        // 전화번호 형식 확인
        alert('유효하지 않은 전화번호 형식입니다.');
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
        // 회원가입 버튼 누르면
        // window.location.href = "../action/checkDuplicate.jsp?id=" + encodeURIComponent(idValue);
        window.location.href = "../action/checkDuplicate.jsp?id=" + idValue;   // MEMO ::
    }
}

// 비밀번호 보이기/숨기기
function togglePasswordVisibilityEvent() {   // MEMO ::
    // 비밀번호 입력값 가져오기
    var pwValue = document.getElementById('pw_value').value;

    // 현재 input 타입이 password이면 text로, text이면 password로 변경
    if (pwValue.type === "password") {
        pwValue.type = "text";
    } else {
        pwValue.type = "password";
    }
}

const autoHyphen = (target) => {
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}