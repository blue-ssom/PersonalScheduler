let selectedYear, selectedMonth, selectedDate;

function initializeCalendar() {
    // 현재 년/월/일을 가져와서 표시
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1 해줌
    const currentDateOfMonth = currentDate.getDate();

    // 디버깅
    console.log("currentYear",currentYear);
    console.log("currentMonth",currentMonth);
    console.log("currentDateOfMonth",currentDateOfMonth);

    // 올해 년도 HTML에 출력
    document.getElementById('showYear').innerText = currentYear;

    // 월 버튼 생성 및 이벤트 처리 함수
    const monthContainer = document.getElementById('monthContainer');
    monthContainer.innerHTML = ''; // 기존에 생성된 버튼 제거

    const monthList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

    for (let i = 0; i < monthList.length; i++) {
        const monthButton = document.createElement('button');
        monthButton.type = 'button';
        monthButton.textContent = monthList[i];
        monthButton.addEventListener('click', createButtonClickHandler(monthButton, i + 1, monthList));

        monthContainer.appendChild(monthButton);

        // 초기값으로 현재 월에 해당하는 버튼에 선택 효과 추가
        if (i + 1 === currentMonth) {
            monthButton.classList.add('selected');
        }
    }

    // 일 버튼 생성 및 이벤트 처리 함수
    const dateContainer = document.getElementById('dateContainer');
    dateContainer.innerHTML = ''; // 기존에 생성된 날짜 제거

    const daysInMonth = new Date(currentYear, currentMonth, 0).getDate();
    const firstDayOfMonth = new Date(currentYear, currentMonth - 1, 1).getDay(); // 해당 월의 첫 날의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

    // 해당 월의 첫 날이 무조건 일요일이므로 그 날짜부터 시작
    for (let currentDay = 1; currentDay <= daysInMonth; currentDay++) {
        const dateButton = document.createElement('button');
        dateButton.type = 'button';
        dateButton.textContent = currentDay;

        // 클릭 이벤트 핸들러 추가
        dateButton.addEventListener('click', createDateButtonClickHandler(dateButton, currentDay));

        // 일요일인 경우 글자색을 빨간색으로 변경
        if ((currentDay + firstDayOfMonth - 1) % 7 === 1) {
            dateButton.classList.add('sunday');
        }

        dateContainer.appendChild(dateButton);

        // 초기값으로 선택된 일자가 있으면 해당 버튼에 선택 효과 추가
        if (currentDateOfMonth && currentDay === currentDateOfMonth) {
            dateButton.classList.add('selected');
        }

        // 한 주에 7일이 되면 줄바꿈 추가
        if ((currentDay + firstDayOfMonth - 1) % 7 === 0) {
            dateContainer.appendChild(document.createElement('br'));
        }
    }
    
}

function createButtonClickHandler(button, selectedMonth, monthsList) {
    return function () {
        // 모든 월 버튼의 선택 효과 제거
        const allMonthButtons = document.querySelectorAll('#monthContainer button');
        allMonthButtons.forEach(btn => btn.classList.remove('selected'));

        // 선택된 월에 선택 효과 추가
        button.classList.add('selected');
        console.log("selectedMonth:", selectedMonth);
    };
}

function createDateButtonClickHandler(button, day) {
    return function () {
        // 모든 날짜 버튼의 선택 효과 제거
        const allDateButtons = document.querySelectorAll('#dateContainer button');
        allDateButtons.forEach(btn => btn.classList.remove('selected'));

        // 선택된 날짜에 선택 효과 추가
        button.classList.add('selected');
        console.log("Selected Date:", day);
    };
}

function showPreviousYearEvent() {
    // 현재 연도를 가져와서 1을 빼고 표시
    const currentYear = parseInt(document.getElementById('showYear').innerText);
    const previousYear = currentYear - 1;
    document.getElementById('showYear').innerText = previousYear;
}

function showNextYearEvent() {
    // 현재 연도를 가져와서 1을 더하고 표시
    const currentYear = parseInt(document.getElementById('showYear').innerText);
    const nextYear = currentYear + 1;
    document.getElementById('showYear').innerText = nextYear;
}

// 초기화 함수 호출
initializeCalendar();