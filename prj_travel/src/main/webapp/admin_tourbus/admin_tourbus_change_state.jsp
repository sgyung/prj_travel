<%@page import="org.json.simple.JSONObject"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String tourId = request.getParameter("tourId");

	TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();
	
	JSONObject jsonObj = new JSONObject();
	boolean resultFlag = false;
	int result = tbmDAO.updateTourBusState(tourId);
	
	if( result == 1 ){
		resultFlag = true;
	}//end if
	
	jsonObj.put("resultFlag", resultFlag);
	
	out.print(jsonObj.toJSONString());
	
%>