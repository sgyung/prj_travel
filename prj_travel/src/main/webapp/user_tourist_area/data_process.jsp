<%@page import="user.vo.RestaurantVO"%>
<%@page import="user.dao.RestaurantDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.TouristAreaVO"%>
<%@page import="user.dao.TouristAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String areaType = request.getParameter("areaType");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String tel = request.getParameter("tel");
	String longitude = request.getParameter("longitude");
	String latitude = request.getParameter("latitude");
	String area_image = request.getParameter("area_image");
	String thumbnail_img = request.getParameter("thumbnail_img");
	String tags = request.getParameter("tag");
	
	if( areaType.equals("관광지")){
		TouristAreaVO tVO = new TouristAreaVO();
		tVO.setName(name);
		tVO.setAddr(addr);
		tVO.setTel(tel);
		tVO.setLongitude(Double.parseDouble(longitude));
		tVO.setLatitude(Double.parseDouble(latitude));
		tVO.setImage(area_image);
		tVO.setThumbNail(thumbnail_img);
		tVO.setTags(tags);
		try{
			TouristAreaDAO taDAO = TouristAreaDAO.getInstance();
			taDAO.insertTransactionTA(tVO);
		}catch( SQLException se ){
			se.printStackTrace();
		}//end catch
		
	}//end if
	
	if( areaType.equals("맛집")){
		RestaurantVO rVO = new RestaurantVO();
		rVO.setName(name);
		rVO.setAddr(addr);
		rVO.setTel(tel);
		rVO.setLongitude(Double.parseDouble(longitude));
		rVO.setLatitude(Double.parseDouble(latitude));
		rVO.setImage(area_image);
		rVO.setThumbNail(thumbnail_img);
		rVO.setTags(tags);
		try{
			TouristAreaDAO taDAO = TouristAreaDAO.getInstance();
			taDAO.insertTransactionRES(rVO);
		}catch( SQLException se ){
			se.printStackTrace();
		}//end catch
		
	}//end if
	
	
	
%>
