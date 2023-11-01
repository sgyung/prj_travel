package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.RestRankTagVO;
import user.vo.TourRankTagVO;

public class MainDAO {

	private static MainDAO mainDAO;
	
	private MainDAO() {
		
	}
	
	public static MainDAO getInstance() {
		if( mainDAO == null ) {
			mainDAO = new MainDAO();
		}//end if
		
		return mainDAO;
	}//getInstance
	
	public List<TourRankTagVO> selectTourRank() throws SQLException {
		List<TourRankTagVO> list = new ArrayList<TourRankTagVO>();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTourRank = new StringBuilder();
			selectTourRank
			.append("	SELECT TOURIST_AREA_ID, TOURIST_AREA_NAME, TOURIST_AREA_THUMBNAIL	")
			.append(" 	FROM ( SELECT TOURIST_AREA_ID, TOURIST_AREA_NAME, TOURIST_AREA_THUMBNAIL FROM tourist_area ORDER BY TOURIST_AREA_LIKE DESC )	")
			.append("	WHERE ROWNUM <= 3	")	
			;
			pstmt = con.prepareStatement(selectTourRank.toString());
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				TourRankTagVO trtVO = new TourRankTagVO();
				trtVO.setId(rs.getString("TOURIST_AREA_ID"));
				trtVO.setName(rs.getString("TOURIST_AREA_NAME"));
				trtVO.setThumbNail(rs.getString("TOURIST_AREA_THUMBNAIL"));
				
				list.add(trtVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
	
	}//selectTourRank
	
	
	public List<RestRankTagVO> selectRestRank() throws SQLException {
		List<RestRankTagVO> list = new ArrayList<RestRankTagVO>();
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectRestRank = new StringBuilder();
			selectRestRank
			.append("	SELECT RESTAURANT_ID, RESTAURANT_NAME, RESTAURANT_THUMBNAIL	")
			.append(" 	FROM ( SELECT RESTAURANT_ID, RESTAURANT_NAME, RESTAURANT_THUMBNAIL FROM RESTAURANT ORDER BY RESTAURANT_LIKE DESC )	")
			.append("	WHERE ROWNUM <= 3	")	
			;
			pstmt = con.prepareStatement(selectRestRank.toString());
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				RestRankTagVO rrtVO = new RestRankTagVO();
				rrtVO.setId(rs.getString("RESTAURANT_ID"));
				rrtVO.setName(rs.getString("RESTAURANT_NAME"));
				rrtVO.setThumbNail(rs.getString("RESTAURANT_THUMBNAIL"));
				
				list.add(rrtVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
	
	}//selectRestRank
	
	
	public List<String> selectAllTourTags() throws SQLException{
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
	}//selectTourTags
	
	
	public List<String> selectAllRestTags() throws SQLException{
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
	}//selectRestTags

	
	
}
