<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.133/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap CDN-->
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN -->
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	//관광지
	$("#taBtn").click(function(){
		var resultJson = null;
		var resultJsonArr = [];
		var selectPage = $("#taPageInput").val();
		$.ajax({
			url : "https://api.visitjeju.net/vsjApi/contents/searchList?apiKey=i75oazz3kw7nexws&locale=kr&category=c1"+"&page="+selectPage,
			type : "get",
			dataType:"json",
			error : function( xhr ){
				xhr.status
			},
			success :function( jsonArr ){
				var items = jsonArr.items;
				var itemCnt = jsonArr.pageSize
				for( var i = 0; i<itemCnt; i++){
					resultJson = {
						"areaType" : "관광지",
						"name" :  items[i].title,
						"addr" :  items[i].address,
						"tel" :  items[i].phoneno,
						"longitude" :  items[i].longitude,
						"latitude" :  items[i].latitude,
						"area_image" :  items[i].repPhoto.photoid.imgpath,
						"thumbnail_img" :  items[i].repPhoto.photoid.thumbnailpath,
						"tag" :  items[i].tag,
					}//json
					
				$.ajax({
					url : "data_process.jsp",
					data : resultJson,
					type : "get",
					dataType : "json",
					error : function( xhr ){
						xhr.status
					},
					success : function( resJson ) {
						
					}//success
				})//ajax
				}//end for
				alert("완료");
			}//success
		})//ajax
	})//click
	
	//음식점
	$("#resBtn").click(function(){
		var resultJson = null;
		var resultJsonArr = [];
		var selectPage = $("#resPageInput").val();
		$.ajax({
			url : "https://api.visitjeju.net/vsjApi/contents/searchList?apiKey=i75oazz3kw7nexws&locale=kr&category=c4"+"&page="+selectPage,
			type : "get",
			dataType:"json",
			error : function( xhr ){
				xhr.status
			},
			success :function( jsonArr ){
				var items = jsonArr.items;
				var itemCnt =100 //검색할 아이템 수
				for( var i = 0; i<itemCnt; i++){
					resultJson = {
						"areaType" : "맛집",								
						"name" :  items[i].title,
						"addr" :  items[i].address,
						"tel" :  items[i].phoneno,
						"longitude" :  items[i].longitude,
						"latitude" :  items[i].latitude,
						"area_image" :  items[i].repPhoto.photoid.imgpath,
						"thumbnail_img" :  items[i].repPhoto.photoid.thumbnailpath,
						"tag" :  items[i].tag,
					}//json
					
				$.ajax({
					url : "data_process.jsp",
					data : resultJson,
					type : "get",
					dataType : "json",
					error : function( xhr ){
						xhr.status
					},
					success : function( resJson ) {
						
					}//success
					
				})//ajax
					
				}//end for
				alert("완료");
			}//success
		})//ajax
		
		
	})//click
})//ready
</script>
</head>
<body>
<input type="button" id="taBtn"  value="touristArea Data Insert"  class="btn btn-primary" /> 
<input type="text" id="taPageInput" class="inputBox" placeholder="페이지 번호를 입력해주세요."> <span>페이지당 100개</span><br/>
<input type="button" id="resBtn"  value="restaurant Data Insert"  class="btn btn-info" />
<input type="text" id="resPageInput" class="inputBox" placeholder="페이지 번호를 입력해주세요."> <span>페이지당 100개</span><br/>
</body>
</html>