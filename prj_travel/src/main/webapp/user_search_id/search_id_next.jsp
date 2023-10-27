<%@page import="user.vo.UserIdVO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
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

.search_form_wrap {
	width : 50%;
	max-width : 600px;
	height : 500px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
	position: relative;
}

.search_form_text {
	text-align: center;
	margin-bottom: 30px;
}

.input_area_img {
	margin: 30px 10px 0px 10px ;
}

.input_area_img > svg {
	width:24px;
	height: 24px;
}

.input_box {
	width:100%;
	height: 50px;
	margin-top:20px;
	border: solid #ccc;
    border-width: 0 0 2px;
}

.small_input_box {
	width:91%;
}

.input_box:focus {
	outline : none;
	border: solid #0DCAF0;
    border-width: 0 0 2px;
}

.long_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}
.list_box {
	width : 90%;
	height : 150px;
	margin: 0 auto;
	border-radius: 14px;
	box-shadow: 4px 12px 30px 6px rgba(0,0,0,.09);
	flex-direction:column;
	justify-content:center;
	align-items: center;
	overflow:auto;
}

.search_id_area {
	width: 80%;
	height: 25px;
}

.radioBtn{
	flex-grow: 2
}

.searched_id{
	flex-grow: 5
}

.signup_date{
	flex-grow: 5
}

.login_pw {
	width:80%;
	margin:0 auto;
	justify-content: space-between;
}

.login_pw_btn {
	width: 150px;
}

.height_50{
	height: 50px;
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

        <div class="search_form_wrap">
        
	        <div class="search_form_text">
	            <h1>계정 찾기</h1>
	        </div>
	        <div class="search_form_text">
	            <p>고객님의 정보와 일치하는 아이디 목록입니다</p>
	        </div>
	        <%
	        UserIdVO uiVO = (UserIdVO)session.getAttribute("userData");
	        
			String id = uiVO.getId();
			Date joindate = uiVO.getJoindate();
			
			pageContext.setAttribute("id", id);
			pageContext.setAttribute("joindate", joindate);
	        %>
	        <div class="list_box flex">
		        <div class="search_id_area flex">
		        	<input type="radio" class="radioBtn" id="id">
		        	<label class="searched_id"><c:out value="${ id }"/></label>
		        	<span class="signup_date">가입일 : <c:out value="${ joindate }"/></span>
		        </div>
		        
	        
	        </div>
	        
	        <div class="height_50"></div>
	        
	        <div class="login_pw flex">
            <a href="../user_login/login.jsp">
	            <input type="button" value="로그인" class="btn btn-info login_pw_btn">
            </a>
            <a href="../user_search_pw/search_pw.jsp">
	            <input type="button" value="비밀번호찾기" class="btn btn-info login_pw_btn">
            </a>
            </div>
        
        </div>

    </div>

	<div class="footer">
        <span style="font-size: 60px; color: white; ">FOOTER</span> 
    </div>
	
</div>
      
</body>
</html>