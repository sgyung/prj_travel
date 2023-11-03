<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String contId = request.getParameter("contId");
	String userId = request.getParameter("userId");
	
	TouristAreaDAO tDAO = TouristAreaDAO.getInstance();
	
	boolean resultFlag = tDAO.selectIsReview(contId, userId);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("resultFlag", resultFlag);
	
	out.print(jsonObj.toJSONString());
	
%>