<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.dao.TourBusDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="user.vo.TourReserveVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contId = request.getParameter("contId");
	String date = request.getParameter("date");
	String time = request.getParameter("time");
	String adult = request.getParameter("adult");
	String child = request.getParameter("child");
	String userId = request.getParameter("userId");
	String userName = request.getParameter("userName");
	
	//date sql타입으로 변환
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date parseDate = sdf.parse(date);
	Date sqlDate = new Date(parseDate.getTime());
	
	JSONObject jsonObj = new JSONObject();
	boolean resultFlag = false;
	
	TourReserveVO trVO = new TourReserveVO();
	trVO.setTourId(contId);
	trVO.setReserveDate(sqlDate);
	trVO.setTime(time);
	trVO.setName(userName);
	trVO.setUserId(userId);
	trVO.setAdult(Integer.parseInt(adult));
	trVO.setChild(Integer.parseInt(child));
	
	TourBusDAO tbDAO = TourBusDAO.getInstance();
	try{
		tbDAO.insertTourReserve(trVO);
		resultFlag = true;
	} catch(SQLException se ){
		se.printStackTrace();
	}
	jsonObj.put("resultFlag" , resultFlag);
	out.print(jsonObj);
%>
