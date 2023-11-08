<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
<jsp:include page = "../include/set_style.jsp"></jsp:include>
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
input[type="radio"].radio-custom {
    display: none;
}

input[type="radio"].radio-custom + label.radio-custom-label {
    cursor: pointer;
    padding: 8px 16px;
    border: 1px solid #ccc;
    text-align: center;
    border-radius: 4px;
    background-color: #f0f0f0;
    color: #333;
    display: inline-block; /* 너비 조절을 위해 추가 */
    width: 150px; /* 원하는 너비로 조절 */
    margin-right: 50px; /* 오른쪽 여백 설정 */
    margin-top: 10px;  
}

input[type="radio"].radio-custom:checked + label.radio-custom-label {
    background-color: #2ecc71;
    color: #fff;
}

input[type="radio"] {
  width: 100px;
  margin-right: 50px;
}
</style>
<script type="text/javascript">
$(function(){
	
	$('#content').summernote({
		 height: 350,                 // 에디터 높이
		  minHeight: 100,             // 최소 높이
		  maxHeight: 350,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR"					// 한글 설정
	 });
	
	
	$("#inputBtn").click(function() {
		if('${sesId}'!= null){
			$("#type").val('${param.category}');
			$("#boardFrm").submit();
		}
		
	});//click
	
	$("#cancel").click(function() {
		if ('${param.category}' === 'res') {
		    location.href = 'board_restaurant_list.jsp';
		} else if ('${param.category}' === 'tour') {
		    location.href = 'board_tourist_list.jsp';
		}
	})//click
	
})//ready

	
	
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
						<p class="jisik_tit" data-v-db46a16a="">게시물 작성</p>
						
						 <form action="board_add_proccess.jsp" method="post" name="boardFrm" id="boardFrm">
             			 <input type="hidden" id="postId" name="postId"/>
             			 <input type="hidden" id="type" name="type"/>
						<div class="card-body">
		                <table class="table table-bordered" data-v-db46a16a="">
		                    <tr data-v-db46a16a="" style="height: 80px;">
		                      <th data-v-db46a16a="" style=" width:100px; text-align: center; vertical-align: middle;" >제목</th>
		                      <td data-v-db46a16a=""><input type="text" name="title" class="inputBox" id="title" style=" width:90% ;height: 40px; margin-top: 10px; text-align: left;" value="${ nVO.title }"/></td>
		                    </tr>
		                    <tr data-v-db46a16a="" style="height: 80px;">
		                      <th data-v-db46a16a="" style=" width:100px; text-align: center; vertical-align: middle;" >카테고리</th>
		                      <td data-v-db46a16a="">
		                      <input type="radio" id="restaurant" name="category" value="1" class="radio-custom">
							<label for="restaurant" class="radio-custom-label">맛집</label>
							
							<input type="radio" id="tourist" name="category" value="2" class="radio-custom" >
							<label for="tourist" class="radio-custom-label">관광지</label>
							</td>
		                    </tr>
		                    <tr data-v-db46a16a="" style="height: 400px; max-height: 400px">
		                      <th data-v-db46a16a="" style=" width:100px; text-align: center; vertical-align: middle;">내용</th>
		                      <td> 
		            			<textarea id="content" name="content" ></textarea>
		       				</td>
		                    </tr>
		                </table>
		              </div>
		              <!-- /.card-body -->
		              </form>
						<div class="content" style="text-align: right; width: 100%; margin-top: 20px">
						<input type="button" id="cancel" name="cancel" class="btn btn-warning" value="취소" style="width: 100px"/>
						<input type="button" id="inputBtn" name="inputBtn" class="btn btn-warning" value="등록" style="width: 100px; margin-right: 20px"/>
						</div>

						
					</div>
				</div>
			</div>

		</div>

		<%@ include file="../common/jsp/footer.jsp"%>

	</div>
</body>
</html>