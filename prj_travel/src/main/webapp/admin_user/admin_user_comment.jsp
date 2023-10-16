<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>    
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
</script>

<!-- bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- bootstrap CDN-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="resource/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="resource/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="resource/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="resource/plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resource/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet"
	href="resource/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="resource/plugins/daterangepicker/daterangepicker.css">
<!-- summernote -->
<link rel="stylesheet"
	href="resource/plugins/summernote/summernote-bs4.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake" src="dist/img/AdminLTELogo.png"
				alt="AdminLTELogo" height="60" width="60">
		</div>


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
                <h3 class="card-title">김선경님의 작성 댓글</h3>
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
                    <tr>
                      <td>1</td>
                      <td class="modal-trigger">우도 너무 재미있다 재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다
                      재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다
                      재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있
                      재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다재미있다</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>우도 너무 재미있다</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>우도 너무 재미있다</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td>우도 너무 재미있다</td>
                      <td>2023-10-12</td>
                    </tr>
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
              <h6><label style="margin: 0;">김선경</label></h6>
              <h6><label style="margin: 0;">2023.10.14</label></h6>
              </div>
              <div class="col-md-9" style="display: inline-block; float: left; white-space: normal;">
            <div class="comment-container" style="max-height: 150px; overflow: auto;">
                <p id="modal-content"></p>
              </div>
              </div>
		</div>
  		<button type="button" class="btn btn-primary" id="close-modal" style="display: block; margin: 0 auto; text-align: center;">닫기</button>
			
</div>
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
	<!-- jQuery -->
	<script src="resource/plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="resource/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>
	<!-- Bootstrap 4 -->
	<script src="resource/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="resource/plugins/chart.js/Chart.min.js"></script>
	<!-- Sparkline -->
	<script src="resource/plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->
	<script src="resource/plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="resource/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="resource/plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="resource/plugins/moment/moment.min.js"></script>
	<script src="resource/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="resource/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="resource/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script
		src="resource/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="resource/dist/js/adminlte.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="resource/dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="resource/dist/js/pages/dashboard.js"></script>
</body>
</html>	