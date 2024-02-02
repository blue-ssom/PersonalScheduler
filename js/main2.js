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
        });

        monthContainer.appendChild(monthButton);

        // 초기값으로 현재 월에 해당하는 버튼에 선택 효과 추가
        if (i + 1 === currentMonth) {
            monthButton.classList.add('selected');
        }
    }
}

function updateCalendar() {
    // dateContainer 요소를 찾기 전에 존재 여부 확인
    const dateContainer = document.getElementById('dateContainer');
        if (!dateContainer) {
            console.error("dateContainer not found");
            return;
        }
    dateContainer.innerHTML = ''; // 날짜 컨테이너 초기화

    // 주의 날짜를 추가합니다
    const dayOfWeekContainer = document.createElement('div');
    dayOfWeekContainer.className = 'day_of_week_container';
    daysOfWeek.forEach(day => {
        const dayOfWeek = document.createElement('div');
        dayOfWeek.className = 'day_of_week';
        dayOfWeek.textContent = day;
        dayOfWeekContainer.appendChild(dayOfWeek);
    });
    dateContainer.appendChild(dayOfWeekContainer);

    // 빈 칸 추가 (첫째 날 이전의 요일 수만큼)
    for (let i = 0; i < startingDayOfWeek; i++) {
        const emptyCell = document.createElement('div');
        emptyCell.className = 'empty_cell';
        dateContainer.appendChild(emptyCell);
    }

    // 월의 날짜를 추가합니다
    const daysInMonth = getDaysInMonth(selectedMonth, selectedYear);
    for (let day = 1; day <= daysInMonth; day++) {
        const dayCell = document.createElement('div');
        dayCell.className = 'day_cell';
        dayCell.textContent = day;

        // 오늘의 날짜인 경우 강조 표시
        if (
            selectedYear === currentYear &&
            selectedMonth === currentMonth &&
            day === currentDateOfMonth
        ) {
            dayCell.classList.add('today');
        }

        dateContainer.appendChild(dayCell);
    }
}

// 새로운 함수: 선택된 월과 연도에 따라 해당 월의 일 수를 반환
function getDaysInMonth(month, year) {
    if (month === 1 || month === 3 || month === 5 || month === 7 || month === 8 || month === 10 || month === 12) {
        return 31;
    } else if (month === 2) {
        // 윤년인지 체크하여 29 또는 28 반환
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
}

function showNextYearEvent() {
    // 현재 연도를 가져와서 1을 더하고 표시
    selectedYear += 1;
    document.getElementById('showYear').innerText = selectedYear;
    console.log("selectedYear",selectedYear);
}

document.addEventListener('DOMContentLoaded', function() {
    initializeCalendar();
    updateCalendar();
});
