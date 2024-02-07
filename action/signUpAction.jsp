<%-- 회원가입을 위한 액션 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>

<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>

<%-- 데이터베이스 SQL 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- Table에서 가져온 값을 처리하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>

<%-- java에서 정규 표현식을 사용하기 위한 Pattern 클래스를 import --%>
<%@ page import="java.util.regex.Pattern" %>

<%
    // JSP 영역
    request.setCharacterEncoding("UTF-8"); // 이전 페이지에서 온 값에 대한 인코딩 설정

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String phonenumberValue = request.getParameter("phonenumber_value");

    if (idValue.isEmpty()) {
        // 아이디 입력 확인
        out.println("<script>alert('아이디를 입력해주세요.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정
    }else if (!Pattern.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$", idValue)) {
        // 아이디의 길이가 최소 8자 이상, 최대 12자이고, 영어와 숫자를 포함하는지 확인
        out.println("<script>alert('아이디는 최소 1자 이상, 최대 12자까지이며, 영어와 숫자를 포함해야 합니다.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정
    }else if (pwValue.isEmpty()) {
        // 비밀번호 입력 확인
        out.println("<script>alert('비밀번호를 입력해주세요.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정 
    }else if (!Pattern.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,16}$",pwValue)) {
        // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
        out.println("<script>alert('비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정 
    }else if (nameValue.isEmpty()) {
        // 이름 입력 확인
        out.println("<script>alert('이름을 입력해주세요.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정 
    }else if (!Pattern.matches("^[가-힣]{2,4}$", nameValue)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
        out.println("<script>alert('이름은 최소 2자 이상, 최대 12자까지 입력 가능합니다.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정      
    }else if (phonenumberValue.isEmpty()) {
        // 전화번호 입력 확인
        out.println("<script>alert('전화번호를 입력해 주세요.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정    
    }else if (!Pattern.matches("^010-([0-9]{3,4})-([0-9]{4})$",phonenumberValue)) {
        // 전화번호가 숫자로만 이루어져 있는지 확인
        out.println("<script>alert('유효하지 않은 전화번호 형식입니다.');</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정    
    }

    // 예외가 발생할 가능성이 있는 코드
    try {
        // DB 연결
        Class.forName("com.mysql.jdbc.Driver");// Connector 파일 찾아오는 명령어
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

        // sql 준비 및 전송
        // 세션으로 사용자 아이디 찾아오기
        String checkIdSql = "SELECT * FROM user WHERE id=?";
        PreparedStatement checkIdQuery = conn.prepareStatement(checkIdSql);
        checkIdQuery.setString(1, idValue);// 첫 번째 Column 읽어오기
        ResultSet idResult = checkIdQuery.executeQuery();

        // id가 존재하는 경우
        if (idResult.next()) {
            out.println("<script>alert('사용 불가능한 아이디입니다.');</script>");
            response.sendRedirect('../page/signUp.jsp'); 
        }

        String checkPhoneNumberSql = "SELECT * FROM user WHERE phoneNumber=?";
        PreparedStatement checkPhoneNumberQuery = conn.prepareStatement(checkPhoneNumberSql);
        checkPhoneNumberQuery.setString(1, phonenumberValue);
        ResultSet phoneNumberResult = checkPhoneNumberQuery.executeQuery();

        // 전화번호가 존재하는 경우
        if (phoneNumberResult.next()) {
            out.println("<script>alert('사용 불가능한 전화번호입니다.');</script>");
            response.sendRedirect('../page/signUp.jsp');  
        } 

        // 최종적으로 가입 가능 상태일 경우
        String insertUserSql = "INSERT INTO user(id, password, name, phoneNumber) VALUES (?, ?, ?, ?)";
        PreparedStatement insertUserQuery = conn.prepareStatement(insertUserSql);
        insertUserQuery.setString(1, idValue);
        insertUserQuery.setString(2, pwValue);
        insertUserQuery.setString(3, nameValue);
        insertUserQuery.setString(4, phonenumberValue);
        insertUserQuery.executeUpdate();
        response.sendRedirect('../page/index.jsp');    // 회원가입 후 index.jsp로 이동하도록 설정

    } catch (Exception e) {
        out.println("<script>alert(" + e.message + ");</script>");
        response.sendRedirect('../page/signUp.jsp');    // 실패 시에 다시 signUp.jsp로 이동하도록 설정
    }
%>