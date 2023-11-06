package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.TourReviewVO;
import kr.co.dao.DbConnection;

public class TourReviewDetailtPageDAO {
	private static TourReviewDetailtPageDAO trdpDAO;
	
	private TourReviewDetailtPageDAO() {
		
	}
	
	public static TourReviewDetailtPageDAO getInstance() {
		if(trdpDAO == null) {
			trdpDAO = new TourReviewDetailtPageDAO();
		}
		return trdpDAO;
	}
	
	/**
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int tourReviewDetailTotalCount(PageVO pVO, String areaId) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt
			.append(" select count(tourist_review_id) as cnt	")
			.append(" from tourist_review	")
			.append(" where tourist_area_id = ?	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "tourist_review_content";
				}
				
				
				selectCnt.append(" and ").append(field ).append(" like '%' || ? || '%'");
			
			}//end if
			
			pstmt = con.prepareStatement(selectCnt.toString());
			
			pstmt.setString(1, areaId);
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(2, pVO.getKeyword());
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
	public List<TourReviewVO> selectTouristReviewDetail(PageVO pVO, String areaId) throws SQLException{
		List<TourReviewVO> list = new ArrayList<TourReviewVO>();
		
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
			StringBuilder selectTouristReviewDetail = new StringBuilder();
			selectTouristReviewDetail
	        .append("	select *	 ")
	        .append("	from (select tourist_review_id, user_id, tourist_review_date, tourist_review_content, tourist_star_score, tourist_area_id, review_count, rnum" )
	        .append("   from(")
	        .append("	select tourist_review_id, user_id, tourist_review_date, tourist_review_content, tourist_star_score,tourist_area_id,	 ")
	        .append("	count(tourist_review_id) as review_count, 	")
	        .append("	row_number() over (order by tourist_review_id desc) as rnum	 ")
	        .append("	from tourist_review  ")
			.append("	where tourist_review_id is not null and tourist_area_id = ?	");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "tourist_review_content";
				}

				selectTouristReviewDetail.append(" and ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectTouristReviewDetail
			.append("GROUP BY tourist_review_id, user_id, tourist_review_date, tourist_review_content, tourist_star_score, tourist_area_id")
			.append(")	) where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectTouristReviewDetail.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			
			pstmt.setString(bindCnt++,areaId);
			
			System.out.println(areaId);
			
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			TourReviewVO trVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				trVO = new TourReviewVO();
				trVO.setReviewId(rs.getString("tourist_review_id"));
				trVO.setUserId(rs.getString("user_id"));
				trVO.setReviewDate(rs.getDate("tourist_review_date"));
				trVO.setStarScore(rs.getInt("tourist_star_score"));
				trVO.setContent(rs.getString("tourist_review_content"));
				trVO.setTouristAreaId(rs.getString("tourist_area_id"));
				System.out.println(rs.getString("user_id"));
				list.add(trVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
}
