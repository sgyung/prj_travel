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
.main_content{
    width: 80%;
    margin: 0 auto;
}

.rank_list{
	margin-top:30px;
    width: 70%;
}
.tag_list{
	margin-top:30px;
    width: 30%;
}
 
.tour_rank {
	margin-bottom: 20px;
}

.tour_rank > label , .restaurant_rank > label {
	width: 250px; 
	text-align: center;
	margin-top: 25px;
}

.rank_box {
	margin-left:20px;
	text-align: center;
}


.mainQuickWrap {
    margin: -7px -5px -6px;
    text-align: center;
}

.mainQuickWrap > li {
    display: inline-block;
    margin: 7px 5px;
}

.mainQuickWrap > li > a {
    display: block;
    font-size: 16px;
    line-height: 30px;
    height: 30px;
    padding: 3px 17px;
    border: 1px solid #d9d8d8;
    border-radius: 6px;
    color: #666;
}
</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div class="wrap">
    
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="main_carousel">

        <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="https://api.cdn.visitjeju.net/imageResource/file/202308/28/2ecd4065-8db2-4c93-a703-c9bd431318e6.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>First slide label</h5>
                  <p>Some representative placeholder content for the first slide.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="https://api.cdn.visitjeju.net/imageResource/file/202309/14/c7ad2aee-4294-4f1a-ad66-f17a6ee1e52c.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Second slide label</h5>
                  <p>Some representative placeholder content for the second slide.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="https://api.cdn.visitjeju.net/imageResource/file/202309/26/bb18bd3f-f10d-4e5c-bfeb-2ad596185d01.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Third slide label</h5>
                  <p>Some representative placeholder content for the third slide.</p>
                </div>
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>

    </div>

    <div class="main_content flex">
        <div class="rank_list">
        
            <div class="tour_rank flex">

                <label><h2>관광지</h2></label>
                
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>1</span>
                </div>
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>2</span>
                </div>
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>3</span>
                </div>
               
            </div>
            
            <div class="restaurant_rank flex">
                
				<label><h2>맛집</h2></label>
				
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>1</span>
                </div>
				
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>2</span>
                </div>
				
                <div class="rank_box">
                    <div class="img_box">
                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" 
                        width="150px" height="100px">
                    </div>
                    <span>3</span>
                </div>

            </div>
        </div>
        <div class="tag_list">
            <ul class="mainQuickWrap">
                <li><a href="#">#테마여행</a></li>
                <li><a href="#">#웰니스</a></li>
                <li><a href="#">#지도우편신청</a></li>
                <li><a href="#">#카름스테이</a></li>
                <li><a href="#">#달달익선</a></li>
                <li><a href="#">#러닝홀리데이인제주</a></li>
                <li><a href="#">#안내책자</a></li>
                <li><a href="#">#테마지도</a></li>
                <li><a href="#">#반려동물동반여행</a></li>
                <li><a href="#">#안전여행스탬프in제주</a></li>
                <li><a href="#">#포토제주</a></li>
                <li><a href="#">#제주여행공유</a></li>
            </ul>
        </div>
    </div>

	<div class="footer">
        <span style="font-size: 60px; color: white; ">FOOTER</span> 
    </div>
	
</div>
</body>
</html>