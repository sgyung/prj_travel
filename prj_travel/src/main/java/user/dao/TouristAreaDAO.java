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
import user.vo.TouristAreaVO;


public class TouristAreaDAO {
	
	private static TouristAreaDAO touristAreaDAO;
	
	private TouristAreaDAO() {
		
	}//TouristAreaDAO
	
	public static TouristAreaDAO getInstance() {
		if( touristAreaDAO == null ) {
			touristAreaDAO = new TouristAreaDAO();
		}//end if
		
		return touristAreaDAO;
	}//getInstance
	
	public List<TouristAreaVO> selectAllTouristArea() throws SQLException {
		List<TouristAreaVO> areaList = new ArrayList<TouristAreaVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("select * from tourist_area");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
			TouristAreaVO taVO = new TouristAreaVO();
			
			taVO.setId(rs.getString("tourist_area_id"));
			taVO.setName(rs.getString("tourist_area_name"));
			taVO.setAddr(rs.getString("tourist_area_addr"));
			taVO.setTel(rs.getString("tourist_area_tel"));
			taVO.setServiceHour(rs.getString("tourist_area_service_hours"));
			taVO.setPriceInfo(rs.getString("tourist_area_price_Info"));
			taVO.setSlope(rs.getString("tourist_area_slope"));
			taVO.setDetailInfo(rs.getString("tourist_area_detail_info"));
			taVO.setLatitude(rs.getDouble("tourist_area_longitude"));
			taVO.setStarScore(3);
			taVO.setLike(rs.getInt("tourist_area_like"));
			taVO.setReviewCnt(10);
			taVO.setViewNum(rs.getInt("tourist_area_view_num"));
			taVO.setImage(rs.getString("tourist_area_image"));
			taVO.setThumbNail(rs.getString("tourist_area_thumbnail"));
			taVO.setDeleteState(rs.getString("delete_state"));
			taVO.setInputDate(rs.getDate("tourist_area_upload_date"));
			
			areaList.add(taVO);
			
		}//end while
		
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return areaList;
	}//selectAlltouristArea
	
	public List<TouristAreaVO> selectPageContent(int start, int end) throws SQLException{
		List<TouristAreaVO> selectList = new ArrayList<TouristAreaVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectContent = new StringBuilder();
			selectContent
			.append("	select  alldata.*	")
			.append("	from (	")
			.append("	select row_number() over( order by a.tourist_area_name ) num, a.tourist_area_id, a.tourist_area_name, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE, listagg(t.tag_name, ' ') within group(order by a.tourist_area_id) tag_name ")
			.append("	from tourist_area a, tourist_tags t	")
			.append(" 	where a.tourist_area_id = t.tourist_area_id(+) ")
			.append("	group by a.tourist_area_name, a.tourist_area_id, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE	 ")
			.append("		) alldata	")
			.append("	where num between ? and ?		")
			;
			
			pstmt = con.prepareStatement(selectContent.toString());
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TouristAreaVO taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setAddr(rs.getString("tourist_area_addr"));
				taVO.setTel(rs.getString("tourist_area_tel"));
				taVO.setServiceHour(rs.getString("tourist_area_service_hours"));
				taVO.setPriceInfo(rs.getString("tourist_area_price_Info"));
				taVO.setSlope(rs.getString("tourist_area_slope"));
				taVO.setTags(rs.getString("tag_name"));
				taVO.setLatitude(rs.getDouble("tourist_area_latitude"));
				taVO.setLongitude(rs.getDouble("tourist_area_longitude"));
				taVO.setStarScore(3);
				taVO.setLike(rs.getInt("tourist_area_like"));
				taVO.setReviewCnt(10);
				taVO.setViewNum(rs.getInt("tourist_area_view_num"));
				taVO.setImage(rs.getString("tourist_area_image"));
				taVO.setThumbNail(rs.getString("tourist_area_thumbnail"));
				taVO.setDeleteState(rs.getString("delete_state"));
				taVO.setInputDate(rs.getDate("tourist_area_upload_date"));
				
				selectList.add(taVO);
				
			}//end while
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return selectList;
	}//selectPageContent
	
	public int selectTotalTouristArea() throws SQLException{
		int totalPage = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("select count(*) cnt from tourist_area");
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				totalPage = rs.getInt(1);
			}//end while
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalPage;
	}//selectTotalTouristArea
	
	public List<String> selectAllTags() throws SQLException{
		List<String> list = new ArrayList<String>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select distinct tag_name from tourist_tags	");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getString("tag_name"));
			}//end while
			} finally {
				db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
	}//selectTags
	
	public List<TouristAreaVO> selectTagContent(String tag, int start, int end) throws SQLException{
		List<TouristAreaVO> selectList = new ArrayList<TouristAreaVO>();
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			
			StringBuilder selectContent = new StringBuilder();
			selectContent
			.append("	select  alldata.*		")
			.append("	from (		")
			.append("	select row_number() over( order by a.tourist_area_name ) num, a.tourist_area_id, a.tourist_area_name,	")
			.append("	TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE,	")
			.append("	TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE,	")
			.append("	TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE,	")
			.append("	listagg(t.tag_name, ' ') within group(order by a.tourist_area_id) tag_name	")
			.append("	from tourist_area a, tourist_tags t	")
			.append("		where a.tourist_area_id = t.tourist_area_id(+) and tag_name in ?	")
			.append("	group by a.tourist_area_name, a.tourist_area_id, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS,	")
			.append("	TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE,	")
			.append("	TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE	")
			.append("		) alldata	")
			.append("		where num between ? and  ?	")
			;
			pstmt = con.prepareStatement(selectContent.toString());
			pstmt.setString(1, tag);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				TouristAreaVO taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setAddr(rs.getString("tourist_area_addr"));
				taVO.setTel(rs.getString("tourist_area_tel"));
				taVO.setServiceHour(rs.getString("tourist_area_service_hours"));
				taVO.setPriceInfo(rs.getString("tourist_area_price_Info"));
				taVO.setSlope(rs.getString("tourist_area_slope"));
				taVO.setTags(rs.getString("tag_name"));
				taVO.setLatitude(rs.getDouble("tourist_area_latitude"));
				taVO.setLongitude(rs.getDouble("tourist_area_longitude"));
				taVO.setStarScore(3);
				taVO.setLike(rs.getInt("tourist_area_like"));
				taVO.setReviewCnt(10);
				taVO.setViewNum(rs.getInt("tourist_area_view_num"));
				taVO.setImage(rs.getString("tourist_area_image"));
				taVO.setThumbNail(rs.getString("tourist_area_thumbnail"));
				taVO.setDeleteState(rs.getString("delete_state"));
				taVO.setInputDate(rs.getDate("tourist_area_upload_date"));
				
				selectList.add(taVO);
			}//end while
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return selectList;
	}//selectTagContent
	
	public int selectTotalTagTouristArea(String tag) throws SQLException {
		int totalPage = 0;
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTagArea = new StringBuilder();
			selectTagArea
			.append("	select count (distinct a.tourist_area_id) totalCnt	")
			.append("	from tourist_area a, tourist_tags t	")
			.append("	where (a.tourist_area_id = t.tourist_area_id) and (tag_name = ?)	")
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
	
	}//selectTotalTagTouristArea
	
	public String selectTouristAreaInfo( String id ) throws SQLException {
		StringBuilder info = new StringBuilder("");
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectInfo = new StringBuilder();
			selectInfo
			.append("	select tourist_area_detail_info	")
			.append("	from tourist_area	")
			.append("	where tourist_area_id = ?	")
			;
			pstmt = con.prepareStatement(selectInfo.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				BufferedReader br = null;
				info = new StringBuilder("");
				Clob clob = rs.getClob("tourist_area_detail_info");
				
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
	}//selectTouristAreaInfo
	
	public TouristAreaVO selectTouristArea( String id ) throws SQLException {
		TouristAreaVO taVO = new TouristAreaVO();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTouristArea = new StringBuilder();
			selectTouristArea
			.append("	select  alldata.*	")
			.append("	from (	")
			.append("	select row_number() over( order by a.tourist_area_name ) num, a.tourist_area_id, a.tourist_area_name, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE, listagg(t.tag_name, ' ') within group(order by a.tourist_area_id) tag_name ")
			.append("	from tourist_area a, tourist_tags t	")
			.append(" 	where a.tourist_area_id = t.tourist_area_id(+) ")
			.append("	group by a.tourist_area_name, a.tourist_area_id, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE	 ")
			.append("		) alldata	")
			.append("	where tourist_area_id = ?		")
			;
			pstmt = con.prepareStatement(selectTouristArea.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setAddr(rs.getString("tourist_area_addr"));
				taVO.setTel(rs.getString("tourist_area_tel"));
				taVO.setServiceHour(rs.getString("tourist_area_service_hours"));
				taVO.setPriceInfo(rs.getString("tourist_area_price_Info"));
				taVO.setSlope(rs.getString("tourist_area_slope"));
				taVO.setTags(rs.getString("tag_name"));
				taVO.setLatitude(rs.getDouble("tourist_area_latitude"));
				taVO.setLongitude(rs.getDouble("tourist_area_longitude"));
				taVO.setStarScore(3);
				taVO.setLike(rs.getInt("tourist_area_like"));
				taVO.setReviewCnt(10);
				taVO.setViewNum(rs.getInt("tourist_area_view_num"));
				taVO.setImage(rs.getString("tourist_area_image"));
				taVO.setThumbNail(rs.getString("tourist_area_thumbnail"));
				taVO.setDeleteState(rs.getString("delete_state"));
				taVO.setInputDate(rs.getDate("tourist_area_upload_date"));
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return taVO;
	}//end selectTouristArea
	
	//삭제
	public int updateTest( String info ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder select = new StringBuilder();
			select
			.append("	update tourist_area	")
			.append("	set tourist_area_detail_info = ?	")
			.append("	where tourist_area_id = 'TA_24'	")
			;
			pstmt = con.prepareStatement(select.toString());
			pstmt.setString(1, info);
			
			result = pstmt.executeUpdate();
			
		}finally {
			db.dbClose(null, pstmt, con);
		}//end finally
		
		return result;
	}//end updateTest
	
}//class

