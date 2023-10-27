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
	height : 600px;
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

.input_box:focus {
	outline : none;
	border: solid #0DCAF0;
    border-width: 0 0 2px;
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

.long_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

</style>
<script type="text/javascript">
$(function(){
    $("#btnNext").click(function(){
        checkNull();
    });//end click
});//ready

function checkNull(){

	var id=$("#id").val();
	var name=$("#name").val();
	var tel=$("#tel").val();

	$("#id").focus();
	if( id.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>아이디를 입력해 주세요.</p>");
	    $("#id").val("");
	    return;
	}
	
	$("#name").focus();
	if( name.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>이름을 입력해 주세요.</p>");
	    $("#name").val("");
	    return;
	}

	$("#tel").focus();
	if( tel.replace(/ /g,"")  == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>전화번호를 입력해 주세요.</p>");
	    $("#tel").val("");
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

        <div class="search_form_wrap">
        
        <div class="search_form_text">
            <h1>비밀번호 찾기</h1>
        </div>
        <div class="search_form_text">
            <p>회원정보에 등록한 휴대전화로 인증</p>
        </div>
            <form action="search_pw_process.jsp" method="post" name="frm" id="frm">
            	<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/>
</svg></label>
					<input type="text" placeholder="아이디" id="id" name="id" class="input_box" >
				</div>
                <div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/>
</svg></label>
					<input type="text" placeholder="이름" id="name" name="name" class="input_box" >
				</div>
                <div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
  <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h6zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H5z"/>
  <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
</svg></label>
					<input type="tel" placeholder="휴대전화번호" id="tel" name="tel" class="input_box" >
				</div>

				<div class="textBox" id="warningBox"></div>
				
                <input type="button" value="다음" id="btnNext" class="btn btn-info long_btn">
                
            </form>
        </div>

    </div>

	<div class="footer">
        <span style="font-size: 60px; color: white; ">FOOTER</span> 
    </div>
	
</div>
      
</body>
</html>