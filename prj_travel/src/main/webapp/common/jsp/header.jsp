<%@page import="user.vo.UserNameVO"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<div class="header">
        <div class="header_contents flex">
            <div class="logo"><a href="../user_main/main.jsp">JEJU VISIT</a></div>
            <div class="nav_top">
                <ul>
                    <li><a href="../user_tourist_area/touristArea.jsp?tag=전체">관광지</a></li>
                    <li><a href="../user_restaurant/restaurant.jsp?tag=전체">맛집</a></li>
                    <li><a href="#">게시판</a></li>
                    <li><a href="#">투어예약</a></li>
                </ul>
            </div>
            <div class="search_login flex">
                
                <c:choose>
				<c:when test="${ empty sesId }">
				<a href="../user_login/login.jsp" style="margin-left: 30px;" >로그인</a>
				
				
				</c:when>
				<c:otherwise>
				<%
				UserNameVO unVO = (UserNameVO)session.getAttribute("userName");
				String name = unVO.getName();
				pageContext.setAttribute("name", name);
				%>
					
				<p style="margin-left: 30px;"><a href="#"><c:out value="${ name }"/> 님</a></p>
				
				<a href="logout.jsp" style="margin-left: 30px;">로그아웃</a>
				
				</c:otherwise>	
				</c:choose>
                
            </div>
        </div>
    </div>