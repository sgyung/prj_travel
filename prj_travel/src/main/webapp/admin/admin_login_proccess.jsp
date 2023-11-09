<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.AdminDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<body>

<%
String pass = request.getParameter("pass");
String id = request.getParameter("id");

// 암호화
pass = DataEncrypt.messageDigest("MD5", pass);

AdminDAO adminDAO = AdminDAO.getInstance();
try{
boolean loginFlag = adminDAO.selectAdmin(id, pass);

if(loginFlag){
	session.setAttribute("admin", id);
	
	response.sendRedirect("http://jtour.sist.co.kr/admin_dashboard/dashboard.jsp");
%>

<%	
}else{
%>
		 <script>
            alert("아이디나 비밀번호를 확인해주세요.");
            window.location.href='admin_login.jsp';
        </script>

<%	
}

}catch(SQLException se){
	se.printStackTrace();
}
%>