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
	
	int pageScale = 5;
	Paging paging = Paging.getInstance();
	//문의게시판
	//Page목록
	String qnaPage = request.getParameter("qnaPage");
	int qnaCurrentPage = 1;
	if( qnaPage != null) {
		qnaCurrentPage = Integer.parseInt(qnaPage); 
	}
	MyQnADAO qDAO = MyQnADAO.getInstance();
	int totalQnACnt = qDAO.selectTotalQnA(userId);
	
	//페이지 번호
	int pagePerNum = 5; //한 화면에 보여줄 페이지번호 수
	int totalQnAPage = paging.getTotalPage(totalQnACnt, pageScale);
	//화면에 보여질 페이지 시작번호[0], 끝번호[1] 
	int[] pagePerRange = paging.getTotalPageCnt(qnaCurrentPage, totalQnAPage, pagePerNum);
	pageContext.setAttribute("startNum", pagePerRange[0]);
	pageContext.setAttribute("endNum", pagePerRange[1]);
	
	int[] pageRange = paging.getPageRowRange(qnaCurrentPage, pageScale);
	List<QnAVO> qnaList = qDAO.selectPageQnA(pageRange[0], pageRange[1], userId);
	
	
	
	//qna
	pageContext.setAttribute("qnaList", qnaList );
	pageContext.setAttribute("qnaTotalPage", totalQnAPage );
	pageContext.setAttribute("pagePerNum", pagePerNum );
	pageContext.setAttribute("qnaTotalCnt", totalQnACnt );

	
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
	var qnaPage = 1;
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
	
	//질문 게시글 
	$(document).on("click", ".qna_page_btn", function(){
		var selectPage = $(this).text();
		var userId = "${ sesId }";
		qnaPage = parseInt(selectPage);
		$(".qna_page_btn").each(function(){
			if( $(this).hasClass("active") ){
				$(this).removeClass("active");				
			}//end if
		})//click
		$(this).addClass("active");
		
		var jsonObj = {
				userId : userId,
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
});//ready
</script>
</head>
<body>
<%@ include file="../common/jsp/header.jsp" %>
<div id="wrap" class="wrap">
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
        								나의 문의 <span id="qnaCnt"  data-v-db46a16a=""><c:out value="(${ qnaTotalCnt })" /></span>
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