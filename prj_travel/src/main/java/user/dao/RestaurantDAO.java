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
			.append("	select  alldata.*		")
			.append("	from (	")
			.append("	select row_number() over( order by a.RESTAURANT_NAME ) num, a.RESTAURANT_ID, a.RESTAURANT_NAME, ")
			.append("	RESTAURANT_ADDR, RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE,		")
			.append(" 	RESTAURANT_LIKE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	")
			.append(" 	RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	")
			.append(" 	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	")
			.append(" 	from RESTAURANT a, RESTAURANT_TAGS t	")
			.append(" 	where a.RESTAURANT_ID = t.RESTAURANT_ID(+) and delete_state = 'N'	")
			.append("	group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL,	")
			.append("	RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	")
			.append("	) alldata	")
			.append("	where num between ? and ?		")
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
				rVO.setStarScore(3);
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setReviewCnt(10);
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
	
	public List<String> selectAllTags() throws SQLException{
		List<String> list = new ArrayList<String>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select distinct tag_name from restaurant_tags	");
			
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
			.append("	select all_data.*		")
			.append("	from(select rownum n, data.*	")
			.append("	from (	 ")
			.append("	select row_number() over( order by a.RESTAURANT_NAME ) num, a.RESTAURANT_ID RESTAURANT_ID, a.RESTAURANT_NAME,	 ")
			.append("	RESTAURANT_ADDR, RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE,	 ")
			.append("	RESTAURANT_LIKE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	 ")
			.append("	RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	 ")
			.append("	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	 ")
			.append("	from RESTAURANT a, RESTAURANT_TAGS t	 ")
			.append("	where a.RESTAURANT_ID = t.RESTAURANT_ID(+) and delete_state = 'N'	 ")
			.append("	group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL,	 ")
			.append("	RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	 ")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	 ")
			.append("	) data	 ")
			.append("	where tag_name like ?	 ")
			.append("	) all_data	 ")
			.append("	where n between ? and ? ")
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
				rVO.setStarScore(3);
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setReviewCnt(10);
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
		RestaurantVO rVO = new RestaurantVO();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectResturant = new StringBuilder();
			selectResturant
			.append("	select  alldata.*		")
			.append("	from (	")
			.append("	select row_number() over( order by a.RESTAURANT_NAME ) num, a.RESTAURANT_ID, a.RESTAURANT_NAME, ")
			.append("	RESTAURANT_ADDR, RESTAURANT_TEL, RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE,		")
			.append(" 	RESTAURANT_LIKE, RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE,	")
			.append(" 	RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE,	")
			.append(" 	listagg(t.tag_name, ' ') within group(order by a.RESTAURANT_ID) tag_name	")
			.append(" 	from RESTAURANT a, RESTAURANT_TAGS t	")
			.append(" 	where a.RESTAURANT_ID = t.RESTAURANT_ID(+)	")
			.append("	group by a.RESTAURANT_NAME, a.RESTAURANT_ID, RESTAURANT_ADDR,RESTAURANT_TEL,	")
			.append("	RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE, RESTAURANT_LIKE,	")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE	")
			.append("	) alldata	")
			.append("	where RESTAURANT_ID = ?		")
			;
			pstmt = con.prepareStatement(selectResturant.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rVO.setId(rs.getString("RESTAURANT_ID"));
				rVO.setName(rs.getString("RESTAURANT_NAME"));
				rVO.setAddr(rs.getString("RESTAURANT_ADDR"));
				rVO.setTel(rs.getString("RESTAURANT_TEL"));
				rVO.setServiceHour(rs.getString("RESTAURANT_SERVICE_HOURS"));
				rVO.setTags(rs.getString("TAG_NAME"));
				rVO.setLatitude(rs.getDouble("RESTAURANT_LATITUDE"));
				rVO.setLongitude(rs.getDouble("RESTAURANT_LONGITUDE"));
				rVO.setStarScore(3);
				rVO.setLike(rs.getInt("RESTAURANT_LIKE"));
				rVO.setReviewCnt(10);
				rVO.setViewNum(rs.getInt("RESTAURANT_VIEW_NUM"));
				rVO.setImage(rs.getString("RESTAURANT_IMAGE"));
				rVO.setThumbNail(rs.getString("RESTAURANT_THUMBNAIL"));
				rVO.setDeleteState(rs.getString("DELETE_STATE"));
				rVO.setInputDate(rs.getDate("RESTAURANT_UPLOAD_DATE"));
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return rVO;
	}//end selectResturant
	
	
	
}//class

