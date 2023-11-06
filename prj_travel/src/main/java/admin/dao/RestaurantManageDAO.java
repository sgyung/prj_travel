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

import admin.vo.RestaurantReviewVO;
import admin.vo.RestaurantVO;
import kr.co.dao.DbConnection;

public class RestaurantManageDAO {
	private static RestaurantManageDAO tmDAO;
	
	private RestaurantManageDAO() {
		
	}
	
	public static RestaurantManageDAO getInstance() {
		if(tmDAO == null) {
			tmDAO = new RestaurantManageDAO();
		}
		return tmDAO;
	}
	
	public List<RestaurantVO> selectAllRestaurant() throws SQLException{
		List<RestaurantVO> list = new ArrayList<RestaurantVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RestaurantVO rVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllRestaurant = new StringBuilder();
			selectAllRestaurant
			.append("	select restaurant_id, restaurant_name,restaurant_upload_date	")
			.append("	from restaurant	");
			
			pstmt = con.prepareStatement(selectAllRestaurant.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rVO = new RestaurantVO();
				rVO.setId(rs.getString("tourist_area_id"));
				rVO.setName(rs.getString("tourist_area_name"));
				rVO.setRegistraitionDate(rs.getDate("tourist_area_upload_date"));
				
				list.add(rVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return list;
	}
	
	public RestaurantVO selectRestaurant(String restaurantId) throws SQLException{
		RestaurantVO rVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectRestaurant = new StringBuilder();
			selectRestaurant
			.append("	SELECT a.RESTAURANT_ID, a.RESTAURANT_NAME, a.RESTAURANT_ADDR,a.RESTAURANT_TEL, a.RESTAURANT_SERVICE_HOURS,	")
			.append("    a.RESTAURANT_LONGITUDE, a.RESTAURANT_LATITUDE,a.RESTAURANT_LIKE, a.RESTAURANT_VIEW_NUM, 	")
			.append("    a.RESTAURANT_IMAGE, a.RESTAURANT_THUMBNAIL, a.DELETE_STATE,a.RESTAURANT_UPLOAD_DATE,	 ")
			.append("	LISTAGG(DISTINCT t.TAG_NAME, ' ') WITHIN GROUP (ORDER BY t.TAG_NAME) AS TAG_NAMES,	")
			.append("   LISTAGG(DISTINCT c.CONVENIENCE_NAME, ',') WITHIN GROUP (ORDER BY c.CONVENIENCE_NAME) AS CONVENIENCE_NAMES	")
			.append("     FROM RESTAURANT a LEFT JOIN RESTAURANT_TAGS t ON a.RESTAURANT_ID = t.RESTAURANT_ID	")
			.append("      LEFT JOIN RESTAURANT_CONVENIENCE c ON a.RESTAURANT_ID = c.RESTAURANT_ID	")
			.append("      WHERE a.DELETE_STATE = 'N' AND a.RESTAURANT_ID = ? 	")
			.append("     GROUP BY	")
			.append("     a.RESTAURANT_ID, a.RESTAURANT_NAME, a.RESTAURANT_ADDR,	")
			.append("     a.RESTAURANT_TEL, a.RESTAURANT_SERVICE_HOURS,	")
			.append("     a.RESTAURANT_LONGITUDE, a.RESTAURANT_LATITUDE,	")
			.append("     a.RESTAURANT_LIKE, a.RESTAURANT_VIEW_NUM,	")
			.append("    a.RESTAURANT_IMAGE, a.RESTAURANT_THUMBNAIL, a.DELETE_STATE,	")
			.append("      a.RESTAURANT_UPLOAD_DATE	");
			
			pstmt = con.prepareStatement(selectRestaurant.toString());
			pstmt.setString(1, restaurantId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rVO = new RestaurantVO();
				rVO.setId(restaurantId);
				rVO.setName(rs.getString("RESTAURANT_NAME"));
				rVO.setAddr(rs.getString("RESTAURANT_ADDR"));
				rVO.setTel(rs.getString("RESTAURANT_TEL"));
				rVO.setServiceHour(rs.getString("RESTAURANT_SERVICE_HOURS"));
				rVO.setTags(rs.getString("TAG_NAMES"));
				rVO.setConveniences(rs.getString("CONVENIENCE_NAMES"));
				rVO.setLatitude(rs.getDouble("RESTAURANT_LATITUDE"));
				rVO.setLongitude(rs.getDouble("RESTAURANT_LONGITUDE"));
				rVO.setImage(rs.getString("RESTAURANT_IMAGE"));
				rVO.setThumbnail(rs.getString("RESTAURANT_THUMBNAIL"));
				rVO.setDeleteState(rs.getString("delete_state"));
				rVO.setRegistraitionDate(rs.getDate("RESTAURANT_UPLOAD_DATE"));
				
				pstmt.close();
				rs.close();
				
				StringBuilder selectDetailInfo = new StringBuilder();
				selectDetailInfo
				.append("	SELECT a.RESTAURANT_ID, a.RESTAURANT_DETAIL_content	")
				.append("	FROM RESTAURANT a					")
				.append("	WHERE a.DELETE_STATE = 'N' AND a.RESTAURANT_ID = ? ");
				
				pstmt = con.prepareStatement(selectDetailInfo.toString());
				
				pstmt.setString(1,restaurantId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
				
					Clob clob = rs.getClob("RESTAURANT_DETAIL_content");
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
					    rVO.setDetailInfo(detailInfo.toString());
					}
				}
			}//end if
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return rVO;
				
	}
	
	public int insertTransactionArea(RestaurantVO rVO) throws SQLException{
		int resultCnt = 0;
	
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String restaurantId = null;
			
			con = db.getConn("jdbc/dbcp");
			
			con.setAutoCommit(false);// 오토 커밋 끔
			
			pstmt = con.prepareStatement("select 'RES_' || RES_SEQ.nextval restaurant_id from dual ");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				restaurantId = rs.getString("restaurant_id");
			}
			
			pstmt.close();
			rs.close();
			
			//touristArea 테이블 insert
			StringBuilder insertRestaurant = new StringBuilder();
			insertRestaurant
			.append("	insert into restaurant(restaurant_id, restaurant_name, restaurant_addr, restaurant_tel,	")
			.append("	restaurant_service_hours, ")
			.append("	restaurant_longitude, restaurant_latitude, restaurant_like, restaurant_view_num,	")
			.append("	restaurant_image, restaurant_thumbnail,delete_state, restaurant_upload_date,restaurant_detail_content )	")
			.append("	values( ?, ?, ?, ?, ?,	")
			.append("	?, ?, 0, 0, ?, ?, 'N', sysdate,? ) 	");
			
			pstmt = con.prepareStatement(insertRestaurant.toString());
			pstmt.setString(1, restaurantId);
			pstmt.setString(2, rVO.getName());
			pstmt.setString(3, rVO.getAddr());
			pstmt.setString(4, rVO.getTel());
			pstmt.setString(5, rVO.getServiceHour());
			pstmt.setDouble(6, rVO.getLongitude());
			pstmt.setDouble(7, rVO.getLatitude());
			pstmt.setString(8, "http://loaclhost/prj_travel/common/images/restuarant_img/" + rVO.getImage());
			pstmt.setString(9, "http://loaclhost/prj_travel/common/images/restuarant_img/" +  rVO.getThumbnail());
			pstmt.setString(10, rVO.getDetailInfo());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			rs.close();
			
			
			//restaurant_tags 테이블 insert
			String[] tags = rVO.getTagName();
			if(tags != null) {
				for(int i = 0; i < tags.length; i++) {
					StringBuilder insertTags = new StringBuilder();
					insertTags
					.append(" insert into restaurant_tags(restaurant_id, tag_name )	")
					.append(" values(? , ?)	");
					
					pstmt = con.prepareStatement(insertTags.toString());
					
					pstmt.setString(1, restaurantId);
					pstmt.setString(2, tags[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}// end if
			
			//편의시설 insert
			String[] conveniArr = rVO.getConvenienceName();
			if(conveniArr != null) {
				for( int i = 0; i<conveniArr.length; i++) {
					
					pstmt = con.prepareStatement("	insert into restaurant_convenience(restaurant_id, convenience_name ) values ( ?, ? )	");
					pstmt.setString(1, restaurantId);
					pstmt.setString(2, conveniArr[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}//end if
			
			if(resultCnt == (1+tags.length + conveniArr.length)) {
				con.commit();
			}else {
				con.rollback();
			}
			
			return resultCnt;				
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
	}//insertTouristArea
	
	public List<RestaurantReviewVO> selectReview(String restaurantId) throws SQLException{
		List<RestaurantReviewVO> list = new ArrayList<RestaurantReviewVO>();
		
		RestaurantReviewVO resReviewVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectReview = new StringBuilder();
			selectReview
			.append("	select a.restaurant_review_id, a.user_id, a.restaurant_review_date, a.restaurant_review_content, a.restaurant_star_score,")
			.append("   a.restaurant_id, b.restaurant_name, count(a.restaurant_review_id) cnt	")
			.append("	from restaurant_review a	")
			.append("	inner join restaurant b on tr.tourist_area_id = ta.tourist_area_id	")
			.append("	where a.restaurant_id = ?	")
			.append("	GROUP BY a.restaurant_review_id, a.user_id, a.restaurant_review_date, a.restaurant_review_content,")
			.append(" 	a.restaurant_star_score, a.restaurant_id, b.restaurant_name"	);
			
			pstmt = con.prepareStatement(selectReview.toString());
			
			pstmt.setString(1, restaurantId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				resReviewVO = new RestaurantReviewVO();
				resReviewVO.setReviewId(rs.getString("restaurant_review_id"));
				resReviewVO.setUserId(rs.getString("user_id"));
				resReviewVO.setReviewDate(rs.getDate("restaurant_review_date"));
				resReviewVO.setStarScore(rs.getInt("restaurant_star_score"));
				resReviewVO.setContent(rs.getString("restaurant_review_content"));
				resReviewVO.setRestaurantId(rs.getString("restaurant_id"));
				resReviewVO.setRestaurantName(rs.getString("restaurant_name"));
				resReviewVO.setReviewCnt(rs.getInt("cnt"));
				
				list.add(resReviewVO);
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	public int selectReviewCnt(String restaurantId) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectReview = new StringBuilder();
			selectReview
			.append("  	select count(a.restaurant_review_id) cnt	")
			.append("	from restaurant_review a	")
			.append("	where a.restaurant_id = ?	");
			
			pstmt = con.prepareStatement(selectReview.toString());
			
			pstmt.setString(1, restaurantId);
			
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
			.append("	delete from restaurant_review		")
			.append("	where restaurant_review_id = ?		");
			
			pstmt = con.prepareStatement(deleteReview.toString());
			
			pstmt.setString(1, reviewId);
			
			resultCnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return resultCnt;
	}
	
	public int deleteRestaurant(String restaurantId) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder deleteRestaurant = new StringBuilder();
			deleteRestaurant
			.append("	update restaurant		")
			.append("	set delete_state='Y'		")
			.append("	where restaurant_id = ?		");
			
			pstmt = con.prepareStatement(deleteRestaurant.toString());
			
			pstmt.setString(1, restaurantId);
			
			resultCnt = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}
		return resultCnt;
	}
}
