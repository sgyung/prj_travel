<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.QuestionVO"%>
<%@page import="user.vo.QnAVO"%>
<%@page import="user.dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String userId = request.getParameter("userId");
	String areaId = request.getParameter("areaId");
	String areaType = request.getParameter("areaType");
	String content = request.getParameter("content");
	String title = request.getParameter("title");
	
	JSONObject jsonObj = new JSONObject();
	boolean resultFlag = false;
	
	QuestionVO qVO = new QuestionVO();
	qVO.setUserId(userId);
	qVO.setAreaId(areaId);
	qVO.setContent(content);
	qVO.setTitle(title);
	qVO.setType(areaType);
	
	QnADAO qDAO = QnADAO.getInstance();
	
	try{
	qDAO.insertQnA(qVO);
	int qnaCnt = qDAO.selectTotalQnA();
	
	resultFlag = true;
	jsonObj.put("resultFlag", resultFlag);
	jsonObj.put("qnaCnt", qnaCnt);
	
	
	} catch( SQLException se) {
		se.printStackTrace();
	}//end catch
	
	out.print(jsonObj.toJSONString());
%>