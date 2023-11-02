<%@page import="java.util.List"%>
<%@page import="user.vo.TourBusVO"%>
<%@page import="user.dao.TourBusDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png"> -->
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://192.168.10.133/prj_travel/common/CSS/tour_bus_detail.css">

<style type="text/css">

.container li{
list-style-image: url("../common/images/icon_img/check.png");
        font-size : 20px;
}
    
.arrow {
    display: flex;
    align-items: center;
    justify-content: center;
    background: #efefef;
    width: 40px;
    height: 40px;
    font-size: 20px;
    border-radius: 50%;
    margin: 0 10px;
}

td {
    height: 50px;
}

.Calendar { 
    text-align: center;
    margin: 0 auto; 
}

.Calendar>thead>tr:first-child>td { font-weight: bold; }

.Calendar>thead>tr:last-child>td {
    background-color: gray;
    color: white;
}        

.pastDay{ background-color: lightgray; }

.today{        
	border-radius : 15px;    
    background-color: #FFCA64;            
    cursor: pointer;
}

.futureDay{            
    background-color: #FFFFFF;
    cursor: pointer;
}

.futureDay.choiceDay, .today.choiceDay{  
	border-radius : 15px;          
    background-color: #ef6d00;            
    color: #fff;
    cursor: pointer;
}

</style>
<%
	String contId = request.getParameter("tourbus_contId");

	if( contId == null ){
		response.sendRedirect("tourBus_main.jsp");
		return;
	}//end if
	
	TourBusDAO tDAO = TourBusDAO.getInstance();
	TourBusVO tVO =  tDAO.selectTourBus(contId);
	List<String> routeList = tDAO.selectTourRoute(contId);
	List<String> timeList = tDAO.selectTourTime(contId);
	
	int routeCnt = routeList.size();
	pageContext.setAttribute("tVO", tVO);
	pageContext.setAttribute("contId", contId );
	pageContext.setAttribute("routeList", routeList);
	pageContext.setAttribute("timeList", timeList);
	pageContext.setAttribute("routeCnt", routeCnt);
	
%>
<script type="text/javascript">
$(function(){
	$("#reservationBtn").click(function(){
		$("#reservationPop").show();
	})//click
	
	$("#reserCloseBtn").click(function(){
		$("#reservationPop").hide();
	})//click
	
	//성인 plus,minus버튼
	$("#adultPlusBtn").click(function(){
		var currentCnt = parseInt($("#id_adult_cnt").val());
		var nextCnt = currentCnt + 1;
		if( currentCnt >= 30 ){
			nextCnt = 30;
		}
		$("#id_adult_cnt").val(nextCnt);
	})//end click
	$("#adultMinusBtn").click(function(){
		var currentCnt = parseInt($("#id_adult_cnt").val());
		var nextCnt = currentCnt - 1;
		if( currentCnt == 0 ){
			nextCnt = 0;
		}
		$("#id_adult_cnt").val(nextCnt);
	})//end click
	
	//소아 및 청소년 plus,minus버튼
	$("#childPlusBtn").click(function(){
		var currentCnt = parseInt($("#id_kid_cnt").val());
		var nextCnt = currentCnt + 1;
		if( currentCnt >= 30 ){
			nextCnt = 30;
		}
		$("#id_kid_cnt").val(nextCnt);
	})//end click
	$("#childMinusBtn").click(function(){
		var currentCnt = parseInt($("#id_kid_cnt").val());
		var nextCnt = currentCnt - 1;
		if( currentCnt == 0 ){
			nextCnt = 0;
		}
		$("#id_kid_cnt").val(nextCnt);
	})//end click
	
	$(document).on( "click", ".dropdown-item", function(){
		var select = $(this).text();
		$("#selectTime").text(select);
		$("#id_reserved_time").text(select);
	})//on
	
	$(document).on("click", function(event){
		var target = $(event.target);
		
		if( target.is("td") && !target.hasClass("pastDay")){
			var year = $("#calYear").text();
			var month = $("#calMonth").text();
			var day = target.text();
			var reservedDate = year + "-" + month + "-" + day
			$("#id_reserved_revdate").text(reservedDate)
		}
	})//on
	
	$("#lastReservationBtn").click(function(){
		var contId = $("#contId").val();
		var selectDate = $("#id_reserved_revdate").text();
		var selectTime = $("#id_reserved_time").text();
		var selectAdultFare =$("#id_adult_cnt").val();
		var selectChildFare = $("#id_kid_cnt").val();
		var userId = $("#userId").val();
		var userName = $("#userName").val();
		
		if( selectDate == "" ){ 
			alert("날짜를 선택해 주세요.");
			return;
		}
		if( selectTime =="" ){ 
			alert("버스 시간을 선택해 주세요.");
			return;
		}
		if( (selectAdultFare==0 && selectChildFare==0) ){ 
			alert("탑승인원을 선택해 주세요.");
			return;
		}
		var flag = confirm("예약 하시겠습까?");
		if( !flag ){
			return;
		}//end if
		
		var jsonObj = {
				"contId" : contId,
				"date" : selectDate,
				"time" : selectTime,
				"adult" : selectAdultFare,
				"child" : selectChildFare,
				"userId" : userId,
				"userName" :  userName
		}
		
		$.ajax({
			url : "tourBus_reserve_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonObj ){
				if( jsonObj.resultFlag ){
					alert("예약이 완료 되었습니다.");
					
					$("#reservationPop").hide();
					// redirection 시키기 완료페이지로
				}//end if
			}
		})//ajax
	})//click
	
});//ready
	
</script>
<script src="../common/JS/calendar.js" defer></script>
</head>
<body>

<div class="wrap">
<div class="header">
        <div class="header_contents flex">
            <div class="logo">JEJU VISIT</div>
            <div class="nav_top">
                <ul>
                    <li><a href="http://192.168.10.133/prj_touristArea/touristArea.jsp">관광지</a></li>
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
    	<input type="hidden" id="contId" value="${contId }" />
    	<input type="hidden" id="userName" value="장용석" /><!-- session값 넣기  -->
    	<input type="hidden" id="userId" value="jys" /><!-- session값 넣기  -->
  		<h1 class="my-3">${ tVO.name }</h1>
  		<hr>
	 	 <div class="" style="text-align:center">
	 	 	<div style="border:1px solid #333;background: url(../common/images/tour_bus_img/test_img.png) no-repeat;; width:100%; height:400px"></div>
	 	 	<button type="button" id="reservationBtn">예약하기</button>
	 	 </div>
	</div>
	<!--  -->
	<div class="container my-5 py-3">
  		<h3 class="my-3">요금안내</h3>
  		<hr>
  		<ul class="time-list">
  		<f:formatNumber value="${ tVO.adultFare }" pattern="#,##0" var="adultFare" />
  		<f:formatNumber value="${ tVO.childFare }" pattern="#,##0" var="childFare" />
    		<li>성인 : ${ adultFare }</li>
    		<li>소인 및 청소년 : ${ childFare }</li>
    		<li>6세 미만 : 무료 </li>
  		</ul>
	</div>
   	<!--  -->
   	
   	<div class="container my-5 py-5">
  		<h3 class="my-3">노선안내</h3>
  		<hr>
	 	 <div class="fs-4" style="display:flex">
	 	 	<c:forEach var="route" items="${ routeList }" varStatus="i">
	 	 	${ route }<div class="arrow">&gt;</div>
	 	 		<c:if test="${ i.count eq routeCnt  }" >
	 	 			${ route }
	 	 		</c:if>
	 	 	</c:forEach>
	 	 </div>
	</div>
	
   	<div class="container my-5 py-3">
  <h3 class="my-3">주의사항 및 문의전화</h3>
  <hr>
  <h4 class="tag-title mt-3">문의전화</h4>
  <ul class="time-list">
    <li><i class="xi xi-check-thin"></i> ${ tVO.tel }</li>
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
<div data-v-a315ebf2="" data-v-db46a16a="" class="jisik-pop" id="reservationPop">
	<div data-v-a315ebf2="" class="outline"><h3 data-v-a315ebf2="">투어버스 예약하기<small data-v-a315ebf2="">탑승인원과 탑승날짜,시간을 선택해주세요.</small></h3>
		<div data-v-a315ebf2="" class="box">
		
			<div class="lt-item-wrap">
					<div class="mtit">1. 인원 선택</div>
					<div class="person-cnt-wrap">
						<div class="stit">성인</div>
						<div class="cnt-wrap">
							<button type="button" class="btn-mius" id="adultMinusBtn" style="background: url(../common/images/icon_img/minus_btn.png) no-repeat; background-position: 13px 10px;"></button>
							<input type="text" id="id_adult_cnt" class="inp" value="0">
							<button type="button" class="btn-plus" id="adultPlusBtn" style="background: url(../common/images/icon_img/plus_btn.png) no-repeat; background-position: 11px 8px;"></button>
						</div>
					</div>
					<div class="person-cnt-wrap">
						<div class="stit">소인 및 청소년<br><span class="">(한국나이 6세이상~고등학생)</span></div>
						<div class="cnt-wrap">
							<button type="button" class="btn-mius" id="childMinusBtn" style="background: url(../common/images/icon_img/minus_btn.png) no-repeat; background-position: 13px 10px;"></button>
							<input type="text" id="id_kid_cnt" class="inp" value="0">
							<button type="button" class="btn-plus" id="childPlusBtn" style="background: url(../common/images/icon_img/plus_btn.png) no-repeat; background-position: 11px 8px;"></button>
						</div>
					</div>
				</div>
				<!--  -->
				
				<div class="resev-rela-wrap">
				
				<div class="resev-calendar-wrap">
					<div class="rtit">2.날짜 선택</div>
					<div class="calendar-tbl-wrap">
						
						<!-- 달력 //-->
						<table class="Calendar">
					        <thead>
					            <tr>
					                <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
					                <td colspan="5">
					                    <span id="calYear"></span>년
					                    <span id="calMonth"></span>월
					                </td>
					                <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
					            </tr>
					            <tr>
					                <td style="border-radius:10px 0 0 0">일</td>
					                <td>월</td>
					                <td>화</td>
					                <td>수</td>
					                <td>목</td>
					                <td>금</td>
					                <td  style="border-radius: 0 10px 0 0">토</td>
					            </tr>
					        </thead>
					        <tbody>
					        </tbody>
					    </table>
					   
						<!-- 달력 //-->
						
					</div>
				</div>


				
				<div class="resev-cnt-wrap">
					<div class="rtit">3.시간 선택</div>
					<div class="resev-view-wrap">
						<div class="select-item-wrap" id="id_b_time_select_list">
							<div class="dropdown">
							  <a class="btn btn-primary dropdown-toggle" id="selectTime" 
							  	role="button" data-bs-toggle="dropdown" aria-expanded="true"
							  	style="background-color: #FFFFFF;	border-color: #ce5e00;color:#000000;	width:100%;	height:50px; font-size:20px">
							    시간을 선택해 주세요.
							  </a>

								  <ul class="dropdown-menu" style="width:100%">
								  	<c:forEach var="time" items="${ timeList }" >
								    	<li><a class="dropdown-item" style="font-size:20px">${ time }</a></li>
								    </c:forEach>
								  </ul>
								</div>
							<div class="select-result-wrap">
								<!--탑승시간//-->
								<ul id="id_board_time"></ul>
								<!--탑승시간//-->
							</div>
						</div>
						<dl>
							<dt style="font-size:large">● 선택 정보</dt>
							<dd>
								<ul>
									<li><div class="key">코스 정보</div><span id="id_reserved_title_sub" class="value">${ tVO.name }</span></li>
									<li><div class="key">탑승 날짜</div><span id="id_reserved_revdate" class="value"></span></li>
									<li><div class="key">탑승 시간</div><span id="id_reserved_time" class="value"></span></li>
								</ul>
							</dd>
						</dl>
						
					
					</div>
				</div>
					
	
			</div>
			<!--  -->
			<button data-v-a315ebf2="" type="button" class="submit" id="lastReservationBtn">예약하기</button>
			<button data-v-a315ebf2="" type="button" class="close" id="reserCloseBtn">창 닫기</button>
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