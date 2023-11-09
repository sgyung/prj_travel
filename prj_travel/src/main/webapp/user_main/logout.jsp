<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="로그아웃" %>
<%
	session.removeAttribute("sesId");
	session.removeAttribute("userData");
	session.invalidate();
	response.sendRedirect("http://jtour.sist.co.kr/user_main/main.jsp");
%>  
