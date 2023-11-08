<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.dao.UserBoardDAO"%>
<%@page import="admin.vo.UserCommentVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
String userId = (String)session.getAttribute("sesId");
String postId = request.getParameter("postId");
String content = request.getParameter("content");

UserBoardDAO ubDAO = UserBoardDAO.getInstance();

JSONObject json = new JSONObject();

UserCommentVO ucVO = new UserCommentVO();
try{

ucVO.setUserId(userId);
ucVO.setPostId(postId);
ucVO.setContent(content);
	
int result = ubDAO.insertComment(ucVO);

	if(result != 0){
		json.put("result", result);
	}
}catch(SQLException se){
	se.printStackTrace();
}

out.print(json.toJSONString());
%>