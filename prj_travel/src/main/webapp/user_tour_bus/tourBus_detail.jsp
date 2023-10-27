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
<style type="text/css">


.warp{
	position: relative;
}

.header {
    height: 90px;
    width: 100%;
    background-color: rgb(0,0,0,0.4);
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

.arrow_sign{
	width:25px;
	height:25px;
	background: url(../common/spr_comm.png) no-repeat;
	background-position: -112px -35px;
	margin: 0 10px;
}


button {
    margin-top: 10px;
    width: 250px;
    height: 50px;
    overflow: hidden;
    border-radius: 12px;
    border: 0;
    background: #fdb421;
    padding: 0;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    color: #2c2727;
    font-weight: 600;
}

/* reservation */
div.jisik-pop.on[data-v-db46a16a] {
    display: block;
}

div.jisik-pop[data-v-db46a16a] {
    display: none;
    position: fixed;
    z-index: 604;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    overflow-y: auto;
    background: rgba(0,0,0,.1);
}

div.jisik-pop div.outline[data-v-a315ebf2] {
    position: absolute;
    width: 1000px;
    left: 50%;
    margin-left: -500px;
    top: 100px;
    background: #fff;
    padding: 30px 50px 50px;
    -webkit-box-shadow: 0 0 15px rgba(0,0,0,.05098);
    box-shadow: 0 0 15px rgba(0,0,0,.05098);
}

div.jisik-pop div.outline h3[data-v-a315ebf2] {
    text-align: center;
    font-size: 20px;
    color: #ef6d00;
    font-weight: 600;
    margin: 0 0 45px;
}

div.jisik-pop div.outline h3 small[data-v-a315ebf2] {
    display: block;
    font-size: 14px;
    color: #999;
    font-weight: 400;
}

div.jisik-pop div.outline div.box[data-v-a315ebf2] {
    margin: 40px 0 0;
}

div.jisik-pop div.outline button.submit[data-v-a315ebf2] {
    display: block;
    background: #ef6d00;
    border: 1px solid #ce5e00;
    color: #fff;
    font-size: 18px;
    font-weight: 600;
    height: 45px;
    margin: 0 auto;
    padding: 0 60px;
}

div.jisik-pop div.outline button.close[data-v-a315ebf2] {
    position: absolute;
    right: 30px;
    top: 30px;
    width: 26px;
    height: 26px;
    border: none;
    background: url(../common/x_sign.png) no-repeat 50%/100% auto;
    font-size: 0;
}

.lt-item-wrap {
    width: 100%;
    height: 255px;
    overflow: hidden;
    border-radius: 12px;
    background: #f3f2f2;
}

.lt-item-wrap .mtit {
    margin-top: 30px;
    width: 100%;
    height: auto;
    overflow: hidden;
    text-align: center;
    font-size: 22px;
    color: #191919;
    font-weight: 600;
}

.lt-item-wrap .person-cnt-wrap {
    width: 50%;
    height: auto;
    overflow: hidden;
    float: left;
    margin-top: 30px;
}

.lt-item-wrap .person-cnt-wrap .stit {
    line-height: 1.2em;
    width: 100%;
    height: 60px;
    overflow: hidden;
    text-align: center;
    font-size: 20px;
    color: #191919;
    font-weight: 600;
}

.cnt-wrap {
    width: 220px;
    height: 46px;
    overflow: hidden;
    background: #8a8a8a;
    border-radius: 8px;
    margin: 0 auto;
    border: 1px solid #8a8a8a;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

.cnt-wrap button {
    width: 46px;
    height: 46px;
    overflow: hidden;
    border: 0;
    background: #8a8a8a;
    display: flex;
    justify-content: center;
    align-items: center;
}

.cnt-wrap .inp {
    width: 100%;
    height: 46px;
    border: 0;
    background: #fff;
    flex: 1;
    overflow: hidden;
    text-align: center;
    font-size: 18px;
    color: #2c2727;
}

.cnt-wrap button i {
    font-size: 16px;
    color: #fff;
    font-weight: bold;
}

.help-msg {
    margin-top: 40px;
    width: 100%;
    height: auto;
    overflow: hidden;
    text-align: center;
    line-height: 2em;
    font-size: 16px;
    color: #999;
}

.resev-rela-wrap {
    width: 100%;
    height: auto;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 40px 0; 
    
}

.resev-calendar-wrap {
    width: 50%;
    height: auto;
    overflow: hidden;
    margin: 0 10px;
    border-radius: 12px;
    background: #f3f2f2;
}

.resev-calendar-wrap .rtit {
    width: 100%;
    height: 50px;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 22px;
    color: #191919;
    font-weight: 600;
}

.resev-calendar-wrap .calendar-tbl-wrap {
    width: 100%;
    height: 100%;
    overflow: hidden;
    background: #fff;
    border-radius: 12px;
    position: relative;
}

.resev-calendar-wrap .calendar-func-wrap {
    width: 100%;
    height: 44px;
    overflow: hidden;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.resev-calendar-wrap .calendar-func-wrap button {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
    width: 44px;
    height: 44px;
    border: 0;
    background: transparent;
}

.resev-calendar-wrap .calendar-func-wrap button i {
    font-size: 20px;
    color: #d1d1d1;
    font-weight: bold;
    transition: all .5s;
}

.resev-calendar-wrap .calendar-func-wrap button i {
    font-size: 20px;
    color: #d1d1d1;
    font-weight: bold;
    transition: all .5s;
}

.pop-resev-wrap .pop-resev-cont-wrap .resev-calendar-wrap .calendar-func-wrap .value {
    font-size: 14px;
    color: #191919;
    font-weight: 600;
}

.resev-calendar-wrap .calendar-tbl-wrap table {
    width: calc( 100% - 20px );
    margin: 0 auto;
    table-layout: fixed;
    border: 0;
    border-collapse: collapse;
}

table > tr {
    vertical-align: middle;
}

tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}

th {
    display: table-cell;
    vertical-align: inherit;
    font-weight: bold;
    text-align: -internal-center;
}

.resev-cnt-wrap {
    width: 50%;
    height: auto;
    overflow: hidden;
    margin: 0 10px;
    border-radius: 12px;
    background: #f3f2f2;
}

.resev-cnt-wrap .rtit {
    width: 100%;
    height: 50px;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 22px;
    color: #191919;
    font-weight: 600;
}

.resev-cnt-wrap .resev-view-wrap {
    width: 100%;
    height: 100%;
    padding: 10px 20px 0 20px;
    overflow: hidden;
    background: #fff;
    border-radius: 12px;
}

.resev-cnt-wrap .resev-view-wrap .select-item-wrap {
    width: 100%;
}

.pop-resev-wrap .pop-resev-cont-wrap .resev-cnt-wrap .resev-view-wrap .select-item-wrap>a {
    width: calc( 100% - 20px );
}

.select-item-wrap>a {
    display: block;
    line-height: 35px;
    width: calc( 253px - 16px );
    height: 35px;
    border: 2px solid #8a8a8a;
    padding-left: 16px;
    font-size: 14px;
    color: #111;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
    border-radius: 6px;
    position: relative;
}

.select-item-wrap>a span {
    font-size: 14px;
    color: #2c2727;
}

.select-item-wrap>a i {
    color: #2c2727;
    font-size: 22px;
    position: absolute;
    right: 10px;
    top: 5px;
}

.select-item-wrap>.select-result-wrap {
    max-height: 200px;
    display: none;
    width: calc( 100% - 4px );
    border-radius: 6px;
    padding: 0;
    border: 2px solid #ac1f24;
    background: #fff;
    position: absolute;
    left: 0;
    top: 37px;
    overflow: hidden;
    overflow-y: auto;
}

.select-item-wrap>.select-result-wrap ul {
    width: 100%;
    height: auto;
    overflow: Hidden;
}

.select-item-wrap>.select-result-wrap ul li a {
    width: calc( 100% - 32px );
    padding: 0 16px;
    height: 35px;
    overflow: Hidden;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    font-size: 14px;
    color: #2c2727;
}

.resev-cnt-wrap dl {
    width: 100%;
    height: auto;
    overflow: hidden;
}

.resev-cnt-wrap dl dt {
    margin-top: 25px;
    width: 100%;
    height: auto;
    overflow: hidden;
    border-top: 1px solid #f3f2f2;
    padding-top: 25px;
    font-size: 14px;
    color: #2c2727;
}

.resev-cnt-wrap dl dd {
    width: 100%;
    height: auto;
    overflow: hidden;
}

.resev-cnt-wrap dl dd ul {
    width: 100%;
    height: auto;
    overflow: hidden;
}

.resev-cnt-wrap dl dd ul li {
    margin-top: 8px;
    width: 100%;
    height: auto;
    overflow: hidden;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 16px;
    color: #2c2727;
}

.resev-cnt-wrap dl dd ul li .key {
    font-size: 16px;
    color: #2c2727;
}

.resev-cnt-wrap dl dd ul li .value {
    font-size: 16px;
    color: #2c2727;
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
    
    
    <div class="container my-5 py-3">
  		<h1 class="my-3">제주시티투어버스</h1>
  		<hr>
	 	 <div class="" style="text-align:center">
	 	 	<div style="border:1px solid #333;background: url(../common/test_img.png) no-repeat;; width:100%; height:400px"></div>
	 	 	<button type="button" onclick="">예약하기</button>
	 	 </div>
	</div>
	<!--  -->
	<div class="container my-5 py-3">
  		<h3 class="my-3">요금안내</h3>
  		<hr>
  		<ul class="time-list">
    		<li> 2023. 7. 14.(금) ~ 11. 11.(토)</li>
  		</ul>
	</div>
   	<!--  -->
   	
   	<div class="container my-5 py-3">
  		<h3 class="my-3">노선안내</h3>
  		<hr>
	 	 <div class="fs-3" style="display:flex">
	 	 	우리집<div class="arrow_sign"></div>제주도
	 	 </div>
	</div>
	
   	<div class="container my-5 py-3">
  <h3 class="my-3">주의사항 및 문의전화</h3>
  <hr>
  <h4 class="tag-title mt-3">문의전화</h4>
  <ul class="time-list">
    <li><i class="xi xi-check-thin"></i> 064-741-8784~5(시티투어운영과)</li>
  </ul>

  <h4 class="tag-title mt-5">금지사항</h4>
  <ul class="time-list">
    <li><i class="xi xi-check-thin"></i> 운행중좌석이동</li>
    <li><i class="xi xi-check-thin"></i> 안전벨트 미착용</li>
    <li><i class="xi xi-check-thin"></i> 차내 음식물을 먹는행위 및 흡연</li>
    <li><i class="xi xi-check-thin"></i> 반려동물(개, 새, 고양이 등) 동반 탑승 불가 단, 가방이나 케이지 이용 시 가능</li>
  </ul>

  <h4 class="tag-title mt-5">운행중 요구사항</h4>
  <ul class="time-list">
    <li><i class="xi xi-check-thin"></i> 안전운전에 방해되는 악천후(태풍, 폭우 폭설), 국민안전처로부터 재난발생 경보가 안내되었을 경우 당사의 판단으로 운행을 중단하는 경우가 있습니다.</li>
    <li><i class="xi xi-check-thin"></i> 악천후(태풍, 폭우, 폭설)일 경우에는 당사로 미리 확인후 이용해 주시길 바랍니다.(064-741-8784~5)</li>
    <li><i class="xi xi-check-thin"></i> 고객의 개인적인 사유로 도중 하차할 경우 환불은 불가능합니다.</li>
    <li><i class="xi xi-check-thin"></i> 행사등에 이유로 교통통제가 이루어질 경우 임시운행 노선으로 운행하는 경우가 있습니다.</li>
    <li><i class="xi xi-check-thin"></i> 어린이를 동반하는 고객일 경우 반드시 같이 승차 및 착석을 해주시길 바랍니다.</li>
    <li><i class="xi xi-check-thin"></i> 긴급상황 및 안내사의 요구가 있을 때는 반드시 지시사항에 따라주시길 바립니다.</li>
    <li><i class="xi xi-check-thin"></i> 승하차 하실 때 계단 높이 및 미끄러움에 주의해주시길 바랍니다.</li>
  </ul>
</div>
   	

</div>

<!-- 질문하기  class = on붙이기 (jisik-pop on) -->
<div data-v-a315ebf2="" data-v-db46a16a="" class="jisik-pop on" >
	<div data-v-a315ebf2="" class="outline"><h3 data-v-a315ebf2="">투어버스 예약하기<small data-v-a315ebf2="">탑승인원과 탑승날짜,시간을 선택해주세요.</small></h3>
		<div data-v-a315ebf2="" class="box">
		
			<div class="lt-item-wrap">
					<div class="mtit">1. 인원 선택</div>
					<div class="person-cnt-wrap">
						<div class="stit">성인</div>
						<div class="cnt-wrap">
							<button type="button" class="btn-mius" onclick="payment.adultMinus()"><i class="el-icon-minus"></i></button>
							<input type="text" id="id_adult_cnt" class="inp" value="0">
							<button type="button" class="btn-plus" onclick="payment.adultAdd()"><i class="el-icon-plus"></i></button>
						</div>
					</div>
					<div class="person-cnt-wrap">
						<div class="stit">소인<br><span class="">(한국나이 6세이상~고등학생)</span></div>
						<div class="cnt-wrap">
							<button type="button" class="btn-mius" onclick="payment.kidMinus()"><i class="el-icon-minus"></i></button>
							<input type="text" id="id_kid_cnt" class="inp" value="0">
							<button type="button" class="btn-plus" onclick="payment.kidAdd()"><i class="el-icon-plus"></i></button>
						</div>
					</div>
				</div>
				<!--  -->
				
				<div class="resev-rela-wrap">
				
				<div class="resev-calendar-wrap">
					<div class="rtit">2.날짜 선택</div>
					<div class="calendar-tbl-wrap">
						<div class="loading" id="id_reserved_date_loading"><img src="/assets/image/ico/ico-loading.png"></div><!-- 보일 경우 class on //-->
						<div class="calendar-func-wrap">
							<button type="button" onclick="preMonth()"><i class="el-icon-arrow-left"></i></button>
							<div class="value" id="id_calendar_date">2023 . 10</div>
							<button type="button" onclick="nextMonth()"><i class="el-icon-arrow-right"></i></button>
						</div>
						<!-- 달력 //-->
						<table id="id_calendar"><tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr><tr><td><div class="rela"><div class="num">01</div></div></td><td><div class="rela"><div class="num">02</div></div></td><td><div class="rela"><div class="num">03</div></div></td><td><div class="rela"><div class="num">04</div></div></td><td><div class="rela"><div class="num">05</div></div></td><td><div class="rela"><div class="num">06</div></div></td><td><div class="rela"><div class="num">07</div></div></td></tr><tr><td><div class="rela"><div class="num">08</div></div></td><td><div class="rela"><div class="num">09</div></div></td><td><div class="rela"><div class="num">10</div></div></td><td><div class="rela"><div class="num">11</div></div></td><td><div class="rela"><div class="num">12</div></div></td><td><div class="rela"><div class="num">13</div></div></td><td><div class="rela"><div class="num">14</div></div></td></tr><tr><td><div class="rela"><div class="num">15</div></div></td><td><div class="rela"><div class="num">16</div></div></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-17&quot;,this)"><div class="num">17</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-18&quot;,this)"><div class="num">18</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-19&quot;,this)"><div class="num">19</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-20&quot;,this)"><div class="num">20</div><div class="status type01"></div></a></td><td><a href="javascript:setRevDate(&quot;N&quot;,this)" class="rela"><div class="num">21</div><div class="status type03"></div></a></td></tr><tr><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-22&quot;,this)"><div class="num">22</div><div class="status type01"></div></a></td><td><a href="javascript:setRevDate(&quot;N&quot;,this)" class="rela"><div class="num">23</div><div class="status type03"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-24&quot;,this)"><div class="num">24</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-25&quot;,this)"><div class="num">25</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-26&quot;,this)"><div class="num">26</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-27&quot;,this)"><div class="num">27</div><div class="status type01"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-28&quot;,this)"><div class="num">28</div><div class="status type01"></div></a></td></tr><tr><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-29&quot;,this)"><div class="num">29</div><div class="status type01"></div></a></td><td><a href="javascript:setRevDate(&quot;N&quot;,this)" class="rela"><div class="num">30</div><div class="status type03"></div></a></td><td><a href="javascript:void(0)" class="rela" onclick="setRevDate(&quot;2023-10-31&quot;,this)"><div class="num">31</div><div class="status type01"></div></a></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
						<!-- 달력 //-->
						
					</div>
				</div>


				
				<div class="resev-cnt-wrap">
					<div class="rtit">3.시간 선택</div>
					<div class="resev-view-wrap">
						<div class="select-item-wrap" id="id_b_time_select_list">
							<a href="javascript:getRevDate()"><span id="id_b_time_select_txt">시간을 선택해 주세요.</span><i class="el-icon-caret-bottom"></i></a>
							<div class="select-result-wrap">
								<!--탑승시간//-->
								<ul id="id_board_time"></ul>
								<!--탑승시간//-->
							</div>
						</div>
						<dl>
							<dt>● 선택 정보</dt>
							<dd>
								<ul>
									<li><div class="key">코스 정보</div><span id="id_reserved_title_sub" class="value">도심고궁남산코스</span></li>
									<li><div class="key">탑승 날짜</div><span id="id_reserved_revdate" class="value"></span></li>
									<li><div class="key">탑승 시간</div><span id="id_reserved_time" class="value"></span></li>
								</ul>
							</dd>
						</dl>
						
					
					</div>
				</div>
					
	
			</div>
			<!--  -->
			<button data-v-a315ebf2="" type="button" class="submit">예약하기</button>
			<button data-v-a315ebf2="" type="button" class="close">창 닫기</button>
			<!--  -->
			<div class="help-msg">※ 취소 / 환불 안내<br>
					탑승 2일전부터는 취소 수수료가 발생하며 무통장입금으로 결제한 경우는 고객상담 전화(02-777-6090)을 통해서만 환불이 가능합니다.<br>
					탑승일로부터 3일 전 취소 시 요금의 100% 환불<br>
					탑승일로부터 2일 전 취소 시 요금의 90% 환불<br>
					탑승일로부터 1일 전 취소 시 요금의 80% 환불<br>
					탑승일 당일 취소 시 70%환불 (단, 야경투어는 당일 낮 12시 이후 취소 시 환불 불가)<br>
					※ 예약 확인, 취소 등을 위해 꼭 비밀번호를 확인해 주세요.<br>
					※ 일정 변경이나 기타 문제 발생 시 안내를 위해 정확한 연락처를 입력해 주세요.<br>
					※ 도심고궁남산코스는 순환 코스로 예약하신 시간이 아니더라도 자유롭고 편한 시간대에 이용하실 수 있습니다.<br>
					※ 일시적으로 관광객이 몰리는 시간대에는 입석이 있을 수 있습니다.
				</div>
				<!--  -->
				
				

	</div>
</div>
</div>

   

</body>
</html>