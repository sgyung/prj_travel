<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String date = request.getParameter("reserveDate");
	String time = request.getParameter("reserveTime");
	String adult = request.getParameter("reserveAdult");
	String child = request.getParameter("reserveChild");
	String userName = request.getParameter("userName");
	String tourName = request.getParameter("tourName");
	
	pageContext.setAttribute("date", date);
	pageContext.setAttribute("time", time);
	pageContext.setAttribute("adult", adult);
	pageContext.setAttribute("child", child);
	pageContext.setAttribute("userName", userName);
	pageContext.setAttribute("tourName", tourName);
	
	System.out.println(" --------------");
	System.out.println(userName);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.133/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap CDN-->
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN -->
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	
})//ready
</script>


</head>
<body>
<div class="wrap" style="padding-top:100px">
<%@ include file="../common/jsp/header.jsp" %>
<jsp:useBean id="trdVO" class="user.vo.TourReservedDetailVO" scope="page" />
	<jsp:setProperty property="*" name="trdVO"/>
<div class="container my-5 py-5" style="width:700px">
  		<h1 class="my-3" style="text-align:center">예약이 완료 되었습니다!</h1>
  		<hr>
	 	 <div class="text-center" style="text-align:center">
	 	 	<div class="card" >
			  <div class="card-body">
			    <h4 class="card-title">예약 내역</h4>
			    <h5 class="card-subtitle mb-2 text-body-secondary">${ trdVO.tourName }</h5>
			    <p class="card-text"><strong>예약자</strong> : ${ trdVO.userName }</p>
			    <p class="card-text"><strong>성인</strong> : ${ trdVO.reserveAdult }</p>
			    <p class="card-text"><strong>소아</strong> : ${ trdVO.reserveChild }</p>
			    <p class="card-text"><strong>예약 시간</strong> : ${ trdVO.reserveTime }</p>
			    <a href="http://192.168.10.133/prj_travel/user_main/main.jsp" class="btn btn-primary" style="background:#ef6d00; border-color:white; color:white">메인으로</a>
			  </div>
			</div>
	 	 </div>
	</div>
	
	  <%@ include file="../common/jsp/footer.jsp" %>
	</div>
</body>
</html>