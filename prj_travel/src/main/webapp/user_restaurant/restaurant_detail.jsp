<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.RestaurantVO"%>
<%@page import="user.dao.RestaurantDAO"%>
<%@page import="user.vo.QnAVO"%>
<%@page import="user.dao.QnADAO"%>
<%@page import="user.vo.ReviewVO"%>
<%@page import="user.dao.ReviewDAO"%>
<%@page import="pageUtil.Paging"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="관광지 상세페이지" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contId = request.getParameter("contentInfo");
	String userId = (String) session.getAttribute("sesId");

	if( contId == null || contId.isEmpty() ){
		response.sendRedirect("restaurant.jsp");
		return;
	}

	if( contId != null || !contId.isEmpty()){
		pageContext.setAttribute("contId", contId);
	}//end if
	
	
	//광광지 상세정보
	RestaurantDAO rDAO = RestaurantDAO.getInstance();
	RestaurantVO rVO = rDAO.selectResturant(contId);
	String info = rDAO.selectRestaurantInfo(contId);
	//위도, 경도
	Double RES_latitude = rVO.getLatitude();
	Double RES_longitude = rVO.getLongitude();
	pageContext.setAttribute("TA_latitude", RES_latitude);
	pageContext.setAttribute("TA_longitude", RES_longitude);
	
	//좋아요
	int like = 0;
	String likeState = "N";
	if( userId == null ){
		like = rVO.getLike();
	} else {
		String[] likeValue = rDAO.selectUserLike(userId, contId);
		like = Integer.parseInt(likeValue[0]);
		likeState = likeValue[1];
		
	}//end else
	
	pageContext.setAttribute("like", like);	
	pageContext.setAttribute("likeState", likeState);	
	
	String[] tagArr = null;
	String[] reTagArr = null;
	if( rVO.getTags() != null ){
		tagArr = rVO.getTags().split(" ");
		reTagArr = new String[tagArr.length];
		for( int i = 0; i< tagArr.length; i++ ){
			reTagArr[i] = tagArr[i].replace("#", "");
		}//end for
	}//end if
	
	int pageScale = 5;
	Paging paging = Paging.getInstance();
	
	//리뷰
	String reviewPage = request.getParameter("reviewPage");
	int reviewCurrentPage = 1;
	if( reviewPage != null){
		reviewCurrentPage = Integer.parseInt(reviewPage);
	}
	ReviewDAO reDAO = ReviewDAO.getInstance();
	int totalReviewCnt = reDAO.selectTotalReview(contId);
	
	int rPagePerNum = 10;// 한 화면에 보여줄 페이지 번호 수
	int totalReviewPage = paging.getTotalPage(totalReviewCnt, pageScale);
	//화면에 보여질 페이지 시작번호[0], 끝번호[1] 
	int[] totalReviewPageCnt = paging.getTotalPageCnt(reviewCurrentPage, totalReviewPage, rPagePerNum);
	pageContext.setAttribute("rStartNum", totalReviewPageCnt[0]);
	pageContext.setAttribute("rEndNum", totalReviewPageCnt[1]);
	
	int[] reviewRange = paging.getPageRowRange(reviewCurrentPage, pageScale);
	List<ReviewVO> reviewList = reDAO.selectPageReview(reviewRange[0], reviewRange[1], contId);
	//review
	pageContext.setAttribute("totalReviewPage", totalReviewPage );
	pageContext.setAttribute("reviewList", reviewList );
	pageContext.setAttribute("totalReviewCnt", totalReviewCnt );
	
	
	//문의게시판
	//Page목록
	String qnaPage = request.getParameter("qnaPage");
	int qnaCurrentPage = 1;
	if( qnaPage != null) {
		qnaCurrentPage = Integer.parseInt(qnaPage); 
	}
	QnADAO qDAO = QnADAO.getInstance();
	int totalQnACnt = qDAO.selectTotalQnA();
	
	//페이지 번호
	int pagePerNum = 5; //한 화면에 보여줄 페이지번호 수
	int totalQnAPage = paging.getTotalPage(totalQnACnt, pageScale);
	//화면에 보여질 페이지 시작번호[0], 끝번호[1] 
	int[] pagePerRange = paging.getTotalPageCnt(qnaCurrentPage, totalQnAPage, pagePerNum);
	pageContext.setAttribute("startNum", pagePerRange[0]);
	pageContext.setAttribute("endNum", pagePerRange[1]);
	
	int[] pageRange = paging.getPageRowRange(qnaCurrentPage, pageScale);
	List<QnAVO> qnaList = qDAO.selectPageQnA(pageRange[0], pageRange[1]);
	
	
	//qna
	pageContext.setAttribute("qnaList", qnaList );
	pageContext.setAttribute("qnaTotalPage", totalQnAPage );
	pageContext.setAttribute("pagePerNum", pagePerNum );
	pageContext.setAttribute("qnaTotalCnt", totalQnACnt );
	
	pageContext.setAttribute("rVO", rVO);
	pageContext.setAttribute("tags", reTagArr);
	pageContext.setAttribute("info", info);
	pageContext.setAttribute("contId", contId);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--  -->
<link rel="stylesheet" type="text/css" href="http://192.168.10.133/prj_travel/common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="http://192.168.10.133/prj_travel/common/CSS/header_footer.css">
<style type="text/css">

</style>
<script language="javascript">
//소스출처 : http://www.kma.go.kr/weather/forecast/digital_forecast.jsp  내부에 있음
//기상청에서 이걸 왜 공식적으로 공개하지 않을까?
//
//(사용 예)
//var rs = dfs_xy_conv("toLL","60","127");
//console.log(rs.lat, rs.lng);
//
//<!--
//
// LCC DFS 좌표변환을 위한 기초 자료
//
var RE = 6371.00877; // 지구 반경(km)
var GRID = 5.0; // 격자 간격(km)
var SLAT1 = 30.0; // 투영 위도1(degree)
var SLAT2 = 60.0; // 투영 위도2(degree)
var OLON = 126.0; // 기준점 경도(degree)
var OLAT = 38.0; // 기준점 위도(degree)
var XO = 43; // 기준점 X좌표(GRID)
var YO = 136; // 기1준점 Y좌표(GRID)
//
// LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
//


function dfs_xy_conv(code, v1, v2) {
    var DEGRAD = Math.PI / 180.0;
    var RADDEG = 180.0 / Math.PI;

    var re = RE / GRID;
    var slat1 = SLAT1 * DEGRAD;
    var slat2 = SLAT2 * DEGRAD;
    var olon = OLON * DEGRAD;
    var olat = OLAT * DEGRAD;

    var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);
    var rs = {};
    if (code == "toXY") {
        rs['lat'] = v1;
        rs['lng'] = v2;
        var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);
        var theta = v2 * DEGRAD - olon;
        if (theta > Math.PI) theta -= 2.0 * Math.PI;
        if (theta < -Math.PI) theta += 2.0 * Math.PI;
        theta *= sn;
        rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
        rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
    }
    else {
        rs['x'] = v1;
        rs['y'] = v2;
        var xn = v1 - XO;
        var yn = ro - v2 + YO;
        ra = Math.sqrt(xn * xn + yn * yn);
        if (sn < 0.0) - ra;
        var alat = Math.pow((re * sf / ra), (1.0 / sn));
        alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        if (Math.abs(xn) <= 0.0) {
            theta = 0.0;
        }
        else {
            if (Math.abs(yn) <= 0.0) {
                theta = Math.PI * 0.5;
                if (xn < 0.0) - theta;
            }
            else theta = Math.atan2(xn, yn);
        }
        var alon = theta / sn + olon;
        rs['lat'] = alat * RADDEG;
        rs['lng'] = alon * RADDEG;
    }
    return rs;
}
//-->
function formatDateToYYYYMMDD() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 2자리로 포맷
    const day = String(now.getDate()).padStart(2, '0'); // 일자를 2자리로 포맷

    const formattedDate = `${year}${month}${day}`;
    return formattedDate;
}

function formatTimeToHHMM() {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0'); // 시간을 2자리로 포맷
    const minutes = '00'; // 분을 '00'으로 고정

    const formattedTime = `${hours}${minutes}`;
    return formattedTime;
}
</script>
<script type="text/javascript">
$(function(){
	//날씨정보
	var logitude = $("#TA_longitude").val();
	var latitude = $("#TA_latitude").val();
	
	var date = new Date();
	var year = date.getFullYear().toString();
	var month = (date.getMonth()+1).toString();
	var day = date.getDate().toString().padStart(2, "0"); // 현재 날짜
	var currentTime = date.getHours()  
	var time = ((currentTime - 1)<0? 0 : currentTime-1).toString().padStart(2, "0") + "00"; //현재 시간 (ex : 08:00)
	
	var baseDate = year+month+day;
	
	var weather = ""
	var weatherImg = ""
	
	//위도,경도 -> x,y좌표
	var x = dfs_xy_conv("toXY",latitude, logitude).x;
	var y = dfs_xy_conv("toXY",latitude, logitude).y;
	
	var url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
		+ "?ServiceKey=BJ4MAwskx9P2PjNPlo9ulPIcvWbxV%2BFDDeeCcThcKLC7JuwuoCY%2FxLO52Uf3Au8khQOQcNI3tSXjYkadxluH5Q%3D%3D"
		+ "&pageNo=1"
		+ "&numOfRows=100"
		+ "&dataType=JSON"
		+ "&base_date=" + baseDate
		+ "&base_time=" + time
		+ "&nx=" + x
		+ "&ny=" + y
		
	$.ajax({
		url : url,
		error : function( xhr ){
			alert( xhr.status );
		},
		success : function( jsonData ){
			if( jsonData.response.header.resultMsg == "NO_DATA" ){
				weather = "맑음"
				weatherImg = "sun"	
			} else {
				//하늘상태(SKY)코드 : 맑음(1), 구름많음(3), 흐림(4)
				//강수형태(PTY)코드 : 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
				var SKY = jsonData.response.body.items.item[5].fcstValue;
				var PTY = jsonData.response.body.items.item[6].fcstValue;
				
				if( PTY == 0 ){
					if( SKY == 1 ){
						weather = "맑음"
						weatherImg = "sun"
					} else {
						weather = "구름많음"
						weatherImg = "cloud"
					}//end else
				} else {
					if( PTY == 1 || PTY == 4){
						weather = "비"
						weatherImg = "rain"
					} else{
						weather = "눈"
						weatherImg = "snow"
					}//end else
				}//end else
			}//end else
				
			
				
			$("#weather_img").attr("src", "http://192.168.10.133/prj_travel/common/images/icon_img/weather_g_" + weatherImg + ".png")
			$("#weather_img").attr("alt", weather);
			$("#weather_p").text(weather);
		}//success
		
		
	})//ajax
	
	var qnaPage = 1;
	var reviewPage = 1;
	
	//질문하기 버튼 클릭
	$("#qnaBtn").click(function(){
		var userId = $("#userId").val();
		if (userId == null || userId == "" ){
			alert("로그인 후 질문해주세요.");
			return;
		} //end if
		
		$("#qTitle").val("");
		$("#qContent").val("");
		$("#qnaPop").show();
	})//click
	//질문하기 닫기(x) 버튼 클릭
	$("#closeBtn").click(function(){
		$("#qnaPop").hide();
	})//click
	//질문 상세 보기 닫기(x)
	$("#qnaDetailClose").click(function(){
		$("#qnaDetail").hide();
	})
	//질문 리스트 클릭
	$(document).on("click", ".qnaList", function(){
		var qnaId = $(this).find("input[type=hidden]").val();
		var output = "";
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_QnA/qna_detail_process.jsp",
			type : "GET",
			data : "qnaId=" + qnaId,
			dataType : "JSON",
			error : function(xhr){
				alert(xhr.status);
			},
			success : function( jsonObj ){
				output += "<li data-v-0fc691de='''>"
				output += "<div data-v-0fc691de='' class='qustion'>";
				output += "<p data-v-0fc691de='' class='name' style='display : inline-block'>";
				output += "<strong data-v-0fc691de='' style='display : block'>"+ jsonObj.userId + "</strong>" 
				output += "<span data-v-0fc691de=''><strong data-v-0fc691de=''>올린시간 : </strong>" + jsonObj.registrationDate + "</span></p>";
				output += "<p data-v-0fc691de='' class='category'><strong data-v-0fc691de=''>카테고리 : </strong>[" + jsonObj.category + "]</p>";
				output += "<p data-v-0fc691de='' class='title'>"+ jsonObj.title +"</p>";
				output += "<div data-v-0fc691de='' class='jisik_text'>";
				output += "<div data-v-0fc691de=''>"+ jsonObj.content +"</div>";
				output += "<ul data-v-0fc691de='' class='thumb_img'></ul></div>";
				output += "<p data-v-0fc691de='' class='count'><strong data-v-0fc691de=''>답변수 : </strong><span data-v-0fc691de=''>"
				if( jsonObj.answerType == "N"){
					output += 0
					output+="</span></p><div data-v-0fc691de='' class='buttons'><!----></div></div>";
				} else {
					output += 1 
					output+="</span></p><div data-v-0fc691de='' class='buttons'><!----></div></div>";
					output += "<div data-v-0fc691de='' class='answer'><p data-v-0fc691de='' class='name'><strong data-v-0fc691de=''>작성자 : </strong>관리자";
					output += "<span data-v-0fc691de=''><strong data-v-0fc691de=''>올린시간 : </strong>"+ jsonObj.answerDate +"</span></p>"
					output +="<div data-v-0fc691de='' class='jisik_text'>";
					output +="<div data-v-0fc691de=''>";
					output +="<div data-v-0fc691de='' class='comment_contents'>";
					output += jsonObj.answer +"</div>"
					output +="<ul data-v-0fc691de='' class='thumb_img'></ul></div>"
					output +="<div data-v-0fc691de='' class='tags'></div></div></div>"
				}//end else
				output +="</li>";
				
				$("#qnaDetailView").html(output);
				$("#qnaDetail").show();
			}//success
		})//ajax
	})//on
	
	//질문작성완료
	$("#qnaSubmitBtn").click(function(){
		var userId = $("#userId").val();
		var areaId = $("#areaId").val();
		var areaType = $("#areaType").val();
		var qContent = $("#qContent").val();
		var qTitle = $("#qTitle").val();
		
		var jsonObj = {
				"userId" : userId,
				"areaId" : areaId,
				"areaType" : areaType,
				"content" : qContent,
				"title" : qTitle
		}
			
		console.log(jsonObj);
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_QnA/qna_insert_process.jsp",
			type : "GET",
			data : jsonObj,
			dataType : "JSON",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonObj ){
				if( jsonObj.resultFlag ){
					alert("문의가 등록 되었습니다.");
					$("#qnaPop").hide();
					$("#qnaCnt").text("(" + jsonObj.qnaCnt + ")");
					$(".active").click();
				}//end if
			}//success
		})//ajax
		
	})//click
	
	$("#regsitReview").click(function(){
		var userId = $("#userId").val();
		if( userId == null || userId == ""){
			alert("로그인 후 리뷰를 남겨주세요.");
			return;
		}//end if
		var contId = $("#contId").val();
		var areaType = $("#areaType").val();
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_review/is_review.jsp",
			data : { "contId" : contId, "userId" : userId, "areaType" :  areaType },
			type : "GET",
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonObj ){
				if( jsonObj.resultFlag ){
					alert("리뷰는 한번만 작성 가능합니다.");
					return;
				}//end if
			$("#reviewContent").val("");
			$("#registReviewPop").show();
			}//success
		})//ajax
	})//click
	
	$("#reviewCancel").click(function(){
		$(".btn_score").each(function(){
			if( $(this).prop("title") == 1 ){
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		})

		$("#registReviewPop").hide();
	})//click
	
	//별점 호버링
	$(".btn_score").mouseover(function(){
		var flag = $(this).prop("class").includes("on");
		var idx = $(this).prop("title");
		
		$(".btn_score").each(function(i){
			if( i < idx ){
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		})//each
	})//mouseover
	
	//리뷰등록
	$('#btn_regist').click(function(){
		var selectStar =  1;
		$(".btn_score").each(function(i){
			if( $(this).prop("class").includes("on") ){
				selectStar = i+1;
			};
		})//each
		
		var userId = $("#userId").val();
		var areaId = $("#areaId").val();
		var areaType = $("#areaType").val();
		var rContent = $("#reviewContent").val();
		
		
		var jsonObj = {
				"areaId" : areaId,
				"userId" : userId,
				"areaType" : areaType,
				"content" : rContent,
				"starScore" : selectStar
		}
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_review/review_insert_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "json",
			error : function( xhr ){
				
			},//error
			success : function( jsonObj ){
				if( jsonObj.resultFlag ){
					alert("리뷰가 등록 되었습니다");
					$("#reviewTotal").text("( " +jsonObj.reviewCnt + " )");
					$("#registReviewPop").hide();
					$(".current").click();
				}//end if
			}//success
		})//ajax
		
	
	})//click

	
	//리뷰 게시글
	$(document).on("click", ".review_page_btn", function(){
		var contId = $("#areaId").val();
		var selectPage = $(this).text();
		reviewPage = parseInt(selectPage);
		$(".review_page_btn").each(function(){
			if( $(this).hasClass("current") ){
				$(this).removeClass("current");				
			}//end if
		})//click
		$(this).addClass("current");
		var jsonObj = {
				contId : contId,
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
					liNode += "</div>"	;
					liNode += "</li>"	;
				})//each
				$("#review_list").html(liNode);
			}//success
		})//ajax
		
		
	})//on
	
	
	//질문 게시글 
	$(document).on("click", ".qna_page_btn", function(){
		var selectPage = $(this).text();
		qnaPage = parseInt(selectPage);
		$(".qna_page_btn").each(function(){
			if( $(this).hasClass("active") ){
				$(this).removeClass("active");				
			}//end if
		})//click
		$(this).addClass("active");
		
		var jsonObj = {
				selectPage : qnaPage,
				pageScale : 5
				};
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_detail_QnA/qna_page_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "HTML",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( resData ){
				$("#qnaTbody").empty();
				$("#qnaTbody").append(resData);
			}
		})//ajax
	})//on
	
	//QNA페이지 다음 버튼
	$(document).on("click", "#qnaNextBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#qnaTotalPage").val();
		var jsonData = {
				"currentPage" : qnaPage,
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
				var nextPage = qnaPage + 1;  
				var nextFlag = jsonObj.nextFlag;
				var output = "";
				if( nextFlag ){
					$(".qna_page_btn").each(function(){
						if( $(this).text() == nextPage ){
							$(this).click();
						}//end if
					})
				} else {
					if( startPage > pagePerNum ){
						output += "<button type='button' id='qnaPrevBtn' >&lt;</button>"
					}
					for( let i = startPage; i<=endPage; i++){
						if( i == startPage ){
							output += "<button type='button' class='qna_page_btn active'>";
							
						} else {
							output += "<button type='button' class='qna_page_btn'>";
						}//end else
						output += i + "</button>";
					}//end for
					if( (endPage + pagePerNum) < totalPage ){
						output += "<button type='button' id='qnaNextBtn' >&gt;</button>";
					}
					
					
					$("#qna_paging").empty();
					$("#qna_paging").append(output);
					
					$(".active").click();
				}//end else
			}//success
		})//ajax
	})//on
	
	
	//QNA페이지 이전 버튼
	$(document).on("click", "#qnaPrevBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#qnaTotalPage").val();
		var jsonData = {
				"currentPage" : qnaPage,
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
				var prevPage = qnaPage - 1;  
				var prevFlag = jsonObj.nextFlag;
				var output = "";
				if( prevFlag ){
					$(".qna_page_btn").each(function(){
						if( $(this).text() == prevPage ){
							$(this).click();
						}//end if
					})
				} else {
					if( startPage > pagePerNum ){
						output += "<button type='button' id='qnaPrevBtn' >&lt;</button>"
					}
					for( let i = startPage; i<=endPage; i++){
						if( i == endPage ){
							output += "<button type='button' class='qna_page_btn active'>";
							
						} else {
							output += "<button type='button' class='qna_page_btn'>";
						}//end else
						output += i + "</button>";
					}//end for
					if( (endPage) < totalPage ){
						output += "<button type='button' id='qnaNextBtn' >&gt;</button>";
					}
					
					$("#qna_paging").empty();
					$("#qna_paging").append(output);
					
					$(".active").click();
				}//end else
			}//success
		})//ajax
	})//on
	
	//리뷰 페이지 다음 버튼
	$(document).on("click", "#reviewNextBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#reviewTotalPage").val();
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
					$(".review_page_btn").each(function(){
						if( $(this).text() == nextPage ){
							$(this).click();
						}//end if
					})
				} else {
					for( let i = startPage; i<=endPage; i++){
						if( i == startPage ){
							output += "<a href='javascript:void(0)' class='spr_com page-prev' id='reviewPrevBtn'>이전 페이지</a>"							
							output += "<a href='javascript:void(0)' title='현재 페이지' class='current review_page_btn'>"+ i +"</a>";
							
						} else {
							output += "<a href='javascript:void(0)' class='review_page_btn'>"+ i +"</a>";
						}//end else
						output += "<a href='javascript:void(0)' class='spr_com page-next' id='reviewNextBtn'>다음 페이지</a>"
					
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
		var totalPage = $("#reviewTotalPage").val();
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
					$(".review_page_btn").each(function(){
						if( $(this).text() == prevPage ){
							$(this).click();
						}//end if
					})
				} else {
					for( let i = startPage; i<=endPage; i++){
						if( i == startPage ){
							output += "<a href='javascript:void(0)' class='spr_com page-prev' id='reviewPrevBtn'>이전 페이지</a>"							
							output += "<a href='javascript:void(0)' title='현재 페이지' class='current review_page_btn'>"+ i +"</a>";
							
						} else {
							output += "<a href='javascript:void(0)' class='review_page_btn'>"+ i +"</a>";
						}//end else
						output += "<a href='javascript:void(0)' class='spr_com page-next' id='reviewNextBtn'>다음 페이지</a>"
					
					$("#paging").empty();
					$("#paging").append(output);
					
					$(".current").click();
					}//end for
				}//end else
			}//success
		})//ajax
	})//on
	
	//좋아요 버튼 클릭
	$("#like_btn").click(function(){
		var userId = $("#userId").val();
		var contId = $("#areaId").val();
		var areaType = $("#areaType").val();
		
		if( userId == null || userId == "" ){
			alert("로그인 후 좋아요를 눌러주세요.");
			return;
		}//end if
		
		var json = {
				"userId" : userId,
				"contId" : contId,
				"areaType" : areaType
		}//jsonObj
				
		$.ajax({
			url : "like_process.jsp",
			data : json,
			type : "get",
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonObj ){
				if( $(".ico_like").hasClass("on") ){
					$(".ico_like").removeClass("on");
				} else {
					$(".ico_like").addClass("on");
				}//end else
				$("#like_cnt").text(jsonObj.likeCnt);
				$("#like_state").val(jsonObj.likeState);
				
			}//success
		})//ajax
	})//click
	
	//질문 게시판 show/hide
	$("#qnaFadeBtn").click(function(){
		if($("#qnaFadeBtn").hasClass("up")){
			$("#stab6").hide();
			$("#qnaFadeBtn").removeClass("up");
		}else {
			$("#stab6").show();
			$("#qnaFadeBtn").addClass("up");
		}//else
	})//click
	//리뷰 게시판 show/hide
	$("#reviewFadeBtn").click(function(){
		if($("#reviewFadeBtn").hasClass("up")){
			$("#stab3").hide();
			$("#reviewFadeBtn").removeClass("up");
		}else {
			$("#stab3").show();
			$("#reviewFadeBtn").addClass("up");
		}//else
	})//click
	//디테일 내용 show/hide
	$("#detailFadeBtn").click(function(){
		if($("#detailFadeBtn").hasClass("up")){
			$("#stab0").hide();
			$("#detailFadeBtn").removeClass("up");
		}else {
			$("#stab0").show();
			$("#detailFadeBtn").addClass("up");
		}//else
	})//click
	
	
	
	
});//ready
</script>
</head>
<body>
<%@ include file="../common/jsp/header.jsp" %>
<div id="wrap" class="wrap">
		<input type="hidden"  id="areaId" name="areaId" value="${ contId }" />
    	<input type="hidden"  id="userId" name="userId" value="${ sesId }" />
		<input type="hidden" id="areaType" name="areaType" value="맛집">
		<input type="hidden" id="TA_latitude" name="TA_latitude" value="${ TA_latitude }">
		<input type="hidden" id="TA_longitude" name="TA_longitude" value="${ TA_longitude }">

   
   	<div id="detailContentsView">
   		<div id="container" data-v-09a75c9f="">
   			<div id="content" data-v-09a75c9f="">
				<div class="cont detail_page detail_style" data-v-09a75c9f="">
					<h2 class="hide" data-v-09a75c9f=""></h2>
					<div class="sub_visual_wrap" style="background: url(${ rVO.image }) 50% 50% / cover no-repeat;" data-v-09a75c9f=""><div class="inner_wrap" data-v-09a75c9f=""><div data-v-09a75c9f=""></div>
					<div class="sub_info_area" data-v-09a75c9f="">
					<div class="sub_info_title" data-v-09a75c9f="">
					<h3 data-v-09a75c9f="" class=""><c:out value="${ rVO.name }" /></h3>
					<p class="h3_sub" style="margin-top:0" data-v-09a75c9f=""></p>
					<!---->
				</div>
				<div class="score_area_l" data-v-09a75c9f="">
					<p class="score_count_l" style="width:${ rVO.starScore * 20}%;" data-v-09a75c9f=""></p>
				</div>
				<div class="tag_area" data-v-09a75c9f="">
					<p class="best_tag" data-v-09a75c9f="">
						<c:forEach var="tag" items="${ tags }">
							<a href="restaurant.jsp?&tag=${ tag }">#<c:out value="${tag}"/></a> 
						</c:forEach>
					</p>
					
				</div>
				<div class="basic_information" data-v-09a75c9f="">
					<p class="info_tit" data-v-09a75c9f="">기본정보</p>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">주소</p>
						<p class="info_sub_cont" data-v-09a75c9f=""><c:out value="${ rVO.addr }"/></p>
					</div>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">연락처</p>
						<p class="info_sub_cont" data-v-09a75c9f="">${ rVO.tel }</p>
					</div>
					<div class="weather" data-v-09a75c9f="">
					<img data-v-09a75c9f="" id="weather_img" src="" alt="" class="ico_weather" style="margin-top:20px">
					<p data-v-09a75c9f="" id="weather_p"></p>
				</div>
				</div>
			</div>
		</div>
		<div class="outer_wrap" data-v-09a75c9f=""></div>
	</div>
	<div class="cont_wrap sub_visual" data-v-09a75c9f="">
	<div class="location_wrap clear" data-v-09a75c9f="">
	<div class="location clear">
		<a href="/kr/#" class="ico_home">HOME</a>
		<span class="p_depth">
			<a href="javascript:void(0)" class="asd">&gt; 관광지</a>
		</span><div class="lst_depth">
		<a href="javascript:void(0)" title="2뎁스목록 열기(선택된 목록)" class="btn_dropdown">&gt; 테마관광지</a>
		<!---->
	</div>
	</div>
	
	</div>
		<input type="hidden" name="like_state"  id="like_state"  value="${ likeState }" >
		<ul class="appraisal_list clear" data-v-09a75c9f="">
			<li data-v-09a75c9f="">
				<button type="button" data-v-09a75c9f="" id="like_btn">
					<div class="ico_like ${ likeState eq 'Y'? 'on' : ''  }" data-v-09a75c9f=""></div>
					<p class="appraisal_tit" data-v-09a75c9f="">좋아요<span class="status" data-v-09a75c9f=""></span></p>
					<p class="appraisal_cnt" data-v-09a75c9f="" id="like_cnt"><c:out value="${ like }" /></p>
				</button>
			</li>
			<li data-v-09a75c9f=""><div class="ico_review" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">리뷰</p><p class="appraisal_cnt" data-v-09a75c9f=""><c:out value="${ totalReviewCnt }" /></p></li>
			<li data-v-09a75c9f=""><div class="ico_hits" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">조회</p><p class="appraisal_cnt" data-v-09a75c9f=""><c:out value="${ rVO.viewNum }" /></p></li>
		</ul>
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail_left" data-v-09a75c9f="">
				<div id="tab0" class="add2020_detail_box" data-v-09a75c9f="">
					<h2 data-v-09a75c9f="">
						<a id="detailFadeBtn" class="up" data-v-09a75c9f="">상세정보<span class="arrow" data-v-09a75c9f="">확장됨</span></a>
					</h2>
					<div id="stab0" class="add2020_detail_box_in" data-v-09a75c9f="">
						<div data-helper-component-key="core-system-grid" __vue_component_directive="ice?visit-jeju;contents;kr-CONT_000000000500457;@5"
						 __vue_component_directive_fallback="ice?visit-jeju;contents;kr-CONT_000000000500457;@5" __directive_pos="0"
						  data-accept-components="contentsDecoration/htmlBlock.vue,contentsDecoration/contentsTitle.vue,contentsDecoration/subContentsTitle.vue,contentsDecoration/GridImageViewer.vue,contentsDecoration/relativeComponent.vue,contentsDecoration/contentsParagraph.vue,contentsDecoration/Quotation.vue,contentsDecoration/devideLine.vue,contentsDecoration/YouTube.vue,contentsDecoration/Caption.vue,contentsDecoration/html2.vue"
						   data-fragment-name="컨텐츠"
						   class="_grid-system-grid_ grid-container "
						   style="background-color:transparent;width:100%;">
							<div>
								<!-- 상세정보  -->
								${ info }										
							</div>
						</div>
						<!---->
								<div class="conts_detail"><p>&nbsp;</p>
							</div>
						</div>
						<!---->
					</div>
					<div class="add2020_detail_tab" data-v-09a75c9f="">
						<ul data-v-09a75c9f="">
							<!--질문게시판  -->
							<li data-v-09a75c9f="">
								<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
									<h2 data-v-09a75c9f=""><a  data-v-09a75c9f="" id="qnaFadeBtn" class="up">질문<span class="arrow" data-v-09a75c9f=""></span></a></h2>
									<div id="stab6" transition="fadeIn" class="add2020_detail_con tab_cont kr" style data-v-db46a16a="" data-v-09a75c9f=""><p class="jisik_tit" data-v-db46a16a="">
        								문의게시판 <span data-v-db46a16a=""><c:out value="(${ qnaTotalCnt })" /></span>
        								<button type="button" data-v-db46a16a="" id="qnaBtn">문의하기</button></p>
        								<table class="jisik_list" data-v-db46a16a="">
        									<thead data-v-db46a16a="">
        										<tr data-v-db46a16a="">
        											<th data-v-db46a16a="">제목</th>
        											<th data-v-db46a16a="">카테고리</th>
        											<th data-v-db46a16a="">답변수</th>
        											<th data-v-db46a16a="">작성일</th>
       											</tr>
   											</thead>
   											<tbody data-v-db46a16a="" id="qnaTbody">
   												<c:choose>
   												<c:when test="${ not empty qnaList }">
   												<c:forEach var="qna" items="${ qnaList }">
   												<tr data-v-db46a16a=""  class="qnaList">
   													<td data-v-db46a16a="">
   														<p data-v-db46a16a="">
   															<u class="ok" data-v-db46a16a=""><c:out value="${ qna.answerType eq 'Y'? '[답변완료]' : '[대기중]' }"></c:out></u><c:out value="${ qna.title }"></c:out>
														</p>
													</td>
													<td data-v-db46a16a=""><c:out value="${ qna.category }"></c:out></td>
													<td data-v-db46a16a=""><c:out value="${ qna.answerType eq 'Y'? 1 : 0 }"></c:out></td>
													<td data-v-db46a16a=""><c:out value="${ qna.registrationDate }"></c:out></td>
													<input type="hidden" id="questionId" value="${ qna.qnaId }" />
												</tr>
												</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="4" style="text-align:center; font-size:large; ">등록된 문의가 없습니다.</td>
													</tr>
												</c:otherwise>
												</c:choose>
											</tbody>
										</table>
        						<input type="hidden" value="1" id="currentQnAPage" />
        						<input type="hidden" value="${ qnaTotalPage }" id="qnaTotalPage" />
        						<input type="hidden" value="${ pagePerNum }" id="pagePerNum" />
        						<div class="know_paging_wrap" data-v-db46a16a=""  id="qna_paging">
        						<!---->
        						<c:choose>
        						<c:when test="${ endNum eq 0 }">
        							<button type="button" class="active qna_page_btn">${startNum }</button>
        						</c:when>
        						<c:otherwise>
        						<c:forEach begin="${startNum }" end="${endNum }" var="num">
	        						<c:choose>
										<c:when test="${ num eq 1 || endNum eq 0 }">
											<button type="button" class="active qna_page_btn">${num}</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="qna_page_btn">${num}</button>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${ num eq endNum and endNum lt qnaTotalPage }">
											<button type="button" id="qnaNextBtn" >&gt;</button>
										</c:when>
									</c:choose>
								</c:forEach>
								</c:otherwise>
								</c:choose>
        						
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
				       		 <!-- style display : none -->
                   			 <li data-v-09a75c9f="">
                   			 	<div id="tab3" class="add2020_detail_tab_box" data-v-09a75c9f="">
                   			 		<h2 data-v-09a75c9f=""><a data-v-09a75c9f="" id="reviewFadeBtn" class="up">리뷰<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2>
                   			 			<div id="stab3" transition="fadeIn" class="add2020_detail_con tab_cont " style data-v-09a75c9f=""><p class="cont_tit">여행가의 리뷰<span id="reviewTotal" style="font-weight: 800; color: rgb(239, 109, 0); line-height: 24px; margin-left: 0px;"><c:out value="( ${ totalReviewCnt } )" /></span></p>
                   			 				<button type="button" id="regsitReview" class="btn_regsit">리뷰 및 평가 등록</button>
                   			 				<div class="util_wrap clear">
                   			 					<div class="util_area">
                   			 						<ul class="clear">
                   			 							<li class="on"><a href="javascript:void(0)">최신</a></li>
                   			 							<li class=""><a href="javascript:void(0)">평가</a></li>
               			 							</ul>
           			 							</div>
           			 							</div>
           			 							<div class="review_wrap">
           			 								<ul class="review_list" id="review_list">
           			 									<c:choose>
           			 									<c:when test="${ not empty reviewList }">
       			 										<c:forEach var="review" items="${ reviewList }">
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
        												<input type="hidden" value="${ totalReviewPage }" id="reviewTotalPage" />
        												<input type="hidden" value="${ pagePerNum }" id="reviewPerNum" />
														<div id="paging" class="page-wrap">
														<c:choose>
														<c:when test="${ rEndNum eq 0 }">
															<a href="javascript:void(0)" title="현재 페이지" class="current review_page_btn">${ rStartNum }</a>	
														</c:when>
														<c:otherwise>
														<c:forEach begin="${rStartNum }" end="${rEndNum }" var="num">
															<c:choose>
																<c:when test="${ num eq 1 }">
																	<a href="javascript:void(0)" class="spr_com page-prev" id="reviewPrevBtn">이전 페이지</a>
																	<a href="javascript:void(0)" title="현재 페이지" class="current review_page_btn">${num }</a>
																</c:when>
																<c:otherwise>
																	<a href="javascript:void(0)"  class="review_page_btn">${num }</a>
																</c:otherwise>
															</c:choose>
															<c:if test="${ rEndNum eq num }" >
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
																						<textarea data-v-2ede1d5f="" rows="4" cols="50" id="reviewContent" name="content" maxlength="450" title="리뷰 입력"></textarea>
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
													
													
													<div id="review_popup" class="photo_popup review_photo" style="display: none"><img src="" alt=""><button type="button" class="btn_close">닫기</button></div></div></div></li>
                                                </ul>
                                               </div></div>
                                               <div class="add2020_detail_right" data-v-09a75c9f="">
                                               	
                                               <div class="add2020_detail_side_box" data-v-09a75c9f="">
                                               	<h2>이용안내 </h2>
                                               		<div class="add2020_detail_side_info">
                                               		<dl>
                                               			
                                               			<dt>이용 시간</dt>
                                               			<dd>
										                    <c:out value="${ rVO.serviceHour }"/>
               											 </dd>
               											 <dt>편의시설</dt>
               											 <dd>${rVO.convenience }</dd>
               											 <!---->
          											 </dl>
          											 <!----><!----><!----><!---->
       											 </div>
   											 </div>
										 </div>
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