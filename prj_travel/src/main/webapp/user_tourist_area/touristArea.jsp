<%@page import="java.lang.reflect.Array"%>
<%@page import="pageUtil.Paging"%>
<%@page import="user.vo.TouristAreaVO"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	TouristAreaDAO dao = TouristAreaDAO.getInstance();

	List<String> tagList = dao.selectAllTags();
	for( int i = 0; i<tagList.size(); i++ ){
		tagList.set(i, tagList.get(i).substring(1));
	}//end for

	List<TouristAreaVO> pageList = new ArrayList<TouristAreaVO>();
	
	String currentPage = request.getParameter("page");
	String selectTag = request.getParameter("tag");
	
	int selectPage = 1;
	if( currentPage != null ){
		selectPage= Integer.parseInt(currentPage);
	}//end if
	
	//paging util
	Paging paging = Paging.getInstance();
	
	int pageScale = 10; // 환화면에 보여줄 컨텐츠 수
	int[] pageRange = paging.getPageRowRange(selectPage, pageScale);
	
	
	//선택된 tag가 있을때
	if( selectTag == null || selectTag.equals("전체") ){
		pageList = dao.selectPageContent(pageRange[0], pageRange[1]);
	}else {
		pageList = dao.selectTagContent("#"+selectTag, pageRange[0], pageRange[1]);
	}
	

	
	int ContentCnt = pageList.size();
	int totalContent = 0;
	
	if(selectTag == null || selectTag.equals("전체")){
		totalContent = dao.selectTotalTouristArea();
	} else {
		totalContent = dao.selectTotalTagTouristArea("#" + selectTag);
	}
	
	int pagePerNum = 5; // 한 화면에 보여줄 페이지번호 수
	int totalPage = paging.getTotalPage(totalContent, pageScale);
	int[] pagePerRange = paging.getTotalPageCnt(selectPage, totalPage, pagePerNum);
	
	
	pageContext.setAttribute("startNum", pagePerRange[0] );
	pageContext.setAttribute("endNum", pagePerRange[1] );
	
	pageContext.setAttribute("tags", tagList);
	pageContext.setAttribute("selectTag", selectTag);
	pageContext.setAttribute("cnt", ContentCnt);
	pageContext.setAttribute("totalContent", totalContent);
	pageContext.setAttribute("selectPage", selectPage);
	pageContext.setAttribute("startRow", pageRange[0]);
	pageContext.setAttribute("areaList", pageList);
	pageContext.setAttribute("totalPage", totalPage);
	pageContext.setAttribute("pagePerNum", pagePerNum);
	
	
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
<!-- kakao지도 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9d996728af7880d0f5ca73221c2412ab"></script>
<!-- kakao지도 api -->
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="http://192.168.10.133/prj_travel/common/CSS/ta_view.css">
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<style type="text/css">



.container {
    margin-top: 90px;
}

h2 {
    font-size: 2rem;
    padding: 20px 0 0 0;
}



</style>
<script type="text/javascript">
$(function(){
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.378173, 126.551793), //지도의 중심좌표.
		level: 9 //지도의 레벨(확대, 축소 정도)
	};
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
    map.setZoomable(false);    
	
	// 마커가 표시될 위치입니다 (여러개)
	var positions = [];
	var overlays = [];
	// 전역 오버레이 객체
	var clickedOverlay = null;
	// 위도,경도,제목을 class로 받아 positions배열에 추가
	$(".longLat").each(function(){
		var mapData = $(this).val().split(",");
		var data =
		{
			img : mapData.pop(),
			contentId : mapData.pop(),
			title : mapData.pop(),
			latlng: new kakao.maps.LatLng(mapData[0],mapData[1])
		};
		positions.push(data);
	});
	// positions배열에 설정된 위도,경도,제목을 추출해 마커생성
	for( var i = 0; i<positions.length; i++){
		var marker = new kakao.maps.Marker({
			map : map, //마커를 표시할 지도
			position : positions[i].latlng, // 마커를 표시할 위치
			title : positions[i].title, //마커의 타이틀( 마커에 마우스를 올리면 타이틀이 표시됩니다.)
			clickable : true
		});
		//오버레이 표시될 html
		 var content = '<div id="cont1" style="position: absolute; top: -315px; left: -110px; z-index: 0; margin: 0px; padding: 0px; border: 1px solid rgb(201, 201, 201); display: block; cursor: default; box-sizing: content-box !important; background:#EFEFEF; ">' + 
		    '				<div style="margin: 0px; padding: 0px; border: 0px solid transparent; display: inline-block; box-sizing: content-box !important; width: 221px; height: 270px; align-items:center">'+
		    '					<div class="map_cont2" >'+	
		    '						<img src="'+ positions[i].img +'" style="width:221px; height:200px">'+
		    '					 	<p style="text-align:center; margin: 5px 0">' + positions[i].title + '</p>'+
		    '				 		<div style="text-align:center;">'+
		    '							<a href="touristArea_detail.jsp?contentInfo=' + positions[i].contentId+'"' + 'style="margin-bottom:10px;background-color:rgb(255,255,255);">자세히보기</a>'+
			'				 		</div>'+
			'					</div>'+
			'				</div>'+
			'				<div style="margin: 0px; padding: 0px; display: none; width: 0px; height: 0px; position: absolute; border-width: 15px 10px 0px; border-style: solid; border-color: rgb(201, 201, 201) transparent transparent; border-image: initial; pointer-events: none; box-sizing: content-box !important; bottom: -16px; left: 91px;"></div>'+
			'				<div style="margin: 0px; padding: 0px; display: none; width: 0px; height: 0px; position: absolute; border-width: 15px 10px 0px; border-style: solid; border-color: rgb(255, 255, 255) transparent transparent; border-image: initial; pointer-events: none; box-sizing: content-box !important; bottom: -13px; left: 91px;"></div>'+
		    '			</div>';
		
		//커스텀 오버레이 생성
	    var overlay = new kakao.maps.CustomOverlay({
	    	content : content,
	    	map : map,
	    	position : positions[i].latlng
	    })
		
		//초기에 오버레이 보이지않게 설정
	    overlay.setMap(null);
		
	    overlays.push(overlay);
	    //마커 클릭시 오버레이 보이도록 이벤트 설정
		kakao.maps.event.addListener(marker, 'click', function(olay, pos){
			return function () {
		        if (clickedOverlay) {
		        	clickedOverlay.setMap(null);
		        }
		        olay.setMap(map);
		        map.panTo(pos);
		        clickedOverlay = olay;
		    }
		} ( overlay, positions[i].latlng));
	
	}//end for
	
	//a태그 클릭시 클릭한 관광지에 해당하는 지도상의 좌표로 이동
	$(".ta").click(function(){
		var idxValue = $(this).attr("id");
		var idx = parseInt(idxValue);
		
		if (clickedOverlay) {
        	clickedOverlay.setMap(null);
        }
		overlays[idx].setMap(map)
		map.panTo(positions[idx].latlng);
		clickedOverlay = overlays[idx];
	})//end click
	
	// 현재 페이지 URL의 쿼리 문자열을 가져오기
	const queryString = window.location.search;

	// URLSearchParams 객체 생성
	const urlParams = new URLSearchParams(queryString);

	// 특정 매개변수(예: 'page')의 값을 가져오기
	const pageParam = urlParams.get('page');

     //선택된 페이지 표시
     if( pageParam != null ){
	     $(".page").each(function(){
	    	  if($(this).text() == pageParam ){
				 $(this).addClass("current");
			 } else{
				 $(this).removeClass("current");
			 }
		 }) 
     }//end if
     
     //해시태그 클릭시 해당하는 맛집 리스트 출력
     $("input[name='tag']").change(function(){
    	 var selectedValue = $("input[name='tag']:checked").val();
    	 
    	 window.location.href = "touristArea.jsp?tag="+ selectedValue;
     })
     
});//ready

</script>
</head>
<body>
	<%@ include file="../common/jsp/header.jsp" %>

	<div class="container">
		<div id="content">
			<div class="page_title" >
				<h2>관광지</h2>
			</div>
			</div>
			<div>
				<div class="tagBox box01">
					<input id="hashTag_전체"  type="radio" name="tag" value="전체"  ${ "전체" eq selectTag? 'checked' : '' }>	
					<label for="hashTag_전체">#전체</label>
					<c:forEach var="tag" items="${ tags }">
					<input id="hashTag_${ tag }"  type="radio" name="tag" value="${ tag }"  ${ tag eq selectTag? 'checked' : '' }>	
					<label for="hashTag_${ tag }">#${ tag }</label>
					</c:forEach>
				</div>
			</div>
			
			
			<div class="recommend_area">
				<div class="counter" data-v-2fbcbd64="">
					<p data-v-2fbcbd64=""><strong data-v-2fbcbd64="" style=" color: #ef6d00; padding: 0 4px 0 0;">${ totalContent }</strong>개의 결과가 있습니다</p>
				</div>
				<div class="map_outline">
					<div class="map_box" data-v-2fbcbd64>
						<ul class="item_list_map type_map clear" style="height:  ${ 300 * cnt gt 2000? 2000 : 300*cnt }px;">
							
							<c:forEach var="touristArea" items="${ areaList }" varStatus="i" >
						
							<li data-v-2fbcbd64="">
								<dl data-v-2fbcbd64="" class="item_section_new">
									<dt data-v-2fbcbd64="" class="item_top">
										<a data-v-2fbcbd64="" href="javascript:void(0)"  class="ta" id=" ${ i.index}">
											<img data-v-2fbcbd64="" src="${ touristArea.image }" alt="${ touristArea.name } 사진" class="">
											<p data-v-2fbcbd64="" class="s_tit">${ touristArea.name }</p>
											<p data-v-2fbcbd64="" class="item_tag next">${ touristArea.tags }</p>						
											<div data-v-2fbcbd64="" class="score_area">
											<p data-v-2fbcbd64="" class="score_count" style="width: ${ touristArea.starScore * 20}%;">별점(5점만점에 5점)</p>
											${ touristArea.starScore}
											</div>
											<input  class="longLat" type="hidden"  value="${ touristArea.latitude}, ${ touristArea.longitude },${ touristArea.name },${ touristArea.id}, ${ touristArea.image }"/>
										</a>
									</dt>
									<dd data-v-2fbcbd64="" class="item_count_area clear">
										<a data-v-2fbcbd64="" href="javascript:void(0);">
											<p class="ico_type like">
												<span>좋아요</span>
												<span class="count">${ touristArea.like }</span>
											</p>
										</a>
										<a data-v-2fbcbd64="">
											<p data-v-2fbcbd64="" class="ico_type review">
												<span data-v-2fbcbd64="">리뷰</span>
												<span data-v-2fbcbd64="" class="count">${ touristArea.reviewCnt }</span>
											</p>
										</a>
									</dd>
								</dl>
							</li>
							</c:forEach>
						
							
							
							
							<li class="map_paging" data-v-2fbcbd64="">
								<div class="map_paging_inner" data-v-2fbcbd64="">
									<div id="paging" class="page-wrap" data-v-2fbcbd64="">
									
										<c:url var="firstPage" value="touristArea.jsp">
											<c:param name="page" value="1"/>
											<c:if test="${ not empty selectTag }" >
												<c:param name="tag" value="${selectTag }"/>
											</c:if>
										</c:url>
										<a href="${firstPage}"  class="spr_com page-first" data-v-2fbcbd64="">처음 페이지</a>
										<c:url var="beforePage" value="touristArea.jsp">
											<c:param name="page" value="${ selectPage-1 lt 1 ? 1 : selectPage - 1 }"/>
											<c:if test="${ not empty selectTag }" >
												<c:param name="tag" value="${selectTag }"/>
											</c:if>
										</c:url>
										<a href="${ beforePage }"  class="spr_com page-prev" data-v-2fbcbd64="">이전 페이지</a>
										
										<c:forEach begin="${startNum }" end="${endNum }" var="num">
											<c:url var="url" value="touristArea.jsp">
											<c:param name="page" value="${num }"/>
											<c:if test="${ not empty selectTag }" >
												<c:param name="tag" value="${selectTag }"/>
											</c:if>
											</c:url>
											<c:choose>
											<c:when test="${ num eq 1 }">
												<a data-v-2fbcbd64=""  href="${url}" title="현재 페이지" class="current page">${num }</a>
											</c:when>
											<c:otherwise>
												<a data-v-2fbcbd64=""  href="${url}"  title="" class="page">${num}</a>
											</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:url var="nextPage" value="touristArea.jsp">
											<c:param name="page" value="${ selectPage + 1 gt totalPage ? totalPage : selectPage + 1 }"/>
											<c:if test="${ not empty selectTag }" >
												<c:param name="tag" value="${selectTag }"/>
											</c:if>
										</c:url>
										<a href="${nextPage}" class="spr_com page-next" data-v-2fbcbd64="">다음 페이지</a>
										<c:url var="lastPage" value="touristArea.jsp">
											<c:param name="page" value="${ totalPage }"/>
											<c:if test="${ not empty selectTag }" >
												<c:param name="tag" value="${selectTag }"/>
											</c:if>
										</c:url>
										<a href="${lastPage}" class="spr_com page-last" data-v-2fbcbd64="">마지막 페이지</a>
									</div>
								</div>
							</li>
							
						</ul>
					</div>
					<div class="map-sticky-wrapper" style="height: ${ 250 * cnt > 2000 ? 2000 : 250*cnt }px" >
						<div class="map_area">
							<div id="map"></div>				
						</div>						
						
					</div>
				</div>
			</div>
		</div>
					<footer  style="position:relative; top: ${ 260 * cnt lt 750? 750 : 200*cnt }px">
						<%@ include file="../common/jsp/footer.jsp" %>
					</footer>
</body>
</html>