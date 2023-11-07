<%@page import="admin.vo.TourBusReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="admin.vo.TourBusVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 | 투어버스관리 | 투어버스예약관리</title>
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

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	 
<script type="text/javascript">
$(function() {
		
	$( "#reservationDate" ).datepicker({
		  dateFormat: 'yy-mm-dd',
	      showOn: "button",
	      buttonImage: "http://192.168.10.134/prj_travel/common/images/icon_img/calendar.png",
	      buttonImageOnly: true,
	    });
		
})//ready

	function searchReservation(id) {
		
		$.ajax({
			url:"admin_tourbus_reservation_proccess.jsp",
			type: "get",
			data: { tourbusId : id, reservationTime : $("#reservationTime option:selected").val(), reservationDate: $("#reservationDate").val() },
			dataType: "json",
			error: function(xhr) {
				console.log(xhr.status);
			},
			success: function(json){
				$("#input").empty();
				
				var output = "";
					output += "<thead>";
					output +=  "<tr>";
					output +=	"<th style='width: 20px'>번호</th>";
					output +=	"<th style='width: 180px'>예약자</th>";
					output +=	"<th style='width: 60px'>성인</th>";
					output +=	"<th style='width: 60px'>소인</th>";
                    output += 	"<th style='width: 150px'>예약일자</th>";
                    output += 	"<th style='width: 150px'>예약시간</th>";
                    output +=	"<th style='width: 70px'>상태</th>";
                    output += 	"<th style='width: 70px'>승인버튼</th>";
                  output += "</tr>";
                	  output += "</thead>";
                	  output +=	"<tbody>";
				$.each(json.jsonArr, function(i, data){
                	  output +=	"<tr>";
                	  output +=	"<td>"+(i+1)+"</td>";
                	  output +=	"<td>"+data.userId+"</td>"
                	  output +=	"<td>"+data.adult+"</td>";
                	  output +=	"<td>"+data.child+"</td>";
                	  output +=	"<td>"+data.reservationDate+"</td>";
                	  output +=	"<td>"+data.reservationTime+"</td>";
                	  output += "<td class='state'><label id='acc_"+i+"'>" + (data.reservationState === 'N' ? '미승인' : '승인완료') + "</label>";
                	  output +=	"</td>";
                		  output +=	"<td style='text-align: center;' id='btn_" + i + "'>";
                		  if (data.reservationState === 'N') {
                			    output += '<input type="button" class="btn btn-primary" onclick="complete(\'' + data.reservationId + '\','+i+')" value="승인하기">';
                			} else {
                			    output += '<input type="button" class="btn btn-primary"  onclick="cancel(\'' + data.reservationId + '\','+i+')" value="승인취소">';
                			}
                    output += "</td>";
                    output += "</tr>";
				});//each
				output += "</tbody>";
                    

				$("#input").html(output);
		
			}//success
		});//ajax
	
	}
	
	function complete(id,i) {
		$.ajax({
			url:"admin_tourbus_reservation_complete.jsp",
			type: "get",
			data: { reservationId : id },
			dataType: "json",
			error: function(xhr) {
				console.log(xhr.status);
			},
			success: function(json){
				
				if(json.complete === 1){
					
					$("#acc_"+i).html("승인완료");
       				 $("#btn_"+i).html('<input type="button" class="btn btn-primary" onclick="cancel(\'' + json.reservationId + '\','+i+')" value="승인취소">');
         			
				}
				
				
				
			}//success
		})//ajax
			
		
	}
	
	function cancel(id,i) {
		$.ajax({
			url:"admin_tourbus_reservation_cancel.jsp",
			type: "get",
			data: { reservationId : id },
			dataType: "json",
			error: function(xhr) {
				console.log(xhr.status);
			},
			success: function(json){
				
				if(json.cancel === 1){
					$("#acc_"+i).html("미승인");
					 $("#btn_"+i).html('<input type="button" class="btn btn-primary"  onclick="complete(\'' + json.reservationId + '\','+i+')" value="승인하기">');
				}
				
			}//success
		})//ajax
			
		
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
        <label style="margin-right: 20px; margin-top: 5px">관리자님 안녕하세요.</label>
       </li>
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
					<li class="nav-item"><a href="../admin_dashboard/dashboard.jsp" class="nav-link">
							<i class="bi bi-speedometer"></i>
							<p>Dashboard</p>
					</a></li>

					<li class="nav-item"><a href="../admin_user/admin_user.jsp" class="nav-link">
							<i class="bi-people-fill"></i>
							<p>회원관리</p>
					</a></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-pencil-square"></i> <i
							class="right fas fa-angle-left"></i>
							<p>게시판관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="../admin_post/admin_post_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>공지사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="../admin_post/admin_question_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>문의사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="../admin_post/admin_board_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>자유게시판 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="admin_tourarea_list" class="nav-link"> <i
							class="bi bi-map"></i> <i class="right fas fa-angle-left"></i>
							<p>관광지 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="../admin_tourarea/admin_tourarea_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 목록</p>
							</a></li>
							<li class="nav-item"><a href="../admin_tourarea/admin_tourarea_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin_tourarea/admin_tourarea_review_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>관광지 리뷰 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-tencent-qq"></i> <i class="right fas fa-angle-left"></i>
							<p>맛집 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="../admin_restaurant/admin_tourarea_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 목록</p>
							</a></li>
							<li class="nav-item"><a href="../admin_restaurant/admin_tourarea_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin_restaurant/admin_tourarea_review_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>맛집 리뷰 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="#" class="nav-link active"> <i
							class="bi bi-bus-front"></i> <i class="right fas fa-angle-left"></i>
							<p>투어버스 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_tourbus_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 목록</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourbus_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 추가</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourbus_reservation_list.jsp"
								class="nav-link active"> <i class="far fa-circle nav-icon"></i>
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
							<h1 class="m-0">투어버스 관리</h1>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
<%
	TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();
	String tourbusId = request.getParameter("tourbusId");
	
	try{
		if(tourbusId != null){
			TourBusVO tbVO = tbmDAO.selectTourBus(tourbusId);
			
			String[] dispatchArr = null;
			String[] reDispatchArr = null;
			if( tbVO.getDispatchTimes() != null ){
				dispatchArr = tbVO.getDispatchTimes().split(" ");
				reDispatchArr = new String[dispatchArr.length];
				for( int i = 0; i< dispatchArr.length; i++ ){
					reDispatchArr[i] = dispatchArr[i];
				}
			}//end if
		pageContext.setAttribute("dispatches", reDispatchArr);
		pageContext.setAttribute("tbVO", tbVO);
			
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
%>			
	<section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title"><c:out value="${ tbVO.name }"/></h3>
              </div>
              <!-- /.card-header -->
              <div class="contents" style="margin-top: 20px">
            <div class="contents col-md-4" style="margin-top: 10px; display: inline-block;">
  		<label style="margin-left: 30px; float: left">운행날짜</label>
  		<input type="text" class="reservationDate" id="reservationDate" name="reservationDate" style="width: 60%; margin-left: 40px" placeholder="운행날짜를 입력해주세요."><br/>
		</div>
		<div class="contents" style="margin-top: 10px; display: inline-block; width: 30%;">
  		 <label style=" float: left; margin-right: 60px">버스시간</label>
  		<select class="form-select" id="reservationTime" name="reservationTime" style="width: 50%">
    	<c:forEach var="dispatch" items="${dispatches}" varStatus="i">
        	<option value="${dispatch}"><c:out value="${dispatch}"/></option>
    	</c:forEach>
		</select>
		</div>
		<div class="contents" style="margin-top: 10px; display: inline-block; width: 30%;">
  		<input type="button" id="search" name="search" value="조회" onclick="searchReservation('${ param.tourbusId }')" class="btn btn-info" style="width: 40%"/>
  		</div>
  		</div>
            
              <div class="card-body" style="height: 650px; margin-top: 70px">
                <table class="table table-bordered" id="input">
                <thead>
                <tr>
                	<th style='width: 20px'>번호</th>
					<th style='width: 180px'>예약자</th>
					<th style='width: 60px'>성인</th>
					<th style='width: 60px'>소인</th>
                   <th style='width: 150px'>예약일자</th>
                    <th style='width: 150px'>예약시간</th>
                    <th style='width: 70px'>상태</th>
                   <th style='width: 70px'>승인버튼</th>
                 </tr>
                  </thead>
                </table>
              </div>
              <!-- /.card-body -->
             
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