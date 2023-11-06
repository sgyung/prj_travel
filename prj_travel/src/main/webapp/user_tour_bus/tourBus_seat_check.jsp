<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.dao.TourBusDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="user.vo.TourReserveVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contId = request.getParameter("contId");
	String date = request.getParameter("date");
	String time = request.getParameter("time");
	String adult = request.getParameter("adult");
	String child = request.getParameter("child");
	String userId = request.getParameter("userId");
	String userName = request.getParameter("userName");
	
	int seatCnt = 0;
	JSONObject jsonObj = new JSONObject();
	
	TourBusDAO tbDAO = TourBusDAO.getInstance();
	
	//date sql타입으로 변환
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date parseDate = sdf.parse(date);
	Date sqlDate = new Date(parseDate.getTime());
	
	TourReserveVO trVO = new TourReserveVO();
	trVO.setTourId(contId);
	trVO.setReserveDate(sqlDate);
	trVO.setTime(time);
	trVO.setName(userName);
	trVO.setUserId(userId);
	trVO.setAdult(Integer.parseInt(adult));
	trVO.setChild(Integer.parseInt(child));
	
	seatCnt = tbDAO.selectReservedSeat(trVO);
	jsonObj.put("seatCnt", seatCnt);
	
	out.print(jsonObj.toJSONString());
	
%>