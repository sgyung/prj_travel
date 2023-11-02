<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%
	String userId = request.getParameter("userId");
	String contId = request.getParameter("contId");
	String areaType = request.getParameter("areaType");
	
	boolean resultFlag = false;
	String[] resultArr = null;
	
	if( areaType.equals("관광지")){
		TouristAreaDAO tDAO = TouristAreaDAO.getInstance();
		int resultCnt = tDAO.updateLike(userId, contId);
		if( resultCnt != 1 ){
		} else {
			resultArr = tDAO.selectUserLike(userId, contId);
			resultFlag = true;
		}//end else
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("likeCnt", resultArr[0]);
		jsonObj.put("likeState", resultArr[1]);
		jsonObj.put("resultFlag", resultFlag);
	
		out.print(jsonObj.toJSONString());
	} else {
		
	}//end else
	

%>