<%@page import="admin.vo.TourBusReservationVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%

String reservationId = request.getParameter("reservationId");

TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();

	JSONObject json = new JSONObject();
	
try{
	
	int resultCnt = tbmDAO.updateReservationState(reservationId);
	
	TourBusReservationVO tbrVO =tbmDAO.selectReservation(reservationId);
	
	json.put("reservationState", tbrVO.getReservationState());
	json.put("reservationId", tbrVO.getReservationId());

	if(resultCnt != 0){
		json.put("complete", 1);
	}
	
	
}catch(SQLException se){
	se.printStackTrace();
}

out.print(json.toJSONString());
%>