package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.CommentVO;
import admin.vo.PostVO;
import kr.co.dao.DbConnection;

public class PostManageDAO {
	private static PostManageDAO postDAO;
	
	private PostManageDAO() {
		
	}
	
	public static PostManageDAO getInstance() {
		if(postDAO == null) {
			postDAO = new PostManageDAO();
		}
		return postDAO;
	}
	
	public List<PostVO> selectAllRestaurantPost() throws SQLException{
		List<PostVO> allRestaurantPostList = new ArrayList<PostVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PostVO pVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectRestaurantPost = new StringBuilder();
			selectRestaurantPost
			.append("	select a.post_id, a.user_id, a.post_title, a.post_content, a.post_upload_date, a.post_view_num, a.delete_state, b.cartegory_name	")
			.append("	from post a inner join post_cartegory b on a.cartegory_id = b.cartegory_id															")
			.append("	where b.cartegory_name = '맛집' and a.delete_state = 'n'																			");
			
			pstmt = con.prepareStatement(selectRestaurantPost.toString());
			
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				pVO = new PostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setPostTitle(rs.getString("post_title"));
				pVO.setPostCategory(rs.getString("cartegory_name"));
				pVO.setPostContent(rs.getString("post_content"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
				pVO.setPostViewNum(rs.getInt("post_view_num"));
				pVO.setPostState(rs.getString("delete_state"));
				
				allRestaurantPostList.add(pVO);
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return allRestaurantPostList;
	}
	
	public List<PostVO> selectAllTouristPost() throws SQLException{
		List<PostVO> allTouristPostList = new ArrayList<PostVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PostVO pVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTouristtPost = new StringBuilder();
			selectTouristtPost
			.append("	select a.post_id, a.user_id, a.post_title, a.post_content, a.post_upload_date, a.post_view_num, a.delete_state, b.cartegory_name	")
			.append("	from post a inner join post_cartegory b on a.cartegory_id = b.cartegory_id															")
			.append("	where b.cartegory_name = '관광지' and a.delete_state = 'n'																			");
			
			pstmt = con.prepareStatement(selectTouristtPost.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				pVO = new PostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setPostTitle(rs.getString("post_title"));
				pVO.setPostCategory(rs.getString("cartegory_name"));
				pVO.setPostContent(rs.getString("post_content"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
				pVO.setPostViewNum(rs.getInt("post_view_num"));
				pVO.setPostState(rs.getString("delete_state"));
				
				allTouristPostList.add(pVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return allTouristPostList;
	}
	
	public PostVO selectPost(String postId) throws SQLException{
		PostVO pVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectPost = new StringBuilder();
			selectPost
			.append("	select a.post_id, a.user_id, a.post_title, a.post_content, a.post_upload_date,b.cartegory_name	")
			.append("	from  post a inner join post_cartegory b on a.cartegory_id = b.cartegory_id										")
			.append("	where a.post_id = ?																								");
			
			pstmt = con.prepareStatement(selectPost.toString());
			
			pstmt.setString(1, postId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pVO = new PostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setPostTitle(rs.getString("post_title"));
				pVO.setPostCategory(rs.getString("cartegory_name"));
				pVO.setPostContent(rs.getString("post_content"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
			
		}
		return pVO;
	}
	
	public List<CommentVO> selectComment(String postId) throws SQLException{
		List<CommentVO> commentList = new ArrayList<CommentVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentVO cVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectComment = new StringBuilder();
			
			selectComment
			.append("	select b.comment_id, a.user_id, b.comment_content, b.comment_date		")
			.append("	from post a, post_comment b								")
			.append("	where a.post_id = b.post_id and a.post_id = ?			");
			
			pstmt = con.prepareStatement(selectComment.toString());
			
			pstmt.setString(1, postId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cVO = new CommentVO();
				cVO.setCommentId(rs.getString("comment_id"));
				cVO.setUserId(rs.getString("user_id"));
				cVO.setContent(rs.getString("comment_content"));
				cVO.setRegistrationDate(rs.getDate("comment_date"));
				
				commentList.add(cVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return commentList;
	}
	
	public int deletePost(String postId) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deletePost = new StringBuilder();
			deletePost
			.append("	delete from post		")
			.append("	where post_id = ?		");
			
			pstmt = con.prepareStatement(deletePost.toString());
			
			pstmt.setString(1, postId);
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
	public int deleteComment(String commentId) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteComment = new StringBuilder();
			deleteComment
			.append("	delete from post_comment		")
			.append("	where comment_id = ?		");
			
			pstmt = con.prepareStatement(deleteComment.toString());
			
			pstmt.setString(1, commentId);
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
}
