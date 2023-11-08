<%@page import="user.dao.UserDAO"%>
<%@page import="java.sql.SQLException"%>
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
	<jsp:useBean id="uVO" class="user.vo.UserVO" scope="page" />
	<jsp:setProperty property="*" name="uVO"/>
	<%
	String userId=(String)session.getAttribute("sesId");
	
	//한글깨짐현상
	String name = new String(uVO.getName().getBytes("8859_1"),"UTF-8");
	uVO.setName(name);
	String addr = new String(uVO.getAddr().getBytes("8859_1"),"UTF-8");
	uVO.setAddr(addr);
	DataEncrypt de = new DataEncrypt("a12345678901234567");
	uVO.setTel(de.encryption(uVO.getTel())); 
	
	System.out.println( uVO );
	UserDAO uDAO = UserDAO.getInstance();
	
	uDAO.updateUserInfo(uVO);
	
	response.sendRedirect("info_modify_update.jsp");
	%>
</body>
</html>