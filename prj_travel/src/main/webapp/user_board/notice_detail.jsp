<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.NoticeVO"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	if("GET".equals(request.getMethod().toUpperCase())){
		response.sendRedirect("user_notice.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">

.content_wrap {
	margin-top:90px;
	width:100%;
}

.content {
	width:70%;
	margin : 0 auto;
}

.post_table {
	width:100%;
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
    width:10%;
}

.post_table tbody tr td:nth-child(2) {
    width: 50%;
    text-align: center;
}

.page-item.active .page-link {
	background-color:#ef6d00;
	border-color:#ef6d00;
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
	NoticeManageDAO nmDAO = NoticeManageDAO.getInstance();

	try{
		String noticeId = request.getParameter("noticeId");
		
		System.out.println(noticeId);
		
		if(noticeId != null){
			NoticeVO nVO = nmDAO.selectNotice(noticeId);
			pageContext.setAttribute("nVO", nVO);
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
							<td>${ nVO.title }</td>
						</tr>
						<tr style="height: 300px">
							<th
								style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">내용</th>
							<td>
								<div style="margin: 10px 0px;">${ nVO.content }</div>
							</td>
						</tr>
						<tr>
							<th
								style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">작성자</th>
							<td>관리자</td>
						</tr>
						<tr>
							<th
								style="text-align: center; vertical-align: middle; border-right: 1px solid #535353; background: #F1F3F4">작성일</th>
							<td>${ nVO.registrationDate }</td>
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
					<input type="button" value="목록" class="btn btn-warning"
						id="list" style="width: 150px">
				</div>
<%
		}
	}catch(SQLException se){
		se.printStackTrace();
	}		
%>	

					</div>
				</div>
			</div>
		</div>
		
		

		<%@ include file="../common/jsp/footer.jsp"%>

	</div>
</body>
</html>