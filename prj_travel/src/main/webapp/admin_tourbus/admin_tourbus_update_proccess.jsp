<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="admin.vo.TourBusVO"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%
request.setCharacterEncoding("UTF-8");

	TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();
	TourBusVO tbmVO = new TourBusVO();

	String tourId = request.getParameter("sub_tourId");
	String name = request.getParameter("sub_name");
	String busTourTime = request.getParameter("sub_busTourTime");
	String startTime = request.getParameter("sub_startTime");
	String endTime = request.getParameter("sub_endTime");
	String tel = request.getParameter("sub_tel");
	
	String[] dispatchTime = request.getParameter("sub_dispatchTime").split(" ");
	String[] route = request.getParameter("sub_route").split(" ");
	
	String adultFare = request.getParameter("sub_adultFare");
	String childFare = request.getParameter("sub_childFare");
	String img = request.getParameter("sub_img");
	
	try {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 시간 형식 지정
	    java.util.Date parsedStartDate = sdf.parse(startTime); // 문자열을 파싱하여 java.util.Date로 변환
	    java.util.Date parsedEndDate = sdf.parse(endTime); // 문자열을 파싱하여 java.util.Date로 변환
	    java.sql.Date sqlStartDate = new java.sql.Date(parsedStartDate.getTime()); // java.sql.Date로 변환
	    java.sql.Date sqlEndDate = new java.sql.Date(parsedEndDate.getTime()); // java.sql.Date로 변환

	    // sqlDate를 사용하여 SQL에서 사용할 수 있습니다.
	int resultCnt = 0;
	
	tbmVO.setId(tourId);
	tbmVO.setName(name);
	tbmVO.setBusTourTime(busTourTime);
	tbmVO.setTel(tel);
	tbmVO.setStartTime(sqlStartDate);
	tbmVO.setEndTime(sqlEndDate);
	tbmVO.setAdultFare(Integer.parseInt(adultFare));
	tbmVO.setAdultFare(Integer.parseInt(childFare));
	tbmVO.setImage(img);
	
	if( dispatchTime != null ){
		tbmVO.setDispatchTime(dispatchTime);
	}//end if
	
	int dispatchTimeLength = ( dispatchTime != null ) ? dispatchTime.length : 0;
	
	if( route != null ){
		tbmVO.setRoute(route);
	}
	
	int routeLength = ( route != null )?  route.length : 0;
	
	resultCnt = tbmDAO.updateTourBusTransaction(tbmVO);
	
	if( resultCnt == (2 + dispatchTimeLength + routeLength)){
		%>
		<script>
            alert(" 투어버스가 성공적으로 수정되었습다.");
            window.location.href = "admin_tourbus_list.jsp";
        </script>
		
	<%} else { %>
	<script>
           alert("투어버스를 수정하는데 실패하였습니다.");
           window.location.href = "admin_tourbus_list.jsp";
        </script>
    <% } 
	
	} catch (ParseException e) {
	    e.printStackTrace();
	}
	
%>
