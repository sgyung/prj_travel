<%@page import="admin.dao.RestaurantManageDAO"%>
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
	RestaurantManageDAO rmDAO = RestaurantManageDAO.getInstance();

	String restaurantId = request.getParameter("restaurantId"); 
	String reviewId = request.getParameter("reviewId"); 
	
	
	try{
		
		int cnt = 0;
		if(restaurantId != null && reviewId == ""){
			cnt = rmDAO.deleteReview(reviewId);
			if(cnt != 0 ){
				response.sendRedirect("admin_restaurant_review_list.jsp?areaId=" + restaurantId);
			}else{
%>
		<script>
			alert("리뷰 삭제를 실패하였습니다. 다시 시도해주세요.");
		</script>
<%				
				response.sendRedirect("admin_restaurant_review_list.jsp?areaId=" + restaurantId);
			}
		}
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>