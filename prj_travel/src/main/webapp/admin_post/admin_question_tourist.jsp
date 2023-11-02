<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="admin.vo.QandAVO"%>
<%@page import="java.util.List"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.QuestionPageDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.google.gson.JsonArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
QuestionPageDAO qpDAO = QuestionPageDAO.getInstance();
PageVO tourVO = new PageVO();

String tourField=request.getParameter("tourField");
String tourKeyword=request.getParameter("tourKeyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
tourVO.setField(request.getParameter("tourField"));
tourVO.setKeyword(request.getParameter("tourKeyword"));

System.out.println("---------------tourVO = " + tourVO);

//1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int tourTotalCount = qpDAO.touristQnaTotalCount(tourVO);

//2. 한 화면에 보여줄 게시물의 수
int tourPageScale = 5;

//3. 총 페이지 수
int tourTotalPage = 0;

tourTotalPage = (int)Math.ceil(tourTotalCount/(double)tourPageScale);


//현재 페이지의 시작번호 구하기
String  tourTempPage = request.getParameter("tourCurrentPage");
int tourCurrentPage = 1;

if(tourTempPage != null){
	tourCurrentPage = Integer.parseInt(tourTempPage);
}

int tourStartNum = tourCurrentPage * tourPageScale - tourPageScale + 1;
int tourEndNum = tourStartNum + tourPageScale -1;

//화면에 보여줄 페이지 인덱스 수
int tourPageNumber=5;

//시작페이지 번호
int tourStartPage=((tourCurrentPage-1)/tourPageNumber)*tourPageNumber+1;

//끝페이지 번호
int tourEndPage=(((tourStartPage-1)+tourPageNumber)/tourPageNumber)*tourPageNumber;

//구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( tourTotalPage <= tourEndPage){
	tourEndPage=tourTotalPage;
}//end if

int tourMovePage=0;

//Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
tourVO.setStartNum(tourStartNum);
tourVO.setEndNum(tourEndNum);

	JSONObject jsonObj = new JSONObject();

	JSONArray jsonArr = new JSONArray();
	
	try{
		
	List<QandAVO> list = qpDAO.selectTouristQna(tourVO);
		
		JSONObject json = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for(int i = 0; i < list.size(); i++){
			json = new JSONObject();
			
			json.put("rowNum", tourStartNum+i);
			json.put("qnaId", list.get(i).getQAndAId());
			json.put("userId", list.get(i).getUserId());
			json.put("tourist",list.get(i).getAreaId());
			json.put("qnaTitle", list.get(i).getTitle());
			json.put("qnaType", list.get(i).getCategory());
			json.put("qnaContent", list.get(i).getContent());
			json.put("qnaDate", sdf.format(list.get(i).getRegistrationDate()));
			json.put("answerState", list.get(i).getAnswerType());
			
			jsonArr.add(json);
		}
		jsonObj.put("jsonArr", jsonArr);
		jsonObj.put("tourCurrentPage", tourCurrentPage);
		jsonObj.put("tourPageNumber",tourPageNumber);
		jsonObj.put("tourMovePage",tourMovePage);
		jsonObj.put("tourStartPage",tourStartPage);
		jsonObj.put("tourEndPage",tourEndPage);
		jsonObj.put("tourTotalPage", tourTotalPage);
		
	
	}catch(SQLException se){
		se.printStackTrace();
	}
	out.print(jsonObj.toJSONString());
	
	
%>