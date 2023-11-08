<%@page import="user.vo.UserVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
	<%
	String inputPw = request.getParameter("pw");

	DataEncrypt de = new DataEncrypt("a12345678901234567");

	String pw = DataEncrypt.messageDigest("MD5", inputPw);
	
	String userId=(String)session.getAttribute("sesId");

	UserDAO uDAO = UserDAO.getInstance();
	try {
		UserVO uVO = uDAO.selectUserInfo(userId);
		if( pw.equals(uVO.getPw()) ){
			session.setAttribute("user", uVO);
			
			response.sendRedirect("info_modify.jsp");
		} else {
	%>
		비밀번호를 확인해주세요.<br/>
		<a href="javascript:history.back()">돌아가기</a>
	<%	
		}//end else

	} catch (SQLException se) {
	se.printStackTrace();
	}
	%>
</body>
</html>