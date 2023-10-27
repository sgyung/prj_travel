<%@page import="javax.swing.undo.CannotUndoException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@page import="admin.vo.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
	NoticeManageDAO nmDAO = NoticeManageDAO.getInstance();
	try{
		String noticeId = request.getParameter("deleteId");
		int cnt = nmDAO.deleteNotice(noticeId);
			if(cnt != 0){
				response.sendRedirect("admin_post_list.jsp");
			}
	}catch(SQLException se){
		se.printStackTrace();
	}
%>