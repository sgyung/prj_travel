package user_mypageDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.ReviewVO;

public class MyReviewDAO {
private static MyReviewDAO rDAO;
	
	private MyReviewDAO() {
		
	}//ReviewDAO
	
	public static MyReviewDAO getInstance() {
		if( rDAO == null) {
			rDAO = new MyReviewDAO();
		}//end if
		
		return rDAO;
	}//getInstance
	
	public int selectTotalReview(String id) throws SQLException {
		int totalCnt = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectReview = new StringBuilder();
			selectReview
			.append("	select (select count(*) from TOURIST_REVIEW where user_id = ?	)	")
			.append("	+ (select count(*) from RESTAURANT_REVIEW where user_id= ? )  total_QnA	")
			.append("	from dual	")
			;
			pstmt = con.prepareStatement(selectReview.toString());
			
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCnt = rs.getInt("total_QnA");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalCnt;
	}//selectTotalReview
	
	public int selectReviewCnt(String userId, String areaType) throws SQLException {
		int totalCnt = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			if( areaType.equals("관광지")) {
				pstmt = con.prepareStatement("	select count(*) cnt from tourist_review where user_id= ? 	");
			} else {
				pstmt = con.prepareStatement("	select count(*) cnt from restaurant_review where user_id= ? 	");
			}
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCnt = rs.getInt("cnt");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalCnt;
	}//selectTotalReview
	
	public List<ReviewVO>selectPageReview(int start, int end, String userId, String areaType) throws SQLException {
		List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			StringBuilder selectReview = new StringBuilder();
			
			if( areaType.equals("관광지")) {
					
					selectReview
					.append("	select totalReview.*	")
					.append("	from (select row_number() over( order by tourist_review_date desc ) num,	")
					.append("	TOURIST_REVIEW_ID, TOURIST_AREA_ID, USER_ID, TOURIST_REVIEW_CONTENT,	")
					.append("	TOURIST_STAR_SCORE, TOURIST_REVIEW_DATE	")
					.append("	from tourist_review where user_id= ? ) totalReview	")
					.append("	where num between ? and ?	")
					;
					pstmt = con.prepareStatement(selectReview.toString());
					pstmt.setString(1,  userId);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						ReviewVO rVO = new ReviewVO();
						rVO.setReviewId(rs.getString("TOURIST_REVIEW_ID"));
						rVO.setAreaId(rs.getString("TOURIST_AREA_ID"));
						rVO.setUserId(rs.getString("USER_ID"));
						rVO.setContent(rs.getString("TOURIST_REVIEW_CONTENT"));
						rVO.setStarScore(rs.getInt("TOURIST_STAR_SCORE"));
						rVO.setDate(rs.getDate("TOURIST_REVIEW_DATE"));
						
						reviewList.add(rVO);
					}//end while
				
			} else {
				selectReview
				.append("	select totalReview.*	")
				.append("	from (select row_number() over( order by RESTAURANT_REVIEW_DATE desc ) num,	")
				.append("	REVIEW_ID, RESTAURANT_ID, USER_ID, RESTAURANT_REVIEW_CONTENT,	")
				.append("	RESTAURANT_STAR_SCORE, RESTAURANT_REVIEW_DATE	")
				.append("	from RESTAURANT_REVIEW	")
				.append("	where user_id= ?	) totalReview	")
				.append("	where num between ? and ?	")
				;
				pstmt = con.prepareStatement(selectReview.toString());
				pstmt.setString(1,  userId);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReviewVO rVO = new ReviewVO();
					rVO.setReviewId(rs.getString("REVIEW_ID"));
					rVO.setAreaId(rs.getString("RESTAURANT_ID"));
					rVO.setUserId(rs.getString("USER_ID"));
					rVO.setContent(rs.getString("RESTAURANT_REVIEW_CONTENT"));
					rVO.setStarScore(rs.getInt("RESTAURANT_STAR_SCORE"));
					rVO.setDate(rs.getDate("RESTAURANT_REVIEW_DATE"));
					
					reviewList.add(rVO);
				}//end while
				
			}//end else
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return reviewList;
	}//selectPageReview
	
	public int deleteReview(String reviewId ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int result = 0;
		String reviewCategory = reviewId.split("_")[0];
		String query = "";
		if( reviewCategory.equals("TA") ) {
			query = "delete from tourist_review where tourist_review_id = ?	";
		} else {
			query = "delete from restaurant_review where review_id = ?	";
		}
		
		try {
			con = db.getConn("jdbc/dbcp");	
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, reviewId);
			
			result = pstmt.executeUpdate();
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return result;
	}//deleteReview
	
}//class
