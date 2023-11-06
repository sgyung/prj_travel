<%@page import="java.sql.SQLException"%>
<%@page import="user_mypageDAO.MyReviewDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String reviewId = request.getParameter("reviewId");

	JSONObject jsonObj = new JSONObject();
	boolean resultFlag = false;
	int deleteFlag = 0;
	
	
	MyReviewDAO mrDAO = MyReviewDAO.getInstance();
	
	deleteFlag = mrDAO.deleteReview(reviewId);
	
	if( deleteFlag == 1 ){
		resultFlag = true;
	}//end if
	
	jsonObj.put("resultFlag", resultFlag);
	
	out.print(jsonObj.toJSONString());
	
%>