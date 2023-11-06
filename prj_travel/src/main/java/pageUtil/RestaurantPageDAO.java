package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.RestaurantVO;
import admin.vo.TouristAreaVO;
import kr.co.dao.DbConnection;

public class RestaurantPageDAO {
	private static RestaurantPageDAO rpDAO;
	
	private RestaurantPageDAO() {
		
	}
	
	public static RestaurantPageDAO getInstance() {
		if(rpDAO == null) {
			rpDAO = new RestaurantPageDAO();
		}
		return rpDAO;
	}
	
	public int restaurantTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from restaurant where delete_state = 'N' " );
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "restaurant_name";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "restaurant_detail_content";
				}
				
				selectCnt.append(" and ").append(field ).append(" like '%' || ? || '%'");
			
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
	public List<RestaurantVO> selectRestaurant(PageVO pVO) throws SQLException{
		List<RestaurantVO> list = new ArrayList<RestaurantVO>();
		
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
			StringBuilder selectTouristArea = new StringBuilder();
			selectTouristArea
	        .append("select restaurant_id, restaurant_name, restaurant_upload_date ")
	        .append("FROM (select restaurant_id, restaurant_name, restaurant_upload_date, ")
	        .append("ROW_NUMBER() OVER (ORDER BY restaurant_id DESC) rnum ")
	        .append("FROM restaurant where delete_state = 'N' ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "restaurant_name";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "restaurant_detail_content";
				}

				selectTouristArea.append(" and ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectTouristArea.append(") WHERE rnum BETWEEN ? AND ?");
			
			pstmt = con.prepareStatement(selectTouristArea.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			RestaurantVO rVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rVO = new RestaurantVO();
				rVO.setId(rs.getString("restaurant_id"));
				rVO.setName(rs.getString("restaurant_name"));
				rVO.setRegistraitionDate(rs.getDate("restaurant_upload_date"));
				
				list.add(rVO);
			}
			
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
