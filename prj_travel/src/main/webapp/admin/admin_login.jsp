<%@ page import="admin.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 | 로그인</title>
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap CDN-->
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN -->
<style>
   
   html,
   body {
     height: 100%;
   }
   
   body {
     display: flex;
     align-items: center;
     padding-top: 40px;
     padding-bottom: 40px;
     background-color: #f5f5f5;
   }
   
   .form-signin {
     width: 100%;
     max-width: 330px;
     padding: 15px;
     margin: auto;
   }
   
   .form-signin .checkbox {
     font-weight: 400;
   }
   
   .form-signin .form-floating:focus-within {
     z-index: 2;
   }
   
   .form-signin input[type="email"] {
     margin-bottom: -1px;
     border-bottom-right-radius: 0;
     border-bottom-left-radius: 0;
   }
   
   .form-signin input[type="password"] {
     margin-bottom: 10px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
   }

</style>
<%
if ("true".equals(request.getParameter("validate"))) {
    String id = request.getParameter("id");
    String pass = request.getParameter("pwd");
    System.out.println(id + " / " + pass);

    AdminDAO adminDAO = AdminDAO.getInstance();

    if (adminDAO.selectAdmin(id, pass)) {
        session.setAttribute("id", id);
        session.setAttribute("pass", pass);
        response.sendRedirect("../admin_dashboard/dashboard.jsp");
    } else {
        // 로그인 실패 시 메시지 표시
%>
        <script type="text/javascript">
            alert("아이디 및 비밀번호를 확인해주세요.");
        </script>
<%
    }
}
%>
<script type="text/javascript">
$(function() {
	$("#login").click(function(){
        var id = $("#id").val(); // 아이디 입력 필드 값 가져오기
        var pass = $("#pwd").val(); // 비밀번호 입력 필드 값 가져오기
        
        if (id === "" || pass === "") {
            alert("아이디와 비밀번호를 입력하세요.");
            return; // 입력 필드가 비어있으면 실행 중단
        }
        
        // 유효성 검사를 서버로 전달하기 위한 hidden input 추가
        $("#frm").append('<input type="hidden" name="validate" value="true">');
        $("#frm").submit(); // 폼을 서버로 제출하여 페이지를 다시로드
	});
});
</script>
</head>


<body class="text-center">
   <main class="form-signin">
      <form action="admin_login.jsp" method="post" id="frm">
         <img class="mb-4" src="${pageContext.request.contextPath}/images/bootstrap-logo.svg" alt="" width="72" height="57">
         <h1 class="h3 mb-3 fw-normal">관리자 로그인 페이지</h1>
         
         <div class="form-floating">
            <input type="text" class="form-control" name="id" id="id" placeholder="아이디 입력...">
            <label for="id">아이디</label>
         </div>
         <div class="form-floating">
            <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password">
            <label for="pwd">비밀번호</label>
         </div>
         
         <div class="checkbox mb-3">
            <label>
               <input type="checkbox" value="remember-me"> 아이디 저장
            </label>
         </div>
         <input type="button" class="w-100 btn btn-lg btn-primary" id="login" value="로그인">
         <p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
      </form>
   </main>
</body>
</html>
