<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 | 관광지 관리</title>
<link rel="stylesheet" type="text/css"
	href="http://localhost/html_prj/common/css/main_v20230906">
 
<style type="text/css">
#tagAdd-btn {
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
            margin-top: 22px;
            margin-bottom : 150px;
            float: left;
        }
#conAdd-btn {
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
            margin-bottom : 150px;
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
  height: 380px;
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
#preview{
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

</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qo9b067gph&submodules=geocoder"></script>
<script type="text/javascript">
	$(function() {
		
		$('#summernote').summernote({
			 height: 350,                 // 에디터 높이
			  minHeight: 100,             // 최소 높이
			  maxHeight: 350,             // 최대 높이
			  lang: "ko-KR"					// 한글 설정
		 });
		
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
		 
		 // 폼 submit
		 $("#complete").click(function() {
			$("#infoFrm").submit();
		});//click
		 
		 $("#cancel").click(function() {
			location.href = "admin_tourarea_list.jsp";
		});
		
		 $("#logout").click(function() {
				location.href = "../admin/admin_logout.jsp";
			});//click 
		
		 	
	});//ready
	
	 let tagFieldCounter = 0;
     const tagMaxFields = 3;
     

     function tagRemoveField(wrapper) {
         $(wrapper).remove();
         tagFieldCounter--;
     }
   
     function tagAdd() {
         if (tagFieldCounter < tagMaxFields) {
        	 tagFieldCounter++;
             let wrapper = $('<div class="input-wrapper" style="margin-left:180px; margin-top:20px;"></div>');

             let newInput = $('<input type="text" style = "margin-right:60px; width: 56%" placeholder="태그를 입력해주세요." class="tag" name="tagName">');
             let removeButton = $('<button class="remove-btn" onclick="tagRemoveField(this.parentNode)">&times</button>');

             wrapper.append(newInput);
             wrapper.append(removeButton);

             $('#tagInput').append(wrapper);
         } else {
             alert('최대 3개까지만 추가 가능합니다.');
         }
     }
     
     let conFieldCounter = 0;
     const conMaxFields = 3;
     
     function conAdd() {
         if (conFieldCounter < conMaxFields) {
        	 conFieldCounter++;
             let wrapper = $('<div class="input-wrapper" style="margin-left:250px;"></div>');

             let newInput = $('<input type="text" style = "margin-right:60px; width: 60%; margin-bottom: 30px" placeholder="편의시설을 입력해주세요." class="con" name="convevienceName">');
             let removeButton = $('<button class="remove-btn" onclick="conRemoveField(this.parentNode)">&times</button>');

             wrapper.append(newInput);
             wrapper.append(removeButton);

             $('#convenienceInput').append(wrapper);
         } else {
             alert('최대 3개까지만 추가 가능합니다.');
         }
     }
     
     function conRemoveField(wrapper) {
         $(wrapper).remove();
         conFieldCounter--;
     }
     
    
     function convertAddressToCoordinates() {
    	    const address = document.getElementById('addr').value;

    	    // 네이버 Geocoding API 요청
    	    naver.maps.Service.geocode({
    	        query: address
    	    }, function(status, response) {
    	        if (status === naver.maps.Service.Status.ERROR) {
    	            alert('주소를 변환하는 중 문제가 발생했습니다.');
    	        } else {
    	            const item = response.v2.meta.totalCount > 0 ? response.v2.addresses[0] : null;
    	            alert(response.v2.addresses[0].x);
    	            if (item) {
    	                document.getElementById('latitude').value = item.y;
    	                document.getElementById('longitude').value = item.x;
    	            } else {
    	                alert('해당 주소에 대한 좌표를 찾을 수 없습니다.');
    	            }
    	        }
    	    });
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

					<li class="nav-item menu"><a href="#" class="nav-link active"> <i
							class="bi bi-map"></i> <i class="right fas fa-angle-left"></i>
							<p>관광지 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_tourarea/admin_tourarea_list.jsp" class="nav-link active">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 목록</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourarea_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 추가</p>
							</a></li>
							<li class="nav-item"><a href="admin_tourarea_review_list.jsp"
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
									<p>맛집 목록</p>
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

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-bus-front"></i> <i class="right fas fa-angle-left"></i>
							<p>투어버스 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="../admin_tourbus/admin_tourbus_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 목록</p>
							</a></li>
							<li class="nav-item"><a href="../admin_tourbus/admin_tourbus_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>투어버스 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin_tourbus/admin_tourbus_reservation_list.jsp"
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
							<h1 class="m-0">관광지 관리</h1>
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
                <h3 class="card-title">관광지 추가/수정</h3>
              </div>
              <!-- /.card-header -->
              <form action="admin_tourarea_add_proccess.jsp" method="post" id="infoFrm" enctype="multipart/form-data">
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
  	<label style="margin-left: 30px">이름</label>
  	<input type="text" class="inputBox" id="name" name="name" style="width: 60%;display: inline-block; margin-left: 70px" placeholder="이름을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">주소</label>
  	<input type="text" class="inputBox" id="addr" name="addr" style="width: 60%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="주소를 입력해주세요.">
  	<input type="button" class="btn btn-success" value="확인" id="addrBtn" onclick="convertAddressToCoordinates()" style="margin-left: 30px"><br/>
  	<label style="margin-left: 30px; margin-top: 30px">위도</label>
  	<input type="text" class="inputBox" id="latitude" name="latitude" style="width: 22%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="위도를 입력해주세요.">
  	<label style="margin-left: 72px; margin-top: 30px">경도</label>
  	<input type="text" class="inputBox" id="longitude" name="longitude" style="width: 22%;display: inline-block; margin-left: 30px; margin-top: 30px" placeholder="경도를 입력해주세요."><br/>
  	<label style="margin-left: 30px;">연락처</label>
  	<input type="text" class="inputBox" id="tel" name="tel" style="width: 60%;display: inline-block; margin-left: 55px; margin-top: 30px" placeholder="연락처를 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-right: 20px; margin-top:22px; float: left;">#tag</label>
  	<a href="#void" id="tagAdd-btn" onclick="tagAdd()">+</a>
  	</div>
  </div>
			</td>
            </tr>
            <tr>
            <td style="border-top: 0px;"><h3><strong><label>이용안내</label></strong></h3></td>
            </tr>
            <tr>
            <td style="border-bottom: 0px;">
            <div class="contents" style="margin-top: 20px">
            <div class="contents col-md-5" style="margin-top: 10px; display: inline-block;">
  	<label style="margin-left: 30px">이용시간</label>
  	<input type="text" class="inputBox" id="serviceHour" name="serviceHour" style="width: 60%;display: inline-block; margin-left: 70px" placeholder="이용시간을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">요금정보</label>
  	<input type="text" class="inputBox" id="priceInfo" name="priceInfo" style="width: 60%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="내용을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">경사도(난이도)</label>
  	<select id="slope" name= "slope" class="form-select" aria-label="Default select example" style="display: inline-block; width: 40%; margin-left: 27px; margin-bottom: 150px">
  		<option selected>난이도를 선택해주세요.</option>
  		<option value="상">상</option>
 		<option value="중">중</option>
  		<option value="하">하</option>
	</select> 
  		</div>
  		<div class="contents" style="margin-top: 10px; display: inline-block; width: 60%;" id="convenienceInput">
  		<label style="margin-left: 30px; float: left">편의시설</label>
  		<a href="#void" id="conAdd-btn" onclick="conAdd()" >+</a>
  		</div>
  		</div>
            </td>
            </tr>
             <tr>
            <td style="border-top: 0px;"><h3><strong><label>상세정보</label></strong></h3></td>
            </tr>
            <tr>
            <td>
            <textarea id="summernote" name="detailInfo"></textarea>
            </td>
            </tr>
            </tbody>
            </table>
            <div class="row" style="margin-top: 20px; text-align: right;">
            <div>
            <input type="button" value="취소" class="btn btn-secondary" id="cancel" style="margin-right: 30px; width: 150px;" >
            <input type="button" value="등록/수정" class="btn btn-warning" id="complete" style="width: 150px; display: inline-block;" >
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