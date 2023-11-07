<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="user_mypageDAO.MyTourBusDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String reserveId = request.getParameter("reserveId");
	MyTourBusDAO mtbDAO = MyTourBusDAO.getInstance();
	
	boolean resultFlag = false;
	JSONObject jsonObj = new JSONObject();
	try{
	int result = mtbDAO.deleteReserved(reserveId);
	
	if( result == 1 ){
		resultFlag = true;
	}//end if
	} catch( SQLException se ){
		se.printStackTrace();
	}
	
	jsonObj.put("resultFlag", resultFlag);
	
	out.print(jsonObj.toJSONString());
	
%>