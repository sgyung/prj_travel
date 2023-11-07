package user_mypageDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user.dao.TourBusDAO;
import user.vo.MyTourBusVO;

public class MyTourBusDAO {
	private static MyTourBusDAO mytDAO;
	
	private MyTourBusDAO() {
		
	}//TourBusDAO
	
	public static MyTourBusDAO getInstance() {
		if( mytDAO == null ) {
			mytDAO = new MyTourBusDAO();
		}//end if
		return mytDAO;
	}//getInstance
	
	
	public int selectTotalReservation(String id) throws SQLException {
		int result  = 0;

		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select nvl(count(*),0) cnt from BUSTOUR_RESERVATION where user_id = ?	");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("cnt");
			}//end if
		} finally {
			db.dbClose(rs, pstmt, con);
		}//finally
		
		return result;
	}//selectTotalRes
	
	public List<MyTourBusVO> selectMyTour(String id) throws SQLException{
		List<MyTourBusVO> list = new ArrayList<MyTourBusVO>();

		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectMyTour = new StringBuilder();
			selectMyTour
			.append("	select r.reservation_id, b.bustour_name, r.reservation_time, r.reservation_date,	")
			.append("	approval_state, p.adult, p.child	")
			.append("	from bustour b, bustour_reservation r, people_num p	")
			.append("	where b.bustour_id = r.bustour_id and r.reservation_id = p.reservation_id	")
			.append("	and ( r.user_id= ? )	")
			;
			
			pstmt = con.prepareStatement(selectMyTour.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				MyTourBusVO vo = new MyTourBusVO();
				vo.setId(rs.getString("reservation_id"));
				vo.setName(rs.getString("bustour_name"));
				vo.setState(rs.getString("approval_state"));
				vo.setReservedTime(rs.getString("reservation_time"));
				vo.setReservedDate(rs.getDate("reservation_date"));
				vo.setAdult(rs.getInt("adult"));
				vo.setChild(rs.getInt("child"));
				
				list.add(vo);
				
			}//end while
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
		
	}//selectMyTour
	
	public int deleteReserved(String id) throws SQLException {
		int result = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("delete from bustour_reservation where reservation_id = ?	");
			pstmt.setString(1,  id);
			
			result = pstmt.executeUpdate();
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return result;
	}//deleteMyTour
	
}//class
