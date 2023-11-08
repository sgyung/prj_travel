package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import admin.vo.NoticeVO;
import admin.vo.UserCommentVO;
import kr.co.dao.DbConnection;
import user.vo.UserBoardVO;

public class UserBoardDAO {
	private static UserBoardDAO ubDAO;
	
	private UserBoardDAO() {
		
	}
	
	public static UserBoardDAO getInstance() {
		if(ubDAO == null) {
			ubDAO = new UserBoardDAO();
		}
		return ubDAO;
	}
	
	
	public List<NoticeVO> selectAllPost() throws SQLException{
		List<NoticeVO> allpostList = new ArrayList<NoticeVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeVO nVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllPost = new StringBuilder();
			selectAllPost
			.append("	select post_id, post_title, post_content, post_upload_date, post_view_num	")
			.append("	from post																		");
			
			pstmt = con.prepareStatement(selectAllPost.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				nVO = new NoticeVO();
				nVO.setId(rs.getString("post_id"));
				nVO.setTitle(rs.getString("post_title"));
				nVO.setContent(rs.getString("post_content"));
				nVO.setRegistrationDate(rs.getDate("post_upload_date"));
				nVO.setViewNum(rs.getInt("post_view_num"));
				
				allpostList.add(nVO);
			}
			
		}finally {
			
		}
		return allpostList;
	}
	
	public void insertNotice(NoticeVO nVO) throws SQLException{
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder insertNotice = new StringBuilder();
			insertNotice
			.append("	insert into notice(notice_id, admin_id, notice_title, notice_content, notice_upload_date)	")
			.append("	values(notice_seq.nextval, 'admin', ?, ?, sysdate )");
			
			pstmt = con.prepareStatement(insertNotice.toString());
			
			pstmt.setString(1, nVO.getTitle());
			pstmt.setString(2, nVO.getContent());
			
			pstmt.executeQuery();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		
	}
	
	public NoticeVO selectNotice(String noticeId) throws SQLException{
		NoticeVO nVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder allRestaurantQnA = new StringBuilder();
			allRestaurantQnA
			.append("	select notice_id, notice_title, notice_content, notice_upload_date, notice_view_num	")
			.append("	from notice																			")
			.append("	where notice_id=? 																	");
			
			pstmt = con.prepareStatement(allRestaurantQnA.toString());
			
			pstmt.setString(1, noticeId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nVO = new NoticeVO();
				nVO.setId(rs.getString("notice_id"));
				nVO.setTitle(rs.getString("notice_title"));
				nVO.setContent(rs.getString("notice_content"));
				nVO.setRegistrationDate(rs.getDate("notice_upload_date"));
				nVO.setViewNum(rs.getInt("notice_view_num"));
				
			}
			
		}finally {
			
		}
		return nVO;
	}
	
	public int updateNotice(NoticeVO nVO) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder updateNotice = new StringBuilder();
			updateNotice
			.append("	update notice														")
			.append("	set  NOTICE_TITLE=? , NOTICE_CONTENT=?, NOTICE_UPLOAD_DATE= sysdate	")
			.append("	where notice_id=? 													");
			
			pstmt = con.prepareStatement(updateNotice.toString());
			
			pstmt.setString(1, nVO.getTitle());
			pstmt.setString(2, nVO.getContent());
			pstmt.setString(3, nVO.getId());
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
	public int deleteNotice(String noticeId) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteNotice = new StringBuilder();
			deleteNotice
			.append("	delete from notice		")
			.append("	where notice_id = ?		");
			
			pstmt = con.prepareStatement(deleteNotice.toString());
			
			pstmt.setString(1, noticeId);
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
	public int insertBoard(UserBoardVO ubVO) throws SQLException{
		int result = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder insertNotice = new StringBuilder();
			insertNotice
			.append("	insert into post(POST_ID, USER_ID, POST_TITLE, CARTEGORY_ID, POST_CONTENT, POST_UPLOAD_DATE, POST_VIEW_NUM, DELETE_STATE)	")
			.append("	values(post_seq.nextval,?, ?, ?,?, sysdate,0,'N' )");
			
			pstmt = con.prepareStatement(insertNotice.toString());
			
			pstmt.setString(1, ubVO.getUserId());
			pstmt.setString(2, ubVO.getBoardTitle());
			pstmt.setString(3, ubVO.getBoardCategory());
			pstmt.setString(4, ubVO.getBoardContent());
			
			result = pstmt.executeUpdate();
			
			return result;
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		
	}
	
	public int insertComment(UserCommentVO ucVO) throws SQLException{
			int result = 0;
				System.out.println(ucVO);
			DbConnection db = DbConnection.getInstance();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder insertComment = new StringBuilder();
				insertComment
				.append("	insert into post_comment(COMMENT_ID, USER_ID, POST_ID, COMMENT_CONTENT, COMMENT_DATE)	")
				.append("	values(comment_seq.nextval,?, ?, ?,sysdate)");
				
				pstmt = con.prepareStatement(insertComment.toString());
				
				pstmt.setString(1, ucVO.getUserId());
				pstmt.setString(2, ucVO.getPostId());
				pstmt.setString(3, ucVO.getContent());
				
				result = pstmt.executeUpdate();
				
				return result;
				
			}finally {
				db.dbClose(null, pstmt, con);
			}
	}
	
	public int updateComment(UserCommentVO ucVO) throws SQLException{
		int result = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder updateComment = new StringBuilder();
			updateComment
			.append("	update post_comment		")
			.append("	set comment_content = ?, comment_date = sysdate  ")
			.append("	where comment_id = ?	");
			
			pstmt = con.prepareStatement(updateComment.toString());
			
			pstmt.setString(1, ucVO.getContent());
			pstmt.setString(2, ucVO.getUserId());
			
			result = pstmt.executeUpdate();
			
			return result;
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
	}
	
	
}
