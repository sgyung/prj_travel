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

public class ResReviewPageDAO {
	private static ResReviewPageDAO rrpDAO;
	
	private ResReviewPageDAO() {
		
	}
	
	public static ResReviewPageDAO getInstance() {
		if(rrpDAO == null) {
			rrpDAO = new ResReviewPageDAO();
		}
		return rrpDAO;
	}
	
	/**
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int resReviewTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt
			.append(" select count(distinct a.restaurant_id) as cnt	")
			.append(" from restaurant a	")
			.append(" inner join restaurant_review b on a.restaurant_id = b.restaurant_id	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "a.restaurant_name";
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
	public List<RestaurantReviewVO> selectRestaurantReview(PageVO pVO) throws SQLException{
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
			StringBuilder selectRestaurantReview = new StringBuilder();
			selectRestaurantReview
	        .append("	select *	 ")
	        .append("	from (select a.restaurant_id,a.restaurant_name,max(b.restaurant_review_date) as latest_review_date,	 ")
	        .append("	count(b.restaurant_review_id) as review_count, 	")
	        .append("	row_number() over (order by max(b.restaurant_review_date) desc) as rnum	 ")
	        .append("	from restaurant a left join restaurant_review b on a.restaurant_id = b.restaurant_id 	")
			.append("	where b.restaurant_review_id is not null and a.delete_state = 'N' 	");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "a.restaurant_name";
				}

				selectRestaurantReview.append(" and ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectRestaurantReview
			.append("	group by a.restaurant_id, a.restaurant_name	 ")
			.append("	having count(b.restaurant_review_id) >= 1 	")
			.append("	order by latest_review_date desc 	")
			.append("	) where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectRestaurantReview.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			RestaurantReviewVO reviewVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reviewVO = new RestaurantReviewVO();
				reviewVO.setRestaurantId(rs.getString("restaurant_id"));
				reviewVO.setRestaurantName(rs.getString("restaurant_name"));
				reviewVO.setReviewDate(rs.getDate("latest_review_date"));
				reviewVO.setReviewCnt(rs.getInt("review_count"));
				list.add(reviewVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
