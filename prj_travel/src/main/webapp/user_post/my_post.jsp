<%@page import="user_mypageVO.PostVO"%>
<%@page import="user_mypageDAO.MyPostDAO"%>
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
	String postPage = request.getParameter("postPage");
	int postCurrentPage = 1;
	if( postPage != null) {
		postCurrentPage = Integer.parseInt(postPage); 
	}
	MyPostDAO mpDAO = MyPostDAO.getInstance();
	int totalPostCnt = mpDAO.selectTotalPost(userId);
	
	//페이지 번호
	int pagePerNum = 5; //한 화면에 보여줄 페이지번호 수
	int totalPostPage = paging.getTotalPage(totalPostCnt, pageScale);
	//화면에 보여질 페이지 시작번호[0], 끝번호[1] 
	int[] pagePerRange = paging.getTotalPageCnt(postCurrentPage, totalPostPage, pagePerNum);
	pageContext.setAttribute("startNum", pagePerRange[0]);
	pageContext.setAttribute("endNum", pagePerRange[1]);
	
	int[] pageRange = paging.getPageRowRange(postCurrentPage, pageScale);
	
	//나의 게시글
	List<PostVO> postList = mpDAO.selectPagePost(userId, pageRange[0], pageRange[1]);
	
	//qna
	pageContext.setAttribute("postList", postList );
	pageContext.setAttribute("totalPostPage", totalPostPage );
	pageContext.setAttribute("pagePerNum", pagePerNum );
	pageContext.setAttribute("totalPostCnt", totalPostCnt );

	
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

tr.postList:hover {
  background-color: #f0f0f0
}

tr.postList{
  background-color: white; /* 기본 배경색 (하얀색) */
  transition: background-color 0.3s; /* 배경색 전환 효과를 추가 */
}
</style>
<script language="javascript">
$(function(){
	var postPage = 1;
	
	//자유게시판 게시글
	$(document).on("click", ".post_page_btn", function(){
		var selectPage = $(this).text();
		var userId = "${ sesId }";
		postPage = parseInt(selectPage);
		$(".post_page_btn").each(function(){
			if( $(this).hasClass("active") ){
				$(this).removeClass("active");				
			}//end if
		})//click
		$(this).addClass("active");
		
		var jsonObj = {
				userId : userId,
				selectPage : postPage,
				pageScale : 5
				};
		
		$.ajax({
			url : "http://192.168.10.133/prj_travel/user_post/post_page_process.jsp",
			type : "get",
			data : jsonObj,
			dataType : "json",
			error : function( xhr ){
				alert(xhr.status);
			},
			success : function( jsonArr ){
			
				var startPage = jsonObj.selectPage * 5 - 5 + 1
				var output = "";
				$.each(jsonArr, function(i, jsonObj){
					output += "<tr data-v-db46a16a=''  class='postList'>"
					output += "<td data-v-dbS46a16a='' style='width:5%; text-align:center;  border-bottom: 1px solid #e5e5e5;'>" + (startPage+i) + "</td>"
					output += "<td data-v-db46a16a='' style='width:10%''>" + jsonObj.postCategory + "</td>"
					output += "<td data-v-db46a16a='' >" + jsonObj.postTitle + "</td>"
					output += "<td data-v-db46a16a='' style='width:15%'>"+ jsonObj.userId + "</td>"		
					output += "<td data-v-db46a16a='' style='width:10%'>" + jsonObj.postDate + "</td>"
					output += "<td data-v-db46a16a='' style='width:10%'>" + jsonObj.postViewNum + "</td>"
					output += "<input type='hidden' id='postId' value='" + jsonObj.postId + "' />"
					output += "</tr>" 
				})//each
				
				$("#postTbody").html(output);
			}//success
		})//ajax
	})//on
	
	//QNA페이지 다음 버튼
	$(document).on("click", "#qnaNextBtn", function(){
		var pagePerNum = $("#pagePerNum").val();
		var totalPage = $("#qnaTotalPage").val();
		var jsonData = {
				"currentPage" : postPage,
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
				var nextPage = postPage + 1;  
				var nextFlag = jsonObj.nextFlag;
				var output = "";
				if( nextFlag ){
					$(".post_page_btn").each(function(){
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
							output += "<button type='button' class='post_page_btn active'>";
							
						} else {
							output += "<button type='button' class='post_page_btn'>";
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
				"currentPage" : postPage,
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
				var prevPage = postPage - 1;  
				var prevFlag = jsonObj.nextFlag;
				var output = "";
				if( prevFlag ){
					$(".post_page_btn").each(function(){
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
							output += "<button type='button' class='post_page_btn active'>";
							
						} else {
							output += "<button type='button' class='post_page_btn'>";
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
        								나의 게시글 <span id="qnaCnt"  data-v-db46a16a=""><c:out value="(${ totalPostCnt })" /></span>
        								<table class="jisik_list" data-v-db46a16a="">
        									<thead data-v-db46a16a="">
        										<tr data-v-db46a16a="">
        											<th data-v-db46a16a="">번호</th>
        											<th data-v-db46a16a="">카테고리</th>
        											<th data-v-db46a16a="">제목</th>
        											<th data-v-db46a16a="">작성자</th>
        											<th data-v-db46a16a="">작성일</th>
        											<th data-v-db46a16a="">조회수</th>
       											</tr>
   											</thead>
   											<tbody data-v-db46a16a="" id="postTbody">
   												<c:choose>
   												<c:when test="${ not empty postList }">
   												<c:forEach var="post" items="${ postList }" varStatus="i">
   												<tr data-v-db46a16a=""  class="postList">
   																					
													<td data-v-db46a16a="" style="width:5%; text-align:center"><c:out value="${ i.index + startNum }"></c:out></td>
													<td data-v-db46a16a="" style="width:10%"><c:out value="${ post.postCategory }"></c:out></td>
													<td data-v-db46a16a="" ><c:out value="${ post.postTitle }"></c:out></td>
													<td data-v-db46a16a="" style="width:15%"><c:out value="${ post.userId }"></c:out></td>
													<td data-v-db46a16a="" style="width:10%"><c:out value="${ post.postDate }"></c:out></td>
													<td data-v-db46a16a="" style="width:10%"><c:out value="${ post.postViewNum }"></c:out></td>
													<input type="hidden" id="postId" value="${ post.postId }" />
												</tr>
												</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="6" style="text-align:center; font-size:large; ">등록한 게시글이 없습니다.</td>
													</tr>
												</c:otherwise>
												</c:choose>
											</tbody>
										</table>
        						<input type="hidden" value="1" id="currentpostPage" />
        						<input type="hidden" value="${ totalPostPage }" id="qnaTotalPage" />
        						<input type="hidden" value="${ pagePerNum }" id="pagePerNum" />
        						<div class="know_paging_wrap" data-v-db46a16a=""  id="qna_paging">
        						<!---->
        						<c:choose>
        						<c:when test="${ endNum eq 0 }">
        							<button type="button" class="active post_page_btn">${startNum }</button>
        						</c:when>
        						<c:otherwise>
        						<c:forEach begin="${startNum }" end="${endNum }" var="num">
	        						<c:choose>
										<c:when test="${ num eq 1 || endNum eq 0 }">
											<button type="button" class="active post_page_btn">${num}</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="post_page_btn">${num}</button>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${ num eq endNum and endNum lt totalPostPage }">
											<button type="button" id="qnaNextBtn" >&gt;</button>
										</c:when>
									</c:choose>
								</c:forEach>
								</c:otherwise>
								</c:choose>
        						
       							</div>
        							
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