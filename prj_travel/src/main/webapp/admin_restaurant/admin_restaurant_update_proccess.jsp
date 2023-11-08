<%@page import="admin.vo.RestaurantVO"%>
<%@page import="admin.dao.RestaurantManageDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.dao.DbConnection"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.IOError"%>
<%@page import="java.sql.SQLException"%>
<%@page import="admin.vo.TouristAreaVO"%>
<%@page import="admin.dao.TouristAreaManageDAO"%>
<%@page import="pageUtil.TouristAreaPageDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info = "" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");

		RestaurantManageDAO rmDAO = RestaurantManageDAO.getInstance();
		RestaurantVO resVO = new RestaurantVO();
		
		String areaId = request.getParameter("sub_areaId");
		String name = request.getParameter("sub_title");
		String addr = request.getParameter("sub_addr");
		double latitude = Double.parseDouble(request.getParameter("sub_latitude"));
		double longitude = Double.parseDouble(request.getParameter("sub_longitude"));
		String tel = request.getParameter("sub_tel");
		String[] tagNames = request.getParameter("sub_tag").split(" ");
		String[] convenienceNames = request.getParameter("sub_convevienceName").split(" ");
		String serviceHour = request.getParameter("sub_serviceHour");
		String detailInfo = request.getParameter("sub_detailInfo");
		String img = request.getParameter("sub_img");
		
		int resultCnt = 0;
		
		resVO.setId(areaId);
		resVO.setName(name);
		resVO.setAddr(addr);
		resVO.setLatitude(latitude);
		resVO.setLongitude(longitude);
		resVO.setTel(tel);
		
		if(tagNames != null){	
			resVO.setTagName(tagNames);
		}
		
		int tagNamesLength = (tagNames != null) ? tagNames.length : 0;
		
		
		if(convenienceNames != null){
			resVO.setConvenienceName(convenienceNames);
		}
		
		int convenienceNamesLength = (convenienceNames != null) ? convenienceNames.length : 0;
		
		resVO.setServiceHour(serviceHour);
		resVO.setDetailInfo(detailInfo);
		
		
		resVO.setImage(img);
		resVO.setThumbnail(img);
		resultCnt = rmDAO.updateTransactionArea(resVO);
				
		if(resultCnt == (2+tagNamesLength+convenienceNamesLength) ){

%>
		<script>
            alert("관광지가 성공적으로 수정하였습니다.");
            window.location.href = "admin_restaurant_list.jsp";
        </script>			
<% } else { %>
		<script>
           alert("관광지를 수정하는데 실패하였습니다.");
           window.location.href = "admin_restaurant_list.jsp";
        </script>
	
<% } %>