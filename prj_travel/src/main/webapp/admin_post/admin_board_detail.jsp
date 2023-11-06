<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.CommentPageDAO"%>
<%@page import="admin.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@page import="admin.vo.PostVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${ empty admin }">
<c:redirect url="../admin/admin_login.jsp"/>
</c:if>   
<%
CommentPageDAO cpDAO = CommentPageDAO.getInstance();
PageVO pVO = new PageVO();

String postId = request.getParameter("postId");
//System.out.println("postId = " + postId);
// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = cpDAO.commentTotalCount(postId);

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 5;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");
//System.out.println("currentPage = " + tempPage);
int currentPage = 1;
if(tempPage != null){
	currentPage = Integer.parseInt(tempPage);
}

int startNum = currentPage * pageScale - pageScale + 1;
int endNum = startNum + pageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int pageNumber=5;

// 시작페이지 번호
int startPage=((currentPage-1)/pageNumber)*pageNumber+1;

// 끝페이지 번호
int endPage=(((startPage-1)+pageNumber)/pageNumber)*pageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( totalPage <= endPage){
	endPage=totalPage;
 }//end if

int movePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
pVO.setStartNum(startNum);
pVO.setEndNum(endNum);

pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);
pageContext.setAttribute("movePage", movePage);
pageContext.setAttribute("postId", postId);

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
#icon{
	font-size : 3em;
}
#icon2{
	font-size : 2em;
}

#answer{
	width : 900px;
	height : 250px;
}
#cursor-position {
  position: absolute;
  padding: 5px;
  background-color: #ffcc00;
  border: 1px solid #333;
}
#btn {
 position: absolute;    
 right: 450px;
 bottom: 150px;
}



</style>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#list").click(function() {
			location.href = "admin_board_list.jsp";
		});
		
		$("#boardDelete").click(function() {
			deleteBoard();
		});
		
		$("#logout").click(function() {
			location.href = "../admin/admin_logout.jsp";
		});//click    
	})//ready
	
	function commentDelete(id){
		 if (confirm("댓글을 삭제 하시겠습니까?")) {
		    	$("#commentId").val(id);
		    	$("#postId").val(${ param.postId });
		    	 $("#DelFrm").submit();
		     } else {
		    	return;
		     }
	}
	
	 function deleteBoard() {
		    if (confirm("게시물을 삭제 하시겠습니까?")) {
		    	$("#postId").val(${ param.postId });
		    	 $("#DelFrm").submit();
		     } else {
		    	return;
		     }
		 }
	 function commentList(num){
			 $("#postId").val(${ param.postId });
			 
			$.ajax({
				url: "admin_board_comment.jsp",
				type: "get",
				data: { currentPage: num, postId : $("#postId").val() },
				dataType: "json",
				error: function(xhr) {
					console.log(xhr.status);
				},
				success: function(json) {
					
					$("#commentOutput").empty();
					var output = "";
					$.each(json.jsonArr, function(i, data) {
						output += "<div class='row'>";
						output += "<div class='col-md-1' style='text-align: center; margin-right: 20px'>";
			             output +=  "<i class='bi bi-person-circle' id='icon2'></i>";
			              output += "<h6><label style='margin: 0'>" + data.userId + "</label></h6>";
			              output += "<h6><label style='margin: 0'>" + data.commentDate + "</label></h6>";
			              output += "</div>";
			              output += "<div class='col-md-9' style='float: left; white-space: normal; margin-left: 20px; margin-top: 5px'>";
			              output += data.content;
			              output += "</div>"
			          output += "<input type='button' value='삭제' class='btn btn-outline-info' onclick=\"commentDelete('" + data.commentId + "')\" style='width: 80px; height: 50px; float: left; margin-top: 20px; margin-left: 30px;'>";
			              output += "</div>";
						});
						 $("#commentOutput").html(output); 
					
					 $("#commentPageOutput").empty();
					 var pageOutput ="";
					 if(json.currentPage > json.pageNumber){
						 json.movePage = json.startPage-1;
						 
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>&laquo;</a></li>";
	    
					 }else{
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&laquo;</a></li>"; 
					 }
					 
					 json.movePage = json.startPage;
					 while(json.movePage <= json.endPage){
						 if(json.movePage == json.currentPage){
							 pageOutput += "<li class='page-item active'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>" + json.movePage + "</a></li>";
			                  
						 }else{
							 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>" + json.movePage + "</a></li>";
			                  
						 }
						 json.movePage++;
						 
					 }
					 
					 if(json.totalPage > json.endPage ){
						 json.movePage = json.endPage+1;
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>&raquo;</a></li>";
						 
					 }else{
						 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&raquo;</a></li>";
					 }
					 
					 $("#commentPageOutput").html(pageOutput);
					 
				}
			});//ajax
			
		}//commentList
	 
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
      <div class="container-fluid" style="width: 80%">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">자유게시판 관리</h3>
              </div>
<%
	PostManageDAO pmDAO = PostManageDAO.getInstance();
	
	try{
		
		PostVO postVO = pmDAO.selectPost(postId);
		
		pageContext.setAttribute("postVO", postVO);
		
	}catch(SQLException se){
		se.printStackTrace();
	}
%>
              <!-- <form action="admin_board_delete_proccess.jsp" id ="postDelFrm" method="post">
 				<input type="hidden" id="postId" name="postId"/>           
              </form> -->
            
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td>
			<div style="margin-left: 100px">
			<div class="row">
              <div class="col-md-1" style="text-align: center">
              <i class="bi bi-person-circle" id="icon"></i>
              <h5><label style="margin: 0">${ postVO.userId }</label></h5>
              <h6><label style="margin: 0">${ postVO.postDate }</label></h6>
              </div>
              <div class="col-md-6" style="margin-top: 20px; margin-left:50px; display: inline-block; float: left">
              <h3><label>${ postVO.postTitle }</label></h3>
              <h3><label>[${ postVO.postCategory }]</label></h3>
              </div>
              </div>
              <div class="row">
              <div class="col-md-11" style="float: left; white-space: normal; vertical-align: middle;">
              ${ postVO.postContent }
              </div>
              </div>
             </div>
			</td>
            </tr>
            <tr>
            <td style="border-bottom: 0px"><h3>댓글</h3></td>
            </tr>
<%
try{
	
	List<CommentVO> list = cpDAO.selectComment(pVO, postId);
	
	pageContext.setAttribute("commentList", list);
	
}catch(SQLException se){
	se.printStackTrace();
} 
%>
            <tr>
            <td>
            <div>
            <form action="admin_board_delete_proccess.jsp" id ="DelFrm" method="post">
 				<input type="hidden" id="commentId" name="commentId"/>           
 				<input type="hidden" id="postId" name="postId"/>           
              </form>
            <c:forEach var="commentList" items="${ commentList }" varStatus="i">
            <div style="margin-left: 100px; margin-top: 20px" id="commentOutput">
              <div class="row">
              <div class="col-md-1" style="text-align: center; margin-right: 20px">
              <i class="bi bi-person-circle" id="icon2"></i>
              <h6><label style="margin: 0">${ commentList.userId }</label></h6>
              <h6><label style="margin: 0">${ commentList.registrationDate }</label></h6>
              </div>
              <div class="col-md-9" style="float: left; white-space: normal; margin-left: 20px; margin-top: 5px">
              ${ commentList.content }
              </div>
	            <input type="button" value="삭제" class="btn btn-outline-info" onclick="commentDelete('${ commentList.commentId }')" style="width: 80px; height:50px; float: left;margin-top:20px; margin-left: 30px" >
              </div>
            </div>
            </c:forEach>
            </div>
            </td>
            </tr>
            </tbody>
            </table>
            <div>
               <ul class="pagination justify-content-center" id="commentPageOutput" style="margin-top: 30px" >
                <%
                if( currentPage > pageNumber ){
                	movePage=startPage-1;
				%>                    
                  <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">&laquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" >&laquo;</a></li>
                <%
                    }
                %>

                  <%
                  movePage=startPage;
                  while( movePage <= endPage ){
                	  if( movePage == currentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
                  %>
                	         
                  <li class="page-item active"><a class="page-link" href="#" onclick="commentList('<%= movePage %>')"><%= movePage %></a></li>
                  <%
                	  }else{
                  %>
                  <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">
                  <%= movePage %></a></li>
                 
                 <%
                 } 
                 movePage++;
                  }
                 %>
                  
                 <%
                if( totalPage > endPage ){
                	movePage = endPage +1;
				%>                    
                   <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">&raquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" >&raquo;</a></li>
                <%
                    }
                %>
                </ul>
                </div>
            <div class="row" style="margin-top: 20px">
            <div class="col-md-1">
            <input type="button" value="목록" class="btn btn-outline-warning" id="list" style="width: 150px;" >
            </div>
            <div class="col-md-11" style="float: left; text-align: right; "> 
            <input type="button" value="삭제" class="btn btn-outline-danger" id="boardDelete" style="width: 150px;" >
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