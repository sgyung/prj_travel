<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.TourBusReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();

String tourbusId = request.getParameter("tourbusId");
String reservationTime = request.getParameter("reservationTime");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf.parse(request.getParameter("reservationDate"));

java.sql.Date reservationDate = new java.sql.Date(date.getTime());

JSONArray jsonArr = new JSONArray();


JSONObject jsonObj = new JSONObject();

try{
	List<TourBusReservationVO> list = tbmDAO.selectTourBusReservation(tourbusId, reservationDate, reservationTime);
	
	JSONObject json = null;
	
	for(int i = 0; i < list.size(); i++){
		json = new JSONObject();
		
		json.put("reservationId",list.get(i).getReservationId());
		json.put("userId",list.get(i).getUserId());
		json.put("adult",list.get(i).getAdult());
		json.put("child",list.get(i).getChild());
		json.put("reservationDate",sdf.format(list.get(i).getReservationDate()));
		json.put("reservationState",list.get(i).getReservationState());
		json.put("reservationTime",list.get(i).getReservationTime());
		
		jsonArr.add(json);
	}
	
	
	
	jsonObj.put("jsonArr", jsonArr);
	
}catch(SQLException se){
	se.printStackTrace();
}

out.print(jsonObj.toJSONString());

%>