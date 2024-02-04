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
            openModal(i); // 해당 날짜를 전달하여 모달 열기
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

// 일자 클릭 시 모달 창 띄우기
function openModal(day) {
    const modal = document.getElementById('modal_container');
    const modalContent = document.getElementById('modalContent');
    modal.style.display = 'block';
    modalContent.textContent = `선택한 일자: ${day}일`;
  }
  
  // 모달 창 닫기
  function closeModalEvent() {
    const modal = document.getElementById('modal_container');
    modal.style.display = 'none';
  }
  
  // 모달 창 외부 클릭 시 닫기
  window.onclick = function(event) {
    const modal = document.getElementById('modal_container');
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  };

initializeCalendar();
