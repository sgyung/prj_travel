<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%
	String sesId = (String) session.getAttribute("sesId");
	
	boolean resultFlag = false;
	if(sesId != null ){
		resultFlag = true;
	}//end if
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("resultFlag", resultFlag);
	
	out.print(jsonObj.toJSONString());
%>

