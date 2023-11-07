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
PageVO resVO = new PageVO();

String resField=request.getParameter("resField");
String resKeyword=request.getParameter("resKeyword");

// 페이지가 최초 호출시에는 field나 keyword가 없다. 검색을 하지 않는 경우에도 값이 없다.
resVO.setField(request.getParameter("resField"));
resVO.setKeyword(request.getParameter("resKeyword"));



// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int resTotalCount = bpDAO.boardRestaurantTotalCount(resVO); /* bpDAO.boardTouristTotalcount...를 + 해주면 되는거아닌가? */

// 2. 한 화면에 보여줄 게시물의 수
int resPageScale = 5;

// 3. 총 페이지 수
int resTotalPage = 0;

resTotalPage = (int)Math.ceil(resTotalCount/(double)resPageScale);


// 현재 페이지의 시작번호 구하기
String  resTempPage = request.getParameter("resCurrentPage");
int resCurrentPage = 1;
if(resTempPage != null){
	resCurrentPage = Integer.parseInt(resTempPage);
}

int resStartNum = resCurrentPage * resPageScale - resPageScale + 1;
int resEndNum = resStartNum + resPageScale -1;

// 화면에 보여줄 페이지 인덱스 수
int resPageNumber=5;

// 시작페이지 번호
int resStartPage=((resCurrentPage-1)/resPageNumber)*resPageNumber+1;

// 끝페이지 번호
int resEndPage=(((resStartPage-1)+resPageNumber)/resPageNumber)*resPageNumber;

// 구해진 끝페이지 번호가 총 페이지보다 적다면 총 페이지 수가 끝 페이지번호가 된다
if( resTotalPage <= resEndPage){
	resEndPage=resTotalPage;
 }//end if

int resMovePage=0;

// Dynamic Query에 의해서 구해진 시작번호와 끝번호를 VO에 넣는다.
resVO.setStartNum(resStartNum);
resVO.setEndNum(resEndNum);

pageContext.setAttribute("resStartNum", resStartNum);
pageContext.setAttribute("resEndNum", resEndNum);
pageContext.setAttribute("resMovePage", resMovePage);
pageContext.setAttribute("resField", resField);
pageContext.setAttribute("resKeyword", resKeyword);

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

	
	var tempResField = "";
	var tempResKeyword = "";
	
		 $("#resSearch").click(function() {
			 tempResField = $("[name='resField'] option:selected").val();
			 tempResKeyword = $("#resKeyword").val();
			resChkNull();
			$.ajax({
				url: "../admin_post/admin_board_restaurant.jsp",
				type: "post",
				data: {resField :tempResField, resKeyword : tempResKeyword},
				dataType: "json",
				error: function(xhr) {
					console.log(xhr.status);
				},
				success: function(jsonObj) {
					$("#resOutput").empty();
					var startNum = $("#resStartNum").val()
					var output = "";
					$.each(jsonObj.jsonArr, function(i, data) {
					output += "<tr>";
					output += "<td>" + data.rowNum +"</td>";
					output += "<td>" + data.postCategory + "</td>"
					output += "<td onclick='postDetail(" + data.postId + ")'>" + data.postTitle + "</td>";
					output += "<td>" + data.userId + "</td>";
					output += "<td>" + data.postDate + "</td>";
					output += "<td>" + data.postVieWNum + "</td>";
					output += "</tr>";
					});
					 $("#resOutput").html(output); 
				}
			});//ajax
			
		});//click
		
		
		$("#resKeyword").keyup(function(evt) {// keydown은 값을 받을 수 없다. 값을 받으려면 keyup을 사용
			if(evt.which == 13){
				resChkNull();
			}//end if
		});//keyup
	
})//ready

function postDetail(id) {
	location.href = "board_restaurant_detail.jsp?postId=" + id;
}

function resChkNull() {
	var keyword = $("#resKeyword").val();
	if(keyword.trim()==""){
		alert("검색 키워드를 입력해주세요.");
		return;
	}//end if

}//chkNull

function restaurantList(num){
	
	$.ajax({
		url: "board_restaurant_json.jsp",
		type: "get",
		data: {resField : $("[name='resField'] option:selected").val(), resKeyword : $("#resKeyword").val(), resCurrentPage: num },
		dataType: "json",
		error: function(xhr) {
			console.log(xhr.status);
		},
		success: function(json) {
			$("#resOutput").empty();
			var startNum = $("#resStartNum").val()
			var output = "";
			$.each(json.jsonArr, function(i, data) {
				output += "<tr>";
				output += "<td>" + data.rowNum +"</td>";
				/* output += "<td>" + data.postCategory + "</td>" */
				output += "<td onclick='postDetail(" + data.postId + ")'>" + data.postTitle + "</td>";
				output += "<td>" + data.userId + "</td>";
				output += "<td>" + data.postDate + "</td>";
				output += "<td>" + data.postVieWNum + "</td>";
				output += "</tr>";
				});
				 $("#resOutput").html(output); 
			
			 $("#resPageOutput").empty();
			 var pageOutput ="";
			 if(json.resCurrentPage > json.resPageNumber){
				 json.resMovePage = json.resStartPage-1;
				 
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>&laquo;</a></li>";

			 }else{
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&laquo;</a></li>"; 
			 }
			 
			 json.resMovePage = json.resStartPage;
			 while(json.resMovePage <= json.resEndPage){
				 if(json.resMovePage == json.resCurrentPage){
					 pageOutput += "<li class='page-item active'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>" + json.resMovePage + "</a></li>";
	                  
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>" + json.resMovePage + "</a></li>";
	                  
				 }
				 json.resMovePage++;
				 
			 }
			 
			 if(json.resTotalPage > json.resEndPage ){
				 json.resMovePage = json.resEndPage+1;
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='restaurantList(\"" + json.resMovePage + "\")'>&raquo;</a></li>";
				 
			 }else{
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&raquo;</a></li>";
			 }
			 
			 $("#resPageOutput").html(pageOutput);
			 
		}
	});//ajax
	
}//restaurantList
	
</script>
</head>
<body>

	<div class="wrap">

		<%@ include file="../common/jsp/header.jsp"%>


<%
PostManageDAO postDAO = PostManageDAO.getInstance();

	try{
		List<PostVO> list = bpDAO.selectRestaurantBoard(resVO);
		System.out.println(list.toString());
		
		pageContext.setAttribute("restaurantList", list);
%>

		<div class="content_wrap">
			<div class="content">
				<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
					<div id="stab6" transition="fadeIn"
						class="add2020_detail_con tab_cont kr" data-v-db46a16a=""
						data-v-09a75c9f="">
						<p class="jisik_tit" data-v-db46a16a="">맛집 게시판</p>
						
						<form action="user_notice_detail.jsp" method="post" id="postFrm">
							<input type="hidden" id="noticeId" name="noticeId" />
						</form>

						<table class="post_table" data-v-db46a16a="">
							<thead data-v-db46a16a="">
								<tr data-v-db46a16a="">
									<th data-v-db46a16a="">번호</th>
									<th data-v-db46a16a="">제목</th>
									<th data-v-db46a16a="">글쓴이</th>
									<th data-v-db46a16a="">작성일</th><!-- 제목 오른쪽에 span으로 붙히기 -->
									<th data-v-db46a16a="">조회수</th>
								</tr>
							</thead>
							<tbody data-v-db46a16a="" id="resOutput" >

								<c:forEach var="restaurantList" items="${restaurantList}" varStatus="i">
									<tr data-v-db46a16a="">
										<td data-v-db46a16a=""><c:out value="${i.count}" /></td>
										<td data-v-db46a16a="">
											<a href="#void" onclick="postDetail('${ restaurantList.postId }')"><c:out value="${restaurantList.postTitle}"/></a>
										</td>
										<td data-v-db46a16a=""><c:out value="${restaurantList.userId}"/></td>
										<td data-v-db46a16a=""><c:out value="${restaurantList.postDate}" /></td>
										<td data-v-db46a16a=""><c:out value="${restaurantList.postViewNum}" /></td>
									</tr>
								</c:forEach>
<%                  
	}catch(SQLException se){
		se.printStackTrace();
	}

%>
							</tbody>
						</table>

						<div class="know_paging_wrap" data-v-db46a16a="">
							
							<ul class="pagination justify-content-center" >
			                <%
			                if( resCurrentPage > resPageNumber ){
			                	resMovePage=resStartPage-1;
							%>                    
			                <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">&laquo;</a></li>
			                <%
			                    }else{
			                %>
			                <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
			                <%
			                    }
			                %>
			
			                <%
			                resMovePage=resStartPage;
			                  while( resMovePage <= resEndPage ){
			                	  if( resMovePage == resCurrentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
		                    %>
			                	         
			                <li class="page-item active"><a class="page-link" href="#" onclick="restaurantList('<%= resMovePage %>')"><%= resMovePage %></a></li>
			                <%
			                	}else{
			                %>
			                <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">
			                <%= resMovePage %></a></li>
			                 
			                <%
			                } 
		                	  resMovePage++;
			                }
			                %>
			                  
			                <%
			                if( resTotalPage > resEndPage ){
			                	resMovePage = resEndPage +1;
							%>                    
			                  <li class="page-item"><a class="page-link" href="#void" onclick="restaurantList('<%= resMovePage %>')">&raquo;</a></li>
			                <%
			                    }else{
			                %>
			                  <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
			                <%
			                    }
			                %>  
			                  
			                </ul>

							<div style="text-align: center">
								<form name="resFrmSearch" id="resFrmSearch"
									action="admin_board_list.jsp" method="get">
									<select name="resField" class="inputBox" style="height: 30px;">
										<option value="1"
											${ param.resField eq '1'?"selected = 'selected'":"" }>아이디</option>
										<option value="2"
											${ param.resField eq '2'?"selected = 'selected'":"" }>제목</option>
										<option value="3"
											${ param.resField eq '3'?"selected = 'selected'":"" }>내용</option>
									</select> <input type="text" name="resKeyword" id="resKeyword"
										class="inputBox"
										value="<%=resKeyword != null ? resKeyword : ""%>"
										style="width: 200px; height: 30px;" placeholder="내용을 입력해주세요." />
									<input type="text" style="display: none;" />
									<div style="display: inline-block;">
										<input type="button" id="resSearch" class="btn btn-warning"
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