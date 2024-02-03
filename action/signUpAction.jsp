<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>

<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>

<%-- 데이터베이스 SQL 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- Table에서 가져온 값을 처리하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>

<%-- 아이디 UNIQUE로 해놓아서 중복 확인 다시 --%>
<%-- 핸드폰번호 UNIQUE로 해놓아서 중복 확인 다시 --%>
<%
    request.setCharacterEncoding("UTF-8"); // 이전 페이지에서 온 값에 대한 인코딩 설정

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String phonenumberValue = request.getParameter("phonenumber_value");
    var regex = /^010-([0-9]{3,4})-([0-9]{4})$/;

    
    if (!idValue.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/)) {
        // 아이디의 길이가 최소 8자 이상, 최대 12자이고, 영어와 숫자를 포함하는지 확인
%>
        <script>
            alert("아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.");
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    }else if (!pwValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/)) {
        // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
%>
        <script>
            alert("비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.");
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%   
    }else if (nameValue === "" || !nameValue.match(/^[\uAC00-\uD7A3]{2,10}$/)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
%>
        <script>
            alert("이름은 최소 2자 이상, 최대 10자까지이며, 한글로 입력되어야 합니다.");
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
        
    }else if (phonenumberValue.length === 0) {
        // 전화번호 길이가 11인지 확인
%>
        <script>
            alert('전화번호를 입력해 주세요.');
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    }else if (!regex.test(phonenumberValue)) {
        // 전화번호가 숫자로만 이루어져 있는지 확인
%>
        <script>
           alert('유효하지 않은 전화번호 형식입니다.');
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    }

    try {
            // DB 연결
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

            // sql 준비 및 전송
            // 입력된 아이디 존재 여부 재확인
            String sql=

            // sql 준비 및 전송
            // 입력된 전화번호 존재 여부 재확인

            // sql 준비 및 전송
            // 회원가입 시 유저 정보를 user 테이블에 삽입
            String sql = "INSERT INTO user(id, password, name, phoneNumber) VALUES (?, ?, ?, ?)";
            PreparedStatement query = conn.prepareStatement(sql);
            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, nameValue);
            query.setString(4, phonenumberValue);
            query.executeUpdate();

%>
            <script>
                window.location.href = '../page/index.jsp'; // 회원가입 완료 후 index.jsp로 이동하도록 설정
            </script>
<%
    } catch (Exception e) {
%>
        <script>
            window.location.href = '../page/signUp.jsp'; // 오류 시에 다시 signUp.jsp로 이동하도록 설정
        </script>
<%
    } 
%>