package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.CommentVO;
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
			.append("	select tourist_area_id, tourist_area_name,tourist_area_upload_date	")
			.append("	from tourist_area	");
			
			pstmt = con.prepareStatement(selectTouristArea.toString());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setRegistraitionDate(rs.getDate("tourist_area_upload_date"));
				
			}
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return taVO;
				
	}
	
	
	
	
}
