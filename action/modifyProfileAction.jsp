<%-- 내 정보를 수정하기 위한 액션 --%>

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
    request.setCharacterEncoding("UTF-8");// 이전 페이지에서 온 값에 대한 인코딩 설정

    HttpSession userSession = request.getSession(false);
    String idValue = (String) userSession.getAttribute("id");

    if (idValue == null) {
        // 세션이 없으면 로그인 페이지로 리디렉션
        response.sendRedirect("../page/index.jsp");
    }
%>
    <script>
        console.log("idValue: <%= idValue %>");
    </script>
<%

    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String phonenumberValue = request.getParameter("phone_number_value");

   if (pwValue.isEmpty()) {
        // 비밀번호 입력 확인
        out.println("<script>alert('아이디를 입력해주세요.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }else if (!Pattern.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,16}$",pwValue)) {
        // 비밀번호의 길이가 최소 8자 이상, 최대 16자이고, 영어와 숫자와 특수문자를 포함하는지 확인
        out.println("<script>alert('비밀번호는 최소 1자 이상, 최대 16자까지이며, 영어와 숫자, 특수문자를 포함해야 합니다.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }else if (nameValue.isEmpty()) {
        // 이름 입력 확인
        out.println("<script>alert('이름을 입력해주세요.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정
    }else if (!Pattern.matches("^[가-힣]{2,4}$", nameValue)) {
        // 이름의 길이가 최소 2자 이상, 최대 10자인지 확인
        out.println("<script>alert('이름은 최소 2자 이상, 최대 12자까지 입력 가능합니다.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }else if (phonenumberValue.isEmpty()) {
        // 전화번호 입력 확인
        out.println("<script>alert('전화번호를 입력해 주세요.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }else if (!Pattern.matches("^010-([0-9]{3,4})-([0-9]{4})$",phonenumberValue)) {
        // 전화번호가 숫자로만 이루어져 있는지 확인
        out.println("<script>alert('유효하지 않은 전화번호 형식입니다.');</script>");
        response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }

    try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "stageus", "1234");

            // 기존 전화번호 가져오기
            String getOldPhoneNumberSql = "SELECT phoneNumber FROM user WHERE id=?";
            PreparedStatement getOldPhoneNumberQuery = conn.prepareStatement(getOldPhoneNumberSql);
            getOldPhoneNumberQuery.setString(1, idValue);
            ResultSet oldPhoneNumberResult = getOldPhoneNumberQuery.executeQuery();

            String oldPhoneNumber = "";
            if (oldPhoneNumberResult.next()) {
                oldPhoneNumber = oldPhoneNumberResult.getString("phoneNumber");
            }

            // 전화번호가 변경된 경우에만 중복 확인 수행
            if (!phonenumberValue.equals(oldPhoneNumber)) {
                // 전화번호 중복 확인
                String checkPhoneNumberSql = "SELECT * FROM user WHERE phoneNumber=?";
                PreparedStatement checkPhoneNumberQuery = conn.prepareStatement(checkPhoneNumberSql);
                checkPhoneNumberQuery.setString(1, phonenumberValue);
                ResultSet phoneNumberResult = checkPhoneNumberQuery.executeQuery();

                // 전화번호가 이미 사용 중인 경우
                if (phoneNumberResult.next()) {
                    
                    out.println("<script>alert('사용 불가능한 전화번호입니다.');</script>");
                    response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
                }
                
                // 전화번호가 변경되었고, 중복이 아닌 경우에만 수정
                String updateUserSql = "UPDATE user SET password=?, name=?, phoneNumber=? WHERE id=?";
                PreparedStatement updateUserQuery = conn.prepareStatement(updateUserSql);

                updateUserQuery.setString(1, pwValue);
                updateUserQuery.setString(2, nameValue);
                updateUserQuery.setString(3, phonenumberValue);
                updateUserQuery.setString(4, idValue);
                updateUserQuery.executeUpdate();
                response.sendRedirect('../page/viewProfile.jsp'); // 정보 수정 후 viewProfile.jsp로 이동하도록 설정
                }
        
            // 전화번호가 변경되지 않은 경우에 나머지 정보들만 수정
            String updateUserSql = "UPDATE user SET password=?, name=? WHERE id=?";
            PreparedStatement updateUserQuery = conn.prepareStatement(updateUserSql);
            updateUserQuery.setString(1, pwValue);
            updateUserQuery.setString(2, nameValue);
            updateUserQuery.setString(3, idValue);
            updateUserQuery.executeUpdate();
            response.sendRedirect('../page/viewProfile.jsp'); // 정보 수정 후 viewProfile.jsp로 이동하도록 설정
        
    } catch (Exception e) {
            out.println("<script>alert('" + e.getMessage() + "');</script>");
            response.sendRedirect('../page/modifyProfile.jsp');    // 실패 시에 다시 modifyProfile.jsp로 이동하도록 설정 
    }
%>