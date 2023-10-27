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

.login_box {
	width : 50%;
	max-width : 600px;
	height : 550px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
}

.login_box > h1 , p {
	text-align: center;
}

.input_box {
	width:100%;
	height: 50px;
	border: solid #ccc;
    border-width: 0 0 2px;
}

.input_box:focus {
	outline : none;
	border: solid #0DCAF0;
    border-width: 0 0 2px;
}

.id_area , .pw_area {
	margin-top : 20px;
}

.textBox{
	width:100%;
	margin-top:20px;
	padding: 20px;
	display: none;
	background-color: #fafafa;
}

.textBox > p {
	font-size: 13px;
	color: #e65f3e;
	margin-bottom: 0px;
	text-align: left;
}

.login_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

.find_signup {
	font-size : 12px;	
	margin-top : 20px;
	justify-content: space-between;
}

.find_signup > ul {
	list-style: none;
}

.find_signup > ul > li {
	margin-left: 10px;
	float : left;
}

</style>
<script type="text/javascript">
$(function(){
	$("#id").keydown(function( evt ){
        if(evt.which == 13){
            checkNull();
        }//end if
    });//end keydown

    $("#pass").keydown(function( evt ){
        if(evt.which == 13){
            checkNull();
        }//end if
    });//end keydown

    $("#btnLogin").click(function(  ){
        checkNull();
    });//end click
});//ready

function checkNull(){

	var id=$("#id").val();
	var pass=$("#pass").val();

	$("#id").focus();
	if( id.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>계정을 입력해 주세요.</p>");
	    $("#id").val("");
	    return;
	}

	$("#pass").focus();
	if( pass.replace(/ /g,"")  == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>비밀번호를 입력해 주세요.</p>");
	    $("#pass").val("");
	    return;
	}

		$("#frm").submit();
	}//chkNull
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="login_box">
            <h1>로그인</h1>
            <p>로그인 하시면 여행지 리뷰 등록 및 내가 찜한 여행지와 일정, 방문지 등의 다양한 기능을 사용하실 수 있습니다.</p>
            <form action="login_process.jsp" method="post" name="frm" id="frm">
                <div class="id_area">
                <input type="text" class="input_box" placeholder="아이디" name="id" id="id">
                </div>
                <div class="pw_area">
                <input type="password" class="input_box" placeholder="비밀번호" name="pass" id="pass">
                </div>
                
                <div class="textBox" id="warningBox"></div>
                
                <input type="button" value="로그인" class="btn btn-info login_btn" id="btnLogin">
            </form>
	        <div class="find_signup flex">
	            <a href="../user_signup/signup.jsp" class="link_signup">회원가입</a>
	            <ul>
		            <li><a href="../user_search_id/search_id.jsp">계정 찾기</a></li>
		            <li><a href="../user_search_pw/search_pw.jsp">비밀번호 찾기</a></li>
	            </ul>
	        </div>
        </div>

    </div>

	<div class="footer">
        <span style="font-size: 60px; color: white; ">FOOTER</span> 
    </div>
	
</div>
      
</body>
</html>