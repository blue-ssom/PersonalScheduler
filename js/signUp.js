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

    // 이름 입력값 가져오기
    var nameValue = document.getElementById('name').value;
    // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
    if (nameValue === "" || !nameValue.match(/^.{2,10}$/)) {
        alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
        return false;
    }
    
    // 전화번호 입력값 가져오기
    var input = document.getElementById('phonenumber');
    var phoneNumber = input.value.replace(/\D/g, ''); // 숫자만 추출

     // 입력값이 비어 있는지 확인
    if (phoneNumber === '') {
        alert('전화번호를 입력해 주세요.');
        return;
    }

    // 정규식을 사용하여 전화번호 형식 확인
    var phoneNumberRegex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

    if (!phoneNumberRegex.test(phoneNumber)) {
        alert('유효하지 않은 전화번호 형식입니다.');
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

function formatPhoneNumber(input) {
    // 입력값에서 숫자만 추출
    var phoneNumber = input.value.replace(/\D/g, '');

    // 전화번호 형식에 맞게 '-' 추가
  if (phoneNumber.length > 2 && phoneNumber.length <= 5) {
    input.value = phoneNumber.slice(0, 2) + '-' + phoneNumber.slice(2);
  } else if (phoneNumber.length > 5 && phoneNumber.length <= 9) {
    input.value = phoneNumber.slice(0, 2) + '-' + phoneNumber.slice(2, 5) + '-' + phoneNumber.slice(5);
  } else if (phoneNumber.length > 9) {
    input.value = phoneNumber.slice(0, 2) + '-' + phoneNumber.slice(2, 5) + '-' + phoneNumber.slice(5, 9) + '-' + phoneNumber.slice(9);
  }

    // 입력란에 반영
    input.value = phoneNumber;
}