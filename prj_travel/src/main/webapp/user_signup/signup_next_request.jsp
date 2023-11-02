<%@page import="user.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
//GET방식의 요청이라면 memberjoin_frm.jsp로 이동
String method=request.getMethod();
if("GET".equals(method)){
	response.sendRedirect("signup_next.jsp");
	return;
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

.welcome_form_wrap {
	width : 50%;
	max-width : 600px;
	height : 350px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
	position: relative;
}

.welcome_form_text {
	text-align: center;
	margin-bottom: 50px;
}

.request_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

.login_main {
	width:50%;
	margin:0 auto;
	justify-content: space-between;
}

.login_main_btn {
	width: 100px;
}

</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>

<jsp:useBean id="uVO" class="user.vo.UserVO" scope="page"/>
<jsp:setProperty property="*" name="uVO"/>
<%
DataEncrypt de = new DataEncrypt("a12345678901234567");

uVO.setPw(DataEncrypt.messageDigest("MD5", uVO.getPw()));
uVO.setTel(de.encryption(uVO.getTel()));

UserDAO uDAO = UserDAO.getInstance();
	
uDAO.insertUser(uVO);
%>

<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="welcome_form_wrap">
        
        <div class="welcome_form_text">
            <h1><strong><c:out value="${ param.name }"/></strong> 님,환영합니다</h1>
        </div>
        <div class="welcome_form_text">
            <p>가입하신 계정으로 이용가능합니다</p>
        </div>
            <div class="login_main flex">
            <a href="../user_login/login.jsp">
	            <input type="button" value="로그인" class="btn btn-warning login_main_btn">
            </a>
            <a href="../user_main/main.jsp">
	            <input type="button" value="메인" class="btn btn-warning login_main_btn">
            </a>
            </div>
        </div>
    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
	
</div>


<%-- <c:if test="${ not empty se }">
입력하신 아이디 [ <c:out value="${ uVO.id }"/> ] 는 이미 사용중입니다.<br>
다른 id로 재가입 해주세요.<br>
<a href="javascript:history.back();">뒤로</a>
</c:if> --%>

</body>
</html>