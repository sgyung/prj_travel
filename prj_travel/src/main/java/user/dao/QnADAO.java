package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.QnAVO;
import user.vo.QuestionVO;


public class QnADAO {
	private static QnADAO qnaDAO;
	
	private QnADAO() {
		
	}//TouristAreaDAO
	
	public static QnADAO getInstance() {
		if( qnaDAO == null ) {
			qnaDAO = new QnADAO();
		}//end if
		return qnaDAO;
	}//getInstance
	
	public List<QnAVO> selectPageQnA(int start, int end) throws SQLException {
		List<QnAVO> qnaList = new ArrayList<QnAVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectQnA = new StringBuilder();
			selectQnA
			.append("	select totalQnA.*	")
			.append("	from(select row_number() over( order by qna_date desc ) num,	")
			.append("	INQUIRY_ID, USER_ID, TOURIST_AREA_ID, RESTAURANT_ID, QNA_TITLE,	")
			.append("	QNA_TYPE, QNA_CONTENT, QNA_DATE, ANSWER, ANSWER_STATE, ANSWER_DATE	")
			.append("	from qna) totalQnA	")
			.append("	where num between ? and ?	")
			;
			pstmt = con.prepareStatement(selectQnA.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnAVO qaVO = new QnAVO();
				qaVO.setUserId(rs.getString("user_id"));
				qaVO.setQnaId(rs.getString("inquiry_id"));
				if( rs.getString("qna_type").equals("관광지") ) {
					qaVO.setAreaId(rs.getString("tourist_area_id"));
				} else {
					qaVO.setAreaId(rs.getString("restaurant_id"));
				}
				qaVO.setTitle(rs.getString("qna_title"));
				qaVO.setCategory(rs.getString("qna_type"));
				qaVO.setContent(rs.getString("qna_content"));
				qaVO.setRegistrationDate(rs.getDate("qna_date"));
				qaVO.setAnswer(rs.getString("answer"));
				qaVO.setAnswerType(rs.getString("answer_state"));
				qaVO.setAnswerDate(rs.getDate("answer_date"));
				
				qnaList.add(qaVO);
			}//end while
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return qnaList;
	}//selectAllQnA
	
	public QnAVO selectQnAContent( String QnAId ) throws SQLException {
		QnAVO qaVO = null;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = db.getConn("jdbc/dbcp");
			
			
			pstmt = con.prepareStatement("select * from qna where inquiry_id=? ");
			pstmt.setString(1, QnAId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qaVO = new QnAVO();
				qaVO.setUserId(rs.getString("user_id"));
				qaVO.setQnaId(rs.getString("inquiry_id"));
				if( rs.getString("qna_type").equals("관광지") ) {
					qaVO.setAreaId(rs.getString("tourist_area_id"));
				} else {
					qaVO.setAreaId(rs.getString("restaurant_id"));
				}
				qaVO.setTitle(rs.getString("qna_title"));
				qaVO.setCategory(rs.getString("qna_type"));
				qaVO.setContent(rs.getString("qna_content"));
				qaVO.setRegistrationDate(rs.getDate("qna_date"));
				qaVO.setAnswer(rs.getString("answer"));
				qaVO.setAnswerType(rs.getString("answer_state"));
				qaVO.setAnswerDate(rs.getDate("answer_date"));
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return qaVO;
	}//selectQnAContent
	
	public void insertQnA( QuestionVO qVO ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder insertQuestion = new StringBuilder();
			insertQuestion
			.append("	insert into qna( INQUIRY_ID, USER_ID, TOURIST_AREA_ID, QNA_TITLE, QNA_TYPE, QNA_CONTENT, QNA_DATE, ANSWER_STATE )	")
			.append("  	values( qna_seq.nextval, ?,  ?,  ?, ?, ?, sysdate, 'N')	 ")
			;
			pstmt = con.prepareStatement(insertQuestion.toString());
			pstmt.setString(1, qVO.getUserId());
			pstmt.setString(2, qVO.getAreaId());
			pstmt.setString(3, qVO.getTitle());
			pstmt.setString(4, qVO.getType());
			pstmt.setString(5, qVO.getContent());
			
			pstmt.executeUpdate();
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
	}//insertQnA
	
	public int selectTotalQnA() throws SQLException {
		int totalQnA = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("select count(*) cnt from qna");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalQnA = rs.getInt("cnt");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return totalQnA;
	}//selectTotalQnA

}//class
