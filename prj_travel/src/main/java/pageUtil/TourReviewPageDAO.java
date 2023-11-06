package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import admin.vo.TourReviewVO;
import kr.co.dao.DbConnection;

public class TourReviewPageDAO {
	private static TourReviewPageDAO trpDAO;
	
	private TourReviewPageDAO() {
		
	}
	
	public static TourReviewPageDAO getInstance() {
		if(trpDAO == null) {
			trpDAO = new TourReviewPageDAO();
		}
		return trpDAO;
	}
	
	/**
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int tourReviewTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt
			.append(" select count(distinct ta.tourist_area_id) as cnt	")
			.append(" from tourist_area ta	")
			.append(" inner join tourist_review tr on ta.tourist_area_id = tr.tourist_area_id	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "ta.tourist_area_name";
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
	public List<TourReviewVO> selectTouristReview(PageVO pVO) throws SQLException{
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
			StringBuilder selectTouristReview = new StringBuilder();
			selectTouristReview
	        .append("	select *	 ")
	        .append("	from (select ta.tourist_area_id,ta.tourist_area_name,max(tr.tourist_review_date) as latest_review_date,	 ")
	        .append("	count(tr.tourist_review_id) as review_count, 	")
	        .append("	row_number() over (order by max(tr.tourist_review_date) desc) as rnum	 ")
	        .append("	from tourist_area ta left join tourist_review tr on ta.tourist_area_id = tr.tourist_area_id 	")
			.append("	where tr.tourist_review_id is not null and ta.delete_state = 'N' 	");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "ta.tourist_area_name";
				}

				selectTouristReview.append(" and ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectTouristReview
			.append("	group by ta.tourist_area_id, ta.tourist_area_name	 ")
			.append("	having count(tr.tourist_review_id) >= 1 	")
			.append("	order by latest_review_date desc 	")
			.append("	) where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectTouristReview.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
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
				trVO.setTouristAreaId(rs.getString("tourist_area_id"));
				trVO.setTourAreaName(rs.getString("tourist_area_name"));
				trVO.setReviewDate(rs.getDate("latest_review_date"));
				trVO.setReviewCnt(rs.getInt("review_count"));
				list.add(trVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
