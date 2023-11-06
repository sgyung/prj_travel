<%@page import="admin.vo.RestaurantVO"%>
<%@page import="admin.dao.RestaurantManageDAO"%>
<%@page import="admin.vo.TouristAreaVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.dao.TouristAreaManageDAO"%>
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
<link rel="stylesheet" type="text/css" href="http://localhost/prj_travel/common/CSS/ta_detail.css">
 
<style type="text/css">



</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#logout").click(function() {
		location.href = "../admin/admin_logout.jsp";
	});//click    
	
	
	
})//ready

function restaurantDelete(id){
	 if (confirm("맛집을 삭제 하시겠습니까?")) {
	    	$("#restaurantId").val(id);
	    	 $("#DelFrm").submit();
	     } else {
	    	return;
	     }
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

					<li class="nav-item menu"><a href="#" class="nav-link"> <i
							class="bi bi-map"></i> <i class="right fas fa-angle-left"></i>
							<p>관광지 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="../admin-tourarea/admin_tourarea_list.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 목록</p>
							</a></li>
							<li class="nav-item"><a href="../admin-tourarea/admin_tourarea_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>관광지 추가</p>
							</a></li>
							<li class="nav-item"><a href="../admin-tourarea/admin_tourarea_review_list.jsp"
								class="nav-link"> <i class="far fa-circle nav-icon"></i>
									<p>관광지 리뷰 관리</p>
							</a></li>
						</ul></li>
						
					<li class="nav-item menu"><a href="#" class="nav-link active"> <i
							class="bi bi-tencent-qq"></i> <i class="right fas fa-angle-left"></i>
							<p>맛집 관리</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item"><a href="admin_restaurant_list.jsp" class="nav-link active">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 목록</p>
							</a></li>
							<li class="nav-item"><a href="admin_restaurant_add.jsp" class="nav-link">
									<i class="far fa-circle nav-icon"></i>
									<p>맛집 추가</p>
							</a></li>
							<li class="nav-item"><a href="admin_restaurant_review_list.jsp"
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
									<p>투어버스 목록</p>
							</a></li>
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
		<div class="content-wrapper" style="background-color: #fff" >
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
<%
	RestaurantManageDAO rmDAO = RestaurantManageDAO.getInstance();
	String restaurantId = request.getParameter("restaurantId");
	
	try{
		if(restaurantId != null){
			RestaurantVO rVO = rmDAO.selectRestaurant(restaurantId);
			
			String[] tagArr = null;
			String[] reTagArr = null;
			if( rVO.getTags() != null ){
				tagArr = rVO.getTags().split(" ");
				reTagArr = new String[tagArr.length];
				for( int i = 0; i< tagArr.length; i++ ){
					reTagArr[i] = tagArr[i].replace("#", "");
				}
			}//end if
			
			pageContext.setAttribute("rVO", rVO);
			pageContext.setAttribute("tags", reTagArr);
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
%>			
	<section class="content">
	<form action="admin_restaurant_delete_proccess.jsp" id ="DelFrm" method="post">
 			<input type="hidden" id="restaurantId" name="restaurantId"/>
            </form>
            <div class="sub_visual_wrap" style="background: url('${rVO.image }') 30% 30% / cover no-repeat;" data-v-09a75c9f=""><div class="inner_wrap" data-v-09a75c9f=""><div data-v-09a75c9f=""></div>
					<div class="sub_info_area" data-v-09a75c9f="">
					<div class="sub_info_title" data-v-09a75c9f="">
					<h3 data-v-09a75c9f="" class="">${ taVO.name }</h3>
					<p class="h3_sub" style="margin-top:0" data-v-09a75c9f=""></p>
					<!---->
				</div>
				<div class="score_area_l" data-v-09a75c9f="">
					<p class="score_count_l" style="width:100%;" data-v-09a75c9f=""></p>
				</div>
				<div class="tag_area" data-v-09a75c9f="">
					<p class="best_tag" data-v-09a75c9f="">
						<c:forEach var="tag" items="${ tags }" varStatus="i">
							<a href="touristArea.jsp?&tag=${ tag }">#<c:out value="${tag}"/></a> 
						</c:forEach>
					</p>
					
				</div>
				<div class="basic_information" data-v-09a75c9f="">
					<p class="info_tit" data-v-09a75c9f="">기본정보</p>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">주소</p>
						<p class="info_sub_cont" data-v-09a75c9f="">${ rVO.addr }</p>
					</div>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">연락처</p>
						<p class="info_sub_cont" data-v-09a75c9f="">${ rVO.tel }</p>
					</div>
					<div class="weather" data-v-09a75c9f="">
					<img data-v-09a75c9f="" id="weather_img" src="" alt="" class="ico_weather" style="margin-top:20px">
					<p data-v-09a75c9f="" id="weather_p"></p>
				</div>
				</div>
			</div>
		</div>
		<div class="outer_wrap" data-v-09a75c9f=""></div>
	</div>
	<div class="cont_wrap sub_visual" data-v-09a75c9f="">
	<div class="location_wrap clear" data-v-09a75c9f="">
	</div>
	
	</div>
	<ul class="appraisal_list clear" data-v-09a75c9f="" style="background-color: #FFF">
			<li data-v-09a75c9f="">
				<button type="button" data-v-09a75c9f="" id="like_btn">
					<div class="ico_like " data-v-09a75c9f=""></div>
					<p class="appraisal_tit" data-v-09a75c9f="">좋아요<span class="status" data-v-09a75c9f=""></span></p>
					<p class="appraisal_cnt" data-v-09a75c9f="" id="like_cnt">0</p>
				</button>
			</li>
			<li data-v-09a75c9f=""><div class="ico_review" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">리뷰</p><p class="appraisal_cnt" data-v-09a75c9f="">0</p></li>
			<li data-v-09a75c9f=""><div class="ico_hits" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">조회</p><p class="appraisal_cnt" data-v-09a75c9f="">0</p></li>
		</ul>
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail_left" data-v-09a75c9f="">
				<div id="tab0" class="add2020_detail_box" data-v-09a75c9f="">
					<h2 data-v-09a75c9f="">
						<a id="detailFadeBtn" class="up" data-v-09a75c9f="">상세정보<span class="arrow" data-v-09a75c9f="">확장됨</span></a>
					</h2>
					<div id="stab0" class="add2020_detail_box_in" data-v-09a75c9f="" style="display: block;">
						<div data-helper-component-key="core-system-grid" __vue_component_directive="ice?visit-jeju;contents;kr-CONT_000000000500457;@5" __vue_component_directive_fallback="ice?visit-jeju;contents;kr-CONT_000000000500457;@5" __directive_pos="0" data-accept-components="contentsDecoration/htmlBlock.vue,contentsDecoration/contentsTitle.vue,contentsDecoration/subContentsTitle.vue,contentsDecoration/GridImageViewer.vue,contentsDecoration/relativeComponent.vue,contentsDecoration/contentsParagraph.vue,contentsDecoration/Quotation.vue,contentsDecoration/devideLine.vue,contentsDecoration/YouTube.vue,contentsDecoration/Caption.vue,contentsDecoration/html2.vue" data-fragment-name="컨텐츠" class="_grid-system-grid_ grid-container " style="background-color:transparent;width:100%;">
							<div>
								<!-- 상세정보  -->
								${ rVO.detailInfo }										
							</div>
						</div>
						<!---->
								<div class="conts_detail"><p>&nbsp;</p>
							</div>
						</div>
						<!---->
					</div>
					<div class="add2020_detail_tab" data-v-09a75c9f="">
                                                
                                                </div>
                                                </div>
                                               <div class="add2020_detail_right" data-v-09a75c9f="">
                                               	
                                               <div class="add2020_detail_side_box" data-v-09a75c9f="">
                                               	<h2>이용안내 </h2>
                                               		<div class="add2020_detail_side_info">
                                               		<dl>
                                               			
                                               			<dt>이용 시간</dt>
                                               			<dd>
										                    ${ rVO.serviceHour }
               											 </dd>
               											 <dt>편의시설</dt>
               											 <dd>${ rVO.conveniences }</dd>
               											 <!---->
          											 </dl>
          											 <!----><!----><!----><!---->
       											 </div>
   											 </div>
										 </div>
                                               </div>
										 <div class="clear" data-v-09a75c9f="">
								 </div>
										 <div style="text-align: center; margin-top: 50px">
										 <input type="button" value="수정" id="modify" class="btn btn-info" style="width:150px; margin-right: 80px; margin-bottom: 60px">
										 <input type="button" value="삭제" id="delete" class="btn btn-danger" onclick="restaurantDelete('${ param.restaurantId }')" style="width:150px; margin-bottom: 60px">
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