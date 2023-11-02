<%@page import="admin.vo.PostVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="user_mypageDAO.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page info="게시판" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.139/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.header {
    height: 90px; 
}

.header_contents{
    width: 80%;
    margin: 0 auto;
    padding-top: 30px;
    justify-content: space-between;
}

.flex { 
    display : flex; 
 }

 .nav_top > ul{
    list-style: none;
 }

 .nav_top > ul > li{
    display: inline-block;
    margin-left: 30px;
 }
.login {
    margin-left: 30px;
}

.main_content{
    background-color: red;
    width: 80%;
    margin: 0 auto;
}


/*글씨체*/
 #icon {src="images/icon_i.png";position: absolute; width: 50px; height: 50px; top:100px; left:50px;  background:#FFF url(images/icon_i.png)no-repeat }
 #head{position: absolute; width:250px; height: 50px; top:100px; left:100px;font-size: 30px; font-weight: bold;}
.bi-info-circle{
            font-size: 30px;
            line-height: 30px;
            color:black;
 }
 
  .head{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 35px;
      line-height: 35px;
     color:black;
     position: absolute; top: 100px; left: 400px;
}
        
.line{
border : 1px solid #000000 ;
width:60%;
margin-left: 18%;
 position: absolute; top: 150px;
}

.box{

height: 233.333px;
width:1287.33px;

position: absolute;
top: 180px;
left: 380px;

}

tr ,td{
width : 100px; 
height :25px;
text-align:center;
margin-left : 20%;
margin-right : 20%;
border : 1px solid #000000 ;
}

.wrapper{
height: 233.333px;
width:1287.33px;

position: absolute;
top: 50px;
left: 380px;


}

#mypage_btn{
position: fixed;
left: 45%;
top: 65%; 
width: 200px;
height: 50px;
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
font-size: 25px;
background: #ef6d00;
border: 1px solid #ce5e00;
}

.table{
position: absolute;
}

.footer{
position: fixed;
left: 0%;
top:63%;
}

</style>
<jsp:include page = "../include/set_style.jsp"></jsp:include>
<c:catch var="se">
<%-- <%
 PostDAO pDAO = PostDAO.getInstance();
List<PostVO> postList = pDAO.selectPost(userid);
 %> --%>
</c:catch>
<script type="text/javascript">
$(function(){
	
$("#mypage_btn").click(function(){
	location.href ="../user_mypage/mypage.jsp"
});
});
</script>

</head>
<body>
<!-- 메인 배너 -->
<div class="wrap">
    <div class="header">
        <div class="header_contents flex">
            <div class="logo">JEJU VISIT</div>
            <div class="nav_top">
                <ul>
                    <li>관광지</li>
                    <li>맛집</li>
                    <li>게시판</li>
                    <li>투어예약</li>
                </ul>
            </div>
            <div class="search_login flex">
                <div class="search">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                      <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                    </svg>
                </div>
                <div class="login">로그인</div>
            </div>
        </div>
    </div>
    </div>
 <div class="head">
 <i class="bi bi-info-circle"></i><span>내가쓴글 - 게시판</span>
  </div> 
 <div class="line"></div>
   <div class="wrapper">
      <!-- Content Wrapper. Contains page content -->
      <div class="content">
         <div class="content-header">
            <div class="container-fluid">
               <div class="row mb-1">
                  <div class="col-sm-1">
                     <!-- <h1 class="m-0">회원관리</h1> -->
                  </div>
                  <!-- /.col -->
               </div>
               <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
         </div>
         <!-- /.content-header -->
<form action="admin_user_info.jsp" method="post" id="hidFrm">
   <input type="hidden" name="id" id="id"/>
</form>
<form action="admin_user_post.jsp" method="post" id="postHidFrm">
   <input type="hidden" name="id" id="post" />
</form>

<jsp:useBean id="pVO" class="user_mypageVO.PostVO" scope="page"/>
<jsp:setProperty property="*" name="pVO"/>

   <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">게시물 목록</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th style="width: 150px"></th>
                      <th style="width: 150px">작성일</th>
                      <th style="width: 120px">카테고리</th>
                      <th style="width: 60px">답변</th>
                    </tr>
                  </thead>
                  <tbody>

         <tr>
            <td name="title"><a href="post_detail.jsp">asd</a></td>
            <td>2023-10-27 </td>
            <td>맛집</td>
            <td>1</td>
          </tr>                   
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <ul class="pagination justify-content-center" >
                  <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                </ul>
                <div style="text-align: center" >
                <input type="text" id="input" class="inputBox" style="width: 200px; height: 30px;" placeholder="제목을 입력해주세요."/>
                <div style="display: inline-block;" >
                <input type="button" id="search" class="btn btn-warning" style="width: 80px; margin-left: 10px; font-size: 13px" value="검색" />
                </div>
                </div>
              </div>
            </div>
            </div>
            </div>
           </div>
         </section>
      </div>
          <button type="submit" class="btn btn-primary" id="mypage_btn" >마이페이지</button>
   </div>
          <div class="footer"><%@ include file="../common/jsp/footer.jsp" %></div>
</body>
</html>