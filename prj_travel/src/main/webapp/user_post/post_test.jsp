<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

table.jisik_list[data-v-db46a16a] {
	width:100%;
}
</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>

	<div class="wrap">

		<%@ include file="../common/jsp/header.jsp"%>

		<div class="content_wrap">
			<div class="content">
				<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
					<div id="stab6" transition="fadeIn"
						class="add2020_detail_con tab_cont kr" style data-v-db46a16a=""
						data-v-09a75c9f="">
						<p class="jisik_tit" data-v-db46a16a="">
							자유게시판 <span data-v-db46a16a=""><c:out
									value="(${ totalCnt })" /></span>
							<button type="button" data-v-db46a16a="" id="qnaBtn">문의하기</button>
						</p>
						<table class="jisik_list" data-v-db46a16a="">
							<thead data-v-db46a16a="">
								<tr data-v-db46a16a="">
									<th data-v-db46a16a="">제목</th>
									<th data-v-db46a16a="">카테고리</th>
									<th data-v-db46a16a="">답변수</th>
									<th data-v-db46a16a="">작성일</th>
								</tr>
							</thead>
							<tbody data-v-db46a16a="">
							
							
							
								<c:forEach var="qna" items="${ qnaList }" varStatus="i">
									<tr data-v-db46a16a="">
										<td data-v-db46a16a=""><p data-v-db46a16a="">
												<u class="ok" data-v-db46a16a=""><c:out
														value='${ qna.answerType eq "Y"? "[답변]" : "[대기중]" }' /></u>
												<c:out value="${ qna.title }" />
											</p></td>
										<td data-v-db46a16a=""><c:out value="${ qna.category }" /></td>
										<td data-v-db46a16a=""><c:out
												value="${ qna.answerType eq 'Y'? 1 : 0 }" /></td>
										<td data-v-db46a16a=""><c:out
												value="${ qna.registrationDate }" /></td>
									</tr>
								</c:forEach>
						
							</tbody>
							
						</table>
						
						<div class="know_paging_wrap" data-v-db46a16a="">
							<!---->
							<button type="button" class="active">1</button>
							<button type="button" class="">2</button>
							<button type="button" class="">3</button>
							<button type="button">&gt;</button>
						</div>
						
					</div>
				</div>
			</div>

		</div>
		
			<%@ include file="../common/jsp/footer.jsp"%>
		
		</div>
</body>
</html>