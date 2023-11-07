<%@page import="user_mypageDAO.MyReviewDAO"%>
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
<%@ page info="마이리뷰페이지" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	String userId = (String)session.getAttribute("sesId");

	int pageScale = 5;
	Paging paging = Paging.getInstance();
	
	//리뷰
	String reviewPage = request.getParameter("reviewPage");
	int reviewCurrentPage = 1;
	if( reviewPage != null){
		reviewCurrentPage = Integer.parseInt(reviewPage);
	}
	MyReviewDAO rDAO = MyReviewDAO.getInstance();
	int taReviewCnt = rDAO.selectReviewCnt(userId, "관광지");
	int resReviewCnt = rDAO.selectReviewCnt(userId, "맛집");
	
	int rPagePerNum = 5;// 한 화면에 보여줄 페이지 번호 수
	//관광지page
	int taReviewPage = paging.getTotalPage(taReviewCnt, pageScale);
	//화면에 보여질 페이지 시작번호[0], 끝번호[1] 
	int[] taReviewPageCnt = paging.getTotalPageCnt(reviewCurrentPage, taReviewPage, rPagePerNum);
	pageContext.setAttribute("taStartNum", taReviewPageCnt[0]);
	pageContext.setAttribute("taEndNum", taReviewPageCnt[1]);
	
	//맛집page
	int resReviewPage = paging.getTotalPage(resReviewCnt, pageScale);
	int[] resReviewPageCnt = paging.getTotalPageCnt(reviewCurrentPage, resReviewPage, rPagePerNum);
	pageContext.setAttribute("resStartNum", resReviewPageCnt[0]);
	pageContext.setAttribute("resEndNum", resReviewPageCnt[1]);
	
	//관광지 리뷰 리스트
	int[] taReviewRange = paging.getPageRowRange(reviewCurrentPage, pageScale);
	List<ReviewVO> taReviewList = rDAO.selectPageReview(taReviewRange[0], taReviewRange[1], userId, "관광지");
	//맛집 리뷰 리스트
	int[] resReviewRange = paging.getPageRowRange(reviewCurrentPage, pageScale);
	List<ReviewVO> resReviewList = rDAO.selectPageReview(resReviewRange[0], resReviewRange[1], userId, "맛집");
	
	//review
	
	pageContext.setAttribute("pagePerNum", rPagePerNum );
	pageContext.setAttribute("taReviewPage", taReviewPage );
	pageContext.setAttribute("resReviewPage", resReviewPage );
	pageContext.setAttribute("taReviewList", taReviewList );
	pageContext.setAttribute("resReviewList", resReviewList );
	pageContext.setAttribute("taReviewCnt", taReviewCnt );
	pageContext.setAttribute("resReviewCnt", resReviewCnt );
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
.tab_cont .cont_tit {
    font-size: 24px;
    font-weight: 800;
    color: #1b1b1b;
    line-height: 24px;
}

.deleteBtn {
	color:#FFFFFF;
	width:70px;
	heigth:50px;
	background:#ef6d00;
}

.detail_page .util_wrap .util_area {
    float: left;
}

li.review_item:hover {
  background-color: #f0f0f0
}

li.review_item {
  background-color: white; /* 기본 배경색 (하얀색) */
  transition: background-color 0.3s; /* 배경색 전환 효과를 추가 */
}
</style>
<script language="javascript">
$(function(){
	var reviewPage = 1;
	//리뷰 게시글
	$(document).on("click", ".ta_review_page_btn", function(){
		var userId = "${sesId}";
		var category = "";
		$(".categoryBtn").each(function(){
			if( $(this).hasClass("on") ){
				category = $(this).text();
			}//end if
		})
		
		var selectPage = $(this).text();
		reviewPage = parseInt(selectPage);
		$(".ta_review_page_btn").each(function(){
			if( $(this).hasClass("current") ){
				$(this).removeClass("current");				
			}//end if
		})//clickf
		$(this).addClass("current");
		var jsonObj = {
				userId : userId,
				areaType : category,
				selectPage : reviewPage,
				pageScale : 5
				};
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_review/review_page_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonArr ){
				var liNode = "";
				$.each( jsonArr , function( i, jsonObj){
					var starScore = jsonObj.starScore * 20;
					liNode += "<li id='contentsReviewItem" + i + "' class='review_item'>"
					liNode += "<div class='review_area clear'>";
					liNode += "<div class='user_profile'>"
					liNode += "<div class='photo_area'>"
					liNode += "<img src='http://192.168.10.133/prj_travel/common/images/icon_img/img_non_profile.png' alt='프로필이미지' class='user_profile_img'>"
					liNode += "</div>"
					liNode += "<p class='user_name'>" + jsonObj.userId + "</p>"
					liNode += "<p class='reg_date'>" +  jsonObj.date + "</p>"		
					liNode += "<div class='score_area_p'>"	
					liNode += "<p class='score_count_p' style='width:"+ starScore + "%;'>" + jsonObj.starScore + "</p>"
					liNode += "	</div>"	;
					liNode += "	</div>"	;
					liNode += "<div class='user_content'>";
					liNode += "<div class='review clear'><p class='review_txt'>" + jsonObj.content + "</p>";
					liNode += "<p class='review_origin_text' style='display:none;'></p>"
					liNode += "</div>"	;	
					liNode += "</div>"	;
					liNode += "<button type='button' class='btn btn-primary deleteBtn' style='color:white'>삭제</button>"	;
					liNode += "<input type='hidden' class='reviewId' value='"+ jsonObj.reviewId  +"'/>"	;
					liNode += "<input type='hidden' class='areaId' value='"+ jsonObj.areaId  +"'/>"	;
					liNode += "</div>"	;
					liNode += "</li>"	;
				})//each
				$("#review_list").html(liNode);
			}//success
		})//ajax
		
	})//on	
	
	//리뷰 페이지 다음 버튼
	$(document).on("click", "#reviewNextBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#taTotalPage").val();
		var jsonData = {
				"currentPage" : reviewPage,
				"totalPage" : totalPage,
				"pagePerNum" : pagePerNum,
				"actionType" : "next"
				};
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_tourist_area/page_process.jsp",
			data : jsonData,
			type : "get",
			dataType : "JSON",
			error : function( xhr ){
				alert( xhr.status );
			},
			success : function( jsonObj ) {
				var startPage = jsonObj.startPage;
				var endPage = jsonObj.endPage;
				var nextPage = reviewPage + 1;  
				var nextFlag = jsonObj.nextFlag;
				var output = "";
				if( nextFlag ){
					$(".ta_review_page_btn").each(function(){
						if( $(this).text() == nextPage ){
							$(this).click();
						}//end if
					})
				} else {
					for( let i = startPage; i<=endPage; i++){
						if( i == startPage ){
							output += "<a href='javascript:void(0)' class='spr_com page-prev' id='reviewPrevBtn'>이전 페이지</a>"							
							output += "<a href='javascript:void(0)' title='현재 페이지' class='current ta_review_page_btn'>"+ i +"</a>";
							
						} else if(i == endPage) {
							output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
							output += "<a href='javascript:void(0)' class='spr_com page-next' id='reviewNextBtn'>다음 페이지</a>"
						} else {
							output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
						}
					
					$("#paging").empty();
					$("#paging").append(output);
					
					$(".current").click();
					}//end for
				}//end else
			}//success
		})//ajax
	})//on
	
	//리뷰 페이지 이전 버튼
	$(document).on("click", "#reviewPrevBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#taTotalPage").val();
		var page = reviewPage;
	
		var jsonData = {
				"currentPage" : reviewPage,
				"totalPage" : totalPage,
				"pagePerNum" : pagePerNum,
				"actionType" : "prev"
				};
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_tourist_area/page_process.jsp",
			data : jsonData,
			type : "get",
			dataType : "JSON",
			error : function( xhr ){
				alert( xhr.status );
			},
			success : function( jsonObj ) {
				var startPage = jsonObj.startPage;
				var endPage = jsonObj.endPage;
				
				var prevPage = reviewPage - 1;
				
				var prevFlag = jsonObj.nextFlag;
				var output = "";
				if( prevFlag ){
					$(".ta_review_page_btn").each(function(){
						if( $(this).text() == prevPage ){
							$(this).click();
						}//end if
					})
				} else {
					for( let i = startPage; i<=endPage; i++){
						if( i == startPage ){
							output += "<a href='javascript:void(0)' class='spr_com page-prev' id='reviewPrevBtn'>이전 페이지</a>"							
							output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
							
						} else if (i == endPage){
							output += "<a href='javascript:void(0)' title='현재 페이지' class='current ta_review_page_btn'>"+ i +"</a>";
							output += "<a href='javascript:void(0)' class='spr_com page-next' id='reviewNextBtn'>다음 페이지</a>"
							
						} else {
							output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
						}
							
					}//end for
					$("#paging").empty();
					$("#paging").append(output);
					
					$(".current").click();
				}//end else
			}//success
		})//ajax
	})//on
	
	//관광지 | 맛집 카테고리 선택
	$(".categoryBtn").click(function(){
		var areaType = $(this).text();
		var userId = "${sesId}";
		var selectPage = 1;
		reviewPage = selectPage;
		
		$(this).addClass("on");
		$(".categoryBtn").not(this).removeClass("on");

		var jsonObj = {
				userId : userId,
				areaType : areaType,
				selectPage : reviewPage,
				pageScale : 5
				};
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_review/review_page_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonArr ){
				var liNode = "";
				$.each( jsonArr , function( i, jsonObj){
					var starScore = jsonObj.starScore * 20;
					liNode += "<li id='contentsReviewItem" + i + "' class='review_item'>"
					liNode += "<div class='review_area clear'>";
					liNode += "<div class='user_profile'>"
					liNode += "<div class='photo_area'>"
					liNode += "<img src='http://192.168.10.133/prj_travel/common/images/icon_img/img_non_profile.png' alt='프로필이미지' class='user_profile_img'>"
					liNode += "</div>"
					liNode += "<p class='user_name'>" + jsonObj.userId + "</p>"
					liNode += "<p class='reg_date'>" +  jsonObj.date + "</p>"		
					liNode += "<div class='score_area_p'>"	
					liNode += "<p class='score_count_p' style='width:"+ starScore + "%;'>" + jsonObj.starScore + "</p>"
					liNode += "	</div>"	;
					liNode += "	</div>"	;
					liNode += "<div class='user_content'>";
					liNode += "<div class='review clear'><p class='review_txt'>" + jsonObj.content + "</p>";
					liNode += "<p class='review_origin_text' style='display:none;'></p>"
					liNode += "</div>"	;	
					liNode += "</div>"	;
					liNode += "<button type='button' class='btn btn-primary deleteBtn' style='color:white'>삭제</button>"	;
					liNode += "<input type='hidden' class='reviewId' value='"+ jsonObj.reviewId  +"'/>"	;
					liNode += "<input type='hidden' class='areaId' value='"+ jsonObj.areaId  +"'/>"	;
					liNode += "</div>"	;
					liNode += "</li>"	;
				})//each
				$("#review_list li").remove();
				$("#review_list").html(liNode);
				
				if( areaType == "관광지"){
					var totalPage = $("#taTotalPage").val();
				} else {
					var totalPage = $("#resTotalPage").val();
				}//end else
					
				var jsonData = {
						"currentPage" : 1,
						"totalPage" : totalPage,
						"pagePerNum" : 5,
						"actionType" : "next"
						};
				
				$.ajax({
					url : "http://192.168.10.133/prj_travel/user_tourist_area/page_process.jsp",
					data : jsonData,
					type : "get",
					dataType : "JSON",
					error : function( xhr ){
						alert( xhr.status );
					},
					success : function( jsonObj ) {
						var startPage = jsonObj.startPage;
						var endPage = jsonObj.endPage;
						var nextPage = reviewPage + 1;  
						var nextFlag = jsonObj.nextFlag;
						var output = "";
						for( let i = startPage; i<=endPage; i++){
							if( i == startPage ){
								output += "<a href='javascript:void(0)' class='spr_com page-prev' id='reviewPrevBtn'>이전 페이지</a>"							
								output += "<a href='javascript:void(0)' title='현재 페이지' class='current ta_review_page_btn'>"+ i +"</a>";
								
							} else if(i == endPage) {
								output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
								output += "<a href='javascript:void(0)' class='spr_com page-next' id='reviewNextBtn'>다음 페이지</a>"
							} else {
								output += "<a href='javascript:void(0)' class='ta_review_page_btn'>"+ i +"</a>";
							}
						
						$("#paging").empty();
						$("#paging").append(output);
						
						}//end for
					}//success
				})//ajax
			}//success
		})//ajax
	})//click
	
	//리뷰삭제
	$(document).on("click", ".deleteBtn", function(){
		var reviewId = $(this).next("input.reviewId").val();
		var confirmed = confirm("삭제 하시겠습니까?");
		if( confirmed ){
			$.ajax({
				url : "http://192.168.10.133/prj_travel/user_review/review_delete_process.jsp",
				data : { "reviewId" : reviewId },
				dataType : 'json',
				type : "get",
				error : function( xhr ){
					alert(xhr);
				},
				success : function( jsonObj ){
					if( jsonObj.resultFlag ){
						alert("삭제되었습니다.");
						location.reload();
					}
				}//success
			})//ajax
			
		} else {
			return;
		}
		
		
	})//on
	
	$(document).on("click", ".review_item", function(){
		if( !$(event.target).is(".deleteBtn")){
			var areaId = $(this).find('.areaId').val()
			var areaPath = "";
			var category = "";
			$(".categoryBtn").each(function(){
				if( $(this).hasClass("on") ){
					category = $(this).text();
				}//end if
			})
			
			if( category == "관광지"){
				areaPath = "user_tourist_area/touristArea_detail.jsp?contentInfo="
			} else {
				areaPath = "user_restaurant/restaurant_detail.jsp?contentInfo="
			}//end else

			location.href="http://192.168.10.133/prj_travel/" + areaPath + areaId
		}//end if
	})//on
		
});//ready
</script>
</head>
<body>
<%@ include file="../common/jsp/header.jsp" %>
<div id="wrap" class="wrap">
   	<div id="detailContentsView">
	<div class="cont detail_page detail_style" data-v-09a75c9f="">
	<div class="cont_wrap sub_visual" data-v-09a75c9f="">
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail" data-v-09a75c9f="">
					<div class="add2020_detail_tab" data-v-09a75c9f="">
						<ul data-v-09a75c9f="">
							<!--질문게시판  -->
							<li data-v-09a75c9f="">
                   			 	<div id="tab3" class="add2020_detail_tab_box" data-v-09a75c9f="">
                   			 		<h2 data-v-09a75c9f=""><a data-v-09a75c9f="" id="reviewFadeBtn" class="up">리뷰<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2>
                   			 			<div id="stab3" transition="fadeIn" class="add2020_detail_con tab_cont " style data-v-09a75c9f=""><p class="cont_tit">나의 리뷰
                   			 			<span id="reviewTotal" style="font-weight: 800; color: rgb(239, 109, 0); line-height: 24px; margin-left: 0px;"><c:out value="( ${ taReviewCnt + resReviewCnt } )" /></span></p>
                   			 				<div class="util_wrap clear">
                   			 					<div class="util_area">
                   			 						<ul class="clear">
                   			 							<li class="on categoryBtn"><a href="javascript:void(0)">관광지</a></li>
                   			 							<li class="categoryBtn"><a href="javascript:void(0)">맛집</a></li>
               			 							</ul>
           			 							</div>
           			 							</div>
           			 							<div class="review_wrap">
           			 								<ul class="review_list" id="review_list">
           			 									<c:choose>
           			 									<c:when test="${ not empty taReviewList }">
       			 										<c:forEach var="review" items="${ taReviewList }">
	           			 									<li id="contentsReviewItem0" class="review_item">
	           			 										<div class="review_area clear">
	           			 											<div class="user_profile">
	           			 											<div class="photo_area">
	           			 												<img src="http://192.168.10.133/prj_travel/common/images/icon_img/img_non_profile.png" alt="프로필이미지" class="user_profile_img">
	           			 												<!---->
	       			 												</div>
	       			 												<p class="user_name"><c:out value="${ review.userId }" /></p>
	       			 												<p class="reg_date"><c:out value="${ review.date }" /></p>
	       			 												<div class="score_area_p">
	       			 													<p class="score_count_p" style="width:${ review.starScore * 20 }%"><c:out value="${ review.starScore }" /></p>
	   			 													</div>
			 													</div>
			 													<div class="user_content">
			 														<div class="review clear"><p class="review_txt"><c:out value="${ review.content }" /></p>
			 													
			 															<p class="review_origin_text" style="display:none;"></p>
			 															
																			</div>
			 														</div>
			 														<button type="button" class="btn deleteBtn" style="color:white;">삭제</button>
			 														<input type='hidden' class='areaId' value="${ review.areaId }"/>
			 														<input type='hidden' class='reviewId' value="${ review.reviewId }"/>
			 														</div>
																</li>
	 														</c:forEach>
	 														</c:when>
	 														<c:otherwise>
	 															<li style="font-size:large; text-align:center">등록된 리뷰가 없습니다.</li>
	 														</c:otherwise>
           			 									</c:choose>
														</ul>
													</div>
													<div class="paging">
														<input type="hidden" value="1" id="currentReviewPage" />
        												<input type="hidden" value="${ taReviewPage }" id="taTotalPage" />
        												<input type="hidden" value="${ resReviewPage }" id="resTotalPage" />
        												<input type="hidden" value="${ pagePerNum }" id="pagePerNum" />
														<div id="paging" class="page-wrap">
														<c:choose>
														<c:when test="${ taEndNum eq 0 }">
															<a href="javascript:void(0)" title="현재 페이지" class="current ta_review_page_btn">${ taStartNum }</a>	
														</c:when>
														<c:otherwise>
														<c:forEach begin="${taStartNum }" end="${taEndNum }" var="num">
															<c:choose>
																<c:when test="${ num eq 1 }">
																	<a href="javascript:void(0)" class="spr_com page-prev" id="reviewPrevBtn">이전 페이지</a>
																	<a href="javascript:void(0)" title="현재 페이지" class="current ta_review_page_btn">${num }</a>
																</c:when>
																<c:otherwise>
																	<a href="javascript:void(0)"  class="ta_review_page_btn">${num }</a>
																</c:otherwise>
															</c:choose>
															<c:if test="${ taEndNum eq num }" >
																<a href="javascript:void(0)" class="spr_com page-next" id="reviewNextBtn">다음 페이지</a>
															</c:if>
														</c:forEach>
														</c:otherwise>
														</c:choose>
														</div>
													</div>
													
													<!--리뷰 평가 및 등록-->
													<div data-v-2ede1d5f="" class="pop_wrap pop_review_write_box" style="display:none" id="registReviewPop">
														<div data-v-2ede1d5f="" class="pop_dim"></div>
														<div data-v-2ede1d5f="" class="pop_container pop_review" style="position:fixed;">
															<div data-v-2ede1d5f="" class="pop_content">
															<div data-v-2ede1d5f="" class="review_top">
																<h3 data-v-2ede1d5f="">리뷰 쓰기</h3>
															</div>
															<div data-v-2ede1d5f="">
																<table data-v-2ede1d5f="" class="board_write">
																	<colgroup data-v-2ede1d5f="">
																		<col data-v-2ede1d5f="" width="100">
																	</colgroup>
																	<tbody data-v-2ede1d5f="">
																		<tr data-v-2ede1d5f="">
																			<th data-v-2ede1d5f=""><span data-v-2ede1d5f="">평가</span></th>
																				<td data-v-2ede1d5f="">
																					<div data-v-2ede1d5f="" class="score_area">
																						<input data-v-2ede1d5f="" type="hidden" value="regsitReview" id="reviewBoxfocusTarget">
																						<button data-v-2ede1d5f="" type="button" title="1" class="btn_score btn_score1 on"><span data-v-2ede1d5f="" class="hide">1</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="2" class="btn_score btn_score2"><span data-v-2ede1d5f="" class="hide">2</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="3" class="btn_score btn_score3"><span data-v-2ede1d5f="" class="hide">3</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="4" class="btn_score btn_score4"><span data-v-2ede1d5f="" class="hide">4</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="5" class="btn_score btn_score5"><span data-v-2ede1d5f="" class="hide">5</span><!----></button>
																					</div>
																				</td>
																			</tr>
																			
																			<tr data-v-2ede1d5f="">
																				<th data-v-2ede1d5f=""><label data-v-2ede1d5f="" for="txtContent">리뷰</label></th>
																					<td data-v-2ede1d5f="">
																						<textarea data-v-2ede1d5f="" rows="4" cols="50" id="reviewContent" name="content" maxlength="1000" title="리뷰 입력"></textarea>
																						<input type="hidden"  id="userId" name="userId" value="jys" /><!--userId 임시 ( session으로 받아오기 -->
																						<input type="hidden"  id="areaId" name="areaId" value="${contId }" />
																						<input type="hidden" id="areaType" name="areaType" value="관광지">
																					</td>
																			</tr>
																			
																			
																			</tbody>
																		</table>
																	</div>
																	<!---->
																	
																	
																	<div data-v-2ede1d5f="" class="review_btn_box">
																		<button data-v-2ede1d5f="" type="button" class="btn_regist" id="btn_regist">등록</button>
																		<button data-v-2ede1d5f="" type="button" class="btn_cancel" id="reviewCancel">취소</button>
																	</div>
																</div>
															</div>
															<!---->
														</div>
													
													
													<div id="review_popup" class="photo_popup review_photo" style="display: none"><img src="" alt=""><button type="button" class="btn_close">닫기</button></div></div></div>
													</li>
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