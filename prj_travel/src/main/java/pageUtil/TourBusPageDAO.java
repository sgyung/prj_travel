package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.TourBusVO;
import kr.co.dao.DbConnection;

public class TourBusPageDAO {
	private static TourBusPageDAO tbpDAO;
	
	private TourBusPageDAO() {
		
	}
	
	public static TourBusPageDAO getInstance() {
		if(tbpDAO == null) {
			tbpDAO = new TourBusPageDAO();
		}
		return tbpDAO;
	}
	
	public int tourBusTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from bustour	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "bustour_name";
				}
				
				selectCnt.append("where ").append(field ).append(" like '%' || ? || '%'");
			
			}//end if
			
			pstmt = con.prepareStatement(selectCnt.toString());
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(1, pVO.getKeyword());
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt("cnt");
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return totalCount;
	}
	

	/**
	 * 시작번호와 끝번호 사이의 레코드를 검색
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public List<TourBusVO> selectTourBus(PageVO pVO) throws SQLException{
		List<TourBusVO> list = new ArrayList<TourBusVO>();
		
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		// 1. JNDI 사용객체 생성
		// 2. DataSource 얻기
		// 3. Connection 얻기
			con = db.getConn("jdbc/dbcp");
				
		// 4. 쿼리문 생성객체 얻기 => 검색 키워드와 검색 field에 따라 Dynamic Query로 변경
			StringBuilder selectTourBus = new StringBuilder();
			selectTourBus
	        .append("	select bustour_id, bustour_name, regist_date, operation_state ")
	        .append("	FROM (select bustour_id, bustour_name, regist_date, operation_state, ")
	        .append("	ROW_NUMBER() OVER (ORDER BY bustour_id DESC) rnum ")
	        .append("	FROM bustour ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "bustour_name";
				}
				selectTourBus.append("	WHERE ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectTourBus.append(") WHERE rnum BETWEEN ? AND ?");
			
			pstmt = con.prepareStatement(selectTourBus.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			TourBusVO tbVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tbVO = new TourBusVO();
				tbVO.setId(rs.getString("bustour_id"));
				tbVO.setName(rs.getString("bustour_name"));
				tbVO.setRegistrationTime(rs.getDate("regist_date"));
				tbVO.setOperationState(rs.getString("operation_state"));
				
				list.add(tbVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
