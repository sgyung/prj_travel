<%@page import="admin.dao.TourBusManageDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.TouristAreaManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();

	String tourId = request.getParameter("tourId"); 
	
	try{
		
		int cnt = 0;
		if(tourId != null){
			cnt = tbmDAO.deleteTourBus(tourId);
			if(cnt != 0 ){
				response.sendRedirect("admin_tourbus_list.jsp");
			}else{
%>
		<script>
			alert("투어버스 삭제에 실패하였습니다. 다시 시도해주세요.");
		</script>
<%				
				response.sendRedirect("admin_tourbus_detail.jsp?areaId=" + tourId);
			}
		}
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>