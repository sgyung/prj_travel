<%@page import="admin.vo.PostVO"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.CommentPageDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.NoticeVO"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	if("GET".equals(request.getMethod().toUpperCase())){
		response.sendRedirect("board_restaurant_list.jsp");
		return;
	}
%>
<%
CommentPageDAO cpDAO = CommentPageDAO.getInstance();
PageVO pVO = new PageVO();

String postId = request.getParameter("postId");
//System.out.println("postId = " + postId);
// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = cpDAO.commentTotalCount(postId);

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 5;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");
//System.out.println("currentPage = " + tempPage);
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

pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);
pageContext.setAttribute("movePage", movePage);
pageContext.setAttribute("postId", postId);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon"
	href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- bootstrap JS  -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="../common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">
.content_wrap {
	margin-top: 90px;
	width: 100%;
}

.content {
	width: 70%;
	margin: 0 auto;
}

.post_table {
	width: 100%;
	border-top: 2px solid #535353;
}

.post_table thead tr th {
	text-align: center;
	font-weight: 600;
	font-size: 18px;
	color: #333;
	line-height: 58px;
	padding: 0;
	border-bottom: 1px solid #e5e5e5;
}

.post_table tbody tr td {
	border-bottom: 1px solid #e5e5e5;
	line-height: 56px;
	text-align: center;
	padding: 0 10px;
	width: 10%;
}

.post_table tbody tr td:nth-child(2) {
	width: 50%;
	text-align: center;
}

.page-item.active .page-link {
	background-color: #ef6d00;
	border-color: #ef6d00;
}
</style>
<script type="text/javascript">
$(function(){
	$("#list").click(function() {
		location.href = "user_notice.jsp"
	});
	
	
});//ready
</script>
</head>
<body>

	<div class="wrap">

		<%@ include file="../common/jsp/header.jsp"%>

<%
	PostManageDAO pmDAO = PostManageDAO.getInstance();
	
	try{
		
		PostVO postVO = pmDAO.selectPost(postId);
		
		pageContext.setAttribute("postVO", postVO);
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>

		<div class="content_wrap">
			<div class="content">


				<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
					<div id="stab6" transition="fadeIn"
						class="add2020_detail_con tab_cont kr" data-v-db46a16a=""
						data-v-09a75c9f="">
						<p class="jisik_tit" data-v-db46a16a="">공지사항</p>

						<table class="table"
							style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; border-bottom: 1px solid #535353; border-spacing: 0px">
							<tbody>
								<tr>
									<th
										style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">제목</th>
									<td>${ postVO.postTitle }<label>[${ postVO.postCategory }]</label></td>
								</tr>
								<tr style="height: 300px">
									<th
										style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">내용</th>
									<td>
										<div style="margin: 10px 0px;">${ postVO.postContent }</div>
									</td>
								</tr>
								<tr>
									<th
										style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">작성자</th>
									<td>${ postVO.userId }</td>
								</tr>
								<tr>
									<th
										style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">작성일</th>
									<td>${ postVO.postDate }</td>
								</tr>
								<tr>
									<th
										style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">조회수</th>
									<td>${ nVO.viewNum }</td>
								</tr>
								<!-- <tr>
            <th style="text-align: center;	vertical-align: middle; border-right: 1px solid #535353;">공지글 여부</th>
            <td>y</td>
            </tr> -->
							</tbody>
							
							
						</table>
						
						
						<%-- 
				<form action="admin_post_add.jsp" method="post" id="postFrm">
					<input type="hidden" id="postId" name="postId">
				</form>
				<div style="text-align: right; margin-top: 10px">
					<form action="admin_post_delete_proccess.jsp" method="post"
						id="deleteFrm">
						<input type="hidden" id="deleteId" name="deleteId">
					</form>
					<input type="button" value="수정" class="btn btn-info" id="modify"
						style="width: 80px;" onclick="postModify('${ nVO.id }')">
					<input type="button" value="삭제" class="btn btn-info" id="delete"
						style="width: 80px; margin-left: 20px;">
				</div> 
				--%>

						<div style="text-align: center; margin-top: 10px">
							<input type="button" value="목록" class="btn btn-warning" id="list"
								style="width: 150px">
						</div>

					</div>
				</div>
			</div>
		</div>



		<%@ include file="../common/jsp/footer.jsp"%>

	</div>
</body>
</html>