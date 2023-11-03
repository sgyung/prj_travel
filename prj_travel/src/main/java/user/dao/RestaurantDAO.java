package user.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.RestaurantVO;


public class RestaurantDAO {
	
	private static RestaurantDAO restaurantDAO;
	
	private RestaurantDAO() {
		
	}//TouristAreaDAO
	
	public static RestaurantDAO getInstance() {
		if( restaurantDAO == null ) {
			restaurantDAO = new RestaurantDAO();
		}//end if
		
		return restaurantDAO;
	}//getInstance
	
	public List<RestaurantVO> selectPageContent(int start, int end) throws SQLException{
		List<RestaurantVO> selectList = new ArrayList<RestaurantVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectContent = new StringBuilder();
			selectContent
			.append("	select data.* , ( select count(*) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) review_cnt,	")
			.append("	( select count(*) from RESTAURANT_LIKE where RESTAURANT_ID = data.RESTAURANT_ID) restaurant_like,	")
			.append("	( select nvl(trunc(avg(RESTAURANT_STAR_SCORE)),5) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) star_score	")
			.append("		from (	")
			.append("	select row_number() over( order by a.RESTAURANT_NAME ) num, a.RESTAURANT_ID RESTAURANT_ID,a.RESTAURANT_NAME,	")
			.append("		RESTAURANT_ADDR, RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE,	")
			.append("		RESTAURANT_LATITUDE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	")
			.append("			RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	")
			.append("	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	")
			.append("	from RESTAURANT a, RESTAURANT_TAGS t	")
			.append("	where a.RESTAURANT_ID = t.RESTAURANT_ID(+) and delete_state = 'N'	")
			.append("		group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL,	RESTAURANT_SERVICE_HOURS,	")
			.append("	RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	")
			.append("			) data	")
			.append("			where num between ? and ?	")
			;
			
			pstmt = con.prepareStatement(selectContent.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RestaurantVO rVO = new RestaurantVO();
				rVO.setId(rs.getString("RESTAURANT_ID"));
				rVO.setName(rs.getString("RESTAURANT_NAME"));
				rVO.setAddr(rs.getString("RESTAURANT_ADDR"));
				rVO.setTel(rs.getString("RESTAURANT_TEL"));
				rVO.setServiceHour(rs.getString("RESTAURANT_SERVICE_HOURS"));
				rVO.setTags(rs.getString("TAG_NAME"));
				rVO.setLatitude(rs.getDouble("RESTAURANT_LATITUDE"));
				rVO.setLongitude(rs.getDouble("RESTAURANT_LONGITUDE"));
				rVO.setStarScore(rs.getInt("star_score"));
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setReviewCnt(rs.getInt("review_cnt"));
				rVO.setViewNum(rs.getInt("RESTAURANT_VIEW_NUM"));
				rVO.setImage(rs.getString("RESTAURANT_IMAGE"));
				rVO.setThumbNail(rs.getString("RESTAURANT_THUMBNAIL"));
				rVO.setDeleteState(rs.getString("DELETE_STATE"));
				rVO.setInputDate(rs.getDate("RESTAURANT_UPLOAD_DATE"));
				
				selectList.add(rVO);
				
			}//end while
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return selectList;
	}//selectPageContent
	
	public int selectTotalRestaurant() throws SQLException{
		int totalPage = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select count(*) cnt from restaurant where delete_state='N'		");
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				totalPage = rs.getInt(1);
			}//end while
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalPage;
	}//selectTotalRestaurant
	
	public List<String> selectAllTags(int start, int end) throws SQLException{
		List<String> list = new ArrayList<String>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTag = new StringBuilder();
			selectTag
			.append("	select num, tag_name	")
			.append("	from(select row_number() over( order by restaurant_id ) num,	")
			.append("	tag_name from (select distinct * from restaurant_tags))	")
			.append("	where num between ? and ?	");
			pstmt = con.prepareStatement(selectTag.toString());
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getString("tag_name"));
			}//end while
			} finally {
				db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
	}//selectTags
	
	public List<RestaurantVO> selectTagContent(String tag, int start, int end) throws SQLException{
		List<RestaurantVO> selectList = new ArrayList<RestaurantVO>();
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder keyTag = new StringBuilder();
			keyTag.append("%").append(tag).append("%");
			StringBuilder selectContent = new StringBuilder();
			selectContent
			.append("	select alldata.*	")
			.append("	from( select rownum num, data.* ,	")
			.append("	( select count(*) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) review_cnt,	 ")
			.append("	( select count(*) from RESTAURANT_LIKE where RESTAURANT_ID = data.RESTAURANT_ID) RESTAURANT_like,	 ")
			.append("	( select nvl(trunc(avg(RESTAURANT_STAR_SCORE)),5) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) star_score	 ")
			.append("	from (	 ")
			.append("	select a.RESTAURANT_ID RESTAURANT_ID,a.RESTAURANT_NAME,	 ")
			.append("	RESTAURANT_ADDR, RESTAURANT_TEL,RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE,	 ")
			.append("	RESTAURANT_LATITUDE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	 ")
			.append("	RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	 ")
			.append("	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	 ")
			.append("	from RESTAURANT a, RESTAURANT_TAGS t	 ")
			.append("	where a.RESTAURANT_ID = t.RESTAURANT_ID(+) and delete_state = 'N'	 ")
			.append("	group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS,	 ")
			.append("	RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	 ")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	 ")
			.append("	) data	 ")
			.append("	where tag_name like ? ) alldata	 ")
			.append("	where num between ? and ?	 ")
			;
			
			
			pstmt = con.prepareStatement(selectContent.toString());
			pstmt.setString(1, keyTag.toString());
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RestaurantVO rVO = new RestaurantVO();
				rVO.setId(rs.getString("RESTAURANT_ID"));
				rVO.setName(rs.getString("RESTAURANT_NAME"));
				rVO.setAddr(rs.getString("RESTAURANT_ADDR"));
				rVO.setTel(rs.getString("RESTAURANT_TEL"));
				rVO.setServiceHour(rs.getString("RESTAURANT_SERVICE_HOURS"));
				rVO.setTags(rs.getString("TAG_NAME"));
				rVO.setLatitude(rs.getDouble("RESTAURANT_LATITUDE"));
				rVO.setLongitude(rs.getDouble("RESTAURANT_LONGITUDE"));
				rVO.setStarScore(rs.getInt("star_score"));
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setReviewCnt(rs.getInt("review_cnt"));
				rVO.setViewNum(rs.getInt("RESTAURANT_VIEW_NUM"));
				rVO.setImage(rs.getString("RESTAURANT_IMAGE"));
				rVO.setThumbNail(rs.getString("RESTAURANT_THUMBNAIL"));
				rVO.setDeleteState(rs.getString("DELETE_STATE"));
				rVO.setInputDate(rs.getDate("RESTAURANT_UPLOAD_DATE"));
				
				selectList.add(rVO);
				
			}//end while
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return selectList;
	}//selectTagContent
	
	public int selectTotalTagRestaurant(String tag) throws SQLException {
		int totalPage = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTagArea = new StringBuilder();
			selectTagArea
			.append("	select count (distinct a.RESTAURANT_ID) totalCnt		")
			.append("	from RESTAURANT a, RESTAURANT_TAGS t	")
			.append("	where (a.RESTAURANT_ID = t.RESTAURANT_ID) and (tag_name = ? )	")
			;
			pstmt = con.prepareStatement(selectTagArea.toString());
			pstmt.setString(1, tag);
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				totalPage = rs.getInt("totalCnt");
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalPage;
	
	}//selectTotalTagRestaurant
	
	
	
	public String selectRestaurantInfo( String id ) throws SQLException {
		StringBuilder info = new StringBuilder("");
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectInfo = new StringBuilder();
			selectInfo
			.append("	select RESTAURANT_DETAIL_CONTENT	")
			.append("	from RESTAURANT	")
			.append("	where RESTAURANT_ID = ?	")
			;
			pstmt = con.prepareStatement(selectInfo.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				BufferedReader br = null;
				info = new StringBuilder("");
				Clob clob = rs.getClob("RESTAURANT_DETAIL_CONTENT");
				
				if( clob != null ) {
					br = new BufferedReader( clob.getCharacterStream());
					String temp="";
					while((temp = br.readLine()) != null ){
						info.append(temp);
					}//end while
					if( br != null ) {
						br.close();
					}//end if
				}//end if
			}//end if 
			
		} catch (IOException ie) {
			ie.printStackTrace();
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return info.toString();
	}//selectRestaurantInfo
	
	public RestaurantVO selectResturant( String id ) throws SQLException {
		RestaurantVO rVO = null;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			//조회수 + 1
			StringBuilder updateViewNum = new StringBuilder();
			updateViewNum
			.append("	update restaurant	")
			.append("	set RESTAURANT_VIEW_NUM = RESTAURANT_VIEW_NUM + 1	")
			.append("	where RESTAURANT_ID = ?		")
			;
			pstmt = con.prepareStatement(updateViewNum.toString());
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			
			
			StringBuilder selectResturant = new StringBuilder();
			selectResturant
			.append("	select data.* , ( select count(*) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) review_cnt,	")
			.append("	( select count(*) from RESTAURANT_LIKE where RESTAURANT_ID = data.RESTAURANT_ID) restaurant_like,	")
			.append("	( select nvl(trunc(avg(RESTAURANT_STAR_SCORE)),5) from RESTAURANT_REVIEW where RESTAURANT_ID = data.RESTAURANT_ID ) star_score,	")
			.append("	( select listagg(convenience_name, ', ') within group(order by data.RESTAURANT_ID) CONVENIENCE_NAME	")
			.append("		from RESTAURANT_CONVENIENCE where RESTAURANT_ID = data.RESTAURANT_ID group by RESTAURANT_ID ) RES_CONVENIENCE	")
			.append("		from (	")
			.append("	select a.RESTAURANT_ID RESTAURANT_ID,a.RESTAURANT_NAME,	")
			.append("	RESTAURANT_ADDR, RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE,	")
			.append("	RESTAURANT_LATITUDE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	")
			.append("	RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	")
			.append("	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	")
			.append("		from RESTAURANT a, RESTAURANT_TAGS t	")
			.append("	where a.RESTAURANT_ID = t.RESTAURANT_ID(+) and delete_state = 'N'	")
			.append("		group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL,	")
			.append("	RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	")
			.append("		) data	")
			.append("		where RESTAURANT_ID = ?		")
			;
			pstmt = con.prepareStatement(selectResturant.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rVO = new RestaurantVO();
				rVO.setId(rs.getString("RESTAURANT_ID"));
				rVO.setName(rs.getString("RESTAURANT_NAME"));
				rVO.setAddr(rs.getString("RESTAURANT_ADDR"));
				rVO.setTel(rs.getString("RESTAURANT_TEL"));
				rVO.setServiceHour(rs.getString("RESTAURANT_SERVICE_HOURS"));
				rVO.setTags(rs.getString("TAG_NAME"));
				rVO.setLatitude(rs.getDouble("RESTAURANT_LATITUDE"));
				rVO.setLongitude(rs.getDouble("RESTAURANT_LONGITUDE"));
				rVO.setStarScore(rs.getInt("star_score"));
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setConvenience(rs.getString("RES_CONVENIENCE"));
				rVO.setReviewCnt(rs.getInt("review_cnt"));
				rVO.setViewNum(rs.getInt("RESTAURANT_VIEW_NUM"));
				rVO.setImage(rs.getString("RESTAURANT_IMAGE"));
				rVO.setThumbNail(rs.getString("RESTAURANT_THUMBNAIL"));
				rVO.setDeleteState(rs.getString("DELETE_STATE"));
				rVO.setInputDate(rs.getDate("RESTAURANT_UPLOAD_DATE"));
			}//end if
				
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return rVO;
	}//end selectResturant
	
	public String[] selectUserLike( String userId, String contId ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String[] result = new String[2];
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectLike = new StringBuilder();
			selectLike
			.append("	SELECT		")
			.append("	    (SELECT COUNT(*) FROM restaurant_like where restaurant_id = ? and like_state='Y' ) AS like_cnt,		")
			.append("		COALESCE(		")
			.append("			(SELECT like_state FROM restaurant_like WHERE user_id = ? and restaurant_id= ?  ),'N'		")
			.append("		) AS user_state		")
			.append("	FROM DUAL		")
			;
			pstmt = con.prepareStatement(selectLike.toString());
			pstmt.setString(1, contId);
			pstmt.setString(2, userId);
			pstmt.setString(3, contId);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				result[0] = rs.getString("like_cnt");
				result[1] = rs.getString("user_state");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//finally
		return result;
	}//selectUserLike
	
	
}//class

