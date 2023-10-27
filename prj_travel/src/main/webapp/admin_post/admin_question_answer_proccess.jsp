<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.QAndAManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="qaVO" class="admin.vo.QandAVO" scope="page"/>
<jsp:setProperty property="*" name="qaVO"/>
<c:catch var="se">
<%
	String questionId = request.getParameter("questionId");

	QAndAManageDAO qamDAO = QAndAManageDAO.getInstance();
	try{
	qaVO.setQAndAId(questionId);
	
	
	int cnt = qamDAO.updateAnswer(qaVO);
	
	if( cnt != 0){
	
	response.sendRedirect("admin_question_answer_detail.jsp?questionId=" + questionId);
	
	}
	}catch(SQLException se){
		se.printStackTrace();
	}
	
%>
</c:catch>