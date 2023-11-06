package user_mypageDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.dao.DbConnection;
import user.dao.TourBusDAO;

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
	
}//class
