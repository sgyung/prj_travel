<%@page import="user.vo.RestRankTagVO"%>
<%@page import="user.vo.TourRankTagVO"%>
<%@page import="java.util.List"%>
<%@page import="user.dao.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MainDAO dao = MainDAO.getInstance();

	List<TourRankTagVO> tourList = dao.selectTourRank();
	List<RestRankTagVO> restList = dao.selectRestRank();
	List<String> tourTags = dao.selectAllTourTags();
	List<String> restTags = dao.selectAllRestTags();
	
	System.out.println( tourList.toString() );
	System.out.println( restList.toString() );
	System.out.println( tourTags.toString() );
	System.out.println( restTags.toString() );
	
	pageContext.setAttribute("tourList", tourList);
	pageContext.setAttribute("restList", restList);
	pageContext.setAttribute("tourTags", tourTags);
	pageContext.setAttribute("restTags", restTags);
	
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
.wrap {
	width:100%;
}

.main_carousel {
	
	margin-top: 90px;
}

.main_content{
    width: 80%;
    margin: 40px auto;
}


.rank_list{
    width: 80%;
}
.tag_list{
    width: 20%;
}
 
.tour_rank {
	margin-bottom: 40px;
}

.tour_rank > label , .restaurant_rank > label {
	width: 250px; 
	text-align: center;
	margin-top: 25px;
}

.rank_title {
	width:260px;
	min-width:260px;
	height:259px;
	background: #ef6d00;
	color: #fff;
    text-align: center;
    border-radius: 15px;
}

.stitle {
	margin-top: 45px;
    font-size: 14px;
    line-height: 50px;
    margin: 30px 0 5px;
}

.title {
    font-size: 25px;
    line-height: 38px;
}

.rank_box {
	margin-left: 30px;
	text-align: center;
}

.rank_box > a:hover {
	color : #ef6d00;
}

.img_box {
	border-radius: 15px 15px 0 0;
	width:250px;
	height:169px;
}
.img_box > img {
	width: 100%;
	border-radius: 15px 15px 0 0;
}

.title_box {
    border-left: 1px solid #d9d8d8;
    border-right: 1px solid #efefef;
    border-bottom: 1px solid #efefef;
    border-radius: 0 0 15px 15px;
}

.title_box > span {
    display: table-cell;
    height: 90px;
    vertical-align: middle;
    text-align: center;
    width: 248px;
    padding: 0 10px;
    font-size: 18px;
    line-height: 20px;
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
    line-height: 20px;
    height: 30px;
    padding: 3px 17px;
    border: 1px solid #d9d8d8;
    border-radius: 6px;
    color: #666;
}

.mainQuickWrap > li > a:hover {
    color: #ef6d00;
    border: 1px solid #ef6d00;
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

                <div class="rank_title" style="width:260px">
	                    <p class="stitle">New Hot Spots</p>
	                    <p class="title">새로운 제주를<br>알아가는 즐거움</p>
                </div>
                
				<c:forEach var="tourList" items="${tourList}" varStatus="i">
	            <div class="rank_box">
                	<a href="../user_tourist_area/touristArea_detail.jsp?contentInfo=${ tourList.id }">
	                    <div class="img_box">
		                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" >
	                    </div>
	                    <div class="title_box">
	                    <%-- 위의img_box클래스의 img src경로에 넣을 값 ${ tourList.thumbNail } --%>
	                    <span>${ tourList.name }</span>
	                    </div>
                	</a>
	            </div>
				</c:forEach>
                
            </div>
            
            <div class="restaurant_rank flex">
                
				<div class="rank_title" style="width:260px; background: #59a193">
	                    <p class="stitle">Personalized Recommendation</p>
	                    <p class="title">인기있는 맛집을<br>찾으시나요?</p>
                </div>
				
				<c:forEach var="restList" items="${ restList }" varStatus="i">
                <div class="rank_box">
               		<a href="../user_restaurant/restaurant_detail.jsp?contentInfo=${ restList.id }">
	                    <div class="img_box">
		                        <img src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/201804/30/e1c2f9e4-bf4c-488c-884c-5674f8d8b119.jpg" >
	                    </div>
	                    <div class="title_box">
		                    <%-- 위의img_box클래스의 img src경로에 넣을 값 ${ restList.thumbNail } --%>
		                    <span>${ restList.name }</span>
	                    </div>
                	</a>
                </div>
				</c:forEach>

            </div>
        </div>
        <div class="tag_list">
        
        	<div class="tour_tag_list">
        	
        		<ul class="mainQuickWrap">
        			<c:forEach var="tourTags" items="${ tourTags }" varStatus="i">
	        			<li><a href="../user_restaurant/restaurant.jsp?tag=${ tourTags }">#${ tourTags }</a></li>
        			</c:forEach>
                </ul>
        	</div>
        	
        	<div class="tour_tag_list">
        		<ul class="mainQuickWrap">
	        		<c:forEach var="restTags" items="${ restTags }" varStatus="i">
	        			<li><a href="../user_tourist_area/touristArea.jsp?tag=${ restTags }">#${ restTags }</a></li>
        			</c:forEach>
                </ul>
        	</div>
      
   	 	</div>
	
	</div>
	
	<%@ include file="../common/jsp/footer.jsp" %>
    
</div>   
</body>
</html>