package admin.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.PStmtKey;

import admin.vo.NoticeVO;
import kr.co.dao.DbConnection;

public class NoticeManageDAO {
	private static NoticeManageDAO nmDAO;
	
	private NoticeManageDAO() {
		
	}
	
	public static NoticeManageDAO getInstance() {
		if(nmDAO == null) {
			nmDAO = new NoticeManageDAO();
		}
		return nmDAO;
	}
	
	
	public List<NoticeVO> selectAllnotice() throws SQLException{
		List<NoticeVO> allnoticeList = new ArrayList<NoticeVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeVO nVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllnotice = new StringBuilder();
			selectAllnotice
			.append("	select notice_id, notice_title, notice_content, notice_upload_date, notice_view_num	")
			.append("	from notice																			");
			
			pstmt = con.prepareStatement(selectAllnotice.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				nVO = new NoticeVO();
				nVO.setId(rs.getString("notice_id"));
				nVO.setTitle(rs.getString("notice_title"));
				nVO.setContent(rs.getString("notice_content"));
				nVO.setRegistrationDate(rs.getDate("notice_upload_date"));
				nVO.setViewNum(rs.getInt("notice_view_num"));
				
				allnoticeList.add(nVO);
			}
			
		}finally {
			
		}
		return allnoticeList;
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
	
}
