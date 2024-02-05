let currentYear, currentMonth, currentDateOfMonth;
let selectedYear, selectedMonth, selectedDate;

function initializeCalendar() {
    // 현재 년/월/일을 가져와서 표시
    const currentDate = new Date();
    currentYear = currentDate.getFullYear();
    currentMonth = currentDate.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1 해줌
    currentDateOfMonth = currentDate.getDate();

    // 디버깅
    console.log("currentYear",currentYear);
    console.log("currentMonth",currentMonth);
    console.log("currentDateOfMonth",currentDateOfMonth);

    // 초기값 설정
    selectedYear = currentYear;
    selectedMonth = currentMonth;
    selectedDate = currentDateOfMonth;

    // 올해 연도 HTML에 출력
    document.getElementById('showYear').innerText = currentYear;

    // 기존 월 버튼 제거
    const monthContainer = document.getElementById('monthContainer');
    monthContainer.innerHTML = '';

    // 1부터 12까지의 월 버튼 생성
    const monthList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

    for (let i = 0; i < monthList.length; i++) {
        const monthButton = document.createElement('button');
        monthButton.type = 'button';
        monthButton.textContent = monthList[i];
        monthButton.addEventListener('click', function () {
            // 모든 월 버튼의 선택 효과 제거
            const allMonthButtons = document.querySelectorAll('#monthContainer button');
            allMonthButtons.forEach(btn => btn.classList.remove('selected'));

            // 선택된 월에 선택 효과 추가
            monthButton.classList.add('selected');
            selectedMonth = i + 1;
            console.log("selectedMonth",selectedMonth);

            // 업데이트된 월에 따라 날짜를 업데이트
            updateDays();
        });

        monthContainer.appendChild(monthButton);

        // 초기값으로 현재 월에 해당하는 버튼에 선택 효과 추가
        if (i + 1 === currentMonth) {
            monthButton.classList.add('selected');
        }
    }

    // 초기화시 현재 월에 따른 날짜 업데이트
    updateDays();
}

function updateDays() {
    const dateContainer = document.getElementById('dateContainer');
    dateContainer.innerHTML = ''; // 날짜 컨테이너 초기화

    const daysInMonth = getDaysInMonth(selectedMonth);

    for (let i = 1; i <= daysInMonth; i++) {
        const dayButton = document.createElement('button');
        dayButton.type = 'button';
        dayButton.textContent = i;

        dayButton.addEventListener('click', function () {
            // 모든 일 버튼의 선택 효과 제거
            const allDayButtons = document.querySelectorAll('#dateContainer button');
            allDayButtons.forEach(btn => btn.classList.remove('selected'));

            // 선택된 일에 선택 효과 추가
            dayButton.classList.add('selected');
            selectedDate = i;
            console.log("selectedDate", selectedDate);
        });

        // 각 일자 버튼에 클릭 이벤트 핸들러 추가
        dayButton.addEventListener('click', function () {
            openModal(selectedYear, selectedMonth,i); // 해당 날짜를 전달하여 모달 열기
        });

        dateContainer.appendChild(dayButton);

        // 초기값으로 현재 날짜에 해당하는 버튼에 선택 효과 추가
        if (i === currentDateOfMonth && selectedMonth === currentMonth && selectedYear === currentYear) {
            dayButton.classList.add('day');
        }

        // 한 줄에 7일씩 배치
        if (i  % 7 === 0) {
            dateContainer.appendChild(document.createElement('br'));
        }
        
        // 일요일일 때 빨간색으로 변경
        if (i  % 7 === 1) {
            dayButton.style.color = 'red';
        }
    }
}

// 선택된 월과 연도에 따라 해당 월의 일 수를 반환
function getDaysInMonth(month) {
    if (month === 1 || month === 3 || month === 5 || month === 7 || month === 8 || month === 10 || month === 12) {
        return 31;
    } else if (month === 2) {
        return 28;
    } else {
        return 30;
    }
}

function showPreviousYearEvent() {
    // 현재 연도를 가져와서 1을 빼고 표시
    selectedYear -= 1;
    document.getElementById('showYear').innerText = selectedYear;
    console.log("selectedYear",selectedYear);
    // 연도가 변경되었을 때 일자 업데이트
    updateDays();
}

function showNextYearEvent() {
    // 현재 연도를 가져와서 1을 더하고 표시
    selectedYear += 1;
    document.getElementById('showYear').innerText = selectedYear;
    console.log("selectedYear",selectedYear);
    // 연도가 변경되었을 때 일자 업데이트
    updateDays();
}

let formattedMonth = '';
let formattedDay = '';
let clickedDate = '';

// 일자 클릭 시 모달 창 띄우기
function openModal(year,month,day) {
    const modal = document.getElementById('modal');
    const modalContent = document.getElementById('modalDate');

    // 클릭한 날짜 정보를 서버로 전달할 때 형식 변환
    formattedMonth = (month < 10) ? `0${month}` : month;
    formattedDay = (day < 10) ? `0${day}` : day;
    clickedDate = `${year}-${formattedMonth}-${formattedDay}`;
    console.log('formattedMonth:', formattedMonth);
    console.log('formattedDay:', formattedDay);
    console.log('clickedDate:', clickedDate);


    // 모달 열기
    modal.style.display = 'block';
    // 모달 내용 설정
    modalContent.textContent = `${year}.${month}.${day}`;

    clearPostInput(); // 모달이 열릴 때 입력 창 초기화
  }


function savePostEvent() {
    const postContainer = document.getElementById('post_container');
    const postTextElement = document.getElementById('post_input');
    const postTimeElement = document.getElementById('time_input');

    const postText = postTextElement.value;
    const postTime = postTimeElement.value;
    console.log('저장한 내용:', postText);
    console.log('저장한 시간:', postTime);
    console.log('클릭한 날짜:', clickedDate);

    // 클릭한 날짜 정보를 쿼리 문자열로 변환
    const queryString = `?post_text=${encodeURIComponent(postText)}&post_time=${encodeURIComponent(postTime)}&clicked_date=${encodeURIComponent(clickedDate)}`;

    // 새로운 페이지로 이동
    window.location.href = `../action/savePost2.jsp${queryString}`;

    // 입력 칸 초기화
    postTextElement.value = '';
    postTimeElement.value = '00:00'; // 초기값으로 00:00 설정
}

function createPostElement(postText, postTime) {
    const postContainer = document.getElementById('post_container');

    const postDiv = document.createElement('div');
    postDiv.classList.add('post_container');

    const postContent = document.createElement('p');
    postContent.classList.add('post_input');
    postContent.textContent = postText;

    const postTimeContent = document.createElement('p');
    postTimeContent.classList.add('time_input');
    postTimeContent.textContent = postTime; 

    const buttonContainer = document.createElement('div');
    buttonContainer.classList.add('button_container');

    const editButton = document.createElement('button');
    editButton.type = 'button';
    editButton.textContent = '수정'; 
    editButton.addEventListener('click', function () {
        editPostEvent(postDiv);
    });

    const deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.textContent = '삭제';
    deleteButton.addEventListener('click', function () {
        deletePostEvent(postDiv);
    });

    buttonContainer.appendChild(editButton);
    buttonContainer.appendChild(deleteButton);

    postDiv.appendChild(postTimeContent);
    postDiv.appendChild(postContent);
    postDiv.appendChild(buttonContainer);

    postContainer.appendChild(postDiv);
}


// 게시물 수정
function editPostEvent(postDiv) {
    // 게시글 내용과 시간을 input으로 교체
    const postContent = postDiv.querySelector('.post_input');
    const postTime = postDiv.querySelector('.time_input');

    console.log('수정하려는 내용:', postContent.textContent);
    console.log('수정하려는 시간:', postTime.textContent);

    const postTextElement = document.createElement('input');
    postTextElement.type = 'text';
    postTextElement.classList.add('post_input');
    postTextElement.value = postContent.textContent;

    const postSelectElement = document.createElement('input');
    postSelectElement.type = 'text';
    postSelectElement.classList.add('time_input');
    postSelectElement.value = postTime.textContent;

    const saveButton = document.createElement('button');
    saveButton.type = 'button';
    saveButton.textContent = '저장';
    saveButton.addEventListener('click', function () {
        updatePostEvent(postDiv);
    });

    const deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.textContent = '삭제';
    deleteButton.addEventListener('click', function () {
        deletePostEvent(postDiv);
    });

    // 기존 내용 삭제하고 input으로 교체
    postContent.replaceWith(postTextElement);
    postTime.replaceWith(postSelectElement);

    // 수정 모드로 변경된 게시글 스타일 적용
    postDiv.classList.add('edit_mode');

    // 저장 및 삭제 버튼 추가 전에 기존 버튼 숨기기
    const existingButtons = postDiv.querySelectorAll('button');
    existingButtons.forEach(button => {
        button.style.display = 'none';
    });

    // 저장 및 삭제 버튼 추가
    postDiv.appendChild(saveButton);
    postDiv.appendChild(deleteButton);
}

// 수정된 내용을 저장하는 함수
function updatePostEvent(postDiv) {
    // 게시글 내용과 시간을 input으로 교체
    const postContent = postDiv.querySelector('.post_input');
    const postTime = postDiv.querySelector('.time_input');
    console.log('수정된 내용:', postContent.value);
    console.log('수정된 시간:', postTime.value);

    const postTextElement = document.createElement('input');
    postTextElement.type = 'text';
    postTextElement.classList.add('post_input');
    postTextElement.value = postContent.value;

    const postSelectElement = document.createElement('input');
    postSelectElement.type = 'text';
    postSelectElement.classList.add('time_input');
    postSelectElement.value = postTime.value;

    // 기존 내용 삭제하고 input으로 교체
    postContent.replaceWith(postTextElement);
    postTime.replaceWith(postSelectElement);

    // 수정 모드로 변경된 게시글 스타일 적용
    postDiv.classList.add('edit_mode');
}

// 삭제 버튼 클릭 시 해당 게시물 삭제
function deletePostEvent(postDiv) {
    const postContainer = document.getElementById('post_container');
    postContainer.removeChild(postDiv);
}

// 입력 창 초기화
function clearPostInput() {
    const postTextElement = document.getElementById('post_input');
    const postTimeElement = document.getElementById('time_input');

    // 해당 요소들이 존재하는지 확인
    if (postTextElement && postTimeElement) {
        postTextElement.value = '';
        postTimeElement.value = '';
    }
}
  
// 모달 창 닫기
function closeModalEvent() {
    const modal = document.getElementById('modal');
    modal.style.display = 'none';
}
  
// 모달 창 외부 클릭 시 닫기
window.onclick = function(event) {
    const modal = document.getElementById('modal');
    if (event.target === modal) {
      modal.style.display = 'none';
    }
};

initializeCalendar();

function viewProfileEvent() {
    // 내 정보 보기 버튼 누르면
    window.location.href = "../page/viewProfile.jsp";
}

function LogoutEvent() {
    // 로그아웃 버튼 누르면
    window.location.href = "../action/logout.jsp";
}