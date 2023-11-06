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
	TouristAreaManageDAO tamDAO = TouristAreaManageDAO.getInstance();

	String areaId = request.getParameter("areaId"); 
	String reviewId = request.getParameter("reviewId"); 
	
	System.out.println("---" + areaId + " / " + reviewId);
	
	try{
		
		int cnt = 0;
		if(areaId != null && reviewId == ""){
			cnt = tamDAO.deleteReview(reviewId);
			if(cnt != 0 ){
				response.sendRedirect("admin_tourarea_review_list.jsp?areaId=" + areaId);
			}else{
%>
		<script>
			alert("리뷰 삭제를 실패하였습니다. 다시 시도해주세요.");
		</script>
<%				
				response.sendRedirect("admin_tourarea_review_list.jsp?areaId=" + areaId);
			}
		}
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>