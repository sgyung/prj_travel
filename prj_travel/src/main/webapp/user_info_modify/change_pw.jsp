<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.UserVO"%>
<%@page import="user.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="user.vo.UserIdPwVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%
    String userId=(String)session.getAttribute("sesId");
    System.out.println(userId);
    
    if( userId == null ){
    	response.sendRedirect("http://192.168.10.132/prj_travel/user_main/main.jsp");
    	return;
    }//end if
    if( userId != null ){
    	pageContext.setAttribute("userId", userId);
    }//end if
    
    UserDAO uDAO = UserDAO.getInstance();
	try{
		UserVO uVO = uDAO.selectUserInfo(userId);
		//ex) 1998-09-30 00:00으로 출력되기에
		String birthdate = uVO.getBirthdate().substring(0,11).replace("-","").trim();
		uVO.setBirthdate(birthdate);
		
		System.out.println(uVO);
		
		DataDecrypt dd = new DataDecrypt("a12345678901234567");
		uVO.setTel(dd.decryption(uVO.getTel())); 
		
		
		pageContext.setAttribute("user", uVO);
	}catch(SQLException se){
		se.printStackTrace();
	}
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

.small_input_box {
	width:91%;
}

.reverse {
	flex-direction: row-reverse;
}

</style>
<script type="text/javascript">
$(function(){
    $("#btnConfirm").click(function(){
        checkPw();
    });//end click
});//ready

function checkPw() {
	
	var pw=$("#pw").val();
	var re_pw=$("#re_pw").val();

	var getPw= RegExp(/^(?=.*[a-z])(?=.*[0-9]).{8,16}$/);//정규식
	
	$("#pw").focus();
	if( pw.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>변경할 비밀번호를 입력해주세요</p>");
	    $("#pw").val("");
	    return;
	}
	
	$("#re_pw").focus();
	if( re_pw.replace(/ /g,"") == ""){
		$("#warningBox").show();
	    $("#warningBox").html("<p>한번더 입력해주세요</p>");
	    $("#re_pw").val("");
	    return;
	}
	//NullCheck
	
	// 비밀번호 유효성검사
    if(!getPw.test($("#pw").val())) {
	   	$("#warningBox").show();
	    $("#warningBox").html("<p>비밀번호는 8~16자 영문(소문자), 숫자를 혼합해서 사용해야 됩니다.</p>");
	    $("#pw").val("");
	    $("#pw").focus();
	    return;
    }
	
	
	if($("#re_pw").val() != $("#pw").val()){
		$("#warningBox").show();
	    $("#warningBox").html("<p>비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요.</p>");
	    $("#re_pw").val("");
	    return;
	}
	
		$("#frm").submit();
		
}//checkPw
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="search_form_wrap">
        
        <div class="search_form_text">
            <h1>비밀번호 재설정</h1>
        </div>
        <div class="search_form_text">
            <p>비밀번호를 변경해 주세요.</p>
        </div>
        
            <form action="../user_search_pw/search_pw_next_process.jsp" method="post" name="frm" id="frm">
            	<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/>
</svg></label>
					<input type="text" value="${ user.id }" name="id" id="id" class="input_box" readonly="readonly">
				</div>
                <div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
  <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/>
  <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
  </svg></label>
					<input type="password" placeholder="새로운 비밀번호" name="pw" id="pw" class="input_box" >
				</div>
				<div class="input_area flex reverse">
					
					<input type="password" placeholder="재확인" name="re_pw" id="re_pw" class="input_box small_input_box" >
				</div>
				
				<div class="textBox" id="warningBox"></div>
				
                <input type="button" value="확인" id="btnConfirm" class="btn btn-warning long_btn">
            </form>
        </div>

    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
	
</div>
      
</body>
</html>