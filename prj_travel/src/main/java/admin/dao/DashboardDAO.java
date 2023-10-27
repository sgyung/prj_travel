package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import admin.vo.QandAVO;
import admin.vo.RankVO;
import admin.vo.ReservationCountVO;
import admin.vo.RestaurantReviewVO;
import admin.vo.TourReviewVO;
import kr.co.dao.DbConnection;

public class DashboardDAO {
	private static DashboardDAO dashboardDAO;
	
	private DashboardDAO() {
		
	}
	
	public static DashboardDAO getInstance() {
		if(dashboardDAO == null) {
			dashboardDAO = new DashboardDAO();
		}
			return dashboardDAO;
	}
	
	public List<NoticeVO> selectRecentNotice() throws SQLException{
		List<NoticeVO> recentNoticeList = new ArrayList<NoticeVO>();
		NoticeVO noticeVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		con = db.getConn("jdbc/dbcp");
		
		StringBuilder selectRecentNotice = new StringBuilder();
		selectRecentNotice
		.append("	select notice_id,admin_id,notice_title,notice_content,notice_upload_date,notice_view_num	")
		.append("	from notice	")
		.append("	order by notice_upload_date desc, notice_id desc	");
		
		pstmt = con.prepareStatement(selectRecentNotice.toString());
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			noticeVO = new NoticeVO(rs.getString("notice_id"),rs.getString("notice_title"),rs.getString("notice_content"),
						rs.getInt("notice_view_num"),rs.getDate("notice_upload_date"));
			recentNoticeList.add(noticeVO);
		}
		
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return recentNoticeList;
	}
	
	public List<QandAVO> selectWaitingAnswer() throws SQLException{
		List<QandAVO> waitingAnswerList = new ArrayList<QandAVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QandAVO questionBoardVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder waitingAnswer = new StringBuilder();
			waitingAnswer
			.append("	select inquiry_id, user_id, qna_title, qna_type, qna_date		")
			.append("	from  qna														")
			.append("	where answer_state = ?											")
			.append("	order by qna_date asc											");
	
			pstmt = con.prepareStatement(waitingAnswer.toString());
			
			pstmt.setString(1, "n");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				questionBoardVO = new QandAVO();
				questionBoardVO.setQAndAId(rs.getString("inquiry_id"));
				questionBoardVO.setUserId(rs.getString("user_id"));
				questionBoardVO.setTitle(rs.getString("qna_title"));
				questionBoardVO.setCategory(rs.getString("qna_type"));
				questionBoardVO.setRegistrationDate(rs.getDate("qna_date"));
				
				waitingAnswerList.add(questionBoardVO);
				
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return waitingAnswerList;
	}
	
	public List<RankVO> selectRestaurantRank() throws SQLException{
		List<RankVO> restaurantRankList = new ArrayList<RankVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RankVO rankVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selecrRestaurantRank = new StringBuilder();
			selecrRestaurantRank
			.append("	select row_number() over(order by restaurant_like desc) num, restaurant_name, restaurant_like	")
			.append("	from restaurant																					")
			.append("	order by num asc																				");
			
			pstmt = con.prepareStatement(selecrRestaurantRank.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				rankVO = new RankVO();
				rankVO.setName(rs.getString("restaurant_name"));
				rankVO.setLike(rs.getInt("restaurant_like"));
				
				restaurantRankList.add(rankVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return restaurantRankList;
	}
	
	public List<RankVO> selectTouristAreaRank() throws SQLException{
		List<RankVO> touristAreaRankList = new ArrayList<RankVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RankVO rankVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selecrtouristAreaRank = new StringBuilder();
			selecrtouristAreaRank
			.append("	select row_number() over(order by tourist_area_like desc) num, tourist_area_name, tourist_area_like	")
			.append("	from tourist_area																					")
			.append("	order by num asc																					");
			
			pstmt = con.prepareStatement(selecrtouristAreaRank.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				rankVO = new RankVO();
				rankVO.setName(rs.getString("tourist_area_name"));
				rankVO.setLike(rs.getInt("tourist_area_like"));
				
				touristAreaRankList.add(rankVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return touristAreaRankList;
	}
	
	public List<TourReviewVO> selectRecentTourReview() throws SQLException{
		List<TourReviewVO> recentTourReviewList = new ArrayList<TourReviewVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TourReviewVO tourReviewVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selecrTourReview = new StringBuilder();
			selecrTourReview
			.append("	select tourist_review_content, user_id, tourist_review_date			")
			.append("	from tourist_review													")
			.append("	order by tourist_review_date desc									");
			
			pstmt = con.prepareStatement(selecrTourReview.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				tourReviewVO = new TourReviewVO();
				tourReviewVO.setContent(rs.getString("tourist_review_content"));
				tourReviewVO.setUserId(rs.getString("user_id"));
				tourReviewVO.setReviewDate(rs.getDate("tourist_review_date"));
				
				
				recentTourReviewList.add(tourReviewVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return recentTourReviewList;
	}
	
	public List<RestaurantReviewVO> selectRecentRestaurantReview() throws SQLException{
		List<RestaurantReviewVO> recentRestaurantReviewList = new ArrayList<RestaurantReviewVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RestaurantReviewVO restaurantReviewVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selecrRestaurantReview = new StringBuilder();
			selecrRestaurantReview
			.append("	select restaurant_review_content, user_id, restaurant_review_date			")
			.append("	from restaurant_review												")
			.append("	order by restaurant_review_date desc								");
			
			pstmt = con.prepareStatement(selecrRestaurantReview.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				restaurantReviewVO = new RestaurantReviewVO();
				restaurantReviewVO.setContent(rs.getString("restaurant_review_content"));
				restaurantReviewVO.setUserId(rs.getString("user_id"));
				restaurantReviewVO.setReviewDate(rs.getDate("restaurant_review_date"));
				
				
				recentRestaurantReviewList.add(restaurantReviewVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return recentRestaurantReviewList;
	}
	
	public List<ReservationCountVO> selectUnappovedReservation() throws SQLException{
		List<ReservationCountVO> unappovedReservationList = new ArrayList<ReservationCountVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReservationCountVO reservationCountVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectUnappovedReservation = new StringBuilder();
			selectUnappovedReservation
			.append("	select a.bustour_name,count(*) as reservation_state										")
			.append("	from bustour a inner join bustour_reservation b on a.bustour_id = b.bustour_id			")
			.append("	where b.approval_state = 'N' and a.bustour_name = ?										")
			.append("	group by a.bustour_name																	");
			
			pstmt = con.prepareStatement(selectUnappovedReservation.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				reservationCountVO = new ReservationCountVO();
				reservationCountVO.setTourName(rs.getString("bustour_name"));
				reservationCountVO.setUnapprovedCount(rs.getInt("reservation_state"));
				
				
				unappovedReservationList.add(reservationCountVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		
		return unappovedReservationList;
	}
	
}
