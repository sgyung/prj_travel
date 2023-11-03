package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.vo.TourBusVO;
import user.vo.TourReserveVO;

public class TourBusDAO {
	private static TourBusDAO tDAO;
	
	private TourBusDAO() {
		
	}//TourBusDAO
	
	public static TourBusDAO getInstance() {
		if( tDAO == null ) {
			tDAO = new TourBusDAO();
		}//end if
		return tDAO;
	}//getInstance
	
	public List<TourBusVO> selectAllTourBus() throws SQLException{
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<TourBusVO> tourList = new ArrayList<TourBusVO>();
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select * from bustour		");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TourBusVO tVO = new TourBusVO();
				tVO.setId(rs.getString("BUSTOUR_ID"));
				tVO.setName(rs.getString("BUSTOUR_NAME"));
				tVO.setTel(rs.getString("BUSTOUR_TEL"));
				tVO.setImage(rs.getString("BUSTOUR_IMAGE"));
				tVO.setSeat(rs.getInt("BUSTOUR_SEAT"));
				tVO.setAdultFare(rs.getInt("ADULT_FARE"));
				tVO.setChildFare(rs.getInt("CHILD_FARE"));
				tVO.setStart(rs.getDate("BUSTOUR_START"));
				tVO.setEnd(rs.getDate("BUSTOUR_END"));
				tVO.setTime(rs.getString("BUSTOUR_TIME"));
				
				tourList.add(tVO);
				
			}//end while
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return tourList;
	}//selectAllTourBus
	
	public TourBusVO selectTourBus(String id) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		TourBusVO tVO = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select * from bustour where bustour_id = ?	");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				tVO = new TourBusVO();
				tVO.setId(rs.getString("BUSTOUR_ID"));
				tVO.setName(rs.getString("BUSTOUR_NAME"));
				tVO.setTel(rs.getString("BUSTOUR_TEL"));
				tVO.setImage(rs.getString("BUSTOUR_IMAGE"));
				tVO.setSeat(rs.getInt("BUSTOUR_SEAT"));
				tVO.setAdultFare(rs.getInt("ADULT_FARE"));
				tVO.setChildFare(rs.getInt("CHILD_FARE"));
				tVO.setStart(rs.getDate("BUSTOUR_START"));
				tVO.setEnd(rs.getDate("BUSTOUR_END"));
				tVO.setTime(rs.getString("BUSTOUR_TIME"));
				
			}//end if
			
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return tVO;
		
	}//selectTourBus
	
	public List<String> selectTourRoute(String id) throws SQLException{
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<String> routeList = new ArrayList<String>();
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select * from bustour_route where bustour_id= ?		");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				routeList.add(rs.getString("route_name"));
				
			}//end while
						
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return routeList;
		
	}//selectTourRoute
	
	public List<String> selectTourTime(String id) throws SQLException{
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<String> timeList = new ArrayList<String>();
		
		try {
			
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select * from bustour_dispatch where bustour_id = ?	");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				timeList.add(rs.getString("bustour_time"));
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
	
		return timeList;
		
	}//selectTourTime
	
	public void insertTourReserve(TourReserveVO trVO ) throws SQLException {
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			con.setAutoCommit(false);
			String reservation_id = "";
			
			pstmt = con.prepareStatement("	select 'tour_res_'||tour_reser_seq.nextval reservation_id from dual	");
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				reservation_id = rs.getString("reservation_id");
			}//end if
			
			pstmt.close();
			pstmt=null;
			
			StringBuilder insertReserve = new StringBuilder();
			insertReserve
			.append("	insert into bustour_reservation(RESERVATION_ID, USER_ID, BUSTOUR_ID, SUBSCRIBER,	")
			.append("	RESERVATION_TIME, RESERVATION_DATE, APPROVAL_STATE, REGIST_DATE)		")
			.append("	values( ?, ?, ?, ?, ?, ?, 'N', sysdate)	")
			;
			pstmt = con.prepareStatement(insertReserve.toString());
			pstmt.setString(1, reservation_id);
			pstmt.setString(2, trVO.getUserId());
			pstmt.setString(3, trVO.getTourId());
			pstmt.setString(4, trVO.getName());
			pstmt.setString(5, trVO.getTime());
			pstmt.setDate(6, trVO.getReserveDate());
			
			pstmt.executeQuery();
			pstmt.close();
			pstmt = null;
			
			pstmt = con.prepareStatement("	insert into people_num(RESERVATION_ID, ADULT, CHILD ) values(?, ?, ?)	");
			pstmt.setString(1, reservation_id);
			pstmt.setInt(2, trVO.getAdult());
			pstmt.setInt(3, trVO.getChild());
			
			pstmt.executeQuery();
			
			con.commit();
		} catch(SQLException se ) {
			con.rollback();
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
	}//insertTourReservation
	
}//class
