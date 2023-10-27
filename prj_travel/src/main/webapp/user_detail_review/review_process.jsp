<%@page import="user.dao.ReviewDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
		request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="rVO" class="user.vo.ReviewVO" scope="page" />
	<jsp:setProperty property="*" name="rVO"/>
	<c:catch var ="e">
<%
	ReviewDAO rDAO = ReviewDAO.getInstance();
	try{
		rDAO.insertReview(rVO);
		response.sendRedirect("touristArea_detail.jsp?contentInfo=" + rVO.getAreaId());
	} catch(SQLException se ){
		se.printStackTrace();
	}
%>
	</c:catch>
	<c:if test="${ not empty e }" >
		리뷰 등록 실패
		<a href="javascript:history.back();">뒤로</a>
	</c:if>