<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.vo.ReviewVO"%>
<%@page import="user.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String areaId = request.getParameter("areaId");
	String userId = request.getParameter("userId");
	String areaType = request.getParameter("areaType");
	String content = request.getParameter("content");
	String starScore = request.getParameter("starScore");
	
	boolean resultFlag = false;
	int reviewCnt = 0;
	JSONObject  jsonObj = new JSONObject();
	
	ReviewVO rVO = new ReviewVO();
	rVO.setAreaId(areaId);
	rVO.setUserId(userId);
	rVO.setContent(content);
	rVO.setStarScore(Integer.parseInt(starScore));
	
	try{
		ReviewDAO rDAO = ReviewDAO.getInstance();
		rDAO.insertReview(rVO);
		reviewCnt = rDAO.selectTotalReview(areaId);
		
		resultFlag = true;
	} catch(SQLException se ){
		se.printStackTrace();
	}//end catch
	
	jsonObj.put("resultFlag" , resultFlag);
	jsonObj.put("reviewCnt" , reviewCnt);
	
	out.print(jsonObj);
%>