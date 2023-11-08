package admin.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.CommentVO;
import admin.vo.TourReviewVO;
import admin.vo.TouristAreaVO;
import kr.co.dao.DbConnection;

public class TouristAreaManageDAO {
	private static TouristAreaManageDAO tamDAO;
	
	private TouristAreaManageDAO() {
		
	}
	
	public static TouristAreaManageDAO getInstance() {
		if(tamDAO == null) {
			tamDAO = new TouristAreaManageDAO();
		}
		return tamDAO;
	}
	
	public List<TouristAreaVO> selectAllTouristArea() throws SQLException{
		List<TouristAreaVO> list = new ArrayList<TouristAreaVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TouristAreaVO taVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllTouristArea = new StringBuilder();
			selectAllTouristArea
			.append("	select tourist_area_id, tourist_area_name,tourist_area_upload_date	")
			.append("	from tourist_area	");
			
			pstmt = con.prepareStatement(selectAllTouristArea.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setRegistraitionDate(rs.getDate("tourist_area_upload_date"));
				
				list.add(taVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return list;
	}
	
	public TouristAreaVO selectTouristArea(String areaId) throws SQLException{
		TouristAreaVO taVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTouristArea = new StringBuilder();
			selectTouristArea
			.append("	SELECT a.TOURIST_AREA_ID, a.TOURIST_AREA_NAME, a.TOURIST_AREA_ADDR,a.TOURIST_AREA_TEL, a.TOURIST_AREA_SERVICE_HOURS, a.TOURIST_AREA_PRICE_INFO,	")
			.append("    a.TOURIST_AREA_SLOPE, a.TOURIST_AREA_LONGITUDE, a.TOURIST_AREA_LATITUDE,a.TOURIST_AREA_LIKE, a.TOURIST_AREA_VIEW_NUM, 	")
			.append("    a.TOURIST_AREA_IMAGE, a.TOURIST_AREA_THUMBNAIL, a.DELETE_STATE,a.TOURIST_AREA_UPLOAD_DATE,	 ")
			.append("	LISTAGG(DISTINCT t.TAG_NAME, ' ') WITHIN GROUP (ORDER BY t.TAG_NAME) AS TAG_NAMES,	")
			.append("   LISTAGG(DISTINCT c.CONVENIENCE_NAME, ',') WITHIN GROUP (ORDER BY c.CONVENIENCE_NAME) AS CONVENIENCE_NAMES	")
			.append("     FROM TOURIST_AREA a LEFT JOIN TOURIST_TAGS t ON a.TOURIST_AREA_ID = t.TOURIST_AREA_ID	")
			.append("      LEFT JOIN TOURIST_CONVENIENCE c ON a.TOURIST_AREA_ID = c.TOURIST_AREA_ID	")
			.append("      WHERE a.DELETE_STATE = 'N' AND a.TOURIST_AREA_ID = ? 	")
			.append("     GROUP BY	")
			.append("     a.TOURIST_AREA_ID, a.TOURIST_AREA_NAME, a.TOURIST_AREA_ADDR,	")
			.append("     a.TOURIST_AREA_TEL, a.TOURIST_AREA_SERVICE_HOURS, a.TOURIST_AREA_PRICE_INFO,	")
			.append("    a.TOURIST_AREA_SLOPE, a.TOURIST_AREA_LONGITUDE, a.TOURIST_AREA_LATITUDE,	")
			.append("     a.TOURIST_AREA_LIKE, a.TOURIST_AREA_VIEW_NUM,	")
			.append("    a.TOURIST_AREA_IMAGE, a.TOURIST_AREA_THUMBNAIL, a.DELETE_STATE,	")
			.append("      a.TOURIST_AREA_UPLOAD_DATE	");
			
			pstmt = con.prepareStatement(selectTouristArea.toString());
			pstmt.setString(1, areaId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				taVO = new TouristAreaVO();
				taVO.setId(areaId);
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setAddr(rs.getString("tourist_area_addr"));
				taVO.setTel(rs.getString("tourist_area_tel"));
				taVO.setServiceHour(rs.getString("tourist_area_service_hours"));
				taVO.setPriceInfo(rs.getString("tourist_area_price_Info"));
				taVO.setSlope(rs.getString("tourist_area_slope"));
				taVO.setTags(rs.getString("TAG_NAMES"));
				taVO.setConveniences(rs.getString("CONVENIENCE_NAMES"));
				taVO.setLatitude(rs.getDouble("tourist_area_latitude"));
				taVO.setLongitude(rs.getDouble("tourist_area_longitude"));
				taVO.setImage(rs.getString("tourist_area_image"));
				taVO.setThumbnail(rs.getString("tourist_area_thumbnail"));
				taVO.setDeleteState(rs.getString("delete_state"));
				taVO.setRegistraitionDate(rs.getDate("tourist_area_upload_date"));
				
				pstmt.close();
				rs.close();
				
				StringBuilder selectDetailInfo = new StringBuilder();
				selectDetailInfo
				.append("	SELECT a.TOURIST_AREA_ID, a.TOURIST_AREA_DETAIL_INFO	")
				.append("	FROM TOURIST_AREA a					")
				.append("	WHERE a.DELETE_STATE = 'N' AND a.TOURIST_AREA_ID = ? ");
				
				pstmt = con.prepareStatement(selectDetailInfo.toString());
				
				pstmt.setString(1,areaId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
				
					Clob clob = rs.getClob("TOURIST_AREA_DETAIL_INFO");
					if (clob != null) {
					    StringBuilder detailInfo = new StringBuilder();
					    try (BufferedReader br = new BufferedReader(clob.getCharacterStream())) {
					        String line;
					        while ((line = br.readLine()) != null) {
					            detailInfo.append(line);
					        }
					        if(br != null) {
					        	br.close();
					        }//end if
					        
					    } catch (IOException e) {
					        e.printStackTrace();
					    }
					    taVO.setDetailInfo(detailInfo.toString());
					}
				}
			}//end if
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return taVO;
				
	}
	
	public int insertTransactionArea(TouristAreaVO taVO) throws SQLException{
		
		int resultCnt = 0;
		int deleteCnt = 0;
	
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String touristAreaId = null;
			
			con = db.getConn("jdbc/dbcp");
			
			con.setAutoCommit(false);// 오토 커밋 끔
			
			if( taVO.getId() != null ) {
				pstmt = con.prepareStatement("	delete from tourist_area where tourist_area_id = ?	");
				pstmt.setString(1, taVO.getId());
				deleteCnt = pstmt.executeUpdate();
				
				touristAreaId = taVO.getId();
				pstmt.close();
			} else {
				pstmt = con.prepareStatement("select 'TA_' || TA_SEQ.nextval tourist_area_id from dual ");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					touristAreaId = rs.getString("tourist_area_id");
				}
				
				pstmt.close();
				rs.close();
			}
			
			
			//touristArea 테이블 insert
			StringBuilder insertTouristArea = new StringBuilder();
			insertTouristArea
			.append("	insert into tourist_area(tourist_area_id, tourist_area_name, tourist_area_addr, tourist_area_tel,	")
			.append("	tourist_area_service_hours, tourist_area_price_info, tourist_area_slope,	")
			.append("	Tourist_area_longitude, tourist_area_latitude, tourist_area_like, tourist_area_view_num,	")
			.append("	tourist_area_image, tourist_area_thumbnail,delete_state, tourist_area_upload_date,tourist_area_detail_info )	")
			.append("	values( ?, ?, ?, ?, ?,	")
			.append("	?, ?, ?, ?, 0, 0, ?, ?, 'N', sysdate,? ) 	");
			
			pstmt = con.prepareStatement(insertTouristArea.toString());
			pstmt.setString(1, touristAreaId);
			pstmt.setString(2, taVO.getName());
			pstmt.setString(3, taVO.getAddr());
			pstmt.setString(4, taVO.getTel());
			pstmt.setString(5, taVO.getServiceHour());
			pstmt.setString(6, taVO.getPriceInfo());
			pstmt.setString(7, taVO.getSlope());
			pstmt.setDouble(8, taVO.getLongitude());
			pstmt.setDouble(9, taVO.getLatitude());
			pstmt.setString(10, "http://loaclhost/prj_travel/common/images/touristArea_img/" + taVO.getImage());
			pstmt.setString(11, "http://loaclhost/prj_travel/common/images/touristArea_img/" +  taVO.getThumbnail());
			pstmt.setString(12, taVO.getDetailInfo());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			
			
			//tourist_tags 테이블 insert
			String[] tags = taVO.getTagName();
			if(tags != null) {
				for(int i = 0; i < tags.length; i++) {
					StringBuilder insertTags = new StringBuilder();
					insertTags
					.append(" insert into tourist_tags(Tourist_area_id, tag_name )	")
					.append(" values(? , ?)	");
					
					pstmt = con.prepareStatement(insertTags.toString());
					
					pstmt.setString(1, touristAreaId);
					pstmt.setString(2, tags[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}// end if
			
			//편의시설 insert
			String[] conveniArr = taVO.getConvenienceName();
			if(conveniArr != null) {
				for( int i = 0; i<conveniArr.length; i++) {
					
					pstmt = con.prepareStatement("	insert into tourist_convenience(tourist_area_id, convenience_name ) values ( ?, ? )	");
					pstmt.setString(1, touristAreaId);
					pstmt.setString(2, conveniArr[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}//end if
			
			if((resultCnt+deleteCnt) == (1+deleteCnt +tags.length + conveniArr.length)) {
				con.commit();
			}else {
				con.rollback();
			}
			
			return resultCnt;				
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
	}//insertTouristArea
	
	public List<TourReviewVO> selectReview(String areaId) throws SQLException{
		List<TourReviewVO> list = new ArrayList<TourReviewVO>();
		
		TourReviewVO trVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectReview = new StringBuilder();
			selectReview
			.append("	select tr.tourist_review_id, tr.user_id, tr.tourist_review_date, tr.tourist_review_content, tr.tourist_star_score,")
			.append("   tr.tourist_area_id, ta.tourist_area_name, count(tr.tourist_review_id) cnt	")
			.append("	from tourist_review tr	")
			.append("	inner join tourist_area ta on tr.tourist_area_id = ta.tourist_area_id	")
			.append("	where tr.tourist_area_id = ?	")
			.append("	GROUP BY tr.tourist_review_id, tr.user_id, tr.tourist_review_date, tr.tourist_review_content,")
			.append(" 	tr.tourist_star_score, tr.tourist_area_id, ta.tourist_area_name"	);
			
			pstmt = con.prepareStatement(selectReview.toString());
			
			pstmt.setString(1, areaId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				trVO = new TourReviewVO();
				trVO.setReviewId(rs.getString("tourist_review_id"));
				trVO.setUserId(rs.getString("user_id"));
				trVO.setReviewDate(rs.getDate("tourist_review_date"));
				trVO.setStarScore(rs.getInt("tourist_star_score"));
				trVO.setContent(rs.getString("tourist_review_content"));
				trVO.setTouristAreaId(rs.getString("tourist_area_id"));
				trVO.setTourAreaName(rs.getString("tourist_area_name"));
				trVO.setReviewCnt(rs.getInt("cnt"));
				
				list.add(trVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	public int selectReviewCnt(String areaId) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectReview = new StringBuilder();
			selectReview
			.append("  	select count(tr.tourist_review_id) cnt	")
			.append("	from tourist_review tr	")
			.append("	where tr.tourist_area_id = ?	");
			
			pstmt = con.prepareStatement(selectReview.toString());
			
			pstmt.setString(1, areaId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				resultCnt = rs.getInt("cnt");
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return resultCnt;
		
	}
	
	public int deleteReview(String reviewId) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteReview = new StringBuilder();
			deleteReview
			.append("	delete from tourist_review		")
			.append("	where tourist_review_id = ?		");
			
			pstmt = con.prepareStatement(deleteReview.toString());
			
			pstmt.setString(1, reviewId);
			
			resultCnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return resultCnt;
	}
	
	public int deleteTouristArea(String areaId) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteTouristArea = new StringBuilder();
			deleteTouristArea
			.append("	update tourist_area		")
			.append("	set delete_state='Y'		")
			.append("	where tourist_area_id = ?		");
			
			pstmt = con.prepareStatement(deleteTouristArea.toString());
			
			pstmt.setString(1, areaId);
			
			resultCnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return resultCnt;
	}
	
	public int updateTransactionArea(TouristAreaVO taVO) throws SQLException{
		int resultCnt = 0;
	
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String touristAreaId = taVO.getId();
			con = db.getConn("jdbc/dbcp");
			con.setAutoCommit(false);// 오토 커밋 끔
			
			//수정전 삭제
			pstmt = con.prepareStatement("	delete from tourist_area where tourist_area_id = ?	");
			pstmt.setString(1,  touristAreaId);
			
			resultCnt = pstmt.executeUpdate();
			
			pstmt.close();
			
			/*
			 * pstmt = con.
			 * prepareStatement("select 'TA_' || TA_SEQ.nextval tourist_area_id from dual "
			 * );
			 * 
			 * rs = pstmt.executeQuery();
			 * 
			 * if(rs.next()) { touristAreaId = rs.getString("tourist_area_id"); }
			 * 
			 * pstmt.close(); rs.close();
			 */
			
			//touristArea 테이블 insert
			StringBuilder insertTouristArea = new StringBuilder();
			insertTouristArea
			.append("	insert into tourist_area(tourist_area_id, tourist_area_name, tourist_area_addr, tourist_area_tel,	")
			.append("	tourist_area_service_hours, tourist_area_price_info, tourist_area_slope,	")
			.append("	Tourist_area_longitude, tourist_area_latitude, tourist_area_like, tourist_area_view_num,	")
			.append("	tourist_area_image, tourist_area_thumbnail,delete_state, tourist_area_upload_date,tourist_area_detail_info )	")
			.append("	values( ?, ?, ?, ?, ?,	")
			.append("	?, ?, ?, ?, 0, 0, ?, ?, 'N', sysdate,? ) 	");
			
			pstmt = con.prepareStatement(insertTouristArea.toString());
			pstmt.setString(1, touristAreaId);
			pstmt.setString(2, taVO.getName());
			pstmt.setString(3, taVO.getAddr());
			pstmt.setString(4, taVO.getTel());
			pstmt.setString(5, taVO.getServiceHour());
			pstmt.setString(6, taVO.getPriceInfo());
			pstmt.setString(7, taVO.getSlope());
			pstmt.setDouble(8, taVO.getLongitude());
			pstmt.setDouble(9, taVO.getLatitude());
			pstmt.setString(10, taVO.getImage());
			pstmt.setString(11, taVO.getThumbnail());
			pstmt.setString(12, taVO.getDetailInfo());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			
			
			//tourist_tags 테이블 insert
			String[] tags = taVO.getTagName();
			if(tags != null) {
				for(int i = 0; i < tags.length; i++) {
					StringBuilder insertTags = new StringBuilder();
					insertTags
					.append(" insert into tourist_tags(Tourist_area_id, tag_name )	")
					.append(" values(? , ?)	");
					
					pstmt = con.prepareStatement(insertTags.toString());
					
					pstmt.setString(1, touristAreaId);
					pstmt.setString(2, tags[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}// end if
			
			//편의시설 insert
			String[] conveniArr = taVO.getConvenienceName();
			if(conveniArr != null) {
				for( int i = 0; i<conveniArr.length; i++) {
					
					pstmt = con.prepareStatement("	insert into tourist_convenience(tourist_area_id, convenience_name ) values ( ?, ? )	");
					pstmt.setString(1, touristAreaId);
					pstmt.setString(2, conveniArr[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}//end if
			
			if(resultCnt == (2+tags.length + conveniArr.length)) {
				con.commit();
			}else {
				con.rollback();
			}
			
			return resultCnt;				
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
	}//insertTouristArea
	
	
	
	
}
