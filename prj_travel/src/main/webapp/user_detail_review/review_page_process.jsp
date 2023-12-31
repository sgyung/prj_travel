<%@page import="java.util.ArrayList"%>
<%@page import="user_mypageDAO.MyReviewDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="user.vo.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="user.dao.ReviewDAO"%>
<%@page import="pageUtil.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String selectPage = request.getParameter("selectPage");
	String pageScale = request.getParameter("pageScale");
	String contId = request.getParameter("contId");
	String userId = request.getParameter("userId");
	String areaType = request.getParameter("areaType");
	
	Paging paging = Paging.getInstance();
	int[] pageRange = paging.getPageRowRange(Integer.parseInt(selectPage), Integer.parseInt(pageScale));
	
	JSONObject jsonObj = null;
	JSONArray jsonArr = new JSONArray();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
	try {
		
		if( areaType != null ){
			MyReviewDAO mrDAO = MyReviewDAO.getInstance();
			reviewList = mrDAO.selectPageReview(pageRange[0], pageRange[1], userId, areaType);
		} else {
			ReviewDAO rDAO = ReviewDAO.getInstance();
			reviewList = rDAO.selectPageReview(pageRange[0], pageRange[1], contId);
		}
	
	for( ReviewVO vo : reviewList ){
		jsonObj = new JSONObject();
		jsonObj.put( "reviewId", vo.getReviewId());
		jsonObj.put( "areaId", vo.getAreaId());
		jsonObj.put( "userId", vo.getUserId());
		jsonObj.put( "content", vo.getContent());
		jsonObj.put( "starScore", vo.getStarScore());
		jsonObj.put( "date", sdf.format(vo.getDate()));
		
		jsonArr.add(jsonObj);
		
	}//end for
	} catch ( SQLException se ){
		se.printStackTrace();
	}

	out.print( jsonArr.toJSONString() );
%>
