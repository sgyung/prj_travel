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
import java.util.Map;

import kr.co.dao.DbConnection;
import user.vo.RestaurantVO;
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
			.append("	select row_number() over( order by a.tourist_area_name ) num, a.tourist_area_id, a.tourist_area_name, TOURIST_AREA_ADDR, TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE, listagg(t.tag_name, ' ') within group(order by a.tourist_area_id) tag_name, nvl(trunc(avg(r.TOURIST_STAR_SCORE)),5) star_score, count(r.TOURIST_REVIEW_ID) review_cnt  ")
			.append("	from tourist_area a, tourist_tags t, tourist_review r	")
			.append(" 	where (a.tourist_area_id = t.tourist_area_id(+)) and ( a.tourist_area_id = r.tourist_area_id(+) )	 ")
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
				taVO.setLike(rs.getInt("tourist_area_like"));
				taVO.setReviewCnt(rs.getInt("review_cnt"));
				taVO.setViewNum(rs.getInt("tourist_area_view_num"));
				taVO.setImage(rs.getString("tourist_area_image"));
				taVO.setThumbNail(rs.getString("tourist_area_thumbnail"));
				taVO.setDeleteState(rs.getString("delete_state"));
				taVO.setInputDate(rs.getDate("tourist_area_upload_date"));
				taVO.setStarScore(rs.getInt("star_score"));
				
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
			
			StringBuilder selectTag = new StringBuilder();
			selectTag
			.append("	select num, tag_name	")
			.append("	from(select row_number() over( order by tourist_area_id ) num,	")
			.append("	tag_name from (select distinct * from tourist_tags))	")
			.append("	where num between 1 and 25	")
			;
			pstmt = con.prepareStatement(selectTag.toString());
			
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
			
			StringBuilder searchTag = new StringBuilder();
			searchTag.append("%").append(tag).append("%");
			StringBuilder selectContent = new StringBuilder();
			selectContent
			.append("	select  alldata.*		")
			.append("	from(select rownum n, data.*		")
			.append("	from (	")
			.append("	select row_number() over( order by a.tourist_area_name ) num, a.tourist_area_id,	")
			.append("	nvl(trunc(avg(r.TOURIST_STAR_SCORE)),5) star_score, count(r.TOURIST_REVIEW_ID) review_cnt,	")
			.append("	a.tourist_area_name, TOURIST_AREA_ADDR, TOURIST_AREA_TEL,	")
			.append("	TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE,	")
			.append("	TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE,	")
			.append("	TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL,	")
			.append("	DELETE_STATE, TOURIST_AREA_UPLOAD_DATE,	")
			.append("	listagg(t.tag_name, ' ') within group(order by a.tourist_area_id) tag_name	")
			.append("	from tourist_area a, tourist_tags t, tourist_review r	")
			.append("	where ( a.tourist_area_id = t.tourist_area_id(+) ) and ( a.tourist_area_id = r.tourist_area_id(+) )	")
			.append("	group by a.tourist_area_name, a.tourist_area_id, TOURIST_AREA_ADDR,	")
			.append("	TOURIST_AREA_TEL, TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO,	")
			.append("	TOURIST_AREA_SLOPE, TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE,	")
			.append("	TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM, TOURIST_AREA_IMAGE,	")
			.append("	TOURIST_AREA_THUMBNAIL, DELETE_STATE, TOURIST_AREA_UPLOAD_DATE	")
			.append("	) data	")
			.append("	where tag_name like ? 	")
			.append("	) alldata	")
			.append("	where n between ? and ?	")
			
			;
			pstmt = con.prepareStatement(selectContent.toString());
			pstmt.setString(1, searchTag.toString());
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
				taVO.setStarScore(rs.getInt("star_score"));
				taVO.setLike(rs.getInt("tourist_area_like"));
				taVO.setReviewCnt(rs.getInt("review_cnt"));
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
		int updateCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = db.getConn("jdbc/dbcp");
			con.setAutoCommit(false);
			
			StringBuilder updateViewNum = new StringBuilder();
			updateViewNum
			.append("	update tourist_area	")
			.append("	set tourist_area_view_num = tourist_area_view_num + 1	")
			.append("	where tourist_area_id = ?	")
			;
			pstmt = con.prepareStatement(updateViewNum.toString());
			pstmt.setString(1, id);
			
			updateCnt = pstmt.executeUpdate();
			
			pstmt.close();
			
			if( updateCnt == 1) {
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
					
				}//end if
				con.commit();
			} else {
				con.rollback();
			}//end else
			
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
	
	public int updateViewNum(String id) throws SQLException {
		int result = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
		} finally {
			db.dbClose(null, pstmt, con);
			
		}
		
		return result;
	}//updateViewNum
	
	public int selectStarScore( String id ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int result = 0;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectStar = new StringBuilder();
			selectStar
			.append("	select nvl(trunc(avg(tourist_star_score)),5) starscore from tourist_review		")
			.append("	where tourist_area_id = ?	");
			
			pstmt = con.prepareStatement(selectStar.toString());
			pstmt.setString(1,  id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("starscore");
			}
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return result;
	}//selectStarScore
	
	public int selectLike( String contId ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int result = 0;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectLike = new StringBuilder();
			selectLike
			.append("	SELECT COUNT(*) like_cnt  from tourist_like		")
			.append("    where tourist_area_id = ?		")
			;
			pstmt = con.prepareStatement(selectLike.toString());
			pstmt.setString(1, contId);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				result = rs.getInt("like_cnt");
			}//end if
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//finally
		return result;
	}//selectLike
	
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
			.append("	    (SELECT COUNT(*) FROM tourist_like where tourist_area_id = ? and like_state='Y' ) AS like_cnt,		")
			.append("		COALESCE(		")
			.append("			(SELECT like_state FROM tourist_like WHERE user_id = ? and tourist_area_id= ?  ),'N'		")
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
	
	public int updateLike(String userId, String contId) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int resultCnt = 0;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			//1. 처음 누르는지(insert) / 취소인지(update)
			pstmt = con.prepareStatement("	SELECT like_state  from tourist_like WHERE tourist_area_id = ? and user_id = ?	");
			pstmt.setString(1, contId);
			pstmt.setString(2, userId);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pstmt.close();
				rs.close();
				
				//update
				StringBuilder updateState = new StringBuilder();
				updateState
				.append("	update tourist_like set like_state = CASE	")
				.append("		when like_state = 'Y' THEN 'N'	")
				.append("	when like_state = 'N' THEN 'Y'	")
				.append("		ELSE like_state	END	")
				.append("	where tourist_area_id = ? and user_id = ?	")
				;
				pstmt = con.prepareStatement(updateState.toString());
				pstmt.setString(1, contId);
				pstmt.setString(2, userId);
				
				resultCnt = pstmt.executeUpdate();
				
			} else {
				//insert
				pstmt.close();
				rs.close();
				
				StringBuilder insertState = new StringBuilder();
				insertState
				.append("	insert into tourist_like(LIKE_ID, USER_ID, LIKE_STATE, TOURIST_AREA_ID)	")
				.append("		values( 'ta_like_'||ta_like_seq.nextval, ?, 'Y', ? )	")
				;
				pstmt = con.prepareStatement(insertState.toString());
				pstmt.setString(1, userId);
				pstmt.setString(2, contId);
				
				resultCnt += pstmt.executeUpdate();
				
			}//end else
			
			
			return resultCnt;
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
	}//updateTransactionLike
	
	public int insertTransactionTA( TouristAreaVO tVO ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int resultCnt = 0;
		
		try {
			String touristAreaId = null;
			
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select  'TA_' || TA_SEQ.nextval tourist_area_id from dual		");
			
			rs = pstmt.executeQuery();
			if( rs.next()) {
				touristAreaId = rs.getString("tourist_area_id");
			}
			
			pstmt.close();
			rs.close();
			
			
			//touristArea 테이블 insert
			StringBuilder insertTouristArea = new StringBuilder();
			insertTouristArea
			.append("	insert into tourist_area(TOURIST_AREA_ID, TOURIST_AREA_NAME, TOURIST_AREA_ADDR, TOURIST_AREA_TEL,	")
			.append("	TOURIST_AREA_SERVICE_HOURS, TOURIST_AREA_PRICE_INFO, TOURIST_AREA_SLOPE,	")
			.append("	TOURIST_AREA_LONGITUDE, TOURIST_AREA_LATITUDE, TOURIST_AREA_LIKE, TOURIST_AREA_VIEW_NUM,	")
			.append("	TOURIST_AREA_IMAGE, TOURIST_AREA_THUMBNAIL,DELETE_STATE, TOURIST_AREA_UPLOAD_DATE )	")
			.append("	values( ?, ?, ?, ?, '평일 : 00:00 ~ 00:00 , 주말 : 00:00 ~ 00:00',	")
			.append("	'무료', '중', ?, ?, 0, 0, ?, ?, 'N', sysdate ) 	")
			;
			pstmt = con.prepareStatement(insertTouristArea.toString());
			pstmt.setString(1, touristAreaId);
			pstmt.setString(2, tVO.getName());
			pstmt.setString(3, tVO.getAddr());
			pstmt.setString(4, tVO.getTel());
			pstmt.setDouble(5, tVO.getLongitude());
			pstmt.setDouble(6, tVO.getLatitude());
			pstmt.setString(7, tVO.getImage());
			pstmt.setString(8, tVO.getThumbNail());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			rs.close();
			
			//tourist_tags 테이블 insert
			String[]  tags = tVO.getTags().split(",");
			for( int i = 0; i< tags.length; i++) {
				StringBuilder insertTags = new StringBuilder();
				insertTags
				.append(" insert into tourist_tags(TOURIST_AREA_ID, TAG_NAME )	")
				.append(" values(? , ?)	")
				;
				
				pstmt = con.prepareStatement(insertTags.toString());
				pstmt.setString(1, touristAreaId);
				pstmt.setString(2, "#"+tags[i]);
				
				resultCnt += pstmt.executeUpdate();
				
			}//end for
			pstmt.close();
			rs.close();
			
			//편의시설 insert
			String[] conveniArr = { "화장실", "편의점" };
			for( int i = 0; i<conveniArr.length; i++) {
				
				pstmt = con.prepareStatement("	insert into tourist_convenience(TOURIST_AREA_ID, CONVENIENCE_NAME ) values ( ?, ? )	");
				pstmt.setString(1, touristAreaId);
				pstmt.setString(2, conveniArr[i]);
				
				resultCnt += pstmt.executeUpdate();
			}//end for
			
			
			return resultCnt;
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
	}//insertTouristArea 
	
	public int insertTransactionRES( RestaurantVO rVO ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int resultCnt = 0;
		
		try {
			String restaurantId = null;
			
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select  'RES_' || RES_SEQ.nextval restaurant_id from dual		");
			
			rs = pstmt.executeQuery();
			if( rs.next()) {
				restaurantId = rs.getString("restaurant_id");
			}
			
			pstmt.close();
			rs.close();
			
			
			//touristArea 테이블 insert
			StringBuilder insertTouristArea = new StringBuilder();
			insertTouristArea
			.append("	insert into RESTAURANT(RESTAURANT_ID, RESTAURANT_NAME, RESTAURANT_ADDR, RESTAURANT_TEL,	")
			.append("	RESTAURANT_SERVICE_HOURS, RESTAURANT_LONGITUDE, RESTAURANT_LATITUDE,RESTAURANT_LIKE,	")
			.append("	RESTAURANT_VIEW_NUM, RESTAURANT_IMAGE, RESTAURANT_THUMBNAIL, DELETE_STATE, RESTAURANT_UPLOAD_DATE)	")
			.append("	values( ?, ?, ?, ?, '평일 : 00:00 ~ 00:00 , 주말 : 00:00 ~ 00:00',	")
			.append("		?, ?, 0, 0, ?, ?, 'N', sysdate)	")
			;
			pstmt = con.prepareStatement(insertTouristArea.toString());
			pstmt.setString(1, restaurantId);
			pstmt.setString(2, rVO.getName());
			pstmt.setString(3, rVO.getAddr());
			pstmt.setString(4, rVO.getTel());
			pstmt.setDouble(5, rVO.getLongitude());
			pstmt.setDouble(6, rVO.getLatitude());
			pstmt.setString(7, rVO.getImage());
			pstmt.setString(8, rVO.getThumbNail());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			rs.close();
			
			//tourist_tags 테이블 insert
			String[]  tags = rVO.getTags().split(",");
			for( int i = 0; i< tags.length; i++) {
				StringBuilder insertTags = new StringBuilder();
				insertTags
				.append(" insert into restaurant_tags(RESTAURANT_ID, TAG_NAME ) 	")
				.append(" values(? , ?)	")
				;
				
				pstmt = con.prepareStatement(insertTags.toString());
				pstmt.setString(1, restaurantId);
				pstmt.setString(2, "#"+tags[i]);
				
				resultCnt += pstmt.executeUpdate();
				
			}//end for
			pstmt.close();
			rs.close();
			
			//편의시설 insert
			String[] conveniArr = { "화장실", "편의점" };
			for( int i = 0; i<conveniArr.length; i++) {
				
				pstmt = con.prepareStatement("	insert into RESTAURANT_CONVENIENCE(RESTAURANT_ID, CONVENIENCE_NAME ) values ( ?, ? )	");
				pstmt.setString(1, restaurantId);
				pstmt.setString(2, conveniArr[i]);
				
				resultCnt += pstmt.executeUpdate();
			}//end for
			
			
			return resultCnt;
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
	}//insertTouristArea 
	
}//class

