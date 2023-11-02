<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page info="문의 사항- 상세" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.139/jsp_prj/common/main/favicon.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
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


.col-md-12{
position: static;
}

.button{
float: right;
width: 90px;
height: 30px;
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
font-size: 13px;
background: #ef6d00;
border: 1px solid #ce5e00;
}

#mod_btn{
margin-right: 10px;
}

.row{
}

.card{
overflow: scroll;
height: 700px;
width:1285px;
 top: 80px;
left: 380px;
    display: flex;
    flex-direction: column;
    min-width: 60%;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0,0,0,.125);
    border-radius: 0.25rem;
}

#icon{
	font-size : 7em;
}

#list_btn{
position: absolute;
left: 45%;
top: 85%; 
width: 200px;
height: 50px;
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
font-size: 25px;
background: #ef6d00;
border: 1px solid #ce5e00;
}

</style>
<!-- summernote 시작 -->

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- i18n -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>

<script type="text/javascript">
$(function(){
	$('#note').summernote({
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    //['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']],
		    ['para', ['ul', 'ol', 'paragraph']],
		  //  ['height', ['height']]
		    ['table', ['table']],
		    ['insert', ['picture']]
		  ],
		  placeholder: '맛집추천',
		  height:300,
		  lang: 'ko-KR'
	});
});//ready
</script>
<!-- summernote 끝 -->
<script type="text/javascript">
$(function(){
	$("#mod_btn").click(function(){
		alert("asd");
	});
	
	$("#list_btn").click(function(){
		location.href ="post.jsp"
		 $("#frm").submit(); 
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
 <i class="bi bi-info-circle"></i><span>접이식 자전거 보관</span>
  </div> 
 <div class="line"></div>
  <!-- <textarea class="inputBox"  name="note" id="note"></textarea> -->
      <div class="col-md-12">
            <div class="card">
              <div class="card-header">
              <h4><label style="margin-left:0px; margin-top: 10px; background: #ef6d00;">[관광지]</label>
              &emsp;
              <label style="margin: 0;">aaa1234&emsp;</label>
              <label style="margin: 0;">2023.09.28&emsp;</label>
              </h4>
              <input type="button" class="button" id="del_btn" value="삭제"> 
              <input type="button" class="button" id="mod_btn" value="수정">
              </div>
              <div class="row">
              <!-- <div class="col-md-2" style="margin-left: 70px; float: left; text-align: center;"> -->
              <!-- </div> -->
              <div class="col-md-3" style="display: inline-block; float: left">
              </div>
              </div>
              <div class="row" >
              <div style="width: 1200px; margin-left: 60px; float: left; white-space: normal;  ">
                 혹시 작은 자전거 보관이 가능할까요?
              </div>
              </div>
        </div>
        </div>
        <button type="submit" class="btn btn-primary" id="list_btn" >목록</button>    
		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
		</aside>
	<!-- ./wrapper -->
	<!-- jQuery -->
	<script src="resource/plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="resource/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>
	<!-- Bootstrap 4 -->
	<script src="resource/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="resource/plugins/chart.js/Chart.min.js"></script>
	<!-- Sparkline -->
	<script src="resource/plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->
	<script src="resource/plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="resource/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="resource/plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="resource/plugins/moment/moment.min.js"></script>
	<script src="resource/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="resource/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="resource/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script
		src="resource/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="resource/dist/js/adminlte.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="resource/dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="resource/dist/js/pages/dashboard.js"></script>
  </div>
</body>
</html>