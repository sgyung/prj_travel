package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.ReviewVO;


public class ReviewDAO {
	private static ReviewDAO rDAO;
	
	private ReviewDAO() {
		
	}//ReviewDAO
	
	public static ReviewDAO getInstance() {
		if( rDAO == null) {
			rDAO = new ReviewDAO();
		}//end if
		
		return rDAO;
	}//getInstance
	
	public List<ReviewVO>selectPageReview(int start, int end, String areaId) throws SQLException {
		List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String areaType = areaId.split("_")[0];
		try {
			con = db.getConn("jdbc/dbcp");
			StringBuilder selectReview = new StringBuilder();
			
			if( areaType.equals("TA")) {
					
					selectReview
					.append("	select totalReview.*	")
					.append("	from (select row_number() over( order by tourist_review_date desc ) num,	")
					.append("	TOURIST_REVIEW_ID, TOURIST_AREA_ID, USER_ID, TOURIST_REVIEW_CONTENT,	")
					.append("	TOURIST_STAR_SCORE, TOURIST_REVIEW_DATE	")
					.append("	from tourist_review where tourist_area_id= ? ) totalReview	")
					.append("	where num between ? and ?	")
					;
					pstmt = con.prepareStatement(selectReview.toString());
					pstmt.setString(1,  areaId);
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
				.append("	where RESTAURANT_ID= ?	) totalReview	")
				.append("	where num between ? and ?	")
				;
				pstmt = con.prepareStatement(selectReview.toString());
				pstmt.setString(1,  areaId);
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
	
	public int selectTotalReview(String contid) throws SQLException {
		int totalCnt = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String areaId = contid.split("_")[0];
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			if( areaId.equals("TA")) {
				pstmt = con.prepareStatement("	select count(*) cnt from tourist_review where tourist_area_id= ? 	");
			} else {
				pstmt = con.prepareStatement("	select count(*) cnt from restaurant_review where restaurant_id= ? 	");
			}
			pstmt.setString(1, contid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCnt = rs.getInt("cnt");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalCnt;
	}//selectTotalReview
	
	public void insertReview( ReviewVO rVO ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String areaId = rVO.getAreaId().split("_")[0];
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder insertQuestion = new StringBuilder();
			if( areaId.equals("TA")) {
				insertQuestion
				.append("	insert into tourist_review(TOURIST_REVIEW_ID, USER_ID,TOURIST_REVIEW_CONTENT,	")
				.append("	TOURIST_STAR_SCORE, TOURIST_REVIEW_DATE, TOURIST_AREA_ID)	")
				.append("	values( 'TA_RE_'||ta_review_seq.nextval, ?, ?, ?, sysdate, ?)	");
			}//end if
			if( areaId.equals("RES")) {
				insertQuestion
				.append("	insert into restaurant_review(REVIEW_ID, USER_ID, RESTAURANT_REVIEW_CONTENT,	")
				.append("	RESTAURANT_STAR_SCORE, RESTAURANT_REVIEW_DATE, RESTAURANT_ID   )	")
				.append("	values( 'RES_RE_'||ta_review_seq.nextval, ?, ?, ?, sysdate, ?	 )	");
			}//end if
			
			pstmt = con.prepareStatement(insertQuestion.toString());
			pstmt.setString(1, rVO.getUserId());
			pstmt.setString(2, rVO.getContent());
			pstmt.setInt(3, rVO.getStarScore());
			pstmt.setString(4, rVO.getAreaId());
			
			pstmt.executeUpdate();
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
	}//insertReview
	
	public boolean selectIsReview( String contId, String userId, String areaType ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean resultFlag = false;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			String selectReview = "";
			if( areaType.equals("관광지")) {
				selectReview = "	select *  from tourist_review where tourist_area_id = ? and user_id = ?	";
			} else {
				selectReview = "	select *  from restaurant_review where restaurant_id = ? and user_id = ?	";
			}//end else
			
			pstmt = con.prepareStatement(selectReview);
			pstmt.setString(1, contId);
			pstmt.setString(2, userId);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
					resultFlag = true;
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return resultFlag;
		
	}//selectIsReview
	
}//class
;