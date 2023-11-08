<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	height : 400px;
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
	border: solid #ef6d00;
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

.reverse {
	flex-direction: row-reverse;
}

</style>
<script type="text/javascript">
$(function(){
    $("#btnNext").click(function(  ){
    	checkPw();
    });//end click
});//ready

function checkPw(){

	var pw=$("#pw").val();
	
	var getPw= RegExp(/^(?=.*[a-z])(?=.*[0-9]).{8,16}$/);

	$("#pw").focus();
	if( pw.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>비밀번호를 입력해 주세요.</p>");
	    $("#name").val("");
	    return;
	}
	
	// 비밀번호 유효성검사
    if(!getPw.test( pw )) {
    	$("#warningBox").show();
	    $("#warningBox").html("<p>비밀번호는 8~16자 영문(소문자), 숫자를 혼합해서 사용해야 됩니다.</p>");
        $("#pw").val("");
        $("#pw").focus();
        return false;
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
            <h1>비밀번호 확인</h1>
        </div>
            <form action="check_pw_process.jsp" method="post" name="frm" id="frm">
                <div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16"><path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/><path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/></svg></label>
					<input type="password" placeholder="비밀번호" id="pw" name="pw" class="input_box" >
				</div>
				
				<div class="textBox" id="warningBox"></div>
				
                <input type="button" value="다음" id="btnNext" class="btn btn-warning long_btn">
                
            </form>
        </div>

    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
	
</div>
      
</body>
</html>