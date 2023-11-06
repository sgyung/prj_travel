package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import admin.vo.TouristAreaVO;
import kr.co.dao.DbConnection;

public class TouristAreaPageDAO {
	private static TouristAreaPageDAO tapDAO;
	
	private TouristAreaPageDAO() {
		
	}
	
	public static TouristAreaPageDAO getInstance() {
		if(tapDAO == null) {
			tapDAO = new TouristAreaPageDAO();
		}
		return tapDAO;
	}
	
	/**
	 * 10월 23일 Dynamic Query
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int touristAreaTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from tourist_area where delete_state = 'N' " );
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "tourist_area_name";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "tourist_area_detail_info";
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
	public List<TouristAreaVO> selectTouristArea(PageVO pVO) throws SQLException{
		List<TouristAreaVO> list = new ArrayList<TouristAreaVO>();
		
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
	        .append("select tourist_area_id, tourist_area_name,tourist_area_upload_date ")
	        .append("FROM (select tourist_area_id, tourist_area_name,tourist_area_upload_date, ")
	        .append("ROW_NUMBER() OVER (ORDER BY tourist_area_id DESC) rnum ")
	        .append("FROM tourist_area where delete_state = 'N' ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "tourist_area_name";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "tourist_area_detail_info";
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
			TouristAreaVO taVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				taVO = new TouristAreaVO();
				taVO.setId(rs.getString("tourist_area_id"));
				taVO.setName(rs.getString("tourist_area_name"));
				taVO.setRegistraitionDate(rs.getDate("tourist_area_upload_date"));
				
				list.add(taVO);
			}
			
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
