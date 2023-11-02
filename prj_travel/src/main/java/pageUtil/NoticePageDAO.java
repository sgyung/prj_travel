package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.NoticeVO;
import kr.co.dao.DbConnection;


public class NoticePageDAO {
	private static NoticePageDAO npDAO;
	
	private NoticePageDAO() {
		
	}
	
	public static NoticePageDAO getInstance() {
		if(npDAO == null) {
			npDAO = new NoticePageDAO();
		}
		return npDAO;
	}
	
	/**
	 * 10월 23일 Dynamic Query
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int noticeTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from notice	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "notice_title";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "notice_content";
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
	public List<NoticeVO> selectNotice(PageVO pVO) throws SQLException{
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		
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
			StringBuilder selectNotice = new StringBuilder();
			selectNotice
	        .append("SELECT notice_id, notice_title, notice_content, notice_upload_date, notice_view_num ")
	        .append("FROM (SELECT notice_id, notice_title, notice_content, notice_upload_date, notice_view_num, ")
	        .append("ROW_NUMBER() OVER (ORDER BY notice_upload_date DESC) rnum ")
	        .append("FROM notice ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "notice_title";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "notice_content";
				}

				selectNotice.append("WHERE ").append(field).append(" LIKE '%' || ? || '%' ");
			}
			selectNotice.append(") WHERE rnum BETWEEN ? AND ?");
			
			pstmt = con.prepareStatement(selectNotice.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			System.out.println(pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			System.out.println(pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			NoticeVO nVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				nVO = new NoticeVO();
				nVO.setId(rs.getString("notice_id"));
				nVO.setTitle(rs.getString("notice_title"));
				nVO.setContent(rs.getString("notice_content"));
				nVO.setRegistrationDate(rs.getDate("notice_upload_date"));
				nVO.setViewNum(rs.getInt("notice_view_num"));
				
				list.add(nVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
	
}
