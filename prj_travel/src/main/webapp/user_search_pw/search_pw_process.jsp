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
		response.sendRedirect("search_pw.jsp");
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
	<jsp:useBean id="spVO" class="user.vo.SearchPwVO" scope="page" />
	<jsp:setProperty property="*" name="spVO"/>
	<%
		//DB에 저장될때 암호화 되어있기 때문에..
		DataEncrypt de = new DataEncrypt("a12345678901234567");
		spVO.setTel(de.encryption(spVO.getTel()));
		
		//한글 깨짐 현상때문에..
		String name = new String(spVO.getName().getBytes("8859_1"),"UTF-8");
		spVO.setName(name);
		
		UserDAO uDAO = UserDAO.getInstance();
		try{
		UserIdPwVO upVO = uDAO.selectUserFindPw(spVO);
			if( upVO != null ){
		session.setAttribute("userData", upVO);
		
		response.sendRedirect("search_pw_next.jsp");
			} else {
	%>
			아이디,이름,전화번호를 확인해주세요.<br/>
			<a href="javascript:history.back()">돌아가기</a>
		<%	
		}//end else
	
	} catch( SQLException se ){
		se.printStackTrace();
	}
	%>
</body>
</html>