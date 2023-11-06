<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.RestaurantManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	RestaurantManageDAO rmDAO = RestaurantManageDAO.getInstance();

	String restaurantId = request.getParameter("restaurantId"); 
	
	try{
		
		int cnt = 0;
		if(restaurantId != null){
			cnt = rmDAO.deleteRestaurant(restaurantId);
			if(cnt != 0 ){
				response.sendRedirect("admin_restaurant_list.jsp");
			}else{
%>
		<script>
			alert("맛집 삭제를 실패하였습니다. 다시 시도해주세요.");
		</script>
<%				
				response.sendRedirect("admin_restaurant_detail.jsp?restaurantId=" + restaurantId);
			}
		}
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>