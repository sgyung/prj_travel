<%@page import="admin.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@page import="admin.vo.PostVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 | 게시판관리</title>
<link rel="stylesheet" type="text/css"
	href="http://localhost/html_prj/common/css/main_v20230906"> 
<style type="text/css">
#icon{
	font-size : 3em;
}
#icon2{
	font-size : 2em;
}

#answer{
	width : 900px;
	height : 250px;
}
#cursor-position {
  position: absolute;
  padding: 5px;
  background-color: #ffcc00;
  border: 1px solid #333;
}
#btn {
 position: absolute;    
 right: 450px;
 bottom: 150px;
}



</style>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#list").click(function() {
			location.href = "admin_board_list.jsp";
		});
		
		$("#boardDelete").click(function() {
			deleteBoard();
		});
	})//ready
	
	function commentDelete(id){
		 if (confirm("댓글을 삭제 하시겠습니까?")) {
		    	$("#commentId").val(id);
		    	$("#postId").val(${ param.postId });
		    	 $("#DelFrm").submit();
		     } else {
		    	return;
		     }
	}
	
	 function deleteBoard() {
		    if (confirm("게시물을 삭제 하시겠습니까?")) {
		    	$("#postId").val(${ param.postId });
		    	 $("#DelFrm").submit();
		     } else {
		    	return;
		     }
		 }
</script>

<jsp:include page = "../include/set_style.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item d-none d-sm-inline-block">
        <a href="../admin_dashboard/dashboard.jsp" class="nav-link">Home</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <li class="nav-item">
        <input type="button" value="로그아웃" class="btn btn-outline-secondary" id="logout" style="width: 150px;" >
       </li>
       </ul>
  </nav>
  <!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo -->
			<a href="../admin_dashboard/dashboard.jsp" class="brand-link"> <span
				class="brand-text font-weight-light">Visit JEJU</span>
			</a>


			<!-- Sidebar Menu -->
			<nav class="mt-2">
				<ul class="nav nav-pills nav-sidebar flex-column"
					data-widget="treeview" role="menu" data-accordion="true">
					<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
					<li class="nav-item"><a href="../admin_dashboard/dashboard.jsp" class="nav-link">
							<i class="bi bi-speedometer"></i>
							<p>Dashboard</p>
					</a></li>

					<li class="nav-item"><a href="../admin_user/admin_user.jsp" class="nav-link">
							<i class="bi-people-fill"></i>
							<p>회원관리</p>
					</a></li>

					<li class="nav-item menu"><a href="#" class="nav-link active"> <i
							class="bi bi-pencil-square"></i> <i
							class="right fas fa-angle-left"></i>
							<p>게시판관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_post_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>공지사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="admin_question_list.jsp"
								class="nav-link active"> <i class="far fa-circle nav-icon"></i>
									<p>문의사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="admin_board_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>자유게시판 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-map"></i> <i class="right fas fa-angle-left"></i>
							<p>관광지 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="./index.html" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 추가</p>
							</a></li>
							<li class="nav-item"><a href="./index2.html"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>관광지 리뷰 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-tencent-qq"></i> <i class="right fas fa-angle-left"></i>
							<p>맛집 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="./index.html" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 추가</p>
							</a></li>
							<li class="nav-item"><a href="./index2.html"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>맛집 리뷰 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-bus-front"></i> <i class="right fas fa-angle-left"></i>
							<p>투어버스 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="./index.html" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 추가</p>
							</a></li>
							<li class="nav-item"><a href="./index2.html"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>투어버스 예약 관리</p>
							</a></li>
						</ul></li>

				</ul>
			</nav>
			<!-- /.sidebar-menu -->
		</aside>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" >
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">게시판 관리</h1>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
	<section class="content">
      <div class="container-fluid" style="width: 80%">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">자유게시판 관리</h3>
              </div>
<%
	PostManageDAO pmDAO = PostManageDAO.getInstance();
	
	String postId = request.getParameter("postId");
	try{
		
		PostVO pVO = pmDAO.selectPost(postId);
		
		pageContext.setAttribute("pVO", pVO);
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>
              <!-- <form action="admin_board_delete_proccess.jsp" id ="postDelFrm" method="post">
 				<input type="hidden" id="postId" name="postId"/>           
              </form> -->
            
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td>
			<div style="margin-left: 100px">
			<div class="row">
              <div class="col-md-1" style="text-align: center">
              <i class="bi bi-person-circle" id="icon"></i>
              <h5><label style="margin: 0">${ pVO.userId }</label></h5>
              <h6><label style="margin: 0">${ pVO.postDate }</label></h6>
              </div>
              <div class="col-md-6" style="margin-top: 20px; margin-left:50px; display: inline-block; float: left">
              <h3><label>${ pVO.postTitle }</label></h3>
              <h3><label>[${ pVO.postCategory }]</label></h3>
              </div>
              </div>
              <div class="row">
              <div class="col-md-11" style="float: left; white-space: normal;">
              ${ pVO.postContent }
              </div>
              </div>
             </div>
			</td>
            </tr>
            <tr>
            <td style="border-bottom: 0px"><h3>댓글</h3></td>
            </tr>
<%
try{
	
	List<CommentVO> list = pmDAO.selectComment(postId);
	
	pageContext.setAttribute("commentList", list);
	
}catch(SQLException se){
	se.printStackTrace();
} 
%>
            <tr>
            <td>
            <div>
            <form action="admin_board_delete_proccess.jsp" id ="DelFrm" method="post">
 				<input type="hidden" id="commentId" name="commentId"/>           
 				<input type="hidden" id="postId" name="postId"/>           
              </form>
            <c:forEach var="commentList" items="${ commentList }" varStatus="i">
            <div style="margin-left: 100px">
              <div class="row">
              <div class="col-md-1" style="text-align: center; margin-right: 20px">
              <i class="bi bi-person-circle" id="icon2"></i>
              <h6><label style="margin: 0">${ commentList.userId }</label></h6>
              <h6><label style="margin: 0">${ commentList.registrationDate }</label></h6>
              </div>
              <div class="col-md-9" style="float: left; white-space: normal; margin-left: 20px">
              ${ commentList.content }
              </div>
	            <input type="button" value="삭제" class="btn btn-outline-info" onclick="commentDelete('${ commentList.commentId }')" style="width: 80px; height:50px; float: left; margin-left: 30px" >
              </div>
            </div>
            </c:forEach>
            </div>
            </td>
            </tr>
            </tbody>
            </table>
            <div class="row" style="margin-top: 20px">
            <div class="col-md-1">
            <input type="button" value="목록" class="btn btn-outline-warning" id="list" style="width: 150px;" >
            </div>
            <div class="col-md-11" style="float: left; text-align: right; "> 
            <input type="button" value="삭제" class="btn btn-outline-danger" id="boardDelete" style="width: 150px;" >
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </section>

              
		</div>
		<footer class="main-footer">
			<strong>Copyright &copy; 2014-2021 <a
				href="https://adminlte.io">AdminLTE.io</a>.
			</strong> All rights reserved.
			<div class="float-right d-none d-sm-inline-block">
				<b>Version</b> 3.2.0
			</div>
		</footer>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	
</body>
</html>