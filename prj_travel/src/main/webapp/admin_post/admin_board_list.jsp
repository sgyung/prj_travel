<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.PostVO"%>
<%@page import="java.util.List"%>
<%@page import="admin.dao.PostManageDAO"%>
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
thead {
	text-align: center
}

td {
	text-align: center
}
</style>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
	})//ready
	
	function postDetail(id) {
		location.href = "admin_board_detail.jsp?postId=" + id;
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
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>문의사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="admin_board_list.jsp"
								class="nav-link active"> <i class="far fa-circle nav-icon"></i>
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
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">맛집 자유게시판 관리</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="height: 350px">
<%
PostManageDAO postDAO = PostManageDAO.getInstance();

	try{
		List<PostVO> list = postDAO.selectAllRestaurantPost();
		
		pageContext.setAttribute("restaurantList", list);
%>		
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th style="width: 40px">번호</th>
                      <th style="width: 50px">카테고리</th>
                      <th style="width: 300px">제목</th>
                      <th style="width: 70px">작성자</th>
                      <th style="width: 100px">작성일</th>
                      <th style="width: 70px">조회수</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="restaurantList" items="${restaurantList}" varStatus="i">
				        <tr>
				            <td>${i.count}</td>
				            <td>${restaurantList.postCategory}</td>
				            <td onclick="postDetail('${ restaurantList.postId }')">${restaurantList.postTitle}</td>
				            <td>${restaurantList.userId}</td>
				            <td>${restaurantList.postDate}</td>
				            <td>${restaurantList.postViewNum}</td>
				        </tr>
				</c:forEach>
<%                  
	}catch(SQLException se){
		se.printStackTrace();
	}

%>
             
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
             <div class="card-footer clearfix">
                <ul class="pagination justify-content-center" >
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                </ul>
                <div style="text-align: center" >
                <input type="text" id="input" class="inputBox" style="width: 200px; height: 30px;" placeholder="제목을 입력해주세요."/>
                <div style="display: inline-block;" >
                <input type="button" id="search" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
                </div>
                </div>
              </div>
            </div>
            <!-- /.card -->
            </div>
            </div>
           </div>
         </section>
          
         <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">관광지 자유게시판 관리</h3>
              </div>
              
<%

	try{
		List<PostVO> list = postDAO.selectAllTouristPost();
		
		pageContext.setAttribute("touristList", list);
%>          
		<!-- /.card-header -->
              <div class="card-body" style="height: 350px">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th style="width: 40px">번호</th>
                      <th style="width: 50px">카테고리</th>
                      <th style="width: 300px">제목</th>
                      <th style="width: 70px">작성자</th>
                      <th style="width: 100px">작성일</th>
                      <th style="width: 70px">조회수</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="touristList" items="${touristList}" varStatus="i">
				        <tr>
				            <td>${i.count}</td>
				            <td>${touristList.postCategory}</td>
				            <td onclick="postDetail('${ touristList.postId }')">${touristList.postTitle}</td>
				            <td>${touristList.userId}</td>
				            <td>${touristList.postDate}</td>
				            <td>${touristList.postViewNum}</td>
				        </tr>
				</c:forEach>
                   
                  </tbody>
<%
	}catch(SQLException se){
		se.printStackTrace();
	}

%>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <ul class="pagination justify-content-center" >
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                </ul>
                <div style="text-align: center" >
                <input type="text" id="input" class="inputBox" style="width: 200px; height: 30px;" placeholder="제목을 입력해주세요."/>
                <div style="display: inline-block;" >
                <input type="button" id="search" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
                </div>
                </div>
              </div>
            </div>
            <!-- /.card -->
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