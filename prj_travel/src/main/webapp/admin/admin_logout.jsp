<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	session.removeAttribute("admin");
	session.invalidate();
	response.sendRedirect("http://jtour.sist.co.kr/admin_dashboard/dashboard.jsp");
%>