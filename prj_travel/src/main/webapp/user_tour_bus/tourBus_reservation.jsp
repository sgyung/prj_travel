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
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.warp{
	position: relative;
}


section {
    display: block;
}

::selection {
    background: #833f9e;
    color: #FFF;
    text-shadow: none;
}

body {
    display: block;
    margin: 8px;
}

html, body, p, input, select, form, label, mark, ul, ul li, ol, ol li, dl, dl dt, dl dd, img, a, table, h1, h2, h3, h4, h5 {
    margin: 0;
    padding: 0;
}

.header {
    height: 90px;
    width: 100%;
    background-color: rgb(0,0,0,0.4);
    position: absolute; 
    z-index : 2;
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

.resev-page-wrap {
    width: calc( 100% - 40px );
    max-width: 1200px;
    height: auto;
    overflow: hidden;
    margin: 0px auto 0 auto;
}

.resev-page-wrap .swiper-container {
    width: calc( 100% - 200px );
    padding: 0 100px 90px 100px;
    margin-top: 60px;
    position: relative;
}

.swiper-container {
    margin-left: auto;
    margin-right: auto;
    position: relative;
    overflow: hidden;
    list-style: none;
    padding: 0;
    z-index: 1;
}

.swiper-wrapper {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 1;
    display: flex;
    transition-property: transform;
    box-sizing: content-box;
}

.resev-page-wrap .swiper-container .swiper-slide {
    width: 100%;
    height: 350px;
    overflow: visible;
    border-radius: 12px;
    position: relative;
}

.resev-page-wrap .swiper-container .swiper-slide .slide-item {
    width: 100%;
    height: 180px;
    left: 0;
    top: 80px;
    overflow: hidden;
    position: absolute;
    background-size: cover !important;
}

.resev-page-wrap .swiper-container .swiper-slide .cont {
    width: 100%;
    height: 100%;
    display: flex;
    position: absolute;
    overflow: hidden;
    border-radius: 12px;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .top-item {
    width: 100%;
    height: 80px;
    overflow: hidden;
    background: #2c2727;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .top-item span {
    display: flex;
    font-size: 12px;
    color: #fff;
    font-weight: 600;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .top-item strong {
    display: flex;
    margin-top: 5px;
    font-size: 20px;
    color: #fff;
    font-weight: 600;
    text-align: center;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .bottom-item {
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
    height: 94px;
    overflow: hidden;
    background: #2c2727;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .bottom-item span {
    font-size: 12px;
    color: #fff;
    font-weight: 600;
}

.resev-page-wrap .swiper-container .swiper-slide .cont .bottom-item button {
    margin-top: 8px;
    width: 190px;
    height: 44px;
    overflow: hidden;
    border-radius: 12px;
    border: 0;
    background: #fdb421;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    color: #2c2727;
    font-weight: 600;
}

button {
    appearance: auto;
    font-style: ;
    font-variant-ligatures: ;
    font-variant-caps: ;
    font-variant-numeric: ;
    font-variant-east-asian: ;
    font-variant-alternates: ;
    font-variant-position: ;
    font-weight: ;
    font-stretch: ;
    font-size: ;
    font-family: ;
    font-optical-sizing: ;
    font-kerning: ;
    font-feature-settings: ;
    font-variation-settings: ;
    text-rendering: auto;
    color: buttontext;
    letter-spacing: normal;
    word-spacing: normal;
    line-height: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: center;
    align-items: flex-start;
    cursor: default;
    box-sizing: border-box;
    background-color: buttonface;
    writing-mode: horizontal-tb !important;
    margin: 0em;
    padding-block: 1px;
    padding-inline: 6px;
    border-width: 2px;
    border-style: outset;
    border-color: buttonborder;
    border-image: initial;
}

.container {
    width: 100%;
    height: auto;
    overflow: hidden;
}

.container {
    position: relative;
}

div {
    display: block;
}

.sub-header-wrap {
    width: 100%;
    height: 285px;
    overflow: hidden;
    background-size: cover !important;
    background-position: center center !important;
    box-shadow: 0px 5px 20px 0 rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
}

.sub-header-wrap .mtit {
    font-size: 48px;
    color: #fff;
    font-weight: 600;
}

@media (max-width: 1280px)
.resev-page-wrap .help-list-wrap {
    margin-top: 20px;
}
.resev-page-wrap .help-list-wrap {
    width: 100%;
    max-width: 1200px;
    height: auto;
    overflow: hidden;
    margin: 50px auto 0 auto;
}

.resev-page-wrap .help-list-wrap li {
    width: calc( 100% - 20px );
    position: relative;
    padding-left: 20px;
    height: auto;
    overflow: hidden;
    font-size: 16px;
    color: #890029;
}

@media (max-width: 1280px)
.resev-page-wrap .help-list-wrap li {
    font-size: 14px;
    line-height: 1.5em;
}


</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div class="wrap">
<div class="header">
        <div class="header_contents flex">
            <div class="logo">JEJU VISIT</div>
            <div class="nav_top">
                <ul>
                    <li><a href="http://localhost:8080/prj_touristArea/touristArea.jsp">관광지</a></li>
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
    <!--  -->
    
    <div class="container" id="content">
    	<section class="sub-header-wrap" style="background:url(../common/tourbus_reservation_main.png) no-repeat center top;">
			<div class="mtit">예약하기</div>
		</section>
    
    	<section class="resev-page-wrap">
			<!-- Swiper -->
			<div id="main-course-wrap" class="swiper-container swiper-container-initialized swiper-container-horizontal">
				<div class="swiper-wrapper">
					<div class="swiper-slide swiper-slide-active" style="width: 236.5px; margin-right: 18px;">
						<div class="slide-item" style="background:url(/upimg/course_product/c_product_1675230939.jpg) no-repeat center top"></div>
						<div class="cont">
							<div class="top-item">
								<span>TOUR01</span>
								<strong>도심고궁남산코스</strong>
							</div>
							<div class="bottom-item">
								<span>성인 24,000 원 / 소인 15,000 원</span>
								<button type="button" onclick="setProductCode(&quot;1&quot;,1)">코스선택</button>
							</div>
						</div>
					</div>
					<div class="swiper-slide swiper-slide-next" style="width: 236.5px; margin-right: 18px;">
						<div class="slide-item" style="background:url(/upimg/course_product/c_product_1675231090.jpg) no-repeat center top"></div>
						<div class="cont">
							<div class="top-item">
								<span>TOUR04</span>
								<strong>야경 코스</strong>
							</div>
							<div class="bottom-item">
								<span>성인 20,000 원 / 소인 12,000 원</span>
								<button type="button" onclick="setProductCode(&quot;2&quot;,1)">코스선택</button>
							</div>
						</div>
					</div>
					<div class="swiper-slide" style="width: 236.5px; margin-right: 18px;">
						<div class="slide-item" style="background:url(/upimg/course_product/c_product_1676440410.jpg) no-repeat center top"></div>
						<div class="cont">
							<div class="top-item">
								<span>TOUR02</span>
								<strong>파노라마 코스</strong>
							</div>
							<div class="bottom-item">
								<span>성인 24,000 원 / 소인 15,000 원</span>
								<button type="button" onclick="setProductCode(&quot;N&quot;,1)">코스선택</button>
							</div>
						</div>
					</div>
					<div class="swiper-slide" style="width: 236.5px; margin-right: 18px;">
						<div class="slide-item" style="background:url(/upimg/course_product/c_product_1676440427.jpg) no-repeat center top"></div>
						<div class="cont">
							<div class="top-item">
								<span>TOUR03</span>
								<strong>어라운드강남코스</strong>
							</div>
							<div class="bottom-item">
								<span>성인 20,000 원 / 소인 15,000 원</span>
								<button type="button" onclick="setProductCode(&quot;N&quot;,1)">코스선택</button>
							</div>
						</div>
					</div>
			
				</div>
				<!-- Add Arrows -->
				<div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-disabled="true"></div>
				<div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-disabled="true"></div>
			<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
	
			<ul class="help-list-wrap">
				<li>야경코스(TOUR 04)는 예약 순서에 따라 오픈2층버스 배정 후 오픈1층버스로 배정됩니다. 예약시 버스종류를 알 수 없으며 탑승일 당일 모든 예약 상황을 취합하여 배정됩니다.</li>
				<li>당일 온라인 예약은 불가합니다. 주간 코스(TOUR01)는 당일 현장 구매가 가능합니다. 야간코스(TOUR04)는 방문 전 저희 고객센터로 잔여좌석 문의 바랍니다.</li>
				<li>오픈 2층 버스가 메인으로 운행되며, 예약/교통/차량 상황 등에 따라 오픈 1층 버스, 일반 2층 버스로 운행될 수 있습니다.</li>
				<li>날씨, 시즌 및 예약 인원에 따라 시간 별 예약으로 변경될 수 있습니다.</li>
				<li>소인은 6세 이상부터 고등학생까지를 포함합니다. (2019년 1월 1일 이후 출생자부터 무료 적용, 2023년 기준, 보호자가 동반하는 5세 미만 어린이 1명 무료 탑승)</li>
				<li>예약과 관련해 상단 Tap 메뉴 '예약안내'를 참고해주시고, 기타 문의가 있으실 경우 상단 메뉴의 '고객센터&gt;문의하기'를 이용해 주시기 바랍니다.</li>
				<li>연휴기간이나 휴가기간등 사람이 많이 몰리는 날에는 입석으로 진행될 수 있습니다.<br>
(2층 오픈버스는 입석불가)
	</li>
				<li>취소 / 환불 안내<br>
탑승 2일전부터는 취소 수수료가 발생하며 무통장입금으로 결제한 경우는 고객상담 전화(02-777-6090)을 통해서만 환불이 가능합니다.<br>
탑승일로부터 3일 전 취소 시 요금의 100% 환불<br>
탑승일로부터 2일 전 취소 시 요금의 90% 환불<br>
탑승일로부터 1일 전 취소 시 요금의 80% 환불<br>
탑승일 당일 취소 시 70%환불 (단, 야경투어는 당일 낮 12시 이후 취소 시 환불 불가)
	</li>
			</ul>
		</section>
    	
    </div>
    
</div>
</body>
</html>