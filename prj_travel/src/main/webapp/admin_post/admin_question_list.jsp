<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.QuestionPageDAO"%>
<%@page import="admin.vo.QandAVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.QAndAManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${ empty admin }">
<c:redirect url="../admin/admin_login.jsp"/>
</c:if>
<%
QuestionPageDAO qpDAO = QuestionPageDAO.getInstance();
PageVO resVO = new PageVO();

String resField=request.getParameter("resField");
String resKeyword=request.getParameter("resKeyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
resVO.setField(request.getParameter("resField"));
resVO.setKeyword(request.getParameter("resKeyword"));
System.out.println(resKeyword);



// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int resTotalCount = qpDAO.restaurantQnaTotalCount(resVO);

// 2. 한 화면에 보여줄 게시물의 수
int resPageScale =5;

// 3. 총 페이지 수
int resTotalPage = 0;

resTotalPage = (int)Math.ceil(resTotalCount/(double)resPageScale);


// 현재 페이지의 시작번호 구하기
String  resTempPage = request.getParameter("resCurrentPage");
int resCurrentPage = 1;
if(resTempPage != null){
	resCurrentPage = Integer.parseInt(resTempPage);
}

int resStartNum = resCurrentPage * resPageScale - resPageScale + 1;
int resEndNum = resStartNum + resPageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int resPageNumber=5;

// 시작페이지 번호
int resStartPage=((resCurrentPage-1)/resPageNumber)*resPageNumber+1;

// 끝페이지 번호
int resEndPage=(((resStartPage-1)+resPageNumber)/resPageNumber)*resPageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( resTotalPage <= resEndPage){
	resEndPage=resTotalPage;
 }//end if

int resMovePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
resVO.setStartNum(resStartNum);
resVO.setEndNum(resEndNum);

pageContext.setAttribute("resMovePage", resMovePage);
pageContext.setAttribute("resField", resField);
pageContext.setAttribute("resKeyword", resKeyword);
pageContext.setAttribute("resCurrentPage", resTempPage);

%>
<%
PageVO tourVO = new PageVO();
String tourField=request.getParameter("tourField");
String tourKeyword=request.getParameter("tourKeyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
tourVO.setField(request.getParameter("tourField"));
tourVO.setKeyword(request.getParameter("tourKeyword"));


// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int tourTotalCount = qpDAO.touristQnaTotalCount(tourVO);
System.out.println("/" + tourTotalCount);

// 2. 한 화면에 보여줄 게시물의 수
int tourPageScale = 5;

// 3. 총 페이지 수
int tourTotalPage = 0;

tourTotalPage = (int)Math.ceil(tourTotalCount/(double)tourPageScale);


// 현재 페이지의 시작번호 구하기
String  tourTempPage = request.getParameter("tourCurrentPage");
int tourCurrentPage = 1;

if(tourTempPage != null){
	tourCurrentPage = Integer.parseInt(tourTempPage);
}

int tourStartNum = tourCurrentPage * tourPageScale - tourPageScale + 1;
int tourEndNum = tourStartNum + tourPageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int tourPageNumber=5;

// 시작페이지 번호
int tourStartPage=((tourCurrentPage-1)/tourPageNumber)*tourPageNumber+1;

// 끝페이지 번호
int tourEndPage=(((tourStartPage-1)+tourPageNumber)/tourPageNumber)*tourPageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( tourTotalPage <= tourEndPage){
	tourEndPage=tourTotalPage;
 }//end if

int tourMovePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
tourVO.setStartNum(tourStartNum);
tourVO.setEndNum(tourEndNum);

pageContext.setAttribute("tourStartNum", tourStartNum);
pageContext.setAttribute("tourEndNum", tourEndNum);
pageContext.setAttribute("tourMovePage", tourMovePage);
pageContext.setAttribute("tourField", tourField);
pageContext.setAttribute("tourKeyword", tourKeyword);
pageContext.setAttribute("tourCurrentPage", tourTempPage);

%>  
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
		$("#logout").click(function() {
			location.href = "../admin/admin_logout.jsp";
		});//click    
		
		var tempResField = "";
		var tempResKeyword = "";
		
			 $("#resSearch").click(function() {
				 tempResField = $("[name='resField'] option:selected").val();
				 tempResKeyword = $("#resKeyword").val();
				resChkNull();
				$.ajax({
					url: "admin_question_restaurant.jsp",
					type: "post",
					data: {resField :tempResField, resKeyword : tempResKeyword},
					dataType: "json",
					error: function(xhr) {
						console.log(xhr.status);
					},
					success: function(jsonObj) {
						$("#resOutput").empty();
						var startNum = $("#resStartNum").val()
						var output = "";
						$.each(jsonObj.jsonArr, function(i, data) {
							
						output += "<tr>";
						output += "<td>" + data.rowNum +"</td>";
						output += "<td>" + data.qnaType + "</td>"
						output += "<td onclick='questionDetail(" + data.qnaId + ")'>" + data.qnaTitle + "</td>";
						output += "<td>" + data.userId + "</td>";
						output += "<td>" + data.qnaDate + "</td>";
							if(data.answerState == 'N'){
								output += "<td>답변 대기</td>";
							}else if(data.answerState == 'Y'){
								output += "<td>답변 대기</td>";
							}
						output += "</tr>";
						});
						 $("#resOutput").html(output); 
					}
				});//ajax
				
			});//click
			
		var tempTourField = "";
		var tempTourKeyword = "";
		
			 $("#tourSearch").click(function() {
				 tempTourField = $("[name='tourField'] option:selected").val();
				 tempTourKeyword = $("#tourKeyword").val();
				tourChkNull();
				$.ajax({
					url: "admin_question_tourist.jsp",
					type: "post",
					data: {tourField :tempTourField, tourKeyword : tempTourKeyword},
					dataType: "json",
					error: function(xhr) {
						console.log(xhr.status);
					},
					success: function(jsonObj) {
						$("#tourOutput").empty();
						var startNum = $("#tourStartNum").val()
						var output = "";
						$.each(jsonObj.jsonArr, function(i, data) {
						output += "<tr>";
						output += "<td>" + data.rowNum +"</td>";
						output += "<td>" + data.qnaType + "</td>"
						output += "<td onclick='questionDetail(" + data.qnaId + ")'>" + data.qnaTitle + "</td>";
						output += "<td>" + data.userId + "</td>";
						output += "<td>" + data.qnaDate + "</td>";
							if(data.answerState == 'N'){
								output += "<td>답변 대기</td>";
							}else if(data.answerState == 'Y'){
								output += "<td>답변 대기</td>";
							}
						output += "</tr>";
						});
						 $("#tourOutput").html(output); 
					}
				});//ajax
				
			});//click
		 
			
			$("#resKeyword").keyup(function(evt) {// keydown은 값을 받을 수 없다. 값을 받으려면 keyup을 사용
				if(evt.which == 13){
					resChkNull();
				}//end if
			});//keyup
			
			$("#tourKeyword").keyup(function(evt) {// keydown은 값을 받을 수 없다. 값을 받으려면 keyup을 사용
				if(evt.which == 13){
					tourChkNull();
				}//end if
			});//keyup
			
			$(".page-link").click(function(evt) {
				 $(evt.target).text();
			})
			
	})//ready
	
	function resChkNull() {
		var keyword = $("#resKeyword").val();
		if(keyword.trim()==""){
			alert("검색 키워드를 입력해주세요.");
			return;
		}//end if
	
	}//chkNull
	function tourChkNull() {
		var keyword = $("#tourKeyword").val();
		
		if(keyword.trim()==""){
			alert("검색 키워드를 입력해주세요.");
			return;
		}//end if
	
	}//chkNull
	
	function questionDetail(id) {
		$("#questionId").val(id);
		$("#questionFrm").submit();
	}
	

	
function restaurantList(num){
		
		$.ajax({
			url: "admin_question_restaurant.jsp",
			type: "get",
			data: {resField : $("[name='resField'] option:selected").val(), resKeyword : $("#resKeyword").val(), resCurrentPage: num },
			dataType: "json",
			error: function(xhr) {
				console.log(xhr.status);
			},
			success: function(json) {
				$("#resOutput").empty();
				var startNum = $("#resStartNum").val()
				var output = "";
				$.each(json.jsonArr, function(i, data) {
				output += "<tr>";
				output += "<td>" + data.rowNum +"</td>";
				output += "<td>" + data.qnaType + "</td>"
				output += "<td onclick='questionDetail(" + data.qnaId + ")'>" + data.qnaTitle + "</td>";
				output += "<td>" + data.userId + "</td>";
				output += "<td>" + data.qnaDate + "</td>";
					if(data.answerState == 'N'){
						output += "<td>답변 대기</td>";
					}else if(data.answerState == 'Y'){
						output += "<td>답변 대기</td>";
					}
				output += "</tr>";
				});
				 $("#resOutput").html(output); 
				
				 $("#resPageOutput").empty();
				 var pageOutput ="";
				 if(json.resCurrentPage > json.resPageNumber){
					 json.resMovePage = json.resStartPage-1;
					 
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>&laquo;</a></li>";
    
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&laquo;</a></li>"; 
				 }
				 
				 json.resMovePage = json.resStartPage;
				 while(json.resMovePage <= json.resEndPage){
					 if(json.resMovePage == json.resCurrentPage){
						 pageOutput += "<li class='page-item active'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>" + json.resMovePage + "</a></li>";
		                  
					 }else{
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>" + json.resMovePage + "</a></li>";
		                  
					 }
					 json.resMovePage++;
					 
				 }
				 
				 if(json.resTotalPage > json.resEndPage ){
					 json.resMovePage = json.resEndPage+1;
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>&raquo;</a></li>";
					 
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&raquo;</a></li>";
				 }
				 
				 $("#resPageOutput").html(pageOutput);
				 
			}
		});//ajax
		
	}//restaurantList
	
function touristList(num){
		
		$.ajax({
			url: "admin_question_tourist.jsp",
			type: "get",
			data: {tourField : $("[name='tourField'] option:selected").val(), tourKeyword : $("#tourKeyword").val(), tourCurrentPage: num },
			dataType: "json",
			error: function(xhr) {
				console.log(xhr.status);
			},
			success: function(json) {
				$("#tourOutput").empty();
				var startNum = $("#tourStartNum").val()
				var output = "";
				$.each(json.jsonArr, function(i, data) {
				output += "<tr>";
				output += "<td>" + data.rowNum +"</td>";
				output += "<td>" + data.qnaType + "</td>"
				output += "<td onclick='questionDetail(" + data.qnaId + ")'>" + data.qnaTitle + "</td>";
				output += "<td>" + data.userId + "</td>";
				output += "<td>" + data.qnaDate + "</td>";
					if(data.answerState == 'N'){
						output += "<td>답변 대기</td>";
					}else if(data.answerState == 'Y'){
						output += "<td>답변 대기</td>";
					}
				output += "</tr>";
				});
				 $("#tourOutput").html(output); 
				
				 $("#tourPageOutput").empty();
				 var pageOutput ="";
				 if(json.tourCurrentPage > json.tourPageNumber){
					 json.tourMovePage = json.tourStartPage-1;
					 
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='touristList(\"" + json.tourMovePage + "\")'>&laquo;</a></li>";
    
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&laquo;</a></li>"; 
				 }
				 
				 json.tourMovePage = json.tourStartPage;
				 while(json.tourMovePage <= json.tourEndPage){
					 if(json.tourMovePage == json.tourCurrentPage){
						 pageOutput += "<li class='page-item active'><a class='page-link' href='#void' onclick='touristList(\"" + json.tourMovePage + "\")'>" + json.tourMovePage + "</a></li>";
		                  
					 }else{
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='touristList(\"" + json.tourMovePage + "\")'>" + json.tourMovePage + "</a></li>";
		                  
					 }
					 json.tourMovePage++;
					 
				 }
				 
				 if(json.tourTotalPage > json.tourEndPage ){
					 json.tourMovePage = json.tourEndPage+1;
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='touristList(\"" + json.tourMovePage + "\")'>&raquo;</a></li>";
					 
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&raquo;</a></li>";
				 }
				 
				 $("#tourPageOutput").html(pageOutput);
				 
			}
		});//ajax
		
	}//restaurantList

	
	
	
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
							<h1 class="m-0">게시판 관리</h1>
						</div>
									<div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="../admin_dashboard/dashboard.jsp">Home</a></li>
              <li class="breadcrumb-item active">문의사항 관리</li>
            </ol>
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
                <h3 class="card-title">맛집 문의사항 관리</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body" style="height: 350px">
<%
	QAndAManageDAO qamDAO = QAndAManageDAO.getInstance();
	try{
		List<QandAVO> list = qpDAO.selectRestaurantQna(resVO);
		System.out.println(list.toString());
		
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
                      <th style="width: 70px">답변상태</th>
                    </tr>
                  </thead>
                  <tbody id = "resOutput">
                  <c:forEach var="restaurantList" items="${restaurantList}" varStatus="i">
				        <tr>
				            <td><c:out value="${resStartNum + i.count }"/></td>
				            <td>${restaurantList.category}</td>
				            <td onclick="questionDetail('${ restaurantList.QAndAId }')">${restaurantList.title}</td>
				            <td>${restaurantList.userId}</td>
				            <td>${restaurantList.registrationDate}</td>
				                <c:if test="${restaurantList.answerType eq 'N'}">
				                    <td>답변 대기</td>
				                 </c:if>
				                <c:if test="${restaurantList.answerType eq 'Y'}">
				                    <td>답변완료</td>
				                 </c:if>
				        </tr>
				</c:forEach> 
                 
                  </tbody>
                </table>
              </div>
<%
}catch(SQLException se){
		se.printStackTrace();
	}
%>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <ul class="pagination justify-content-center" id="resPageOutput" >
                <%
                if( resCurrentPage > resPageNumber ){
                	resMovePage=resStartPage-1;
				%>                    
                  <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">&laquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" )">&laquo;</a></li>
                <%
                    }
                %>

                  <%
                  resMovePage=resStartPage;
                  while( resMovePage <= resEndPage ){
                	  if( resMovePage == resCurrentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
                  %>
                	         
                  <li class="page-item active"><a class="page-link" href="#" onclick="restaurantList('<%= resMovePage %>')"><%= resMovePage %></a></li>
                  <%
                	  }else{
                  %>
                  <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">
                  <%= resMovePage %></a></li>
                 
                 <%
                 } 
                 resMovePage++;
                 System.out.println(resMovePage);
                  }
                 %>
                  
                 <%
                if( resTotalPage > resEndPage ){
                	resMovePage = resEndPage +1;
				%>                    
                   <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">&raquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" >&raquo;</a></li>
                <%
                    }
                %>
                </ul>
                <div style="text-align: center" >
              <form name = "resFrmSearch" id="resFrmSearch" action="admin_question_list.jsp" method="get">
                <select name="resField" class="inputBox" style="height: 30px;">
					<option value="1"${ param.resField eq '1'?"selected = 'selected'":"" }>아이디</option>
					<option value="2"${ param.resField eq '2'?"selected = 'selected'":"" }>제목</option>
					<option value="3"${ param.resField eq '3'?"selected = 'selected'":"" }>내용</option>
				</select>
                <input type="text" name="resKeyword" id="resKeyword" class="inputBox" value ="<%= resKeyword != null ? resKeyword : "" %>" style="width: 200px; height: 30px;" placeholder="내용을 입력해주세요."/>
                <input type="text" style="display: none;"/> 
                <div style="display: inline-block;" > 
                <input type="button" id="resSearch" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
                </div>
              </form>
                </div>
              </div>
            </div>
            <!-- /.card -->
            </div>
            </div>
           </div>
         </section>
         <form action="admin_question_detail_proccess.jsp" method="post" id="questionFrm">
         <input type="hidden" id="questionId" name="questionId"/>
         </form>
         <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">관광지 문의사항 관리</h3>
              </div>
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
                      <th style="width: 70px">답변상태</th>
                    </tr>
                  </thead>
<%
	try{
		List<QandAVO> list = qpDAO.selectTouristQna(tourVO);
		
		pageContext.setAttribute("touristlist", list);
%>                  
                  <tbody id="tourOutput">
                    <c:forEach var="touristList" items="${touristlist}" varStatus="i">
				        <tr>
				            <td>${tourStartNum + i.index}</td>
				            <td>${touristList.category}</td>
				            <td onclick="questionDetail('${ touristList.QAndAId }')">${touristList.title}</td>
				            <td>${touristList.userId}</td>
				            <td>${touristList.registrationDate}</td>
				                <c:if test="${touristList.answerType eq 'N'}">
				                    <td>답변 대기</td>
				                 </c:if>
				                <c:if test="${touristList.answerType eq 'Y'}">
				                    <td>답변완료</td>
				                 </c:if>
				        </tr>
				</c:forEach>
                  </tbody>
                </table>
              </div>
<%              
	}catch(SQLException se){
		se.printStackTrace();
	}
%>             
              <!-- /.card-body -->
             <div class="card-footer clearfix">
                <ul class="pagination justify-content-center" id="tourPageOutput" >
                <%
                if( tourCurrentPage > tourPageNumber ){
                	tourMovePage=tourStartPage-1;
				%>                    
                  <li class="page-item"><a class="page-link" href="#void" onclick="touristList('<%= tourMovePage %>')">&laquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                <%
                    }
                %>

                  <%
                  tourMovePage=tourStartPage;
                  while( tourMovePage <= tourEndPage ){
                	  if( tourMovePage == tourCurrentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
                  %>
                	         
                  <li class="page-item active"><a class="page-link" href="#" onclick="touristList('<%= tourMovePage %>')"><%= tourMovePage %></a></li>
                  <%
                	  }else{
                  %>
                  <li class="page-item"><a class="page-link" href="#void" onclick="touristList('<%= tourMovePage %>')">
                  <%= tourMovePage %></a></li>
                 
                 <%
                 } 
                	  tourMovePage++;
                  }
                 %>
                  
                 <%
                if( tourTotalPage >tourEndPage ){
                	tourMovePage = tourEndPage +1;
				%>                    
                   <li class="page-item"><a class="page-link" href="#void" >&raquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" onclick="touristList('<%= tourMovePage %>')">&raquo;</a></li>
                <%
                    }
                %>
                </ul>
                <div style="text-align: center" >
                <form name = "tourFrmSearch" id="tourFrmSearch" action="admin_question_list.jsp" method="get">
                <select name="tourField" class="inputBox" style="height: 30px;">
					<option value="1"${ param.tourField eq '1'?"selected = 'selected'":"" }>아이디</option>
					<option value="2"${ param.tourField eq '2'?"selected = 'selected'":"" }>제목</option>
					<option value="3"${ param.tourField eq '3'?"selected = 'selected'":"" }>내용</option>
				</select>
                <input type="text" name="tourKeyword" id="tourKeyword" class="inputBox" value ="<%= tourKeyword != null ? tourKeyword : "" %>" style="width: 200px; height: 30px;" placeholder="내용을 입력해주세요."/>
                  <input type="text" style="display: none;"/>
                <div style="display: inline-block;" >
                <input type="button" id="tourSearch" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
                </div>
                </form>
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