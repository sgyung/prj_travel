<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="admin.vo.QandAVO"%>
<%@page import="java.util.List"%>
<%@page import="pageUtil.QuestionPageDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
QuestionPageDAO qpDAO = QuestionPageDAO.getInstance();
PageVO resVO = new PageVO();

String resField=request.getParameter("resField");
String resKeyword=request.getParameter("resKeyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
resVO.setField(request.getParameter("resField"));
resVO.setKeyword(request.getParameter("resKeyword"));
System.out.println("---------" + resVO);

// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int resTotalCount = qpDAO.restaurantQnaTotalCount(resVO);

// 2. 한 화면에 보여줄 게시물의 수
int resPageScale = 5;

// 3. 총 페이지 수
int resTotalPage = 0;

resTotalPage = (int)Math.ceil(resTotalCount/(double)resPageScale);


// 현재 페이지의 시작번호 구하기
String  resTempPage = request.getParameter("resCurrentPage");
int resCurrentPage = 1;
if(resTempPage != null){
	resCurrentPage = Integer.parseInt(resTempPage);
}

int resStartNum = resCurrentPage * resPageScale - resPageScale + 1;
int resEndNum = resStartNum + resPageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int resPageNumber=5;

// 시작페이지 번호
int resStartPage=((resCurrentPage-1)/resPageNumber)*resPageNumber+1;

// 끝페이지 번호
int resEndPage=(((resStartPage-1)+resPageNumber)/resPageNumber)*resPageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( resTotalPage <= resEndPage){
	resEndPage=resTotalPage;
 }//end if

int resMovePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
resVO.setStartNum(resStartNum);
resVO.setEndNum(resEndNum);
	JSONArray jsonArr = new JSONArray();
	
	
	JSONObject jsonObj = new JSONObject();
	
	
	
	try{
		
		List<QandAVO> list = qpDAO.selectRestaurantQna(resVO);
		
		JSONObject json = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for(int i = 0; i < list.size(); i++){
			json = new JSONObject();
			
			json.put("rowNum", resStartNum+i);
			json.put("qnaId", list.get(i).getQAndAId());
			json.put("userId", list.get(i).getUserId());
			json.put("restaurant",list.get(i).getRestaurantId());
			json.put("qnaTitle", list.get(i).getTitle());
			json.put("qnaType", list.get(i).getCategory());
			json.put("qnaContent", list.get(i).getContent());
			json.put("qnaDate", sdf.format(list.get(i).getRegistrationDate()));
			json.put("answerState", list.get(i).getAnswerType());
			
			jsonArr.add(json);
		}
		
		jsonObj.put("jsonArr", jsonArr);
		jsonObj.put("resCurrentPage", resCurrentPage);
		jsonObj.put("resPageNumber",resPageNumber);
		jsonObj.put("resMovePage",resMovePage);
		jsonObj.put("resStartPage",resStartPage);
		jsonObj.put("resEndPage",resEndPage);
		jsonObj.put("resTotalPage", resTotalPage);
		
	
	}catch(SQLException se){
		se.printStackTrace();
	}
	
	out.print(jsonObj.toJSONString());
	
%>
