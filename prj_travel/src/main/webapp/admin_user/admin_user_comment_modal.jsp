<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="admin.vo.UserCommentVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.UserManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>


<%
	String commentId = request.getParameter("commentId");
	
	System.out.println(commentId);

	JSONObject json = new JSONObject();	

	UserManageDAO umDAO = UserManageDAO.getInstance();
try{

	if(commentId != null){
	UserCommentVO ucVO = umDAO.selectUserComment(commentId);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	json.put("commentId", ucVO.getCommentId());
	json.put("postId", ucVO.getPostId());
	json.put("name", ucVO.getUserName());
	json.put("userId", ucVO.getUserId());
	json.put("content", ucVO.getContent());
	json.put("date", sdf.format(ucVO.getRegistrationDate()));
	
	System.out.println(ucVO);
	}
}catch(SQLException se){
	se.printStackTrace();
}
System.out.println(json.toJSONString());
out.print(json.toJSONString());
%>