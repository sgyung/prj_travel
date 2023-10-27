<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.QAndAManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	QAndAManageDAO qamDAO = QAndAManageDAO.getInstance();
	try{
		String questionId = request.getParameter("deleteId");
		System.out.println(questionId);
		int cnt = qamDAO.deleteQandA(questionId);
			if(cnt != 0){
				response.sendRedirect("admin_question_list.jsp");
			}
	}catch(SQLException se){
		se.printStackTrace();
	}
%>