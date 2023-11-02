<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.UserCommentPageDAO"%>
<%@page import="admin.vo.UserCommentVO"%>
<%@page import="admin.dao.UserManageDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${ empty admin }">
<c:redirect url="../admin/admin_login.jsp"/>
</c:if>
<%
UserCommentPageDAO ucpDAO = UserCommentPageDAO.getInstance();
PageVO pVO = new PageVO();

String field=request.getParameter("field");
String keyword=request.getParameter("keyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
pVO.setField(request.getParameter("field"));
pVO.setKeyword(request.getParameter("keyword"));



// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = ucpDAO.userCommentTotalCount(pVO, request.getParameter("id"));

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 10;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");
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

%>   
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
		

		    $("#close-modal").on("click", function(e) {
		        e.preventDefault();
		        $("#modal1").hide();
		    });
		    
		    $("#search").click(function() {
				chkNull();
				$("#frmSearch").submit();
			});//click
			
			$("#keyword").keyup(function(evt) {// keydown은 값을 받을 수 없다. 값을 받으려면 keyup을 사용
				if(evt.which == 13){
					chkNull();
				}//end if
			});//keyup
		
	})//ready

	function chkNull() {
		var keyword = $("#keyword").val();
		
		if(keyword.trim()==""){
			alert("검색 키워드를 입력해주세요.");
			return;
		}//end if
	}//chkNull
	
	function commentDetail(id) {
	    $.ajax({
	        url: "admin_user_comment_modal.jsp",
	        type: "get",
	        data: { commentId : id },
	        dataType: "json",
	        error: function(xhr) {
	            console.log(xhr.status);
	        },
	        success: function(data) {
	            var output = "<div class='col-md-2' style='margin-left: 70px; float: left; text-align: center;'>";
	            output += "<i class='bi bi-person-circle' id='icon'></i>";
	            output += "<h6><label style='margin: 0;'>" + data.name + "</label></h6>";
	            output += "<h6><label style='margin: 0;'>" + data.date + "</label></h6>";
	            output += "</div>";
	            output += "<div class='col-md-9' style='display: inline-block; float: left; white-space: normal;'>";
	            output += "<div class='comment-container' style='max-height: 150px; overflow: auto;'>";
	            output += "<p>" + data.content + "</p>"; // 데이터의 내용을 여기에 추가
	            output += "</div>";
	            output += "</div>";

	            $("#modal1 #output").html(output); // 모달 내부의 특정 요소에 새로운 내용을 설정

	            $("#modal1").show();
	        }
	    });//ajax
	}//commentDetail
	
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

					<li class="nav-item"><a href="admin_user.jsp" class="nav-link active">
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
<%
UserManageDAO umDAO = UserManageDAO.getInstance();
try{
	String id = request.getParameter("id");
	List<UserCommentVO> userAllCommentList = ucpDAO.selectUserCommnet(pVO, id);
	System.out.println(userAllCommentList);
		for(int i = 0; i < userAllCommentList.size(); i++ ){
    		  if(userAllCommentList.get(i).getUserId().equals(request.getParameter("id"))){
%>
                <h3 class="card-title"><%=userAllCommentList.get(i).getUserName()%>님의 작성 댓글</h3>
<% 
					break;
    		  }
		}
}catch(SQLException se){
	se.printStackTrace();
}
%>
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
<%
String id = request.getParameter("id");
System.out.println("id = " + id);

try{
List<UserCommentVO> userCommentList = ucpDAO.selectUserCommnet(pVO, id);
System.out.println(pVO.toString());
for(int i = 0; i < userCommentList.size(); i++ ){
  	if(userCommentList.get(i).getContent() != null){
%>
      <tr>
        <td><%= i+1 %></td>
        <td class="modal-trigger" >
        <a href="#void" onclick="commentDetail('<%=userCommentList.get(i).getCommentId() %>')"><%= userCommentList.get(i).getContent() %></a></td>
        <td><%= userCommentList.get(i).getRegistrationDate() %></td>
      </tr>
<%
  	}
if(userCommentList.get(i).getContent() == null){
%>  

    <tr>
      <td colspan="3">작성하신 댓글이 없습니다.</td>
    </tr>
    
<%
}
}
}catch(SQLException se){
	se.printStackTrace();
}
%>              
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              <div style="float: right; text-align: right;">
                <button type="submit" class="btn btn-primary" id="btn" style="width: 100px" >목록</button>
                </div>
                <ul class="pagination justify-content-center" >
                   <%
                if( currentPage > pageNumber ){
                	movePage=startPage-1;
				%>                    
                  <li class="page-item"><a class="page-link" href="admin_user_comment.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">&laquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                <%
                    }
                %>

                  <%
                  movePage=startPage;
                  while( movePage <= endPage ){
                	  if( movePage == currentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
                  %>
                	         
                  <li class="page-item active"><a class="page-link" href="#"><%= movePage %></a></li>
                  <%
                	  }else{
                  %>
                  <li class="page-item"><a class="page-link" href = "admin_user_comment.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">
                  <%= movePage %></a></li>
                 
                 <%
                 } 
                 movePage++;
                  }
                 %>
                  
                 <%
                if( totalPage > endPage ){
				%>                    
                  <li class="page-item"><a class="page-link" href="admin_user_comment.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">&raquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                <%
                    }
                %>
                </ul>
                <div style="text-align: center" >
                <form name = "frmSearch" id="frmSearch" action="admin_user_comment.jsp" method="get">
                <input type='hidden' id="id" name="id" value="<%= request.getParameter("id")%>"/>
                <select name="field" class="inputBox" style="height: 30px;">
					<option value="1"${ param.field eq '1'?"selected = 'selected'":"" }>내용</option>
				</select>
                <input type="text" name="keyword" id="keyword" class="inputBox" value ="${ param.keyword ne 'null'? parma.keyword:'' }" style="width: 200px; height: 30px;" placeholder="내용을 입력해주세요."/>
                <input type="text" style="display: none;">
                <div style="display: inline-block;" >
                <input type="button" id="search" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
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

       

        <div id="modal1" class="modal" style="display: none; position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 20px;max-width: 80%; width: 1000px; height: 250px; 
    z-index: 1000; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 10px;">
		 <div class="row" id="output">
              <%-- <div class="col-md-2" style="margin-left: 70px; float: left; text-align: center;">
              <i class="bi bi-person-circle" id="icon"></i>
              <h6><label style="margin: 0;">${ ucVO.userName }</label></h6>
              <h6><label style="margin: 0;">${ ucVO.registrationDate }</label></h6>
              </div>
              <div class="col-md-9" style="display: inline-block; float: left; white-space: normal;">
            <div class="comment-container" style="max-height: 150px; overflow: auto;">
                <p id="modal-content"></p>
              </div>
              </div> --%>
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

</body>
</html>	