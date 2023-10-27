package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.UserCommentVO;
import admin.vo.UserManageVO;
import admin.vo.UserPostVO;
import kr.co.dao.DbConnection;

public class UserManageDAO {
	private static UserManageDAO userManageDAO;
	
	private UserManageDAO() {
		
	}
	
	public static UserManageDAO getInstance() {
		if(userManageDAO == null) {
			userManageDAO = new UserManageDAO();
		}
		return userManageDAO;
	}
	
	public List<UserManageVO> selectAllUser() throws SQLException {
		List<UserManageVO> userList = new ArrayList<UserManageVO>();
		
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserManageVO userManageVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllUser = new StringBuilder();
			selectAllUser
			.append("	select a.user_id, a.user_name, a.user_registration_date, count(b.user_id) as post_count, count(c.user_id) as comment_count, a.user_registration_state	")
			.append("	from t_user a																																			")
			.append("	left join post b on a.user_id = b.user_id																												")
			.append("	left join post_comment c on a.user_id = c.user_id																										")
			.append("	group by a.user_id, a.user_name, a.user_registration_date,a.user_registration_state																		")
			.append("	order by  a.user_registration_date desc, a.user_name");
			
			
			pstmt = con.prepareStatement(selectAllUser.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				userManageVO = new UserManageVO();
				userManageVO.setId(rs.getString("user_id"));
				userManageVO.setName(rs.getString("user_name"));
				userManageVO.setJoinDate(rs.getDate("user_registration_date"));
				userManageVO.setPostCount(rs.getInt("post_count"));
				userManageVO.setReviewCount(rs.getInt("comment_count"));
				userManageVO.setJoinType(rs.getString("user_registration_state"));
				
				userList.add(userManageVO);
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return userList;
	}
	
	public UserManageVO selectUserInfo(String id) throws SQLException{
		UserManageVO umVO = null;
		
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUserInfo = new StringBuilder();
			selectUserInfo
			.append("		select user_id, user_name, user_tel, user_birth, user_zipcode, user_addr0, user_addr1, user_registration_state		")
			.append("		from t_user																											")
			.append("		where user_id=?																										");
		
			pstmt = con.prepareStatement(selectUserInfo.toString());
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				umVO = new UserManageVO();
				umVO.setId(rs.getString("user_id"));
				umVO.setName(rs.getString("user_name"));
				umVO.setTel(rs.getString("user_tel"));
				umVO.setBirthdate(rs.getDate("user_birth"));
				umVO.setZipcode(rs.getString("user_zipcode"));
				umVO.setAddr(rs.getString("user_addr0"));
				umVO.setAddrDetail(rs.getString("user_addr1"));
				umVO.setJoinType(rs.getString("user_registration_state"));
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return umVO;
	}
	
	public List<UserPostVO> selectUserAllPost(String id) throws SQLException{
		List<UserPostVO> userAllPostList = new ArrayList<UserPostVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserPostVO pVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUserAllPost = new StringBuilder();
			selectUserAllPost
			.append("	select b.post_id,a.user_name,a.user_id, b.post_title, b.post_upload_date		")
			.append("	from t_user a left join post b on a.user_id = b.user_id			")
			.append("	where a.user_id = ?													");
			
			pstmt = con.prepareStatement(selectUserAllPost.toString());
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				pVO = new UserPostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserName(rs.getString("user_name"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setTitle(rs.getString("post_title"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
				
				userAllPostList.add(pVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return userAllPostList;
	}
	
	public UserPostVO selectUserPost(String postId) throws SQLException{
		UserPostVO pVO = null;

		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUserPost = new StringBuilder();
			selectUserPost
			.append("	select b.post_id,a.user_name, a.user_id, b.post_title, b.post_upload_date,b.cartegory_id, b.post_content		")
			.append("	from t_user a left join post b on a.user_id = b.user_id												")
			.append("	where b.post_id = ?																					");
			
			pstmt = con.prepareStatement(selectUserPost.toString());
			
			pstmt.setString(1, postId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pVO = new UserPostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserName(rs.getString("user_name"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setTitle(rs.getString("post_title"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
				pVO.setCategory(rs.getString("cartegory_id"));
				pVO.setContent(rs.getString("post_content"));
				
			}
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
	
		return pVO;
	}
	
	public List<UserCommentVO> selectUserAllComment(String id) throws SQLException{
		List<UserCommentVO> userAllCommentList = new ArrayList<UserCommentVO>();

		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserCommentVO ucVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUserAllComment = new StringBuilder();
			selectUserAllComment
			.append("	select b.comment_id,a.user_name, a.user_id, b.comment_date,b.comment_content			")
			.append("	from t_user a left join post_comment b on a.user_id = b.user_id							")
			.append("	where a.user_id = ?																		");
			
			pstmt = con.prepareStatement(selectUserAllComment.toString());
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ucVO = new UserCommentVO();
				ucVO.setCommentId(rs.getString("comment_id"));
				ucVO.setUserName(rs.getString("user_name"));
				ucVO.setUserId(rs.getString("user_id"));
				ucVO.setRegistrationDate(rs.getDate("comment_date"));
				ucVO.setContent(rs.getString("comment_content"));
				
				userAllCommentList.add(ucVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return userAllCommentList;
	}
	
	public UserCommentVO selectUserComment(String commetnId) throws SQLException{
		UserCommentVO ucVO  = null;

		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUserComment = new StringBuilder();
			selectUserComment
			.append("	select b.comment_id,a.user_name, a.user_id, b.comment_date,b.comment_content			")
			.append("	from t_user a left join post_comment b on a.user_id = b.user_id							")
			.append("	where b.comment_id = ?																	");
			
			pstmt = con.prepareStatement(selectUserComment.toString());
			
			pstmt.setString(1, commetnId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ucVO = new UserCommentVO();
				ucVO.setCommentId(rs.getString("comment_id"));
				ucVO.setUserName(rs.getString("user_name"));
				ucVO.setUserId(rs.getString("user_id"));
				ucVO.setRegistrationDate(rs.getDate("comment_date"));
				ucVO.setContent(rs.getString("comment_content"));
				
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return ucVO;
	}
}
