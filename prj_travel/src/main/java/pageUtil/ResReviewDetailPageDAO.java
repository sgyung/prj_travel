package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.RestaurantReviewVO;
import admin.vo.TourReviewVO;
import kr.co.dao.DbConnection;

public class ResReviewDetailPageDAO {
	private static ResReviewDetailPageDAO rrdpDAO;
	
	private ResReviewDetailPageDAO() {
		
	}
	
	public static ResReviewDetailPageDAO getInstance() {
		if(rrdpDAO == null) {
			rrdpDAO = new ResReviewDetailPageDAO();
		}
		return rrdpDAO;
	}
	
	/**
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int resReviewDetailTotalCount(PageVO pVO, String restaurantId) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt
			.append(" select count(restaurant_review_id) as cnt	")
			.append(" from restaurant_review	")
			.append(" where restaurant_id = ?	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "restaurant_review_content";
				}
				
				
				selectCnt.append(" and ").append(field ).append(" like '%' || ? || '%'");
			
			}//end if
			
			pstmt = con.prepareStatement(selectCnt.toString());
			
			pstmt.setString(1, restaurantId);
			
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
	public List<RestaurantReviewVO> selectResReviewDetail(PageVO pVO, String restaurantId) throws SQLException{
		List<RestaurantReviewVO> list = new ArrayList<RestaurantReviewVO>();
		
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
			StringBuilder selectResReviewDetail = new StringBuilder();
			selectResReviewDetail
	        .append("	select *	 ")
	        .append("	from (select restaurant_review_id, user_id, restaurant_review_date, restaurant_review_content, restaurant_star_score, restaurant_id, review_count, rnum" )
	        .append("   from(")
	        .append("	select restaurant_review_id, user_id, restaurant_review_date, restaurant_review_content, restaurant_star_score,restaurant_id,	 ")
	        .append("	count(restaurant_review_id) as review_count, 	")
	        .append("	row_number() over (order by restaurant_id desc) as rnum	 ")
	        .append("	from restaurant_review  ")
			.append("	where restaurant_review_id is not null and restaurant_id = ?	");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "restaurant_review_content";
				}

				selectResReviewDetail.append(" and ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectResReviewDetail
			.append("GROUP BY restaurant_review_id, user_id, restaurant_review_date, restaurant_review_content, restaurant_star_score, restaurant_id")
			.append(")	) where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectResReviewDetail.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			
			pstmt.setString(bindCnt++,restaurantId);
			
			System.out.println(restaurantId);
			
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			RestaurantReviewVO rVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rVO = new RestaurantReviewVO();
				rVO.setReviewId(rs.getString("restaurant_review_id"));
				rVO.setUserId(rs.getString("user_id"));
				rVO.setReviewDate(rs.getDate("restaurant_review_date"));
				rVO.setStarScore(rs.getInt("restaurant_star_score"));
				rVO.setContent(rs.getString("restaurant_review_content"));
				rVO.setRestaurantId(rs.getString("restaurant_id"));
				
				list.add(rVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
