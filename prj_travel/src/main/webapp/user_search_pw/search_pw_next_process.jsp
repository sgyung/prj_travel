<%@page import="user.vo.UserIdPwVO"%>
<%@page import="user.vo.UserIdVO"%>
<%@page import="user.dao.UserDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	if("GET".equals(request.getMethod().toUpperCase())){
		response.sendRedirect("search_pw_next.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.132/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap CDN-->
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN -->
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	
})//ready
</script>


</head>
<body>
	<jsp:useBean id="uipVO" class="user.vo.UserIdPwVO" scope="page" />
	<jsp:setProperty property="*" name="uipVO"/>
	<%
	uipVO.setPw(DataEncrypt.messageDigest("MD5", uipVO.getPw()));	
	UserDAO uDAO = UserDAO.getInstance();
	uDAO.updateUserFindPw(uipVO);
	response.sendRedirect("search_pw_next_confirm.jsp");
	%>
</body>
</html>