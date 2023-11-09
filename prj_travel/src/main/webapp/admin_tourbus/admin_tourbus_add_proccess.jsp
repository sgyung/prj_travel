<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="admin.vo.TourBusVO"%>
<%@page import="admin.dao.TourBusManageDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>    

<%
//1. 업로드될 파일이 저장된 폴더의 경로를 얻기
File saveDir = new File("e:/dev/prj_travel_deploy/common/images/tour_bus_img");
//2. 파일의 최대 크기 설정(30MByte)
int maxSize = 1024*1024*30;
	try{
		// 3. 파일 업로드 컴포넌트를 생성한다.( 파일 업로드가 진행된다. )
		MultipartRequest mr = new MultipartRequest(request, saveDir.getAbsolutePath(),
					maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// 4. 업로드 파일명 받기(<input type = "file")
		String fileName = mr.getFilesystemName("chooseImg");
		
		File uploadFile = new File(saveDir.getAbsolutePath() + "/" + fileName);
		
		boolean flag = false;
		
			int limitSize = 1024*1024*5;
			if(uploadFile.length() > limitSize){
				uploadFile.delete();
				flag = true;
			}
			
		TourBusManageDAO tbmDAO = TourBusManageDAO.getInstance();
		TourBusVO tbVO = new TourBusVO();
		
		String tourId = mr.getParameter("tourId");
		String name = mr.getParameter("name");
		String tel = mr.getParameter("tel");
		String[] routes = mr.getParameterValues("route");
		String[] dispatchTimes = mr.getParameterValues("dispatchTime");
		String busTourTime = mr.getParameter("busTourTime");
		int adultFare = Integer.parseInt(mr.getParameter("adultFare"));
		int childFare = Integer.parseInt(mr.getParameter("childFare"));
		int deleteCnt = 0;
		
		if( tourId != null ){
			deleteCnt = 1;
			tbVO.setId(tourId);
		}
		
		int resultCnt = 0;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		Date start = sdf.parse(mr.getParameter("startTime"));
		Date end = sdf.parse(mr.getParameter("endTime"));
		
		java.sql.Date startTime = new java.sql.Date(start.getTime());
		java.sql.Date endTime = new java.sql.Date(end.getTime());
		
		tbVO.setName(name);
		tbVO.setTel(tel);
		tbVO.setStartTime(startTime);
		tbVO.setEndTime(endTime);
		tbVO.setBusTourTime(busTourTime);
		tbVO.setAdultFare(adultFare);
		tbVO.setChildFare(childFare);
		
		if(dispatchTimes != null){	
			tbVO.setDispatchTime(dispatchTimes);
		}
		
		int dispatchTimesLength = (dispatchTimes != null) ? dispatchTimes.length : 0;
		
		
		if(routes != null){
			tbVO.setRoute(routes);
		}
		
		int routesLength = (routes != null) ? routes.length : 0;
		
		
		
		if(!flag){// 여기 안에서 DB에 넣는 메소드 넣는다.
			tbVO.setImage(fileName);
			
			resultCnt = tbmDAO.insertTourBusTransaction(tbVO);
			
			
				
				
			if( ( resultCnt + deleteCnt ) == (( 1 + deleteCnt )+dispatchTimesLength+routesLength) ){

%>
		<script>
            alert("투어버스가 성공적으로 등록되었습니다.");
            window.location.href = "admin_tourbus_add.jsp";
        </script>
<%				
			}else{
%>
		<script>
            alert("오류가 발생했습니다. 다시 입력해주세요.");
            window.location.href = "admin_tourbus_add.jsp";
        </script>
<% 				
				uploadFile.delete();
			}
		}
	}catch(SQLException se){
		se.printStackTrace();
%>
        <script>
            alert("오류가 발생했습니다. 다시 입력해주세요.");
            window.location.href = "admin_tourbus_add.jsp";
        </script>
<%	
	}catch(IOException ie){
		ie.printStackTrace();
%>
        <script>
            alert("오류가 발생했습니다. 다시 입력해주세요.");
            window.location.href = "admin_tourbus_add.jsp";
        </script>
<%	
	}
%>