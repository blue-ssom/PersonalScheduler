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

// JavaScript로 select 태그에 시간 옵션 추가
const timeSelect = document.getElementById('time_select');

for (let hour = 0; hour < 24; hour++) {
    for (let minute = 0; minute < 60; minute += 15) {
        const time = `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`;
        const option = document.createElement('option');
        option.value = time;
        option.textContent = time;
        timeSelect.appendChild(option);
    }
}

// 일자 클릭 시 모달 창 띄우기
function openModal(year,month,day) {
    const modal = document.getElementById('modal');
    const modalContent = document.getElementById('modalDate');
    modal.style.display = 'block';
    modalContent.textContent = `${year}.${month}.${day}`;
    clearPostInput(); // 모달이 열릴 때 입력 창 초기화
  }

function savePostEvent() {
    const postContainer = document.getElementById('post_container');
    const postTextElement = document.getElementById('post_value');
    const postSelectElement = document.getElementById('time_select'); // 수정된 부분

    const postText = postTextElement.value;
    const postTime = postSelectElement.options[postSelectElement.selectedIndex].value;
    console.log('Saved Post Content:', postText);
    console.log('Saved Post Time:', postTime);

    const postDiv = document.createElement('div');
    postDiv.classList.add('post_container');

    const postContent = document.createElement('p');
    postContent.id = 'post_value';
    postContent.textContent = postText;

    const postTimeContent = document.createElement('p');
    postTimeContent.id = 'time_select';
    postTimeContent.textContent = postTime;

    const editButton = document.createElement('button');
        editButton.type = 'button';
        editButton.textContent = '수정';
        editButton.addEventListener('click', function () {
        editPostEvent(postDiv);
    });

    const deleteButton = document.createElement('button'); // 삭제 버튼 생성
    deleteButton.type = 'button';
    deleteButton.textContent = '삭제';
    deleteButton.addEventListener('click', function () {
        deletePostEvent(postDiv);
    });
    
    postDiv.appendChild(postTimeContent);
    postDiv.appendChild(postContent);
    postDiv.appendChild(editButton);
    postDiv.appendChild(deleteButton); 

    postContainer.appendChild(postDiv);

    // 입력 칸 초기화
    postTextElement.value = '';
    postSelectElement.selectedIndex = 0; // select 태그 초기화
}

// 삭제 버튼 클릭 시 해당 게시물 삭제
function deletePostEvent(postDiv) {
    const postContainer = document.getElementById('post_container');
    postContainer.removeChild(postDiv);
}

// 입력 창 초기화
function clearPostInput() {
    const postTextElement = document.getElementById('post_value');
    const postTimeElement = document.getElementById('time_select');

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