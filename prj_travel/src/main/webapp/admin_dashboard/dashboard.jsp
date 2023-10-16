<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>관리자 | Dashboard</title>
<link rel = "stylesheet" type="text/css" href = "http://192.168.10.134/html_prj/common/css/main_v20230906">
<style type="text/css">
thead{ text-align : center }
td{ text-align : center }
</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
$(function(){

	    var areaChartData = {
	      labels  : ['우도', '성산일출봉', '섭지코지', '금능해수욕장', '동문시장'],
	      datasets: [
	        {
	          label               : '좋아요',
	          backgroundColor     : '#BFE9E5',
	          borderColor         : 'BFE9E5',
	          pointRadius         : false,
	          pointColor          : 'BFE9E5',
	          pointStrokeColor    : '#c1c7d1',
	          pointHighlightFill  : '#fff',
	          pointHighlightStroke: 'rgba(220,220,220,1)',
	          data                : [65, 59, 80, 81, 56, 0]
	        }
	      ]
	    }
	    
		var barChartCanvas = $('#barChart').get(0).getContext('2d');
	    var barChartData = $.extend(true, {}, areaChartData);
	    var temp0 = areaChartData.datasets[0];
	    barChartData.datasets[0] = temp0;

	    var barChartOptions = {
	      responsive              : true,
	      maintainAspectRatio     : false,
	      datasetFill             : false
	    }

	    new Chart(barChartCanvas, {
	      type: 'bar',
	      data: barChartData,
	      options: barChartOptions
	    });
		
	    var areaChartData2 = {
	  	      labels  : ['가시아방', '갈치조림', '은희네', '고기국수', '횟집'],
	  	      datasets: [
	  	        {
	  	          label               : '좋아요',
	  	          backgroundColor     : '#BFE9E5',
	  	          borderColor         : 'BFE9E5',
	  	          pointRadius         : false,
	  	          pointColor          : 'BFE9E5',
	  	          pointStrokeColor    : '#c1c7d1',
	  	          pointHighlightFill  : '#fff',
	  	          pointHighlightStroke: 'rgba(220,220,220,1)',
	  	          data                : [65, 59, 80, 81, 56, 0]
	  	        }
	  	      ]
	  	    }
	    
	    var barChartCanvas = $('#barChart2').get(0).getContext('2d');
	    var barChartData = $.extend(true, {}, areaChartData2);
	    var temp0 = areaChartData2.datasets[0];
	    barChartData.datasets[0] = temp0;

	    var barChartOptions = {
	      responsive              : true,
	      maintainAspectRatio     : false,
	      datasetFill             : false
	    }

	    new Chart(barChartCanvas, {
	      type: 'bar',
	      data: barChartData,
	      options: barChartOptions
	    });
})//ready
</script>
  
  <!-- bootstrap CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <!-- bootstrap CDN-->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resource/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="resource/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="resource/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="resource/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="resource/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="resource/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="resource/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="resource/plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
  

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
            <span class="brand-text font-weight-light">Visit JEJU</span>
    </a>


      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="true">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="dashboard.jsp" class="nav-link active">
               <i class="bi bi-speedometer"></i>
              <p>
                 Dashboard
              </p>
            </a>
          </li>
          
          <li class="nav-item">
          <a href="admin_user.jsp" class="nav-link">
               <i class="bi-people-fill"></i>
              <p> 회원관리</p>
            </a>
          </li>
         
           <li class="nav-item menu">
            <a href="#" class="nav-link">
              <i class="bi bi-pencil-square"></i>
                <i class="right fas fa-angle-left"></i>
             <p>게시판관리</p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="admin_post_list.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>공지사항 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index2.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>문의사항 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index3.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>자유게시판 관리</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item menu">
            <a href="#" class="nav-link">
              <i class="bi bi-map"></i>
                <i class="right fas fa-angle-left"></i>
             <p>관광지 관리</p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./index.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>관광지 추가</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index2.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>관광지 리뷰 관리</p>
                </a>
              </li>
            </ul>
          </li>
          
           <li class="nav-item menu">
            <a href="#" class="nav-link">
              <i class="bi bi-tencent-qq"></i>
                <i class="right fas fa-angle-left"></i>
             <p>맛집 관리</p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./index.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>맛집 추가</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index2.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>맛집 리뷰 관리</p>
                </a>
              </li>
            </ul>
          </li>
          
           <li class="nav-item menu">
            <a href="#" class="nav-link">
              <i class="bi bi-bus-front"></i>
                <i class="right fas fa-angle-left"></i>
             <p>투어버스 관리</p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./index.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>투어버스 추가</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index2.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>투어버스 예약 관리</p>
                </a>
              </li>
            </ul>
          </li>
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
		<div class="row">
          <div class="col-md-6">
            <div class="card" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">최근 공지사항</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table">
                  <thead>
                    <tr>
                      <th style="width: 60px">번호</th>
                      <th>제목</th>
                      <th style="width: 150px">작성일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>2.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>3.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>4.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body --> 
            </div>
            <!-- /.card -->

             <!-- BAR CHART -->
            <div class="card card-success" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">관광지 랭킹</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <div class="chart">
                  <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
          <div class="col-md-6">
            <div class="card" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">답변 대기 문의사항</h3> 
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table">
                  <thead>
                    <tr>
                      <th style="width: 60px">번호</th>
                      <th>제목</th>
                      <th style="width: 150px">작성일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>2.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>3.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>4.</td>
                      <td>Update software</td>
                      <td>2023-10-12</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- BAR CHART -->
            <div class="card card-danger" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">맛집 랭킹</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <div class="chart">
                  <canvas id="barChart2" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
        
        <!-- row -->
        <div class="row">
          <div class="col-12">
            <div class="card" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">최근 관광지 리뷰</h3>

                <div class="card-tools">
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th style="width:60px">번호</th>
                      <th>리뷰 내용</th>
                      <th style="width:80px">분류</th>
                      <th style="width:150px">아이디</th>
                      <th style="width:150px">작성일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>경치가 좋아요</td>
                      <td>관광지</td>
                      <td><span class="tag tag-success">aaa</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>경치가 좋아요</td>
                      <td>관광지</td>
                      <td><span class="tag tag-success">bbb</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>경치가 좋아요</td>
                      <td>관광지</td>
                      <td><span class="tag tag-success">ccc</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td>경치가 좋아요</td>
                      <td>관광지</td>
                      <td><span class="tag tag-success">ddd</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>5</td>
                      <td>경치가 좋아요</td>
                      <td>관광지</td>
                      <td><span class="tag tag-success">eee</span></td>
                      <td>2023-10-12</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
        </div>
        <!-- /.row -->
        
        <!-- row -->
        <div class="row">
          <div class="col-12">
            <div class="card" style="margin-left: 20px; margin-right: 20px">
              <div class="card-header">
                <h3 class="card-title">최근 맛집 리뷰</h3>

                <div class="card-tools">
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th style="width:60px">번호</th>
                      <th>리뷰 내용</th>
                      <th style="width:80px">분류</th>
                      <th style="width:150px">아이디</th>
                      <th style="width:150px">작성일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>맛있어요</td>
                      <td>맛집</td>
                      <td><span class="tag tag-success">aaa</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>맛있어요</td>
                      <td>맛집</td>
                      <td><span class="tag tag-success">bbb</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>맛있어요</td>
                      <td>맛집</td>
                      <td><span class="tag tag-success">ccc</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td>맛있어요</td>
                      <td>맛집</td>
                      <td><span class="tag tag-success">ddd</span></td>
                      <td>2023-10-12</td>
                    </tr>
                    <tr>
                      <td>5</td>
                      <td>맛있어요</td>
                      <td>맛집</td>
                      <td><span class="tag tag-success">eee</span></td>
                      <td>2023-10-12</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
        </div>
        <!-- /.row -->
       <div style="margin-left: 20px; margin-right: 20px">
       	<h4><i class="bi bi-bus-front">&nbsp;투어버스 예약 미승인 현황</i></h4>
       </div> 
      <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-4 col-8">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3>5건</h3>
                <h4>1번 버스</h4>

              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-4 col-8">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                 <h3>5건</h3>
                <h4>2번 버스</h4>
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-4 col-8">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3>5건</h3>
                <h4>3번 버스</h4>
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
      </div>
      <!-- ./row -->
     </div>
     <!-- ./container-fluid -->
     </section> 
  </div>

 <footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
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
<script src="resource/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="resource/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="resource/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="resource/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="resource/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="resource/dist/js/pages/dashboard.js"></script>
</body>
</html>
