package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import admin.vo.QandAVO;
import kr.co.dao.DbConnection;

public class QuestionPageDAO {
	private static QuestionPageDAO qpDAO;
	
	private QuestionPageDAO() {
		
	}
	
	public static QuestionPageDAO getInstance() {
		if(qpDAO == null) {
			qpDAO = new QuestionPageDAO();
		}
		return qpDAO;
	}
	
	/**
	 * 10월 23일 Dynamic Query
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int restaurantQnaTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from qna where qna_type='맛집'	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "qna_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "qna_content";
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
			System.out.println("//" + totalCount);
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return totalCount;
	}
	
	/**
	 * 10월 23일 Dynamic Query
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int touristQnaTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from qna where qna_type='관광지'	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "qna_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "qna_content";
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
	public List<QandAVO> selectRestaurantQna(PageVO pVO) throws SQLException{
		List<QandAVO> list = new ArrayList<QandAVO>();
		
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
			StringBuilder selectRestaurantQna = new StringBuilder();
			selectRestaurantQna
	        .append("select inquiry_id, user_id,restaurant_id,qna_title, qna_type, qna_content,qna_date,answer_state ")
	        .append("from (select inquiry_id, user_id, restaurant_id, qna_title, qna_type,qna_content,qna_date,answer_state, ")
	        .append("row_number() over (order by qna_date desc) rnum ")
	        .append("from qna where qna_type='맛집' ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "qna_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "qna_content";
				}

				selectRestaurantQna.append(" and ").append(field).append(" like '%' || ? || '%' ");
			}
			selectRestaurantQna.append(") where rnum between ? and ?");
			
			pstmt = con.prepareStatement(selectRestaurantQna.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			QandAVO qbVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				qbVO = new QandAVO();
				qbVO.setQAndAId(rs.getString("inquiry_id"));
				qbVO.setUserId(rs.getString("user_id"));
				System.out.println(rs.getString("user_id"));
				qbVO.setRestaurantId(rs.getString("restaurant_id"));
				qbVO.setTitle(rs.getString("qna_title"));
				qbVO.setCategory(rs.getString("qna_type"));
				qbVO.setContent(rs.getString("qna_content"));
				qbVO.setRegistrationDate(rs.getDate("qna_date"));
				qbVO.setAnswerType(rs.getString("answer_state"));
				
				list.add(qbVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
	
	/**
	 * 시작번호와 끝번호 사이의 레코드를 검색
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public List<QandAVO> selectTouristQna(PageVO pVO) throws SQLException{
		List<QandAVO> list = new ArrayList<QandAVO>();
		
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
			StringBuilder selectTouristQna = new StringBuilder();
			selectTouristQna
	        .append("select inquiry_id, user_id,tourist_area_id,qna_title, qna_type, qna_content,qna_date,answer_state ")
	        .append("from (select inquiry_id, user_id, tourist_area_id, qna_title, qna_type,qna_content,qna_date,answer_state, ")
	        .append("row_number() over (order by qna_date desc) rnum ")
	        .append("from qna where qna_type='관광지' ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "qna_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "qna_content";
				}

				selectTouristQna.append(" and ").append(field).append(" like '%' || ? || '%' ");
			}
			selectTouristQna.append(") where rnum between ? and ?");
			
			pstmt = con.prepareStatement(selectTouristQna.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			QandAVO qbVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				qbVO = new QandAVO();
				qbVO.setQAndAId(rs.getString("inquiry_id"));
				qbVO.setUserId(rs.getString("user_id"));
				qbVO.setAreaId(rs.getString("tourist_area_id"));
				qbVO.setTitle(rs.getString("qna_title"));
				qbVO.setCategory(rs.getString("qna_type"));
				qbVO.setContent(rs.getString("qna_content"));
				qbVO.setRegistrationDate(rs.getDate("qna_date"));
				qbVO.setAnswerType(rs.getString("answer_state"));
				
				list.add(qbVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
}
