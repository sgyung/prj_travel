package admin.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.TourBusReservationVO;
import admin.vo.TourBusVO;
import kr.co.dao.DbConnection;

public class TourBusManageDAO {
	private static TourBusManageDAO tbmDAO;
	
	private TourBusManageDAO() {
		
	}
	
	public static TourBusManageDAO getInstance() {
		if(tbmDAO == null) {
			tbmDAO = new TourBusManageDAO();
		}
		return tbmDAO;
	}
	
	public List<TourBusVO> selectAllTourBus() throws SQLException{
		List<TourBusVO> list = new ArrayList<TourBusVO>();
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllTourBus = new StringBuilder();
			selectAllTourBus
			.append("	select bustour_id, bustour_name, regist_date, operation_state	")
			.append("	from bustour 									");
			
			pstmt = con.prepareStatement(selectAllTourBus.toString());
			
			rs = pstmt.executeQuery();
			TourBusVO tbVO = null;
			
			while(rs.next()) {
				tbVO = new TourBusVO();
				tbVO.setId(rs.getString("bustour_id"));
				tbVO.setName(rs.getString("bustour_name"));
				tbVO.setRegistrationTime(rs.getDate("regist_date"));
				tbVO.setOperationState(rs.getString("operation_state"));
				
				list.add(tbVO);
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
	
	
	public int insertTourBusTransaction(TourBusVO tbVO) throws SQLException{
		int resultCnt = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String bustourId = null;
			
			con = db.getConn("jdbc/dbcp");
			
			con.setAutoCommit(false);// 오토 커밋 끔
			
			pstmt = con.prepareStatement("select 'TOURBUS_' || TOUR_SEQ.nextval bustour_id from dual ");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bustourId = rs.getString("bustour_id");
			}
			
			pstmt.close();
			rs.close();
			
			//touristArea 테이블 insert
			StringBuilder insertBusTour = new StringBuilder();
			insertBusTour
			.append("	insert into bustour(bustour_id, bustour_name, bustour_tel, bustour_start,	")
			.append("	bustour_end, bustour_time, bustour_seat, adult_fare, child_fare,	")
			.append("	bustour_image, regist_date, operation_state)	")
			.append("	values( ?, ?, ?, ?, ?,	")
			.append("	?,45, ?, ?, ?, sysdate,'N' ) 	");
			
			pstmt = con.prepareStatement(insertBusTour.toString());
			pstmt.setString(1, bustourId);
			pstmt.setString(2, tbVO.getName());
			pstmt.setString(3, tbVO.getTel());
			pstmt.setDate(4, tbVO.getStartTime());
			pstmt.setDate(5, tbVO.getEndTime());
			pstmt.setString(6, tbVO.getBusTourTime());
			pstmt.setInt(7, tbVO.getAdultFare());
			pstmt.setInt(8, tbVO.getChildFare());
			pstmt.setString(9, "/prj_travel/common/images/tour_bus_img/" + tbVO.getImage());
			
			resultCnt += pstmt.executeUpdate();
			
			pstmt.close();
			rs.close();
			
			
			//tourbus_dispatch 테이블 insert
			String[] dispatchTimes = tbVO.getDispatchTime();
			if(dispatchTimes != null) {
				for(int i = 0; i < dispatchTimes.length; i++) {
					StringBuilder insertDispatchTimes = new StringBuilder();
					insertDispatchTimes
					.append(" insert into bustour_dispatch(bustour_id, bustour_time )	")
					.append(" values(? , ?)	");
					
					pstmt = con.prepareStatement(insertDispatchTimes.toString());
					
					pstmt.setString(1, bustourId);
					pstmt.setString(2, dispatchTimes[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}// end if
			
			//편의시설 insert
			String[] routeArr = tbVO.getRoute();
			if(routeArr != null) {
				for( int i = 0; i<routeArr.length; i++) {
					
					pstmt = con.prepareStatement("	insert into bustour_route(bustour_id, route_num,route_name ) values ( ?, ?, ? )	");
					pstmt.setString(1, bustourId);
					pstmt.setInt(2, i+1);
					pstmt.setString(3, routeArr[i]);
					
					resultCnt += pstmt.executeUpdate();
				}//end for
			}//end if
			
			if(resultCnt == (1+dispatchTimes.length + routeArr.length)) {
				con.commit();
			}else {
				con.rollback();
			}
			
			return resultCnt;				
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}
	}
	
	public TourBusVO selectTourBus(String tourbusId) throws SQLException{
		TourBusVO tbVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectTourBus = new StringBuilder();
			selectTourBus
			.append("	SELECT a.BUSTOUR_ID, a.BUSTOUR_NAME, a.BUSTOUR_TEL,a.BUSTOUR_START, a.BUSTOUR_END, a.BUSTOUR_TIME,	")
			.append("    a.BUSTOUR_SEAT, a.ADULT_FARE, a.CHILD_FARE,a.BUSTOUR_IMAGE, a.REGIST_DATE,a.OPERATION_STATE, 	")
			.append("	LISTAGG(DISTINCT b.BUSTOUR_TIME, ' ') WITHIN GROUP (ORDER BY  b.BUSTOUR_TIME) AS BUSTOUR_TIMES,	")
			.append("   LISTAGG(DISTINCT c.ROUTE_NAME, ',') WITHIN GROUP (ORDER BY c.ROUTE_NUM) AS ROUTE_NAMES	")
			.append("     FROM BUSTOUR a LEFT JOIN BUSTOUR_DISPATCH b ON a.BUSTOUR_ID = b.BUSTOUR_ID	")
			.append("      LEFT JOIN BUSTOUR_ROUTE c ON a.BUSTOUR_ID = c.BUSTOUR_ID	")
			.append("      WHERE a.BUSTOUR_ID = ? 	")
			.append("     GROUP BY	")
			.append("    a.BUSTOUR_ID, a.BUSTOUR_NAME, a.BUSTOUR_TEL,a.BUSTOUR_START, a.BUSTOUR_END, a.BUSTOUR_TIME,	")
			.append("     a.BUSTOUR_SEAT, a.ADULT_FARE, a.CHILD_FARE,a.BUSTOUR_IMAGE, a.REGIST_DATE,a.OPERATION_STATE 	");
			pstmt = con.prepareStatement(selectTourBus.toString());
			pstmt.setString(1, tourbusId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				tbVO = new TourBusVO();
				tbVO.setId(tourbusId);
				tbVO.setName(rs.getString("BUSTOUR_NAME"));
				tbVO.setTel(rs.getString("BUSTOUR_TEL"));
				tbVO.setStartTime(rs.getDate("BUSTOUR_START"));
				tbVO.setEndTime(rs.getDate("BUSTOUR_END"));
				tbVO.setBusTourTime(rs.getString("BUSTOUR_TIME"));
				tbVO.setDispatchTimes(rs.getString("BUSTOUR_TIMES"));
				tbVO.setRoutes(rs.getString("ROUTE_NAMES"));
				tbVO.setTotalSeat(rs.getInt("BUSTOUR_SEAT"));
				tbVO.setAdultFare(rs.getInt("ADULT_FARE"));
				tbVO.setChildFare(rs.getInt("CHILD_FARE"));
				tbVO.setImage(rs.getString("BUSTOUR_IMAGE"));
				tbVO.setRegistrationTime(rs.getDate("REGIST_DATE"));
				tbVO.setOperationState(rs.getString("OPERATION_STATE"));
				
			}	
				
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		
		return tbVO;
	}
	
	public List<TourBusVO> selectOperationBus() throws SQLException{
		List<TourBusVO> list = new ArrayList<TourBusVO>();
			
			DbConnection db = DbConnection.getInstance();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder selectAllTourBus = new StringBuilder();
				selectAllTourBus
				.append("	select bustour_id, bustour_name, regist_date,operation_state	")
				.append("	from bustour 									")
				.append("	where operation_state = 'Y'						");
				
				pstmt = con.prepareStatement(selectAllTourBus.toString());
				
				rs = pstmt.executeQuery();
				TourBusVO tbVO = null;
				
				while(rs.next()) {
					tbVO = new TourBusVO();
					tbVO.setId(rs.getString("bustour_id"));
					tbVO.setName(rs.getString("bustour_name"));
					tbVO.setRegistrationTime(rs.getDate("regist_date"));
					tbVO.setOperationState(rs.getString("operation_state"));
					
					list.add(tbVO);
				}
			}finally {
				db.dbClose(rs, pstmt, con);
			}
			return list;
	}
	
	public List<TourBusReservationVO> selectTourBusReservation(String tourbusId, Date reservationDate, String reservationTime) throws SQLException{
		List<TourBusReservationVO> list = new ArrayList<TourBusReservationVO>();
			DbConnection db = DbConnection.getInstance();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder selectTourBusReservation = new StringBuilder();
				selectTourBusReservation
				.append("	SELECT R.RESERVATION_ID, R.USER_ID, R.BUSTOUR_ID, R.RESERVATION_TIME,		")
				.append("	R.RESERVATION_DATE, R.APPROVAL_STATE, R.REGIST_DATE, T.BUSTOUR_SEAT, T.BUSTOUR_NAME, 	")
				.append("	COALESCE(P.ADULT, 0) AS ADULT_COUNT, COALESCE(P.CHILD, 0) AS CHILD_COUNT 	")
				.append("	FROM BUSTOUR_RESERVATION R JOIN BUSTOUR T ON R.BUSTOUR_ID = T.BUSTOUR_ID				")
				.append("	LEFT JOIN PEOPLE_NUM P ON R.RESERVATION_ID = P.RESERVATION_ID				")
				.append("	WHERE R.BUSTOUR_ID = ? AND R.RESERVATION_DATE = ?		")
				.append("	AND R.RESERVATION_TIME = ?												");
				
				pstmt = con.prepareStatement(selectTourBusReservation.toString());
				
				pstmt.setString(1, tourbusId);
				pstmt.setDate(2, reservationDate);
				pstmt.setString(3, reservationTime);
				
				rs = pstmt.executeQuery();
				TourBusReservationVO tbrVO = null;
				
				while(rs.next()) {
					tbrVO = new TourBusReservationVO();
					tbrVO.setReservationId(rs.getString("RESERVATION_ID"));
					tbrVO.setUserId(rs.getString("USER_ID"));
					tbrVO.setTourBusId(rs.getString("BUSTOUR_ID"));
					tbrVO.setReservationTime(rs.getString("RESERVATION_TIME"));
					tbrVO.setReservationDate(rs.getDate("RESERVATION_DATE"));
					tbrVO.setReservationState(rs.getString("APPROVAL_STATE"));
					tbrVO.setReservationInputDate(rs.getDate("REGIST_DATE"));
					tbrVO.setTourBusName(rs.getString("BUSTOUR_NAME"));
					tbrVO.setTotalSeat(rs.getInt("BUSTOUR_SEAT"));
					tbrVO.setAdult(rs.getInt("ADULT_COUNT"));
					tbrVO.setChild(rs.getInt("CHILD_COUNT"));
					
					
					list.add(tbrVO);
				}
			}finally {
				db.dbClose(rs, pstmt, con);
			}
		return list;
	}
	
	public int updateReservationState(String reservationId) throws SQLException{
		int cnt = 0;
			
			DbConnection db = DbConnection.getInstance();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder updateNotice = new StringBuilder();
				updateNotice
				.append("	update BUSTOUR_RESERVATION			")
				.append("	set  APPROVAL_STATE = 'Y'		")
				.append("	where RESERVATION_ID = ? 			");
				
				pstmt = con.prepareStatement(updateNotice.toString());
				
				pstmt.setString(1, reservationId);
				
				cnt = pstmt.executeUpdate();
				
			}finally {
				db.dbClose(null, pstmt, con);
			}
		return cnt;
	}
	
	public int updateReservationCancel(String reservationId) throws SQLException{
		int cnt = 0;
			
			DbConnection db = DbConnection.getInstance();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder updateNotice = new StringBuilder();
				updateNotice
				.append("	update BUSTOUR_RESERVATION			")
				.append("	set  APPROVAL_STATE = 'N'		")
				.append("	where RESERVATION_ID = ? 			");
				
				pstmt = con.prepareStatement(updateNotice.toString());
				
				pstmt.setString(1, reservationId);
				
				cnt = pstmt.executeUpdate();
				
			}finally {
				db.dbClose(null, pstmt, con);
			}
		return cnt;
	}
	
	public TourBusReservationVO selectReservation(String reservationId) throws SQLException{
		TourBusReservationVO tbrVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
			try {
				con = db.getConn("jdbc/dbcp");
				
				StringBuilder selectTourBus = new StringBuilder();
				selectTourBus
				.append("	SELECT RESERVATION_ID, USER_ID, APPROVAL_STATE	")
				.append("    FROM BUSTOUR_RESERVATION 	")
				.append("	WHERE RESERVATION_ID = ?	");
				
				pstmt = con.prepareStatement(selectTourBus.toString());
				pstmt.setString(1, reservationId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					tbrVO = new TourBusReservationVO();
					tbrVO.setReservationId(rs.getString("RESERVATION_ID"));
					tbrVO.setUserId(rs.getString("USER_ID"));
					tbrVO.setReservationState(rs.getString("APPROVAL_STATE"));
				}	
					
			}finally {
				db.dbClose(rs, pstmt, con);
			}
		
		return tbrVO;
	}
	
}
