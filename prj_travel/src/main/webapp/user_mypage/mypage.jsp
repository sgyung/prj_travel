<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page info="마이페이지" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.139/jsp_prj/common/main/favicon.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<!-- bootstrap CDN-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
border: 1px solid #E5E5E5 ;
background-color: #F4F4F4;

height: 233.333px;
width:1287.33px;

position: absolute;
top: 180px;
left: 380px;

}

.iconbox{
height: 233px;
width: 242px;

border: 1px solid #E5E5E5 ;
background-color: #F4F4F4;
float: left;
}

.bi-person-fill{
  font-size: 230px;
  line-height: 30px;
  color:black;
}

.namebox{
height: 41px;
	width: 1,045.33px;
	
	border: 1px solid #E5E5E5 ;
background-color: #F4F4F4;
}

.user_name1{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 25px;
	 color: #F05400;
}

.user_name2{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 18px;
	color: #1B1B1B;
}
.boardbox{
height: 192.333px;
	width: 1,045.33px;
	
	border: 1px solid #E5E5E5 ;
background-color: #F4F4F4;
}

.my_posts{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 20px;
	color: #1B1B1B;
   font-weight: bold;
	
	position: absolute;
	top: 60px;
	left: 300px;
}

.postbox{
height: 160px;
width: 350px;

border: 1px solid #E5E5E5 ;
background-color: #F4F4F4;
float: left;

position: absolute;
top :60px;
left: 410px;

text-align: center;
}

.post{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 15px;
	color: #1B1B1B;
   font-weight: bold;
	
	
}

.QandA{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 15px;
	color: #1B1B1B;
   font-weight: bold;

	
}

.review{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 15px;
	color: #1B1B1B;
   font-weight: bold;

	
	
}
.reservation{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 20px;
	color: #1B1B1B;
   font-weight: bold;

position: absolute;
top :110px;
left: 850px;
}

.user_info{
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
	font-size: 20px;
	color: #1B1B1B;
   font-weight: bold;
   
height: 100px;
width: 200px;
position: absolute;
top :85px;
left: 1000px;
   
}

.footer{
position: fixed;
left: 0%;
top:63%;
}

</style> 

<script type="text/javascript">
$(function () {
	$("#info_btn").click(function(){
		location.href ="../user_info_modify/info_modify.jsp"
	});
});//ready
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
    
    <%
    String id=(String)session.getAttribute("sesId");
    out.print(id);
    %>
    
    <div class="head"><span class="my_page">마이 페이지</span></div>
    <div class="line">
    </div>
    <div class="box">
     <div class="iconbox"><i class="bi bi-person-fill"></i>
    </div>
    <div class="namebox"><span class="user_name1">서효민</span>
    <span class="user_name2">님의 제주여행</span>
    </div>
    <div class="boardbox"><span class="my_posts">내가쓴글</span>
    <div class="postbox">
    <a href=" ../user_post/post.jsp" class="post">게시판</a><br/>
    <div>&nbsp;</div>
    <a href=" ../user_QandA/QandA.jsp" class="QandA">문의</a><br/>
    <div>&nbsp;</div>
    <a href=" ../user_review/review.jsp" class="review">리뷰</a>
    </div>
    
    <a href=" " class="reservation">예약내역</a>
    <input type="button" value="개인정보" class="user_info" id="info_btn">
    </div>
    <div clas="footer"><%@ include file="../common/jsp/footer.jsp" %></div>
    </div>
</body>
</html>