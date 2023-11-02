<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.vo.QnAVO"%>
<%@page import="user.dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String qnaId = request.getParameter("qnaId");

	JSONObject jsonObj = new JSONObject();
	
	QnADAO qDAO = QnADAO.getInstance();
	
	try{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
	QnAVO qaVO = qDAO.selectQnAContent(qnaId);
	
	jsonObj.put( "qnaId", qaVO.getQnaId());
	jsonObj.put( "areaId", qaVO.getAreaId());
	jsonObj.put( "userId", qaVO.getUserId());
	jsonObj.put( "title", qaVO.getTitle());
	jsonObj.put( "category", qaVO.getCategory());
	jsonObj.put( "content", qaVO.getContent());
	jsonObj.put( "state", qaVO.getState());
	jsonObj.put( "registrationDate", sdf.format(qaVO.getRegistrationDate()));
	jsonObj.put( "answerType", qaVO.getAnswerType());
	if( qaVO.getAnswerType().equals("Y")){
		jsonObj.put( "answer", qaVO.getAnswer());
		jsonObj.put( "answerDate", sdf.format(qaVO.getAnswerDate()));
	}//end if
	
	} catch(SQLException se ){
		se.printStackTrace();
	}//end catch
	
	out.print( jsonObj.toJSONString());
%>