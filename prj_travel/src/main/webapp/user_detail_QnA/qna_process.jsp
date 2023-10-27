<%@page import="user.dao.QnADAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.133/jsp_prj/common/main/favicon.png">
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
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<jsp:useBean id="qVO" class="user.vo.QuestionVO" scope="page" />
	<jsp:setProperty property="*" name="qVO"/>
	<c:catch var="e">
	<%
		QnADAO qDAO = QnADAO.getInstance();
		try{
		qDAO.insertQnA(qVO);
		response.sendRedirect("touristArea_detail.jsp?contentInfo=" + qVO.getAreaId());
		
		} catch( SQLException se ){
			se.printStackTrace();
		}
	%>
	</c:catch>
	<c:if test="${ not empty e }" >
		문의사항 등록 실패
		<a href="javascript:history.back();">뒤로</a>
	</c:if>
	
	
</body>
</html>