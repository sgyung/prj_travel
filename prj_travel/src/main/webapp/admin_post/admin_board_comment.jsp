<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="pageUtil.CommentPageDAO"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="admin.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${ empty admin }">
<c:redirect url="../admin/admin_login.jsp"/>
</c:if>   
<%
CommentPageDAO cpDAO = CommentPageDAO.getInstance();
PageVO pVO = new PageVO();

String postId = request.getParameter("postId");
System.out.println("postId = " + postId);

// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = cpDAO.commentTotalCount(postId);

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 5;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");

int currentPage = 1;
if(tempPage != null){
	currentPage = Integer.parseInt(tempPage);
}

int startNum = currentPage * pageScale - pageScale + 1;
int endNum = startNum + pageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int pageNumber=5;

// 시작페이지 번호
int startPage=((currentPage-1)/pageNumber)*pageNumber+1;

// 끝페이지 번호
int endPage=(((startPage-1)+pageNumber)/pageNumber)*pageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( totalPage <= endPage){
	endPage=totalPage;
 }//end if

int movePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
pVO.setStartNum(startNum);
pVO.setEndNum(endNum);

JSONArray jsonArr = new JSONArray();


JSONObject jsonObj = new JSONObject();



try{
	
	List<CommentVO> list = cpDAO.selectComment(pVO,postId);
	
	JSONObject json = null;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	for(int i = 0; i < list.size(); i++){
		json = new JSONObject();
		
		json.put("rowNum", startNum+i);
		json.put("commentId", list.get(i).getCommentId());
		json.put("userId", list.get(i).getUserId());
		json.put("commentDate", sdf.format(list.get(i).getRegistrationDate()));
		json.put("content",list.get(i).getContent());
		
		jsonArr.add(json);
	}
	
	jsonObj.put("jsonArr", jsonArr);
	jsonObj.put("currentPage", currentPage);
	jsonObj.put("pageNumber",pageNumber);
	jsonObj.put("movePage",movePage);
	jsonObj.put("startPage",startPage);
	jsonObj.put("endPage",endPage);
	jsonObj.put("totalPage", totalPage);
	

}catch(SQLException se){
	se.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>