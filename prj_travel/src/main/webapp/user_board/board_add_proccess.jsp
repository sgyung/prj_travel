<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.UserBoardVO"%>
<%@page import="user.dao.UserBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%
String id = (String)session.getAttribute("sesId");

UserBoardDAO ubDAO = UserBoardDAO.getInstance();

String title = request.getParameter("title");
String category = request.getParameter("category");
String content = request.getParameter("content");
String type = request.getParameter("type");

try{
	int resultCnt = 0;
	
	UserBoardVO ubVO = new UserBoardVO();
	
	ubVO.setUserId(id);
	ubVO.setBoardTitle(title);
	ubVO.setBoardContent(content);
	ubVO.setBoardCategory(category);
	
	resultCnt = ubDAO.insertBoard(ubVO);
	System.out.println(resultCnt);
	if(resultCnt != 0){
		if("res".equals(type)){
%>
	
	<script>
	alert("글이 성공적으로 작성되었습니다.");
	location.href = "board_restaurant_list.jsp";
	</script>
<%	
		}else if("tour".equals(type)){
%>
	<script>
	alert("글이 성공적으로 작성되었습니다.");
	location.href = "board_tourist_list.jsp";
	</script>
<% 			
		}
	}else{
%>
	<script>
	alert("오류가 발생하였습니다. 다시 작성해주세요.");
	location.href = "board_add.jsp";
	</script>
<%		
	}
}catch(SQLException se){
	se.printStackTrace();
%>
	<script>
	alert("오류가 발생하였습니다. 다시 작성해주세요.");
	location.href = "board_add.jsp";
	</script>
<%	
}
%>