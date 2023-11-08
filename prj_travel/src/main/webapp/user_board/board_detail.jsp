<%@page import="admin.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="admin.vo.PostVO"%>
<%@page import="admin.dao.PostManageDAO"%>
<%@page import="pageUtil.PageVO"%>
<%@page import="pageUtil.CommentPageDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.NoticeVO"%>
<%@page import="admin.dao.NoticeManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%
	if("GET".equals(request.getMethod().toUpperCase())){
		response.sendRedirect("board_restaurant_list.jsp");
		return;
	}
%> --%>
<%
CommentPageDAO cpDAO = CommentPageDAO.getInstance();
PageVO pVO = new PageVO();

String postId = request.getParameter("postId");
//System.out.println("postId = " + postId);
// 1. 총 레코드의 수 => 검색키워드에 해당하는 총 레코드의 수
int totalCount = cpDAO.commentTotalCount(postId);

// 2. 한 화면에 보여줄 게시물의 수
int pageScale = 5;

// 3. 총 페이지 수
int totalPage = 0;

totalPage = (int)Math.ceil(totalCount/(double)pageScale);


// 현재 페이지의 시작번호 구하기
String  tempPage = request.getParameter("currentPage");
//System.out.println("currentPage = " + tempPage);
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
pVO.setStartNum(startNum);
pVO.setEndNum(endNum);

pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);
pageContext.setAttribute("movePage", movePage);
pageContext.setAttribute("postId", postId);

String userId = (String)session.getAttribute("sesId");

pageContext.setAttribute("userId",userId);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon"
	href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- bootstrap JS  -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="../common/CSS/ta_detail.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">
.content_wrap {
	margin-top: 90px;
	width: 100%;
}

.content {
	width: 70%;
	margin: 0 auto;
}

.post_table {
	width: 100%;
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
	width: 10%;
}

.post_table tbody tr td:nth-child(2) {
	width: 50%;
	text-align: center;
}

.page-item.active .page-link {
	background-color: #ef6d00;
	border-color: #ef6d00;
}

#icon{
	width: 60%;
	height: 60%;
}
#icon2{
	width: 40%;
	height: 40%;
}

#answer{
	width : 900px;
	height : 250px;
}
#cursor-position {
  position: absolute;
  padding: 5px;
  background-color: #ffcc00;
  border: 1px solid #333;
}
#btn {
 position: absolute;    
 right: 450px;
 bottom: 150px;
}

/* 스타일링 추가 */
       textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-family: 'Arial', sans-serif;
            font-size: 14px;
            line-height: 1.6;
            resize: vertical; /* 텍스트 영역 크기 조정 제한 */
        }
        textarea:focus {
            border-color: #2ecc71; /* 선택되었을 때 테두리 색상 변경 */
            box-shadow: 0 0 5px #2ecc71; /* 선택된 텍스트 영역 주위에 흐릿한 그림자 효과 추가 */
        }

        #characterCount {
            color: #888;
            font-size: 12px;
            margin-top: 5px;
            float: left;
            margin-left: 10px
        }
        
        #submit {
            padding: 10px;
            border: 1px solid #2ecc71;
            border-radius: 5px;
            font-family: 'Arial', sans-serif;
            font-size: 14px;
            background-color: #2ecc71;
            color: #fff;
            cursor: pointer;
            
        }
</style>
<script type="text/javascript">

$(function(){
	$("#list").click(function() {
		if('${ param.type }' === 'res'){
			location.href = "board_restaurant_list.jsp";
		}else if('${ param.type }' === 'tour'){
			location.href = "board_tourist_list.jsp";
		}
	});
	
	$("#submit").click(function() {
		if('${sesId}'!=null ){
			 $.ajax({
				url: "http://localhost/prj_travel/user_board/board_comment_submit.jsp",
				type: "get",
				data: { postId : '${param.postId}', content: $("#userComment").val() },
				dataType: "json",
				error: function(xhr) {
					console.log(xhr.status);
				},
				success: function(json) {
					
					if(json.result === 1){
						location.reload();
					}
				}//success
				
			})//ajax
		}else{
			alert("로그인 후 이용해 주세요.")
		}
		
		});
	
	
});//ready



function commentList(num){
	 $("#postId").val(${ param.postId });
	 
	$.ajax({
		url: "board_comment_ajax.jsp",
		type: "get",
		data: { currentPage: num, postId : $("#postId").val() },
		dataType: "json",
		error: function(xhr) {
			console.log(xhr.status);
		},
		success: function(json) {
			
			$("#commentOutput").empty();
			var output = "";
			$.each(json.jsonArr, function(i, data) {
				output += "<div class='row' style='margin-bottom: 10px'>";
				output += "<div class='col-md-1' style='text-align: center; margin-right: 30px; margin-bottom: 30px'>";
	             output +=  "<img src='http://192.168.10.134/prj_travel/common/images/icon_img/img_non_profile.png' id='icon2'>";
	              output += "<h6><label style='margin: 0'>" + data.userId + "</label></h6>";
	              output += "<label style='margin: 0; font-size: medium;'>" + data.commentDate + "</label>";
	              output += "</div>";
	              output += "<div class='col-md-9' style='float: left; white-space: normal; margin-left: 20px; margin-top: 5px'>";
	              output += data.content;
	              output += "</div>"
	              if('${sesId}' === data.userId){
	          output += "<input type='button' value='삭제' class='btn btn-outline-info' onclick=\"commentDelete('" + data.commentId + "')\" style='width: 80px; height: 50px; float: left; margin-top: 20px; margin-left: 30px;'>";
	              }    
	          output += "</div>";
				});
				 $("#commentOutput").html(output); 
			
			 $("#commentPageOutput").empty();
			 var pageOutput ="";
			 if(json.currentPage > json.pageNumber){
				 json.movePage = json.startPage-1;
				 
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>&laquo;</a></li>";

			 }else{
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&laquo;</a></li>"; 
			 }
			 
			 json.movePage = json.startPage;
			 while(json.movePage <= json.endPage){
				 if(json.movePage == json.currentPage){
					 pageOutput += "<li class='page-item active'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>" + json.movePage + "</a></li>";
	                  
				 }else{
					 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>" + json.movePage + "</a></li>";
	                  
				 }
				 json.movePage++;
				 
			 }
			 
			 if(json.totalPage > json.endPage ){
				 json.movePage = json.endPage+1;
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void' onclick='commentList(\"" + json.movePage + "\")'>&raquo;</a></li>";
				 
			 }else{
				 pageOutput += "<li class='page-item'><a class='page-link' href='#void'>&raquo;</a></li>";
			 }
			 
			 $("#commentPageOutput").html(pageOutput);
			 
		}
	});//ajax
	
}//commentList


	
	

</script>
<jsp:include page = "../include/set_style.jsp"></jsp:include>
<script type="text/javascript">
function countCharacters(textArea) {
    var currentLength = textArea.value.length;
    var maxLength = 300;

    if (currentLength > maxLength) {
        textArea.value = textArea.value.slice(0, maxLength);
        document.getElementById('characterCount').innerHTML = maxLength + ' / ' + maxLength;
        alert('최대 300자까지만 입력할 수 있습니다.');
    } else {
        document.getElementById('characterCount').innerHTML = currentLength + ' / ' + maxLength;
    }
}

</script>
</head>
<body>
	<div class="wrap">

		<%@ include file="../common/jsp/header.jsp"%>



		<div class="content_wrap">
			<div class="content">


				<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
					<div id="stab6" transition="fadeIn"
						class="add2020_detail_con tab_cont kr" data-v-db46a16a=""
						data-v-09a75c9f="">
						<p class="jisik_tit" data-v-db46a16a="">작성 게시물</p>

						<div class="card-body">
<%
PostManageDAO pmDAO = PostManageDAO.getInstance();

try{
	
	PostVO postVO = pmDAO.selectPost(postId);
	
	pageContext.setAttribute("postVO", postVO);
	
}catch(SQLException se){
	se.printStackTrace();
}
%>						
                <table class="table" style="border-left: 0px; border-right: 0px; border-top: 3px solid #535353; 
	border-bottom: 1px solid #535353; border-spacing: 0px;">
			<tbody>
			<tr>
			<td>
			<div style="margin-left: 100px">
			<div class="row">
              <div class="col-md-2" style="text-align: center">
              <img src="http://192.168.10.134/prj_travel/common/images/icon_img/img_non_profile.png" id="icon"/>
              <h5><label style="margin: 0">${ postVO.userId }</label></h5>
              <h6><label style="margin: 0">${ postVO.postDate }</label></h6>
              </div>
              <div class="col-md-6" style="margin-top: 20px; margin-left:50px; display: inline-block; float: left">
              <h2><label>${ postVO.postTitle }</label></h2>
              <h3><label>[${ postVO.postCategory }]</label></h3>
              </div>
              </div>
              <div class="row">
              <div class="col-md-11" style="float: left; white-space: normal; vertical-align: middle; margin-top: 20px; margin-left: 40px">
              <span style="font-size:x-large; ">${ postVO.postContent }</span>
              </div>
              </div>
             </div>
			</td>
            </tr>
            <tr>
            <td style="border-bottom: 0px"><h3>댓글</h3></td>
            </tr>
<%
try{
	
	List<CommentVO> list = cpDAO.selectComment(pVO, postId);
	
	pageContext.setAttribute("commentList", list);
	
}catch(SQLException se){
	se.printStackTrace();
} 
%>
            <tr>
            <td>
            <div>
            <form action="admin_board_delete_proccess.jsp" id ="DelFrm" method="post">
 				<input type="hidden" id="commentId" name="commentId"/>           
 				<input type="hidden" id="postId" name="postId"/>           
              </form>
            <c:forEach var="commentList" items="${ commentList }" varStatus="i">
            <div style="margin-left: 100px; margin-top: 20px" id="commentOutput">
              <div class="row" style="margin-bottom: 10px">
              <div class="col-md-1" style="text-align: center; margin-right: 30px;margin-bottom: 30px">
              <img src="http://192.168.10.134/prj_travel/common/images/icon_img/img_non_profile.png" id="icon2">
              <h6><label style="margin: 0">${ commentList.userId }</label></h6>
              <label style="margin: 0; font-size: 12px;">${ commentList.registrationDate }</label>
              </div>
              <div class="col-md-9" style="float: left; white-space: normal; margin-left: 20px; margin-top: 5px">
              ${ commentList.content }
              </div>  
               <c:if test="${userId != null && userId eq commentList.userId}">
                <input type="button" value="삭제" class="btn btn-outline-info" onclick="commentDelete('${commentList.commentId}')" style="width: 80px; height: 50px; float: left;margin-top: 20px; margin-left: 30px">
            </c:if>          
              </div>
            </div>
            </c:forEach>
            </div>
            </td>
            </tr>
            </tbody>
            </table>
            <div class="col-md-12" style="margin-top: 20px; display: inline-block; width: 100%;">
			    <textarea id="userComment" name="userComment" rows="4" cols="50" onkeyup="countCharacters(this)"></textarea>
			    <span id="characterCount">0 / 300</span><br><br>
			</div>
			    <div style="text-align: right;">
			        <input type="button" style="width:100px" value="등록" id="submit"/><br>
			    </div>
            <div>
               <ul class="pagination justify-content-center" id="commentPageOutput" style="margin-top: 30px" >
                <%
                if( currentPage > pageNumber ){
                	movePage=startPage-1;
				%>                    
                  <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">&laquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" >&laquo;</a></li>
                <%
                    }
                %>

                  <%
                  movePage=startPage;
                  while( movePage <= endPage ){
                	  if( movePage == currentPage ){//현재페이지와 이동할 페이지가 같다면 링크없이 인덱스리스트 제공
                  %>
                	         
                  <li class="page-item active"><a class="page-link" href="#" onclick="commentList('<%= movePage %>')"><%= movePage %></a></li>
                  <%
                	  }else{
                  %>
                  <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">
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
                   <li class="page-item"><a class="page-link" href="#void" onclick="commentList('<%= movePage %>')">&raquo;</a></li>
                <%
                    }else{
                %>
                  <li class="page-item"><a class="page-link" href="#" >&raquo;</a></li>
                <%
                    }
                %>
                </ul>
                </div>
            <div class="row" style="margin-top: 20px">
            <div class="col-md-1">
            <input type="button" value="목록" class="btn btn-outline-warning" id="list" style="width: 150px;" >
            </div>
            <!-- <div class="col-md-11" style="float: left; text-align: right; "> 
            <input type="button" value="삭제" class="btn btn-outline-danger" id="boardDelete" style="width: 150px;" >
            </div> -->
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