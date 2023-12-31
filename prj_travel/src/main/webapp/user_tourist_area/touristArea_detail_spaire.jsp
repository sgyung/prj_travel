<%@page import="user.vo.TouristAreaVO"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="관광지 상세페이지" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contId = (String)request.getParameter("contentInfo");
	
	if( contId == null || contId.isEmpty() ){
		response.sendRedirect("touristArea.jsp");
		return;
	}

	if( contId != null || !contId.isEmpty()){
		pageContext.setAttribute("contId", contId);
	}//end if
	
	//광광지 상세정보
	TouristAreaDAO tDAO = TouristAreaDAO.getInstance();
	TouristAreaVO taVO = tDAO.selectTouristArea(contId);
	String info = tDAO.selectTouristAreaInfo(contId);
	
	String[] tagArr = null;
	String[] reTagArr = null;
	if( taVO.getTags() != null ){
		tagArr = taVO.getTags().split(" ");
		reTagArr = new String[tagArr.length];
		for( int i = 0; i< tagArr.length; i++ ){
			reTagArr[i] = tagArr[i].replace("#", "");
			System.out.println(reTagArr[i]);
		}
	}//end if
	
	
	

	pageContext.setAttribute("taVO", taVO);
	pageContext.setAttribute("tags", reTagArr);
	pageContext.setAttribute("info", info);
	pageContext.setAttribute("contId", contId);
	
	
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

<script type="text/javascript">
$(function(){
	$("#qnaBtn").click(function(){
		$("#qnaPop").show();
	})//click
	
	$("#closeBtn").click(function(){
		$("#qnaPop").hide();
	})//click
	
	$("#submitBtn").click(function(){
		$("#qnaFrm").submit();
	})//click
	
});//ready
</script>
</head>
<body>
<div id="wrap" class="wrap">
<div class="header">
        <div class="header_contents flex">
            <div class="logo">JEJU VISIT</div>
            <div class="nav_top">
                <ul>
                    <li><a href="http://localhost:8080/prj_touristArea/touristArea.jsp">관광지</a></li>
                    <li>맛집</li>
                    <li>게시판</li>
                    <li>투어예약</li>
                </ul>
            </div>
            <div class="search_login flex">
                <div class="search">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                      <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                    </svg>
                </div>
                <div class="login">로그인</div>
            </div>
        </div>
    </div>
   
   	<div id="detailContentsView">
   		<div id="container" data-v-09a75c9f="">
   			<div id="content" data-v-09a75c9f="">
   				<div id="__SEARCH_DATA__" style="display:none;" data-v-09a75c9f="">
   					<pre data-key="language">kr</pre>
   					<pre data-key="contentsid">CONT_000000000500457</pre>
   					<pre data-key="contentscd.value">c1</pre>
   					<pre data-key="contentscd.label">관광지</pre>
   					<pre data-key="contentscd.refId">contentscd&gt;c1</pre>
   					<pre data-key="title">오설록티뮤지엄</pre>
   					<pre data-key="region1cd.value">region2</pre>
   					<pre data-key="region1cd.label">서귀포시</pre>
   					<pre data-key="region1cd.refId">region&gt;region2</pre>
   					<pre data-key="region2cd.value">23</pre>
   					<pre data-key="region2cd.label">안덕</pre>
   					<pre data-key="region2cd.refId">region2&gt;23</pre>
   					<pre data-key="tag">테마공원,커플,친구,부모,아이,혼자,맑음,휴식/힐링,녹차,실내관광지,어트랙션,반려동물,반려동물동반입장,반려동물동반_관광지,무장애관광</pre><pre data-key="introduction">제주녹차문화의 중심, 차박물관과 카페테리아, 2016 KOREAT JEJU TOP 30 선정</pre><pre data-key="readcnt">140412</pre>
   					<pre data-key="snssharecnt">70</pre>
   					<pre data-key="likecnt">96</pre>
   					<pre data-key="reviewcnt">309</pre>
   					<pre data-key="markcnt">2784</pre>
   					<pre data-key="schedulecnt">0</pre>
   					<pre data-key="visitcnt">10</pre>
   					<pre data-key="evelpt">5</pre>
   					<pre data-key="homepage">https://www.osulloc.com/kr/ko/museum</pre>
   					<pre data-key="titleseo">오설록티뮤지엄</pre>
   					<pre data-key="sbstseo">(본문)</pre>
					<pre data-key="keywordseo">테마공원,커플,친구,부모,아이,혼자,맑음,휴식/힐링,녹차,실내관광지,어트랙션,반려동물,반려동물동반,반려동물전용,예스펫존,반려동물동반입장,혼저옵서개,강아지,반려동물여행,반려동물동반관광지</pre>
					<pre></pre>
					<pre></pre>
					<pre></pre>
					<pre data-key="dpassistneedscd.value">1</pre>
					<pre data-key="dpassistneedscd.label">어려움</pre>
					<pre data-key="dpassistneedscd.refId">assistneedscd&gt;1</pre>
					<pre data-key="address">제주특별자치도 서귀포시 안덕면 서광리 1235-1</pre>
					<pre data-key="roadaddress">제주특별자치도 서귀포시 안덕면 신화역사로 15</pre>
					<pre data-key="phoneno">064-794-5312</pre>
					<pre data-key="latitude">33.3063942</pre>
					<pre data-key="longitude">126.2905203</pre>
					<pre data-key="editordesc">&lt;p&gt;&amp;nbsp;&lt;/p&gt;</pre>
					<pre data-key="usedescinfo">연중무휴 /  소형견, 중형견, 대형견 입장 전화 문의 / 안내견 실내입장 가능 / 실외 녹차밭 입장 불가 </pre>
					<pre data-key="tamnaoyn.value">y</pre>
					<pre data-key="tamnaoyn.label">Y</pre>
					<pre data-key="tamnaoyn.refId">codeyn&gt;y</pre>
					<pre data-key="created">20160530111636</pre>
					<pre data-key="repPhoto.descseo">오설록티뮤지엄</pre>
					<pre data-key="repPhoto.photoid">{
						  "photoid": 2019022583605,
						  "imgpath": "https://api.cdn.visitjeju.net/photomng/imgpath/202110/20/003f420c-6efe-41e9-93b7-00fe6ac5e83b.jpg",
						  "thumbnailpath": "https://api.cdn.visitjeju.net/photomng/thumbnailpath/202110/20/3bf30cdd-799f-4789-b172-52b11c07ddf1.jpg"
						}
					</pre>
				</div>
				<div class="cont detail_page detail_style" data-v-09a75c9f="">
					<h2 class="hide" data-v-09a75c9f="">본문</h2>
					<div class="sub_visual_wrap" style="background: url(../common/${ taVO.image}) 50% 50% / cover no-repeat;" data-v-09a75c9f=""><div class="inner_wrap" data-v-09a75c9f=""><div data-v-09a75c9f=""></div>
					<div class="sub_info_area" data-v-09a75c9f="">
					<div class="sub_info_title" data-v-09a75c9f="">
					<h3 data-v-09a75c9f="" class=""><c:out value="${ taVO.name }" /></h3>
					<p class="h3_sub" style="margin-top:0" data-v-09a75c9f=""></p>
					<!---->
				</div>
				<div class="score_area_l" data-v-09a75c9f="">
					<p class="score_count_l" style="width:100%;" data-v-09a75c9f="">별점(5점만점에 5점)</p>
				</div>
				<div class="tag_area" data-v-09a75c9f="">
					<p class="best_tag" data-v-09a75c9f="">
						<c:forEach var="tag" items="${ tags }">
							<a href="touristArea.jsp?&tag=${ tag }">#<c:out value="${tag}"/></a> 
						</c:forEach>
					</p>
					
				</div>
				<div class="basic_information" data-v-09a75c9f="">
					<p class="info_tit" data-v-09a75c9f="">기본정보</p>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">주소</p>
						<p class="info_sub_cont" data-v-09a75c9f=""><c:out value="${ taVO.addr }"/></p>
					</div>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">연락처</p>
						<p class="info_sub_cont" data-v-09a75c9f="">${ taVO.tel }</p>
					</div>
					<div class="weather" data-v-09a75c9f="">
					<img data-v-09a75c9f="" src="/image/weather/weather_g_sun.png" alt="맑음" class="ico_weather">
					<p data-v-09a75c9f="">맑음</p>
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
		<ul class="appraisal_list clear" data-v-09a75c9f="">
			<li data-v-09a75c9f=""><button type="button" data-v-09a75c9f=""><div class="ico_like" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">좋아요<span class="status" data-v-09a75c9f="">선택 안됨</span></p><p class="appraisal_cnt" data-v-09a75c9f=""><c:out value="${ taVO.like }"/></p></button></li>
			<li data-v-09a75c9f=""><div class="ico_review" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">리뷰</p><p class="appraisal_cnt" data-v-09a75c9f=""><c:out value="${ taVO.reviewCnt }" /></p></li>
			<li data-v-09a75c9f=""><div class="ico_hits" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">조회</p><p class="appraisal_cnt" data-v-09a75c9f=""><c:out value="${ taVO.viewNum }" /></p></li>
		</ul>
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail_left" data-v-09a75c9f="">
				<div id="tab0" class="add2020_detail_box" data-v-09a75c9f="">
					<h2 data-v-09a75c9f="">
						<a href="#" class="up" data-v-09a75c9f="">상세정보<span class="arrow" data-v-09a75c9f="">확장됨</span></a>
					</h2>
					<div class="add2020_detail_box_in" data-v-09a75c9f="">
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
									<h2 data-v-09a75c9f=""><a href="#" data-v-09a75c9f="">질문<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2>
									<div id="stab6" transition="fadeIn" class="add2020_detail_con tab_cont kr" style data-v-db46a16a="" data-v-09a75c9f=""><p class="jisik_tit" data-v-db46a16a="">
        								문의게시판 <span data-v-db46a16a=""><c:out value="(${ totalCnt })" /></span>
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
   											<tbody data-v-db46a16a="">
   												<c:forEach var="qna" items="${ qnaList }" varStatus="i">
   												<tr data-v-db46a16a="">
   													<td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a=""><c:out value='${ qna.answerType eq "Y"? "[답변]" : "[대기중]" }' /></u> <c:out value="${ qna.title }" /></p></td>
   													<td data-v-db46a16a=""><c:out value="${ qna.category }"/></td>
   													<td data-v-db46a16a=""><c:out value="${ qna.answerType eq 'Y'? 1 : 0 }" /></td>
   													<td data-v-db46a16a=""><c:out value="${ qna.registrationDate }"/></td>
												</tr>
												</c:forEach>
												</tbody>
											</table>
        						<div class="know_paging_wrap" data-v-db46a16a="">
        						<!---->
        							<button type="button" class="active">1</button>
        							<button type="button" class="">2</button>
        							<button type="button" class="">3</button>
        							<button type="button">&gt;</button></div>
        							
        							<!-- 질문하기  class = on붙이기 (jisik-pop on) -->
        							<div data-v-a315ebf2="" data-v-db46a16a="" class="jisik-pop" id="qnaPop">
        								<div data-v-a315ebf2="" class="outline"><h3 data-v-a315ebf2="">질문하기<small data-v-a315ebf2="">제주관광 관련 궁금한 점을 작성하여 주세요. 관련된 분야의 전문 지식인의 답변을 받으실 수 있습니다.</small></h3>
        									<div data-v-a315ebf2="" class="box">
        										<div data-v-a315ebf2="" class="text">
        											<h5 data-v-a315ebf2="">질문입력</h5>
      											<form action="qna_process.jsp" id="qnaFrm" name="qnaFrm" method="post" accept-charset="UTF-8">
        											<input id="title" name="title" data-v-a315ebf2="" type="text" placeholder="제목을 입력하세요">
        											<textarea id="content" name="content" data-v-a315ebf2="" placeholder="내용을 입력하세요"></textarea>
        											<input type="hidden" id="userId" name="userId" value="1234"><!-- sessionId -->
        											<input type="hidden" id="areaId" name="areaId" value="${ contId }">
        											<input type="hidden" id="type" name="type" value="관광지">
												</form>
       											</div>
											<button data-v-a315ebf2="" type="button" class="submit" id="submitBtn">작성완료</button>
											<button data-v-a315ebf2="" type="button" class="close" id="closeBtn">창 닫기</button>
										</div>
									</div>
        							
        							
        							<!-- 질문 답변 -->
        							<div data-v-0fc691de="" data-v-db46a16a="" class="jisik-detail on" style="display:none;">
        							<div data-v-0fc691de="" class="outline"><ul data-v-0fc691de="" class="jisik_list"><li data-v-0fc691de=""><div data-v-0fc691de="" class="qustion"><p data-v-0fc691de="" class="name"><strong data-v-0fc691de="">작성자 : </strong>정강현
                        <span data-v-0fc691de=""><strong data-v-0fc691de="">올린시간 : </strong> 2023.07.22</span></p><p data-v-0fc691de="" class="category"><strong data-v-0fc691de="">카테고리 : </strong> [관광지]</p><p data-v-0fc691de="" class="tag"><a data-v-0fc691de="" href="">#우도</a><a data-v-0fc691de="" href="">#우도여객선</a><a data-v-0fc691de="" href="">#우도배편</a></p><p data-v-0fc691de="" class="title">우도 들어가는 배편 타는 위치와 시간표는 어떻게 되나요?? </p><div data-v-0fc691de="" class="jisik_text"><div data-v-0fc691de="">우도에 들어가는 배편은 어디에서 타나요??
<br>그리고 배편이 운항하는 시간표는 어떻게 되나요?!</div><ul data-v-0fc691de="" class="thumb_img"></ul></div><p data-v-0fc691de="" class="count"><strong data-v-0fc691de="">답변수 : </strong><span data-v-0fc691de="">1</span></p><button data-v-0fc691de="" type="button" class="answer">답변하기</button><div data-v-0fc691de="" class="buttons"><!----><!----></div></div><div data-v-0fc691de="" class="answer"><p data-v-0fc691de="" class="name"><strong data-v-0fc691de="">작성자 : </strong>@비공개
                        <span data-v-0fc691de=""><strong data-v-0fc691de="">올린시간 : </strong> 2023.07.23</span></p><p data-v-0fc691de="" class="title">우도배편</p><div data-v-0fc691de="" class="jisik_text"><div data-v-0fc691de=""><div data-v-0fc691de="" class="comment_contents">성산포항 가셔서 타시면 됩니다.
<br>계절에 따라 8시나 9시부터 저녁 6시정도까지 하는 것 같아요
<br>30분마다 한번씩 왔다갔다 하니 여유 있게 타실 수 있을 것 같습니다.</div><ul data-v-0fc691de="" class="thumb_img"></ul></div><div data-v-0fc691de="" class="tags"></div></div>

</div>
</li></ul><button data-v-0fc691de="" type="button" class="close">창 닫기</button></div></div>
        							
        							<!----><!---->
        							<div data-v-9db46a28="" data-v-db46a16a=""><!----></div></div></div></li>
				       		 <!--리뷰  -->
				       		 <!-- style display : none -->
                   			 <li data-v-09a75c9f="">
                   			 	<div id="tab3" class="add2020_detail_tab_box" data-v-09a75c9f="">
                   			 		<h2 data-v-09a75c9f=""><a href="#" data-v-09a75c9f="">리뷰<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2>
                   			 			<div id="stab3" transition="fadeIn" class="add2020_detail_con tab_cont" style data-v-09a75c9f=""><p class="cont_tit">여행가의 리뷰<span style="font-weight: 800; color: rgb(239, 109, 0); line-height: 24px; margin-left: 0px;">(309)</span></p>
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
           			 								<ul class="review_list">
           			 									<li id="contentsReviewItem0" class="review_item">
           			 										<div class="review_area clear">
           			 											<div class="user_profile"><div class="photo_area">
           			 												<img src="common/img_non_profile.png" alt="프로필이미지" class="user_profile_img">
           			 												<!---->
       			 												</div>
       			 												<p class="user_name">jun*****</p>
       			 												<p class="reg_date">2019.12.11</p>
       			 												<div class="score_area_p">
       			 													<p class="score_count_p" style="width:100%;">별점(5점만점에 5점)</p>
   			 													</div>
		 													</div>
		 													<div class="user_content">
		 														<div class="review clear"><p class="review_txt">오설록티뮤지엄에서 초록을 모아보다</p>
		 															<p class="review_origin_text" style="display:none;"></p>
		 															
																		</div>
																	
		 														</div>
		 														</div>
		 												
															</li>
														</ul>
													</div>
													<div class="paging">
														<div id="paging" class="page-wrap">
														<a href="javascript:void(0)" class="spr_com page-first">첫 페이지</a>
														<a href="javascript:void(0)" class="spr_com page-prev">이전 페이지</a>
														<a href="javascript:void(0)" title="현재 페이지" class="current">1</a>
														<a href="javascript:void(0)" title="" class="">2</a>
														<a href="javascript:void(0)" title="" class="">3</a>
														<a href="javascript:void(0)" title="" class="">4</a>
														<a href="javascript:void(0)" title="" class="">5</a>
														<a href="javascript:void(0)" title="" class="">6</a>
														<a href="javascript:void(0)" title="" class="">7</a>
														<a href="javascript:void(0)" title="" class="">8</a>
														<a href="javascript:void(0)" title="" class="">9</a>
														<a href="javascript:void(0)" title="" class="">10</a>
														<a href="javascript:void(0)" class="spr_com page-next">다음 페이지</a>
														<a href="javascript:void(0)" class="spr_com page-last">마지막 페이지</a>
														</div>
													</div>
													
													<!--리뷰 평가 및 등록-->
													<div data-v-2ede1d5f="" class="pop_wrap pop_review_write_box" style="display:none">
														<div data-v-2ede1d5f="" class="pop_dim"></div>
														<div data-v-2ede1d5f="" class="pop_container pop_review">
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
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score1 on"><span data-v-2ede1d5f="" class="hide">5점만점에 1점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score2 on"><span data-v-2ede1d5f="" class="hide">5점만점에 2점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score3 on"><span data-v-2ede1d5f="" class="hide">5점만점에 3점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score4 on"><span data-v-2ede1d5f="" class="hide">5점만점에 4점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score5 "><span data-v-2ede1d5f="" class="hide">5점만점에 5점</span><!----></button>
																					</div>
																				</td>
																			</tr>
																			
																			<tr data-v-2ede1d5f="">
																				<th data-v-2ede1d5f=""><label data-v-2ede1d5f="" for="txtContent">리뷰</label></th>
																					<td data-v-2ede1d5f="">
																						<textarea data-v-2ede1d5f="" rows="4" cols="50" id="txtContent" maxlength="1000" title="리뷰 입력"></textarea>
																					</td>
																			</tr>
																			
																			
																			</tbody>
																		</table>
																	</div>
																	<!---->
																	
																	
																	<div data-v-2ede1d5f="" class="review_btn_box">
																		<button data-v-2ede1d5f="" type="button" class="btn_regist">등록</button>
																		<button data-v-2ede1d5f="" type="button" class="btn_cancel">취소</button>
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
										                    <c:out value="${ taVO.serviceHour }"/>
               											 </dd>
               											 <dt>요금 정보</dt>
               											 <dd>
               											 	 <c:out value="${ taVO.priceInfo }"/>
               											 </dd>
               											 <dt>경사도(난이도)</dt>
               											 <dd>
	               											 <c:out value="${ taVO.slope }"/> 
               											 </dd>
               											 <dt>편의시설</dt>
               											 <dd>편의시설 가데이터 넣기</dd>
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
</body>
</html>