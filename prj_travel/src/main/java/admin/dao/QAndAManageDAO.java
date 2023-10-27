package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import admin.vo.QandAVO;
import kr.co.dao.DbConnection;

public class QAndAManageDAO {
	private static QAndAManageDAO qamDAO;
	
	private QAndAManageDAO() {
		
	}
	
	public static QAndAManageDAO getInstance() {
		if(qamDAO == null) {
			qamDAO = new QAndAManageDAO();
		}
		return qamDAO;
	}
	
	public List<QandAVO> selectAllRestaurantQnA() throws SQLException{
		List<QandAVO> restaurantQnAList = new ArrayList<QandAVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QandAVO qbVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectrestaurantQnA = new StringBuilder();
			selectrestaurantQnA
			.append("	select inquiry_id, user_id, qna_title, qna_type, qna_content, qna_date, answer_state	")
			.append("	from qna																				")
			.append("	where 	qna_type='맛집'																			");
			
			pstmt = con.prepareStatement(selectrestaurantQnA.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				qbVO = new QandAVO();
				qbVO.setQAndAId(rs.getString("inquiry_id"));
				qbVO.setUserId(rs.getString("user_id"));
				qbVO.setTitle(rs.getString("qna_title"));
				qbVO.setCategory(rs.getString("qna_type"));
				qbVO.setContent(rs.getString("qna_content"));
				qbVO.setRegistrationDate(rs.getDate("qna_date"));
				qbVO.setAnswerType(rs.getString("answer_state"));
				
				restaurantQnAList.add(qbVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return restaurantQnAList;
	} 
	
	public List<QandAVO> selectAllTouristQnA() throws SQLException{
		List<QandAVO> touristQnAList = new ArrayList<QandAVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QandAVO qbVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTouristQnA = new StringBuilder();
			selectTouristQnA
			.append("	select inquiry_id, user_id, qna_title, qna_type, qna_content, qna_date, answer_state	")
			.append("	from qna																				")
			.append("	where 	qna_type='관광지'																			");
			
			pstmt = con.prepareStatement(selectTouristQnA.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				qbVO = new QandAVO();
				qbVO.setQAndAId(rs.getString("inquiry_id"));
				qbVO.setUserId(rs.getString("user_id"));
				qbVO.setTitle(rs.getString("qna_title"));
				qbVO.setCategory(rs.getString("qna_type"));
				qbVO.setContent(rs.getString("qna_content"));
				qbVO.setRegistrationDate(rs.getDate("qna_date"));
				qbVO.setAnswerType(rs.getString("answer_state"));
				
				touristQnAList.add(qbVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return touristQnAList;
	} 
	
	public QandAVO selectQnA(String qAndAId) throws SQLException{
		QandAVO qaVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTouristQnA = new StringBuilder();
			selectTouristQnA
			.append("	select inquiry_id, user_id, tourist_area_id, restaurant_id, qna_title, qna_type, qna_content, qna_date, answer, answer_state, answer_date	")
			.append("	from qna																																	")
			.append("	where  inquiry_id= ?																														");
			
			pstmt = con.prepareStatement(selectTouristQnA.toString());
			
			pstmt.setString(1, qAndAId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qaVO = new QandAVO();
				qaVO.setQAndAId(rs.getString("inquiry_id"));
				qaVO.setUserId(rs.getString("user_id"));
				qaVO.setAreaId(rs.getString("tourist_area_id"));
				qaVO.setRestaurantId(rs.getString("restaurant_id"));
				qaVO.setTitle(rs.getString("qna_title"));
				qaVO.setCategory(rs.getString("qna_type"));
				qaVO.setContent(rs.getString("qna_content"));
				qaVO.setRegistrationDate(rs.getDate("qna_date"));
				qaVO.setAnswer(rs.getString("answer"));
				qaVO.setAnswerType(rs.getString("answer_state"));
				qaVO.setAnswerDate(rs.getDate("answer_date"));
				
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return qaVO;
	}
	
	public int updateAnswer(QandAVO qaVO) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder updateAnswer = new StringBuilder();
			updateAnswer
			.append("	update qna														")
			.append("	set answer=? , answer_state='y', answer_date= sysdate			")
			.append("	where inquiry_id = ? 											");
			
			pstmt = con.prepareStatement(updateAnswer.toString());
			
			pstmt.setString(1, qaVO.getAnswer());
			pstmt.setString(2, qaVO.getQAndAId());
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
	public int deleteQandA(String questionId) throws SQLException{
		int cnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteNotice = new StringBuilder();
			deleteNotice
			.append("	delete from qna				")
			.append("	where inquiry_id = ?		");
			
			pstmt = con.prepareStatement(deleteNotice.toString());
			
			pstmt.setString(1, questionId);
			
			cnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return cnt;
	}
	
}
