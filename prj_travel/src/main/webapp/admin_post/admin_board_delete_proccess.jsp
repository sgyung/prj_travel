<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	PostManageDAO pmDAO = PostManageDAO.getInstance();

	String postId = request.getParameter("postId"); 
	String commentId = request.getParameter("commentId"); 
	
	System.out.println("---" + postId + " / " + commentId);
	
	try{
		
		int cnt = 0;
		if(postId != null && commentId == ""){
			cnt = pmDAO.deletePost(postId);
			if(cnt != 0 ){
				response.sendRedirect("admin_board_list.jsp");
			}	
		}else if(commentId != null && postId != null){
			cnt = pmDAO.deleteComment(commentId);
			System.out.println(cnt);
			if(cnt != 0){
				response.sendRedirect("admin_board_detail.jsp?postId=" + postId);
			}
		}
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>
