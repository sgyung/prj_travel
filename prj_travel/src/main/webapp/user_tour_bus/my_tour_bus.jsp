<%@page import="user.vo.MyTourBusVO"%>
<%@page import="user_mypageDAO.MyTourBusDAO"%>
<%@page import="user_mypageDAO.MyQnADAO"%>
<%@page import="user.vo.QnAVO"%>
<%@page import="user.dao.QnADAO"%>
<%@page import="user.vo.ReviewVO"%>
<%@page import="user.dao.ReviewDAO"%>
<%@page import="pageUtil.Paging"%>
<%@page import="user.vo.TouristAreaVO"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="관광지 상세페이지" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String userId = (String)session.getAttribute("sesId");
	
	MyTourBusDAO mtbDAO = MyTourBusDAO.getInstance();
	
	int totalMyTour = mtbDAO.selectTotalReservation(userId);
	List<MyTourBusVO> tourList = mtbDAO.selectMyTour(userId);
	//나의 투어 예약 리스트
	pageContext.setAttribute("tourList", tourList );
	pageContext.setAttribute("totalMyTour", totalMyTour );

	
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
<!--  -->
<link rel="stylesheet" type="text/css" href="http://192.168.10.133/prj_travel/common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">
table.jisik_list[data-v-db46a16a] {
   width: 100%;
   border-top: 2px solid #535353;
}
</style>
<script language="javascript">
$(function(){
	$(".deleteBtn").click(function(){
		var reserveId = $(this).next("input.reservation_id").val();
		
		var confirmed = confirm("예약을 취소 하시겠습니까?");
		if(confirmed){
			$.ajax({
				url : "http://192.168.10.133/prj_travel/user_tour_bus/tour_bus_delete_process.jsp",
				type : "get",
				dataType : "json",
				data : { "reserveId" : reserveId },
				error : function( xhr ){
					alert(xhr.status);
				},
				success : function( jsonObj ){
					if( jsonObj ){
						alert("예약이 취소되었습니다.");
						location.reload();
					}//end if
				}//success
			})//ajax
		} else {
			return;
		}//end else
	})//click
});//ready
</script>
</head>
<body>
<div id="wrap" class="wrap">
<%@ include file="../common/jsp/header.jsp" %>
   	<div id="detailContentsView">
	<div class="cont_wrap sub_visual" data-v-09a75c9f="">
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail" data-v-09a75c9f="">
					<div class="add2020_detail_tab" data-v-09a75c9f="">
						<ul data-v-09a75c9f="">
							<!--질문게시판  -->
							<li data-v-09a75c9f="">
								<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
									<h2 data-v-09a75c9f=""><a  data-v-09a75c9f="" id="qnaFadeBtn" class="up">질문<span class="arrow" data-v-09a75c9f=""></span></a></h2>
									<div id="stab6" transition="fadeIn" class="add2020_detail_con tab_cont kr" style data-v-db46a16a="" data-v-09a75c9f=""><p class="jisik_tit" data-v-db46a16a="">
        								나의 투어 예약 <span id="qnaCnt"  data-v-db46a16a=""><c:out value="(${ totalMyTour })" /></span>
        								<table class="jisik_list" data-v-db46a16a="" >
        									<thead data-v-db46a16a="">
        										<tr data-v-db46a16a="">
        											<th data-v-db46a16a="">투어이름</th>
        											<th data-v-db46a16a="">승인상태</th>
        											<th data-v-db46a16a="">탑승인원</th>
        											<th data-v-db46a16a="">버스시간</th>
        											<th data-v-db46a16a="">예약일자</th>
        											<th data-v-db46a16a="">예약취소</th>
       											</tr>
   											</thead>
   											<tbody data-v-db46a16a="" id="myTourTbody" >
   												<c:choose>
   												<c:when test="${ not empty tourList }">
   												<c:forEach var="tour" items="${ tourList }">
   												<tr data-v-db46a16a=""  class="tourList">
   													<td data-v-db46a16a="" style="width:0; text-align:center"><c:out value="${ tour.name }"></c:out>	</td>								
													<td data-v-db46a16a="" style="color:#ef6d00"><c:out value="${ tour.state eq 'N'? '미승인' : '승인'}"></c:out></td>
													<td data-v-db46a16a=""><c:out value="성인 : ${ tour.adult }   소인 : ${ tour.child }"></c:out></td>
													<td data-v-db46a16a=""><c:out value="${ tour.reservedTime }"></c:out></td>
													<td data-v-db46a16a=""><c:out value="${ tour.reservedDate }"></c:out></td>
													<td data-v-db46a16a="">
														<button class="btn deleteBtn" style="  background: #ef6d00; color: #fff;">취소</button>
														<input type="hidden" class="reservation_id" id="reservation_id" value="${ tour.id }" />
													</td>
												</tr>
												</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="6" style="text-align:center; font-size:large; ">예약한 투어버스가 없습니다.</td>
													</tr>
												</c:otherwise>
												</c:choose>
											</tbody>
										</table>
        						<!---->
        						
       							</div>
        							
        							<!-- 질문하기  class = on붙이기 (jisik-pop on) -->
        							<div data-v-a315ebf2="" data-v-db46a16a="" class="jisik-pop" id="qnaPop">
        								<div data-v-a315ebf2="" class="outline"><h3 data-v-a315ebf2="">질문하기<small data-v-a315ebf2="">제주관광 관련 궁금한 점을 작성하여 주세요. 관련된 분야의 전문 지식인의 답변을 받으실 수 있습니다.</small></h3>
        									<div data-v-a315ebf2="" class="box">
        										<div data-v-a315ebf2="" class="text">
        											<h5 data-v-a315ebf2="">질문입력</h5>
        											<input id="qTitle" name="qTitle" data-v-a315ebf2="" type="text" placeholder="제목을 입력하세요">
        											<textarea id="qContent" name="qContent" data-v-a315ebf2="" placeholder="내용을 입력하세요"></textarea>
       											</div>
											<button data-v-a315ebf2="" type="button" class="submit" id="qnaSubmitBtn">작성완료</button>
											<button data-v-a315ebf2="" type="button" class="close" id="closeBtn">창 닫기</button>
										</div>
									</div>
									</div>
        							
        							
        							<!-- 질문 답변 -->
        							<div data-v-0fc691de="" data-v-db46a16a="" class="jisik-detail"  id="qnaDetail">
        							<div data-v-0fc691de="" class="outline">
        								<ul data-v-0fc691de="" class="jisik_list" id="qnaDetailView">
        									
											</ul>
											<button data-v-0fc691de="" type="button" id="qnaDetailClose"  class="close">창 닫기</button>
											</div>
											</div>
        							
        							<!----><!---->
        							<div data-v-9db46a28="" data-v-db46a16a=""><!----></div></div></li>
				       		 <!--리뷰  -->
                                                </ul>
                                               </div></div>
										 <div class="clear" data-v-09a75c9f="">
									 </div>
								 </div>
							 </div>
						 </div>
					 </div>
				 </div>
				 <!---->
		 </div>
    </div>
    <%@ include file="../common/jsp/footer.jsp" %>
</body>
</html>