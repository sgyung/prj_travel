<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
//GET방식의 요청이라면 memberjoin_frm.jsp로 이동
String method = request.getMethod();
if("GET".equals(method)){
	response.sendRedirect("memberjoin_frm.jsp");
	return;
}
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://localhost/jsp_prj/common/main/favicon.png">
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
<jsp:useBean id="nVO" class="admin.vo.NoticeVO" scope="page"/>
<jsp:setProperty property="*" name="nVO"/>
<c:catch var="se">
<%

NoticeManageDAO nmDAO = NoticeManageDAO.getInstance();
try{
	String noticeId = request.getParameter("postId");
	int updateCnt = 0;
	if("".equals(noticeId)){
	nmDAO.insertNotice(nVO);
	response.sendRedirect("admin_post_list.jsp");
	}else{
	nVO.setId(noticeId);
	updateCnt = nmDAO.updateNotice(nVO);
	System.out.println(updateCnt);
		if(updateCnt != 0){
			response.sendRedirect("admin_post_detail.jsp?noticeId=" + noticeId);
		}
	}
}catch(SQLException se){
	se.printStackTrace();
}
%>

</c:catch>


</body>
</html>