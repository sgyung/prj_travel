<%@page import="admin.vo.PostVO"%>
<%@page import="pageUtil.BoardPageDAO"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@page import="user.dao.UserBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.NoticeVO"%>
<%@page import="java.util.List"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.NoticePageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
BoardPageDAO bpDAO = BoardPageDAO.getInstance();
PageVO tourVO = new PageVO();

String field=request.getParameter("field");
String keyword=request.getParameter("keyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
tourVO.setField(request.getParameter("field"));
tourVO.setKeyword(request.getParameter("keyword"));



// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = bpDAO.boardTouristTotalCount(tourVO); /* bpDAO.boardTouristTotalcount...를 + 해주면 되는거아닌가? */

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 5;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");
int currentPage = 1;
if(tempPage != null){
	currentPage = Integer.parseInt(tempPage);
}

int startNum = currentPage * pageScale - pageScale + 1;
int endNum = startNum + pageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int pageNumber=5;

// 시작페이지 번호
int startPage=((currentPage-1)/pageNumber)*pageNumber+1;

// 끝페이지 번호
int endPage=(((startPage-1)+pageNumber)/pageNumber)*pageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( totalPage <= endPage){
	endPage=totalPage;
 }//end if

int movePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
tourVO.setStartNum(startNum);
tourVO.setEndNum(endNum);

pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);
pageContext.setAttribute("movePage", movePage);
pageContext.setAttribute("field", field);
pageContext.setAttribute("keyword", keyword);

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
<link rel="stylesheet" type="text/css" href="../common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">

.content_wrap {
	margin-top:90px;
	width:100%;
}

.content {
	width:70%;
	margin : 0 auto;
}

.post_table {
	width:100%;
	border-top: 2px solid #535353;
}

.post_table thead tr th {
    text-align: center;
    font-weight: 600;
    font-size: 18px;
    color: #333;
    line-height: 58px;
    padding: 0;
    border-bottom: 1px solid #e5e5e5;
}

.post_table tbody tr td {
    border-bottom: 1px solid #e5e5e5;
    line-height: 56px;
    text-align: center;
    padding: 0 10px;
    width:10%;
}

.post_table tbody tr td:nth-child(2) {
    width: 50%;
    text-align: center;
}

.page-item.active .page-link {
	background-color:#ef6d00;
	border-color:#ef6d00;
}

</style>
<script type="text/javascript">
$(function(){
	
	$("#inputBtn").click(function() {
		if('${sesId}'!= null){
		location.href = "board_add.jsp?category=tour";
		}else{
			alert("로그인 후 이용해 주세요.");
			location.href = "../user_login/login.jsp";
		}
	});
		
	$("#search").click(function() {
		chkNull();
	});//click
	
	$("#keyword").keyup(function(evt) {// keydown은 값을 받을 수 없다. 값을 받으려면 keyup을 사용
		if(evt.which == 13){
			chkNull();
		}//end if
	});//keyup
	
})//ready

function chkNull() {
	var keyword = $("#keyword").val();
	
	if(keyword.trim()==""){
		alert("검색 키워드를 입력해주세요.");
		return;
	}//end if
	
	//글자수 제한
	
	$("#frmSearch").submit();
}//chkNull
	
function postDetail(id) {
	$("#postId").val(id);
	$("#torist").val("tour");
	$("#postFrm").submit();
}
	
</script>
</head>
<body>

	<div class="wrap">

		<%@ include file="../common/jsp/header.jsp"%>


<%
PostManageDAO postDAO = PostManageDAO.getInstance();

	try{
		List<PostVO> list = bpDAO.selectTouristBoard(tourVO);
		System.out.println(list.toString());
		
		pageContext.setAttribute("tourist", list);
%>

		<div class="content_wrap">
			<div class="content">
				<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
					<div id="stab6" transition="fadeIn"
						class="add2020_detail_con tab_cont kr" data-v-db46a16a=""
						data-v-09a75c9f="">
						<p class="jisik_tit" data-v-db46a16a="">관광지 게시판</p>
						
						<form action="board_detail.jsp" method="post" id="postFrm">
							<input type="hidden" id="postId" name="postId" />
							<input type="hidden" id="type" name="type" />
						</form>

						<table class="post_table" data-v-db46a16a="">
							<thead data-v-db46a16a="">
								<tr data-v-db46a16a="">
									<th data-v-db46a16a="" style="width: 10%">번호</th>
									<th data-v-db46a16a="" style="width: 55%">제목</th>
									<th data-v-db46a16a="" style="width: 10%">글쓴이</th>
									<th data-v-db46a16a="" style="width: 15%">작성일</th><!-- 제목 오른쪽에 span으로 붙히기 -->
									<th data-v-db46a16a="" style="width: 10%">조회수</th>
								</tr>
							</thead>
							<tbody data-v-db46a16a="" id="Output" >

						<c:choose>
					    <c:when test="${empty tourist}">
					        <tr>
					            <td colspan="5">게시글이 존재하지 않습니다.</td>
					        </tr>
					    </c:when>
					    <c:otherwise>
					        <c:forEach var="tourist" items="${tourist}" varStatus="i">
					            <tr data-v-db46a16a="">
					                <td data-v-db46a16a"><c:out value="${i.index + startNum}" /></td>
					                <td data-v-db46a16a>
					                    <a href="#void" onclick="postDetail('${tourist.postId}')">
					                        <c:out value="${tourist.postTitle}" />
					                    </a>
					                </td>
					                <td data-v-db46a16a><c:out value="${tourist.userId}" /></td>
					                <td data-v-db46a16a><c:out value="${tourist.postDate}" /></td>
					                <td data-v-db46a16a><c:out value="${tourist.postViewNum}" /></td>
					            </tr>
					        </c:forEach>
					    </c:otherwise>
					</c:choose>
<%                  
	}catch(SQLException se){
		se.printStackTrace();
	}

%>
							</tbody>
						</table>
						<div class="content" style="text-align: right; width: 100%; margin-top: 20px">
						<input type="button" id="inputBtn" name="inputBtn" class="btn btn-warning" value="글쓰기" style="width: 100px"/>
						</div>

						<div class="know_paging_wrap" data-v-db46a16a="">
							
							<ul class="pagination justify-content-center" >
			                <%
			                if( currentPage > pageNumber ){
			                	movePage=startPage-1;
							%>                    
			                <li class="page-item"><a class="page-link" href="board_tourist_list.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">&laquo;</a></li>
			                <%
			                    }else{
			                %>
			                <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
			                <%
			                    }
			                %>
			
			                <%
			                movePage=startPage;
			                  while( movePage <= endPage ){
			                	  if( movePage == currentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
		                    %>
			                	         
			                <li class="page-item active"><a class="page-link" href="#"><%= movePage %></a></li>
			                <%
			                	}else{
			                %>
			                <li class="page-item"><a class="page-link" href="board_tourist_list.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">
			                <%= movePage %></a></li>
			                 
			                <%
			                } 
		                	  movePage++;
			                }
			                %>
			                  
			                <%
			                if( totalPage > endPage ){
			                	movePage = endPage +1;
							%>                    
			                  <li class="page-item"><a class="page-link" href="board_tourist_list.jsp?currentPage=<%= movePage %>&keyword=${ param.keyword }&field=${ param.field }">&raquo;</a></li>
			                <%
			                    }else{
			                %>
			                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
			                <%
			                    }
			                %>  
			                  
			                </ul>

							<div style="text-align: center; margin-top: 20px">
								<form name="frmSearch" id="frmSearch"
									action="board_tour_list.jsp" method="get">
									<select name="field" class="inputBox" style="height: 30px;">
										<option value="1"
											${ param.field eq '1'?"selected = 'selected'":"" }>아이디</option>
										<option value="2"
											${ param.field eq '2'?"selected = 'selected'":"" }>제목</option>
										<option value="3"
											${ param.field eq '3'?"selected = 'selected'":"" }>내용</option>
									</select> <input type="text" name="keyword" id="keyword"
										class="inputBox"
										value="<%=keyword != null ? keyword : ""%>"
										style="width: 200px; height: 30px;" placeholder="내용을 입력해주세요." />
									<input type="text" style="display: none;" />
									<div style="display: inline-block;">
										<input type="button" id="search" class="btn btn-warning"
											style="width: 80px; margin-left: 10px; font-size: 13px"
											value="검색" />
									</div>
								</form>
							</div>

						</div>

					</div>
				</div>
			</div>

		</div>

		<%@ include file="../common/jsp/footer.jsp"%>

	</div>
</body>
</html>