<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  

<%
	/* 로그아웃 */
	session.removeAttribute("sesId");
	session.removeAttribute("userData");
	session.invalidate();
	/* response.sendRedirect("main.jsp"); */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">
.content_wrap {
	margin-top: 100px;
	width: 100%;
}

.changed_form_wrap {
	width : 50%;
	max-width : 600px;
	height : 350px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
	position: relative;
}

.changed_form_text {
	text-align: center;
	margin-bottom: 50px;
}

.request_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

.login_main {
	width:100%;
}

.login_main_btn {
	width: 100%;
	margin: 0 auto;
}

</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="changed_form_wrap">
        
        <div class="changed_form_text">
            <h1>회원탈퇴</h1>
        </div>
        <div class="changed_form_text">
            <p>정상적으로 회원탈퇴가 완료되었습니다.</p>
        </div>
            <div class="login_main">
	            <a href="../user_main/main.jsp">
		            <input type="button" value="메인" class="btn btn-warning login_main_btn">
	            </a>
            </div>
        </div>
    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
	
</div>
      
</body>
</html>