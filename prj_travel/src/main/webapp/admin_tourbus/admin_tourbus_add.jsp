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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	 
<style type="text/css">
#dispatchAdd-btn {
            text-decoration: none;
            display: inline-block;
            width: 30px;
            height: 30px;
            background: #8bc34a; /* Green */
            font-size: 2rem;
            font-weight: bold;
            color: #FFF;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-left: 20px;
            margin-bottom : 300px;
            float: left;
        }
#routeAdd-btn {
            text-decoration: none;
            display: inline-block;
            width: 30px;
            height: 30px;
            background: #8bc34a; /* Green */
            font-size: 2rem;
            font-weight: bold;
            color: #FFF;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-left: 20px;
            margin-bottom : 300px;
            float: left;
        }
#preview{
	display: none;
}
.remove-btn{
			text-decoration: none;
            border: 0;
            width: 30px;
            height: 30px;
            background: #F44336;
            color:#fff
            font-size: 1.5rem;
            font-weight: bold;
            color: #FFF;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            margin-right: 100px;	
		}   
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
  width: 40px;
}
.contents .upload-box .drag-file .message {
  margin-bottom: 0;
}
#preview{
 width: 100%;
 height: 100%;
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

</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
	$(function() {
		// 이미지 미리보기
		 $("#chooseImg").change(function( event ){
		 		if( $("#chooseImg").val() == "" ) {
		 			alert("이미지를 선택해 주세요.");
		 			return;
		 		}//end if
		 		
		 		var file = event.target.files[0];
		 			var reader = new FileReader();
		 			reader.onload = function(e) {
		 				$(".message").empty();
		 				$(".image").hide();
		 				$("#preview").attr("src", e.target.result);
		 				$("#preview").show();
		 			}
		 			reader.readAsDataURL(file);
		 	})//change

		$( "#startDate, #endDate" ).datepicker({
			  dateFormat: 'yy-mm-dd',
		      showOn: "button",
		      buttonImage: "http://192.168.10.134/prj_travel/common/images/icon_img/calendar.png",
		      buttonImageOnly: true,
		    });

		 $("#logout").click(function() {
				location.href = "../admin/admin_logout.jsp";
			});//click 
			
			 // 폼 submit
			 $("#complete").click(function() {
				$("#infoFrm").submit();
			});//click
			
	})//ready
	
	 let dispatchFieldCounter = 0;
     const dispatchMaxFields = 9;
     


     function dispatchRemoveField(wrapper) {
         $(wrapper).remove();
         dispatchFieldCounter--;
     }
   
     function dispatchAdd() {
    	    if (dispatchFieldCounter < dispatchMaxFields) {
    	    	dispatchFieldCounter++;
    	        let wrapper = $('<div class="input-wrapper" style="margin-left:180px; margin-bottom:20px;"></div>');

    	        let newInput = $('<input type="text" style="margin-right:60px; width: 50%" placeholder="시간을 입력해주세요." class="dispatchTime" name="dispatchTime">');
    	        let removeButton = $('<button class="remove-btn" onclick="dispatchRemoveField(this.parentNode)">&times;</button>');

    	        wrapper.append(newInput);
    	        wrapper.append(removeButton);

    	        $('#dispatchInput').append(wrapper);
    	    } else {
    	        alert('최대 9개까지만 추가 가능합니다.');
    	    }
    	}
   	
     
     let routeFieldCounter = 0;
     const routeMaxFields = 9;
     
     function routeAdd() {
         if (routeFieldCounter < routeMaxFields) {
        	 routeFieldCounter++;
             let wrapper = $('<div class="input-wrapper" style="margin-left:180px;"></div>');

             let newInput = $('<input type="text" style = "margin-right:60px; width: 60%; margin-bottom: 20px" placeholder="운행노선을 입력해주세요." class="route" name="route">');
             let removeButton = $('<button class="remove-btn" onclick="routeRemoveField(this.parentNode)">&times</button>');

             wrapper.append(newInput);
             wrapper.append(removeButton);

             $('#routeInput').append(wrapper);
         } else {
             alert('최대 9개까지만 추가 가능합니다.');
         }
     }
     
     function routeRemoveField(wrapper) {
         $(wrapper).remove();
         routeFieldCounter--;
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
								class="nav-link active"> <i class="far fa-circle nav-icon"></i>
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
							<li class="nav-item"><a href="../admin_restaurant/admin_restaurant_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin_restaurant/admin_restaurant_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin_restaurant/admin_restaurant_review_list.jsp"
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
							<li class="nav-item"><a href="admin_tourbus_add.jsp" class="nav-link active">
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
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
	<section class="content">
      <div class="container-fluid" style="width: 100%">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">투어버스 추가/수정</h3>
              </div>
              <!-- /.card-header -->
              <form action="admin_tourbus_add_proccess.jsp" method="post" id="infoFrm" enctype="multipart/form-data">
              <div class="card-body">
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td style="border-bottom: 0px">
			<div class="contents" style="margin-top: 20px">
    <div class="upload-box col-md-5">
      <div class="drag-file" id="drop-file">
        <img src="https://img.icons8.com/pastel-glyph/2x/image-file.png" alt="파일 아이콘" class="image" >
        <p class="message">이미지가 없습니다.</p>
        <img src="" id="preview">
      </div>
      <label class="file-label" for="chooseImg">이미지 등록</label>
      <input class="file" id="chooseImg" type="file" name="chooseImg" >
    </div>
  	<div class="contents" style="margin-top: 10px; display: inline-block; width: 80%" id="tagInput">
  	<h3><strong><label>기본정보</label></strong></h3>
  	<hr style="width:90%;">
  	<label style="margin-left: 30px">투어이름</label>
  	<input type="text" class="inputBox" id="name" name="name" style="width: 60%;display: inline-block; margin-left: 70px" placeholder="투어이름을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px; margin-right: 70px">운행시간</label>
  	 <input type="text" id="startDate" name="startTime" placeholder="운행시작 날짜 입력">
    <span style="margin-left: 30px">~</span>
    <input type="text" id="endDate" name="endTime" style="margin-left: 45px " placeholder="운행종료 날짜 입력">
    <br/>
  	<label style="margin-left: 30px; margin-top: 30px">소요시간</label>
  	<input type="text" class="inputBox" id="busTourTime" name="busTourTime" style="width: 60%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="소요시간을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">연락처</label>
  	<input type="text" class="inputBox" id="tel" name="tel" style="width: 60%;display: inline-block; margin-left: 85px; margin-top: 30px" placeholder="연락처를 입력해주세요."><br/>
  	</div>
  </div>
			</td>
            </tr>
            <tr>
            <td style="border-top: 0px;"><h3><strong><label>이용요금</label></strong></h3>
            </td>
            </tr>
            <tr>
            <td style="border-bottom: 0px;">
            <div class="contents col-md-5" style="margin-top: 10px; display: inline-block;margin-bottom: 60px">
  	<label style="margin-left: 30px">성인</label>
  	<input type="text" class="inputBox" id="adultFare" name="adultFare" style="width: 60%;display: inline-block; margin-left: 140px" placeholder="내용을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">소인 및 청소년</label>
  	<input type="text" class="inputBox" id="childFare" name="childFare" style="width: 60%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="내용을 입력해주세요."><br/>
  		</div>
            </td>
            </tr>
            <tr>
            <td style="border-top: 0px;"><h3><strong><label style="float: left;vertical-align: bottom; margin-top: 5px; margin-right: 20px">운행정보</label></strong></h3>
            </td>
            </tr>
            <tr>
            <td style="border-bottom: 0px;">
            <div class="contents" style="margin-top: 20px">
            <div class="contents col-md-5" style="margin-top: 10px; display: inline-block; width: 60%;" id="dispatchInput">
            <label style="margin-left: 30px; float: left">배차시간</label>
  			<a href="#void" id="dispatchAdd-btn" onclick="dispatchAdd()">+</a>
            </div>
            <div class="contents" style="margin-top: 10px; display: inline-block; width: 60%;" id="routeInput">
  			<label style="margin-left: 30px; float: left">운행노선</label>
  			<a href="#void" id="routeAdd-btn" onclick="routeAdd()" >+</a>
            </div>
            </div>
            </td>
            </tr>
            </tbody>
            </table>
            <div class="row" style="margin-top: 20px; text-align: right;">
            <div>
            <input type="button" value="등록/수정" class="btn btn-warning" id="complete" style="width: 1570px; display: inline-block;" >
            </div>
            </div>
            </div>
            </form>
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