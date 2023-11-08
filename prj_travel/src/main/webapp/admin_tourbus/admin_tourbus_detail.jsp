<%@page import="admin.vo.TourBusVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:if test="${ empty admin }">
<c:redirect url="../admin/admin_login.jsp"/>
</c:if>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 | 투어버스관리</title>
<link rel="stylesheet" type="text/css"
	href="http://localhost/html_prj/common/css/main_v20230906"> 
<style type="text/css">

.title {
  text-align: center;
}

.contents {
  display: flex;
  flex-direction: row;
}
.contents .upload-box {
  width: 100%;
  margin-right: 30px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.contents .upload-box .drag-file {
  position: relative;
  width: 100%;
  height: 360px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 3px dashed #dbdbdb;
}
.contents .upload-box .drag-file.highlight {
  border: 3px dashed red;
}
.contents .upload-box .drag-file .image {
  width: 100%;
  height: 100%;
}
.contents .upload-box .drag-file .message {
  margin-bottom: 0;
}
.contents .upload-box .drag-file .preview {
  display: none;
  position: absolute;
  left: 0;
  height: 0;
  width: 100%;
  height: 100%;
}
.contents .upload-box .file-label {
  margin-top: 30px;
  background-color: #5b975b;
  color: #fff;
  text-align: center;
  padding: 10px 0;
  width: 100%;
  border-radius: 6px;
  cursor: pointer;
}
.contents .upload-box .file {
  display: none;
}

@media (max-width: 700px) {
  .contents {
    display: flex;
    flex-direction: column;
    margin-top: 30px;
  }
  .contents .upload-box {
    width: 100%;
    box-sizing: border-box;
    margin-right: 0;
  }
  .contents .upload-box .drag-file {
    height: 150px;
  }
  .contents .files {
    width: 100%;
    box-sizing: border-box;
    margin-right: 0;
    overflow: initial;
  }
}

      .a {
        text-indent: 2em;
      }
      

</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
$(function() {
	 $("#logout").click(function() {
			location.href = "../admin/admin_logout.jsp";
		});//click
		
	$("#complete").click(function(){
		$("#detail_frm").submit();
	})//click
	
	$("#cancel").click(function(){
		 if (confirm("관광지를 삭제 하시겠습니까?")) {
		    	 $("#delete_frm").submit();
		     } else {
		    	return;
		     }
	})//click
	
	$("#list").click(function(){
		location.href="admin_tourbus_list.jsp";	
	})
	
	
	
})//ready
	

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
							<li class="nav-item"><a href="admin_tourbus_list.jsp" class="nav-link active">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 목록</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourbus_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 추가</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourbus_reservation.jsp"
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
							<h1 class="m-0">투어버스 관리</h1>
						</div>
									<div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="../admin_dashboard/dashboard.jsp">Home</a></li>
              <li class="breadcrumb-item active">투어버스 목록</li>
            </ol>
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
			
			String[] routeArr = null;
			String[] reRouteArr = null;
			if( tbVO.getRoutes() != null ){
				routeArr = tbVO.getRoutes().split(",");
				reRouteArr = new String[routeArr.length];
				for( int i = 0; i< routeArr.length; i++ ){
					reRouteArr[i] = routeArr[i];
				}
			}//end if
			
			
			
			pageContext.setAttribute("tbVO", tbVO);
			pageContext.setAttribute("dispatchs", reDispatchArr);
			pageContext.setAttribute("routes", reRouteArr);
			
		
%>			
	<section class="content">
      <div class="container-fluid" style="width: 100%">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">투어버스 상세내용</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td style="border-bottom: 0px">
			<div class="contents" style="margin-top: 20px">
    <div class="upload-box col-md-5">
      <div class="drag-file" id="drop-file">
        <img src="${ tbVO.image }"  class="image" >
    </div>
    </div>
  	<div class="contents" style="margin-top: 10px; width: 80%; display: inline-block;">
  	<h4><strong><label>${ tbVO.name }</label></strong></h4>
  	<hr style="width:90%;">
     <h5><label style="margin-left: 30px;">운행안내</label></h5>
      <ul>
      <li style=" margin-left: 30px"><span  style="width: 100%; margin-bottom: 10px; display: inline-block;  display: inline-block">08:00 ~ 18:00 / 1일 9회 운행</span></li>
      <li style=" margin-left: 30px">
      <span  style="width: 100%;display: inline-block; margin-bottom: 20px; display: inline-block">소요 시간: ${ tbVO.busTourTime }/휴차일 : 매월 세번째 월요일</span>
      </li>
      </ul>
  	<h5><label style="margin-left: 30px;">요금안내</label></h5>
  	<ul>
  	<li style=" margin-left: 30px"><span  style="width: 80%; margin-bottom: 20px; display: inline-block; display: inline-block">
  	성인 : ${ tbVO.adultFare }원, 소인 및 청소년 :  ${ tbVO.childFare }원, 6세 미만 무료</span>
    </li>
    </ul>
    <h5><label style="margin-left: 30px">문의사항</label></h5>
  	<ul>
  	<li style=" margin-left: 30px"><span  style="width: 80%;display: inline-block; display: inline-block">
  	064-741-8784</span>
    </li>
    </ul>
  	</div>
  	</div>
  	</td>
  	</tr>
  	<tr>
  	<td style="border-bottom: 1px;">
  	<div class="contents" style="margin-top: 20px">
   <div class="col-md-5">
  	<h4><strong><label>운행노선</label></strong></h4>
<%for(int i = 0; i < reRouteArr.length; i++ ){
%>
  	<label style="margin-left: 10px; font-size: large;"><%=reRouteArr[i] %></label>
<%
		if(i < reRouteArr.length-1){
%>
  	<img src="http://192.168.10.134/prj_travel/common/images/icon_img/busarrow.png" style="margin:20px">

<%	
		}
	}
%>
  	</div>
  	<div class="contents" style=" margin-left: 200px; display: inline-block; width: 80%">
  	<h4><strong><label>운행시간</label></strong></h4>
<%for(int i = 0; i < reDispatchArr.length; i++ ){
%>
  	<label style="margin-left: 10px; font-size: large;"><%=reDispatchArr[i] %></label>
<%
		if(i < reDispatchArr.length-1){
%>
  	<img src="http://192.168.10.134/prj_travel/common/images/icon_img/busarrow.png" style="margin:20px">

<%	
		}
	}
}
%>
  	</div>
  	</div>
  	</td>
  	</tr>
  	
<%  	
	}catch(SQLException se){
		se.printStackTrace();
	}
%>	
		
            <tr>
            <td style="border-top: 0px;"><h3><strong><label style="margin-top: 80px">이용안내</label></strong></h3></td>
            </tr>
            
            <tr>
            <td style="border: 0px;">
            <h4><strong><label>티켓구입처</label></strong></h4>
            <p class="fw-bolder">각 정류장별 버스 탑승 시 결제 후 티켓 수령</p>
            <p class="fw-bolder" style="margin-bottom: 80px">*공항은 3번 버스정류장에서 탑승 (현금, 신용카드, 교통카드 가능)</p>
            </td>
            </tr>
            <tr>
            <td style="border: 0px;">
            <h4><strong><label>휴차일</label></strong></h4>
             <p class="fw-bolder"style="margin-bottom: 80px">매주 월요일</p>
            </td>
            </tr>
            <tr>
            <td style="border: 0px;">
            <h4><strong><label>주의사항 및 문의전화</label></strong></h4>
            <p class="fw-bolder">문의전화</p>
            <p class="a">064-741-8784(시티투어운영과)</p>
            
            <p class="fw-bolder">금지사항</p>
            <p class="a">운전 중 좌석 이동</p>
            <p class="a">안전벨트 미착용</p>
            <p class="a">차내 음식물을 먹는 행위 및 흡연</p>
            <p class="a">반려동물(개, 새, 고양이 등) 동반 탑승 불가 단, 가방이나 케이지 이용 시 가능</p>
            
            <p class="fw-bolder">운행 중 요구사항</p>
            <p class="a">안전운전에 방해되는 악천후(태풍, 폭우 폭설), 국민안전처로부터 재난 발생 경보가 안내되었을 경우 당사의 파단으로 운행을 중단하는 
            악천후(태풍, 폭우, 폭설)일 경우에는 당사로 미리 확인 후 이용해 주시길 바랍니다.</p>
            <p class="a">(064-741-8784)</p>
            
            
            
            </td>
            </tr>
            
             
            </tbody>
            </table>
  
            
<div class="row" style="margin-top: 10px; text-align: left;">
  <div style="vertical-align: bottom;">
    <input type="button" value="목록" class="btn btn-warning" id="list" style="width: 150px;">
  <div class="" style=" margin-top: 20px; margin-left: 68%; text-align: right ;display: inline-block;">
    <input type="button" value="삭제" class="btn btn-secondary" id="cancel" style="margin-right: 30px; width: 150px;">
    <input type="button" value="수정" class="btn btn-warning" id="complete" style="width: 150px;">
  </div>
  
  <form action="http://192.168.10.133/prj_travel/admin_tourbus/admin_tourbus_modify.jsp" id="detail_frm" name="detail_frm">
	<input type="hidden" id="tourId" name="tourId" value="${ tbVO.id }"/>
 </form>
  <form action="http://192.168.10.133/prj_travel/admin_tourbus/admin_tourbus_delete_proccess.jsp" id="delete_frm" name="delete_frm">
	<input type="hidden" id="tourId" name="tourId" value="${ tbVO.id }"/>
 </form>
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
