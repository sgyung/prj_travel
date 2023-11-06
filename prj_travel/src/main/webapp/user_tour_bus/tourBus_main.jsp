<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.TourBusVO"%>
<%@page import="java.util.List"%>
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
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://192.168.10.133/prj_travel/common/CSS/tour_bus.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">


</style>
<c:catch var="se" >
<%
	
	try{
	TourBusDAO tDAO = TourBusDAO.getInstance();
	List<TourBusVO> tourList = tDAO.selectAllTourBus();
	
	pageContext.setAttribute("tourList", tourList);
	} catch( SQLException se ){
		System.out.println(se);
	}
%>
</c:catch >
<c:if test="${ not empty se }">
	투어버스 정보를 불러오는데 실패 하였습니다.
</c:if>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div class="wrap">
<%@ include file="../common/jsp/header.jsp" %>
    <div class="container" id="content">
    	<section class="sub-header-wrap" style="background:url(../common/images/tour_bus_img/tour_bus_main.png) no-repeat center top;">
			<div class="mtit"></div>
		</section>
    
    	<section class="resev-page-wrap">
			<!-- Swiper -->
			<div id="main-course-wrap" class="swiper-container swiper-container-initialized swiper-container-horizontal">
				<div class="swiper-wrapper">
				<form action="tour_bus_detail_process.jsp">
				</form>
				<c:forEach var="tour" items="${ tourList }" varStatus="i">
						<div class="swiper-slide swiper-slide-active" style="width: 380px; margin-right: 18px;">
							<div class="slide-item" style="background:url(../common/images/tour_bus_img/${ tour.image }) no-repeat center top"></div>
							<div class="cont">
								<div class="top-item">
									<span>TOUR0${ i.count }</span>
									<strong><c:out value="${ tour.name }" /></strong>
								</div>
								<div class="bottom-item">
									<f:formatNumber value="${ tour.adultFare }" pattern="#,##0" var="adultFare" />
									<f:formatNumber value="${ tour.childFare }" pattern="#,##0" var="childFare" />
										<span>성인 ${ adultFare } 원 / 소인 ${ childFare } 원</span>
										<a href="tourBus_detail.jsp?tourbus_contId=${ tour.id }" style="text-decoration :none">
											<button type="button" style="cursor: pointer">코스선택</button>
										</a>
								</div>
							</div>
						</div>
					</c:forEach>
					
			
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
    <%@ include file="../common/jsp/footer.jsp" %>
</div>
</body>
</html>