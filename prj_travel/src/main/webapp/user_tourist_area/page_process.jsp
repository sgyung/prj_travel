<%@page import="org.json.simple.JSONObject"%>
<%@page import="pageUtil.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int qnaPage = (int)Integer.parseInt(request.getParameter("currentPage"));
	int totalPage = (int)Integer.parseInt(request.getParameter("totalPage"));
	int pagePerNum = (int)Integer.parseInt(request.getParameter("pagePerNum"));
	String actionType = request.getParameter("actionType");
	
	int currentPage = qnaPage + 1;
	if( actionType.equals("prev")){
		if( (qnaPage - 1) < 1){
			currentPage = 1;
		} else {
			currentPage = qnaPage - 1;
		}
	}//end if
	boolean nextFlag = false;
	
	JSONObject jsonObj = new JSONObject();
	
	Paging paging = Paging.getInstance();
	
	int[] pageRange = paging.getTotalPageCnt( currentPage, totalPage, pagePerNum );
	if( pageRange[0] <= qnaPage && qnaPage <= pageRange[1]){
		nextFlag = true;
	}
	jsonObj.put( "nextFlag", nextFlag);
	jsonObj.put( "startPage", pageRange[0]);
	jsonObj.put( "endPage", pageRange[1]);
	
	out.print(jsonObj.toJSONString());
	
%>