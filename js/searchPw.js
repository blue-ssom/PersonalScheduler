function validateForm() {
    // 아이디 입력값 가져오기
    var idValue = document.getElementById("id_value").value;
    console.log("id_value: ", idValue);
    
    // 이름 입력값 가져오기
    var nameValue = document.getElementById('name_value').value;
    console.log("name: ", nameValue);


    // 전화번호 입력값 가져오기
    var phoneNumberValue = document.getElementById('phone_number_value').value;
    console.log("phonenumber: ", phoneNumberValue);


     // 아이디의 길이가 최소 8자 이상, 최대 12자이고, 영어와 숫자를 포함하는지 확인
    if (!idValue.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/)) {
        alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
        return false;
    }else if (!nameValue.match(/^[\uAC00-\uD7A3]{2,10}$/)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
        alert("이름은 최소 2자 이상, 최대 10자까지이며, 한글로 입력되어야 합니다.");
        return false;
    }else if (!phoneNumberValue.match(/^010-([0-9]{3,4})-([0-9]{4})$/)) {
        // 전화번호가 숫자로만 이루어져 있는지 확인
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