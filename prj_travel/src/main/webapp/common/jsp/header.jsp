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
                <div class="search">
	                <a href="#">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	                      <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
	                    </svg>
	                </a>
                </div>
                
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
					
				<p style="margin-left: 30px;"><c:out value="${ name }"/>님</p>
				
				<a href="logout.jsp" style="margin-left: 30px;">로그아웃</a>
				
				</c:otherwise>	
				</c:choose>
                
            </div>
        </div>
    </div>