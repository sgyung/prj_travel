<%@page import="java.util.ArrayList"%>
<%@page import="user_mypageDAO.MyQnADAO"%>
<%@page import="user.vo.QnAVO"%>
<%@page import="user.dao.QnADAO"%>
<%@page import="pageUtil.Paging"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String selectPage = request.getParameter("selectPage");
	String pageScale = request.getParameter("pageScale");
	String userId = request.getParameter("userId");
	
	Paging paging = Paging.getInstance();
	int[] pageRange = paging.getPageRowRange(Integer.parseInt(selectPage), Integer.parseInt(pageScale));
	
	List<QnAVO> qnaList = new ArrayList<QnAVO>();
	if( userId != null ){
		MyQnADAO mqnaDAO = MyQnADAO.getInstance();
		qnaList = mqnaDAO.selectPageQnA(pageRange[0], pageRange[1], userId);
	} else {
		QnADAO qDAO = QnADAO.getInstance();
		qnaList = qDAO.selectPageQnA(pageRange[0], pageRange[1]);
	}//end else
	
	
	StringBuilder qnaListHtml = new StringBuilder();
	for( QnAVO vo : qnaList ){
		qnaListHtml
		.append("<tr data-v-db46a16a='' class='qnaList' >")
		.append("<td data-v-db46a16a=''>")
		.append("<p data-v-db46a16a=''>")
		.append("<u class='ok' data-v-db46a16a=''>");
		if( vo.getAnswerType().equals("Y")){
			qnaListHtml.append("[답변완료]");
		} else {
			qnaListHtml.append("[대기중]");
		};
		qnaListHtml.append("</u>")
		.append( vo.getTitle() ).append("</p>").append("</td>")
		.append("<td data-v-db46a16a=''>").append( vo.getCategory() ).append("</td>")
		.append("<td data-v-db46a16a=''>");
		if( vo.getAnswerType().equals("Y")){
			qnaListHtml.append(1);
		} else {
			qnaListHtml.append(0);
		};
		qnaListHtml.append("</td>").append("<input type='hidden' id='questionId' value='").append(vo.getQnaId()).append(" ' />")
		.append("<td data-v-db46a16a=''>").append( vo.getRegistrationDate()).append("</td>").append("</tr>")
		;
	}//end for
	
	String result = qnaListHtml.toString();
%>
<%=result  %>