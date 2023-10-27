package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.dao.DbConnection;

public class AdminDAO {
	private static AdminDAO adminDAO;
	
	private AdminDAO() {
		
	}
	
	public static AdminDAO getInstance() {
		if(adminDAO == null) {
			adminDAO = new AdminDAO();
		}
		return adminDAO;
	}
	
	public boolean selectAdmin(String id, String pass) throws SQLException{
		boolean flag = false;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			String selectAdmin = "select * from admin where admin_id=? and admin_pw=?";
			
			pstmt=con.prepareStatement(selectAdmin);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			flag = rs.next();
			System.out.println(flag);
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return flag;
	}
	
	
}
