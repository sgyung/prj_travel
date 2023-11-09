<%@page import="user.vo.UserNameVO"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style type="text/css">
.depth02 {
	display: none;
    position: absolute;
    left: 46.5%;
}

/* 마우스 오버 시 세부 메뉴 보이도록 처리 */
li:hover .depth02 {
    display: block;
}

.depth02_2 {
	display : flex;
	margin-top : 25px;
	gap : 13px
}

.logo {
	font-size : 20px
}
</style>
<script type="text/javascript">
$(function(){
	 $("#depth01").hover(
		      function() {
		    	  $(".header").css("height", "150px");
		      },
		      function() {
		    	  $(".header").css("height", "90px");
		      }
		    );
});//ready
</script>
<div class="header">
        <div class="header_contents flex">
            <div class="logo"><a href="../user_main/main.jsp">JTour</a></div>
            <div class="nav_top">
                <ul>
                    <li><a href="../user_tourist_area/touristArea.jsp?tag=전체">관광지</a></li>
                    <li><a href="../user_restaurant/restaurant.jsp?tag=전체">맛집</a></li>
                    <li id="depth01">
                    	<a href="../user_board/notice_list.jsp">게시판</a>
                    	<div class="depth02" id="depth02">
                    		<ul class="depth02_2 menu-wrap">
                    			<li><a href="http://192.168.10.133/prj_travel/user_board/notice_list.jsp" title="공지사항" class="asd t-menu-item"><span>공지사항</span></a></li>
                    			<li><a href="http://192.168.10.133/prj_travel/user_board/board_tourist_list.jsp" title="관광지게시판" class="asd t-menu-item"><span>관광지게시판</span></a></li>
                    			<li><a href="http://192.168.10.133/prj_travel/user_board/board_restaurant_list.jsp" title="맛집게시판" class="asd t-menu-item"><span>맛집게시판</span></a></li>
                   			</ul>
               			</div>
                    </li>
                    <li><a href="../user_tour_bus/tourBus_main.jsp">투어예약</a></li>
                </ul>
            </div>
            <div class="search_login flex">
                
                <c:choose>
				<c:when test="${ empty sesId or empty userName }">
				<a href="../user_login/login.jsp" style="margin-left: 30px;" >로그인</a>
				
				
				</c:when>
				<c:otherwise>
				<%
				UserNameVO unVO = (UserNameVO)session.getAttribute("userName");
				String name = unVO.getName();
				pageContext.setAttribute("name", name);
				%>
					
				<p style="margin-left: 30px;"><a href="../user_mypage/mypage.jsp"><c:out value="${ name }"/> 님</a></p>
				
				<a href="logout.jsp" style="margin-left: 30px;">로그아웃</a>
				
				</c:otherwise>	
				</c:choose>
                
            </div>
        </div>
    </div>