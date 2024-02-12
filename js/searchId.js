function validateForm() {
    // 이름 입력값 가져오기
    var nameValue = document.getElementById('name_value').value;
    console.log("nameValue",nameValue);

    // 전화번호 입력값 가져오기
    var phoneNumberValue = document.getElementById('phone_number_value').value;
    console.log("phoneNumberValue",phoneNumberValue);

    if(!nameValue.match(/^[\uAC00-\uD7A3]{2,10}$/)) {
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

const autoHyphen = (target) => {
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}
