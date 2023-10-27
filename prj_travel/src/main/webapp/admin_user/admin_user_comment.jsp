<%@page import="admin.vo.UserCommentVO"%>
<%@page import="admin.dao.UserManageDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 | 회원관리</title>
<link rel="stylesheet" type="text/css"
	href="http://localhost/html_prj/common/css/main_v20230906">
<style type="text/css">
thead {
	text-align: center
}

td {
	text-align: center
}
#icon{
	font-size : 3em;
}

        }
</style>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btn").click(function() {
			location.href = "admin_user.jsp"
		})
		
		 $(".modal-trigger").on("click", function() {
		        var content = $(this).text();
		        $("#modal-content").text(content);
		        $("#modal1").show();
		    });

		    $("#close-modal").on("click", function(e) {
		        e.preventDefault();
		        $("#modal1").hide();
		    });
		    
		   
		
	})//ready

	function commentDetail(commentId) {
		
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
        <a href="index3.html" class="nav-link">Home</a>
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
			<a href="index3.html" class="brand-link"> <span
				class="brand-text font-weight-light">Visit JEJU</span>
			</a>


			<!-- Sidebar Menu -->
			<nav class="mt-2">
				<ul class="nav nav-pills nav-sidebar flex-column"
					data-widget="treeview" role="menu" data-accordion="true">
					<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
					<li class="nav-item"><a href="dashboard.jsp" class="nav-link">
							<i class="bi bi-speedometer"></i>
							<p>Dashboard</p>
					</a></li>

					<li class="nav-item"><a href="#" class="nav-link active">
							<i class="bi-people-fill"></i>
							<p>회원관리</p>
					</a></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-pencil-square"></i> <i
							class="right fas fa-angle-left"></i>
							<p>게시판관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_post_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>공지사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="./index2.html"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>문의사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="./index3.html"
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
		<div class="content-wrapper">
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">회원관리</h1>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
	<section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
<%
UserManageDAO umDAO = UserManageDAO.getInstance();
try{
	String id = request.getParameter("id");
	List<UserCommentVO> userAllCommentList = umDAO.selectUserAllComment(id);
	pageContext.setAttribute("list", userAllCommentList);
		for(int i = 0; i < userAllCommentList.size(); i++ ){
    		  if(userAllCommentList.get(i).getUserId().equals(request.getParameter("id"))){
%>
                <h3 class="card-title"><%=userAllCommentList.get(i).getUserName()%>님의 작성 댓글</h3>
<% 
    		  }
		}
}catch(SQLException se){
	se.printStackTrace();
}
%>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th style="width: 60px">번호</th>
                      <th style="width: 300px">작성한 댓글</th>
                      <th style="width: 120px">작성일</th>
                    </tr>
                  </thead>
                  <tbody>
    <c:forEach var="comment" items="${list}" varStatus="i">
<c:choose>
  <c:when test="${not empty comment.content}">
      <tr>
        <td><c:out value="${i.count}" /></td>
        <td class="modal-trigger">
        <a href="#void" onclick="commentDetail(${comment.commentId})"><c:out value="${comment.content}" /></a></td>
        <td><c:out value="${comment.registrationDate}" /></td>
      </tr>
  </c:when>
  <c:otherwise>
    <tr>
      <td colspan="3">작성하신 댓글이 없습니다.</td>
    </tr>
  </c:otherwise>
</c:choose>
</c:forEach>

                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              <button type="submit" class="btn btn-primary" id="btn">목록</button>
                <ul class="pagination pagination-sm m-0 float-right">
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                </ul>
              </div>
            </div>
            <!-- /.card -->
            </div>
            </div>
           </div>
         </section>

<%
try{
	
	String commentId = request.getParameter("commentId");

	if(commentId != null){
	UserCommentVO ucVO = umDAO.selectUserComment(commentId);
	pageContext.setAttribute("ucVO", ucVO);
%>         

        <div id="modal1" class="modal" style="display: none; position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 20px;max-width: 80%; width: 1000px; height: 250px; 
    z-index: 1000; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 10px;">
		 <div class="row">
              <div class="col-md-2" style="margin-left: 70px; float: left; text-align: center;">
              <i class="bi bi-person-circle" id="icon"></i>
              <h6><label style="margin: 0;">${ ucVO.userName }</label></h6>
              <h6><label style="margin: 0;">${ ucVO.registrationDate }</label></h6>
              </div>
              <div class="col-md-9" style="display: inline-block; float: left; white-space: normal;">
            <div class="comment-container" style="max-height: 150px; overflow: auto;">
                <p id="modal-content"></p>
              </div>
              </div>
		</div>
  		<button type="button" class="btn btn-primary" id="close-modal" style="display: block; margin: 0 auto; text-align: center;">닫기</button>
			
</div>
<% }
}catch(SQLException se){
	se.printStackTrace();
}%>

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