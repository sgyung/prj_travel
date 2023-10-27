<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 | 관광지 관리</title>
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
  width: 40px;
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function searchZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("addr").value = roadAddr;
            }
        }).open();
    }
</script>
<script type="text/javascript">
	$(function() {
		$("#btnZipcode").click(function(){
			searchZipcode();
		});
		
		$('#summernote').summernote({
			 height: 350,                 // 에디터 높이
			  minHeight: 100,             // 최소 높이
			  maxHeight: 350,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR"					// 한글 설정
		 });
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

					<li class="nav-item"><a href="admin_user.jsp" class="nav-link">
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
							<li class="nav-item"><a href="admin_question_list.jsp"
								class="nav-link active"> <i class="far fa-circle nav-icon"></i>
									<p>문의사항 관리</p>
							</a></li>
							<li class="nav-item"><a href="admin_board_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>자유게시판 관리</p>
							</a></li>
						</ul></li>

					<li class="nav-item menu"><a href="admin_tourarea_list" class="nav-link active"> <i
							class="bi bi-map"></i> <i class="right fas fa-angle-left"></i>
							<p>관광지 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_tourarea_add" class="nav-link active">
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
              <div class="card-body">
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td style="border-bottom: 0px">
			<div class="contents" style="margin-top: 20px">
    <div class="upload-box col-md-5">
      <div id="drop-file" class="drag-file">
        <img src="https://img.icons8.com/pastel-glyph/2x/image-file.png" alt="파일 아이콘" class="image" >
        <p class="message">Drag files to upload</p>
        <img src="" alt="미리보기 이미지" class="preview">
      </div>
      <label class="file-label" for="chooseFile">이미지 등록</label>
      <input class="file" id="chooseFile" type="file" onchange="dropFile.handleFiles(this.files)" accept="image/png, image/jpeg, image/gif">
    </div>
  	<div class="contents col-md-11" style="margin-top: 10px; display: inline-block;">
  	<h3><strong><label>기본정보</label></strong></h3>
  	<hr style="width:62%;">
  	<label style="margin-left: 30px">이름</label>
  	<input type="text" class="inputBox" id="name" name="name" style="width: 40%;display: inline-block; margin-left: 70px" placeholder="이름을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">주소</label>
  	<input type="text" class="inputBox" id="addr" name="addr" style="width: 40%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="주소를 입력해주세요.">
  	<input type="button" value="주소검색" class="btn btn-info" id="btnZipcode" style="display: inline-block; margin-left: 20px; height: 35px"/><br/>
  	<label style="margin-left: 30px; margin-top: 30px">위도</label>
  	<input type="text" class="inputBox" id="addr" name="addr" style="width: 15%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="위도를 입력해주세요.">
  	<label style="margin-left: 72px; margin-top: 30px">경도</label>
  	<input type="text" class="inputBox" id="addr" name="addr" style="width: 15%;display: inline-block; margin-left: 30px; margin-top: 30px" placeholder="경도를 입력해주세요."><br/>
  	<label style="margin-left: 30px;">연락처</label>
  	<input type="text" class="inputBox" id="tel" name="tel" style="width: 40%;display: inline-block; margin-left: 55px; margin-top: 30px" placeholder="연락처를 입력해주세요."><br/>
  	<label style="margin-left: 30px;">#tag</label>
  	<input type="text" class="inputBox" id="tel" name="tel" style="width: 40%;display: inline-block; margin-left: 72px; margin-top: 30px" placeholder="Tag를 입력해주세요."><br/>
  	</div>
  </div>
			</td>
            </tr>
            <tr>
            <td style="border-top: 0px;"><h3><strong><label>이용안내</label></strong></h3></td>
            </tr>
            <tr>
            <td style="border-bottom: 0px;">
            <div class="contents col-md-5" style="margin-top: 10px; display: inline-block;">
  	<label style="margin-left: 30px">이용시간</label>
  	<input type="text" class="inputBox" id="name" name="name" style="width: 60%;display: inline-block; margin-left: 70px" placeholder="이용시간을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">요금정보</label>
  	<input type="text" class="inputBox" id="addr" name="addr" style="width: 60%;display: inline-block; margin-left: 70px; margin-top: 30px" placeholder="내용을 입력해주세요."><br/>
  	<label style="margin-left: 30px; margin-top: 30px">경사도(난이도)</label>
  	<select class="form-select" aria-label="Default select example" style="display: inline-block; width: 40%; margin-left: 27px; margin-bottom: 150px">
  		<option selected>난이도를 선택해주세요.</option>
  		<option value="상">상</option>
 		<option value="중">중</option>
  		<option value="하">하</option>
	</select> 
  		</div>
            </td>
            </tr>
             <tr>
            <td style="border-top: 0px;"><h3><strong><label>상세정보</label></strong></h3></td>
            </tr>
            <tr>
            <td>
            <textarea id="summernote" ></textarea>
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