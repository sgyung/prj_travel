<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page info="게시판 - 상세" %>
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
height: 38%;
width:1290px;
 top: 160px;
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
top: 65%; 
width: 200px;
height: 50px;
font-family: NanumSquare, "Nanum Gothic", "\\B098눔고딕", "맑은  고딕", "Malgun Gothic", "Open Sans", Dotum, "\\B3CB움", arial, sans-serif;
font-size: 25px;
background: #ef6d00;
border: 1px solid #ce5e00;
}

.footer{
position: fixed;
left: 0%;
top:63%;
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
 <i class="bi bi-info-circle"></i><span>맛집추천좀해주세요</span>
  </div> 
 <div class="line"></div>
  <!-- <textarea class="inputBox"  name="note" id="note"></textarea> -->
      <div class="col-md-12">
            <div class="card">
              <div class="card-header">
              <h4><label style="margin-left:0px; margin-top: 10px; background: #ef6d00;">[맛집]</label>
              &emsp;
              <label style="margin: 0;">작성자 : aaa1234&emsp;</label>
              <label style="margin: 0;">작성일 : 2023.10.27&emsp;</label>
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
              튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
               소리다이것은 피어나기
               튼튼하며 그들의 피부가 얼마나 생생하며 그들의 눈에 무엇이 타오르고 있는가? 
              우리 눈이 그것을 보는 때에 우리의 귀는 생의 찬미를 듣는다 
              그것은 웅대한 관현악이며 미묘한 교향악이다 뼈 끝에 스며들어 가는 열락의
              </div>
              </div>
        </div>
        </div>
        <button type="submit" class="btn btn-primary" id="list_btn" >목록</button> 
        <div class="footer"><%@ include file="../common/jsp/footer.jsp" %></div>
		
</body>
</html>