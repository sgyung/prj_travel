package user_mypageDAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user_mypageVO.CommentVO;
import user_mypageVO.PostVO;

public class PostDAO {

	private static PostDAO postDAO;
	
	public PostDAO() {
	}
	
	public static PostDAO getInstance() {
		if(postDAO == null){
			postDAO = new PostDAO();
		}
		return postDAO;
	}
	
	public List<PostVO>selectAllPost(String id)throws SQLException{
		List<PostVO> allpostList =new ArrayList<PostVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PostVO pVO=null;
		
		DbConnection db =DbConnection.getInstance();		
		
		try {
		 con =db.getConn("jdbc/dbcp");
		 
		 StringBuilder selectAllPost=new StringBuilder();
		 selectAllPost
		 .append("   select POST_ID, USER_ID, POST_TITLE, CARTEGORY_ID, POST_CONTENT, POST_UPLOAD_DATE, POST_VIEW_NUM, DELETE_STATE")
		.append("   from post                           ")
		.append("where user_id=?                     "); 
		 
		 pstmt = con.prepareStatement(selectAllPost.toString());
		 
		 pstmt.setString(1, id);
		 
		 rs = pstmt.executeQuery();
		
		 while(rs.next()) {
			 pVO =new PostVO();
			 pVO.setPostId(rs.getString("post_id"));
			 pVO.setUserId(rs.getString("user_id"));
			 pVO.setPostTitle(rs.getString("post_title"));
			 pVO.setPostCategory(rs.getString("cartegory_id"));
			 pVO.setPostContent(rs.getString("post_content"));
			 pVO.setPostDate(rs.getDate("post_upload_date"));
			 pVO.setPostViewNum(rs.getInt("post_view_num"));
			 pVO.setDeleteState(rs.getString("delete_state"));
			 
			 allpostList.add(pVO);
		 }
		}finally {
			
		}
		return allpostList;
	}//selectAllPost
	
	public PostVO selectPost(String userid) throws SQLException{
		PostVO pVO=null;
		
		DbConnection db= DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectpost=new StringBuilder();
			selectpost
			.append("   select POST_ID, USER_ID, POST_TITLE, CARTEGORY_ID, POST_CONTENT, POST_UPLOAD_DATE, POST_VIEW_NUM, DELETE_STATE")
			.append("   from post                           ")
			.append("  where user_id=?                     "); 
			
			pstmt = con.prepareStatement(selectpost.toString());
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pVO = new PostVO();
				pVO.setPostId(rs.getString("post_id"));
				 pVO.setUserId(rs.getString("user_id"));
				 pVO.setPostTitle(rs.getString("post_title"));
				 pVO.setPostCategory(rs.getString("cartegory_id"));
				 pVO.setPostContent(rs.getString("post_content"));
				 pVO.setPostDate(rs.getDate("post_upload_date"));
				 pVO.setPostViewNum(rs.getInt("post_view_num"));
				 pVO.setDeleteState(rs.getString("delete_state"));
			}
			
		}finally {
			
		}
		return pVO;
	}//selectPost
	
	public List<CommentVO>selectAllComment()throws SQLException{
		List<CommentVO> allcommentList =new ArrayList<CommentVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentVO cVO=null;
		
		DbConnection db =DbConnection.getInstance();		
		
		try {
			con =db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllComment=new StringBuilder();
			selectAllComment
			.append("   select COMMENT_ID, USER_ID, POST_ID, COMMENT_CONTENT, COMMENT_USER, COMMENT_DATE")
			.append("   from post_comment                           "); 
			
			pstmt = con.prepareStatement(selectAllComment.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cVO =new CommentVO();
				cVO.setCommentId(rs.getString("comment_id"));
				cVO.setUserId(rs.getString("user_id"));
				cVO.setPostId(rs.getString("post_id"));
				cVO.setContent("comment_content");
				cVO.setUser(rs.getString("comment_user"));
				cVO.setRegistrationDate(rs.getDate("comment_date"));
				
				
				allcommentList.add(cVO);
			}
			
		}finally {
			
		}
		return allcommentList;
	}//selectAllComment
	
	/*
	 * public List<PostVO>selectCategory(String id)throws SQLException{ List<PostVO>
	 * categoryList =new ArrayList<PostVO>();
	 * 
	 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
	 * 
	 * DbConnection db =DbConnection.getInstance();
	 * 
	 * try { con =db.getConn("jdbc/dbcp");
	 * 
	 * StringBuilder selectCategory=new StringBuilder(); selectCategory
	 * .append("   select CARTEGORY_ID, CARTEGORY_NAME")
	 * .append("   from POST_CARTEGORY                           ");
	 * 
	 * pstmt = con.prepareStatement(selectCategory.toString());
	 * 
	 * rs = pstmt.executeQuery();
	 * 
	 * if(rs.next()) { cateGory =new String();
	 * cateGory.setCommentId(rs.getString("comment_id"));
	 * cateGory.setUserId(rs.getString("user_id"));
	 * 
	 * categoryList.add(cateGory); }
	 * 
	 * }finally {
	 * 
	 * } return categoryList; }//selectAllComment
	 */	
	
	
	
	
}//class
