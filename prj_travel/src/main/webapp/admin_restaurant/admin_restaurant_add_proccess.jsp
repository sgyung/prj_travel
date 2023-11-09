<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.RestaurantVO"%>
<%@page import="admin.dao.RestaurantManageDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>     
<%
//1. 업로드될 파일이 저장된 폴더의 경로를 얻기
File saveDir = new File("e:/dev/prj_travel_deploy/common/images/restaurant_img");
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
			
		RestaurantManageDAO rmDAO = RestaurantManageDAO.getInstance();
		RestaurantVO rVO = new RestaurantVO();
		
		String areaId = mr.getParameter("areaId");
		String name = mr.getParameter("name");
		String addr = mr.getParameter("addr");
		double latitude = Double.parseDouble(mr.getParameter("latitude"));
		double longitude = Double.parseDouble(mr.getParameter("longitude"));
		String tel = mr.getParameter("tel");
		String[] tagNames = mr.getParameterValues("tagName");
		String[] convenienceNames = mr.getParameterValues("convevienceName");
		String serviceHour = mr.getParameter("serviceHour");
		String detailInfo = mr.getParameter("detailInfo");
		int deleteCnt = 0;
		if( areaId != null ){
			deleteCnt = 1;
			rVO.setId(areaId);
		}
		int resultCnt = 0;
		
		rVO.setName(name);
		rVO.setAddr(addr);
		rVO.setLatitude(latitude);
		rVO.setLongitude(longitude);
		rVO.setTel(tel);
		
		if(tagNames != null){	
			rVO.setTagName(tagNames);
		}
		
		int tagNamesLength = (tagNames != null) ? tagNames.length : 0;
		
		
		if(convenienceNames != null){
			rVO.setConvenienceName(convenienceNames);
		}
		
		int convenienceNamesLength = (convenienceNames != null) ? convenienceNames.length : 0;
		
		rVO.setServiceHour(serviceHour);
		rVO.setDetailInfo(detailInfo);
		
		
		if(!flag){// 여기 안에서 DB에 넣는 메소드 넣는다.
			rVO.setImage(fileName);
			rVO.setThumbnail(fileName);
			
			resultCnt = rmDAO.insertTransactionArea(rVO);
			
			
				
				
			if((resultCnt + deleteCnt) == ((1 + deleteCnt) +tagNamesLength+convenienceNamesLength) ){

%>
		<script>
            alert("맛집이 성공적으로 등록되었습니다.");
            window.location.href = "admin_restaurant_list.jsp";
        </script>
<%				
			}else{
%>
		<script>
            alert("오류가 발생했습니다. 다시 입력해주세요.");
            window.location.href = "admin_restaurant_list.jsp";
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
            window.location.href = "admin_restaurant_add.jsp";
        </script>
<%	
	}catch(IOException ie){
		ie.printStackTrace();
%>
        <script>
            alert("오류가 발생했습니다. 다시 입력해주세요.");
            window.location.href = "admin_restaurant_add.jsp";
        </script>
<%	
	}
%>