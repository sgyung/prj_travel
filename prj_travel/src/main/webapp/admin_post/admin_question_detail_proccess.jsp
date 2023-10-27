<%@page import="admin.vo.QandAVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.QAndAManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<%
	String questionId = request.getParameter("questionId");

	QAndAManageDAO qamDAO = QAndAManageDAO.getInstance();

	try{
	QandAVO qaVO =  qamDAO.selectQnA(questionId);
	
	boolean answerType = false;
	
	if("y".equals(qaVO.getAnswerType())){
		answerType = true;
	}
		if(answerType){
			response.sendRedirect("admin_question_answer_detail.jsp?questionId=" + questionId);
		}else{
			response.sendRedirect("admin_question_answer.jsp?questionId=" + questionId);
		}
	}catch(SQLException se){
		se.printStackTrace();
	}

	
%>
