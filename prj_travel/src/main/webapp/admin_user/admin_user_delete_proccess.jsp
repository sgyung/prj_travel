<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.UserManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	String id = request.getParameter("id");

	UserManageDAO umDAO = UserManageDAO.getInstance();
	
	try{
		int cnt = 0;
		
		if(id != null){
			
		cnt = umDAO.deleteUser(id);
			if(cnt != 0){
				response.sendRedirect("admin_user.jsp");
			}
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
%>