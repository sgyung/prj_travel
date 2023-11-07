<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="user_mypageVO.PostVO"%>
<%@page import="user_mypageDAO.MyPostDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="pageUtil.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  trimDirectiveWhitespaces="true"%>
 <%
	String selectPage = request.getParameter("selectPage");
	String pageScale = request.getParameter("pageScale");
	String userId = request.getParameter("userId");
	
	JSONObject jsonObj = null;
	JSONArray jsonArr = new JSONArray();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	Paging paging = Paging.getInstance();
	int[] pageRange = paging.getPageRowRange(Integer.parseInt(selectPage), Integer.parseInt(pageScale));
	
	try{
	List<PostVO> postList = new ArrayList<PostVO>();
	
	MyPostDAO mpDAO = MyPostDAO.getInstance();
	postList = mpDAO.selectPagePost( userId, pageRange[0], pageRange[1] );
	
	for( PostVO vo : postList ){
		jsonObj = new JSONObject();
		jsonObj.put("postId", vo.getPostId());
		jsonObj.put("userId", vo.getUserId());
		jsonObj.put("postTitle", vo.getPostTitle());
		jsonObj.put("postCategory", vo.getPostCategory());
		jsonObj.put("postContent", vo.getPostContent());
		jsonObj.put("postDate", sdf.format(vo.getPostDate()));
		jsonObj.put("postViewNum", vo.getPostViewNum());
		jsonObj.put("deleteState", vo.getDeleteState());
		
		jsonArr.add(jsonObj);
	}//end for
	} catch( SQLException se){
		se.printStackTrace();
	}
	
	out.print( jsonArr.toJSONString());
	
%>