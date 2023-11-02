package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.UserManageVO;
import kr.co.dao.DbConnection;

public class UserPageDAO {
	private static UserPageDAO upDAO;
	
	private UserPageDAO() {
		
	}
	
	public static UserPageDAO getInstance() {
		if(upDAO == null) {
			upDAO = new UserPageDAO();
		}
		return upDAO;
	}
	
	/**
	 * 10월 23일 Dynamic Query
	 * @param brVO
	 * @return
	 * @throws SQLException
	 */
	public int userTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from t_user	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field="";
				if("1".equals(pVO.getField())) {
					field = "user_name";
				}//end if
				
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
	public List<UserManageVO> selectUser(PageVO pVO) throws SQLException{
		List<UserManageVO> list = new ArrayList<UserManageVO>();
		
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
	        .append("	with rankedusers as ( 	")
	        .append("	select a.user_id, a.user_name, a.user_registration_date, a.user_registration_state, ")
	        .append("	count(distinct b.post_id) as post_count, count(distinct c.comment_id) as comment_count, 					")
	        .append("	row_number() over (order by a.user_registration_date desc) as rnum 					")
	        .append("	from t_user a 																		")
	        .append("	left join post b on a.user_id = b.user_id											 ")
	        .append("	left join post_comment c on a.user_id = c.user_id 									");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_name";
				}
				

				selectNotice.append("	where a.").append(field).append(" like '%' || ? || '%' ");
			}
			selectNotice
			.append("	group by a.user_id, a.user_name, a.user_registration_date, a.user_registration_state		")
			.append("	) select user_id, user_name, user_registration_date, user_registration_state, post_count, comment_count, rnum		")
			.append("	from rankedusers					")
			.append("	where rnum between ? and ?		");
			
			pstmt = con.prepareStatement(selectNotice.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
		// 6. 쿼리문 수행 후 결과 얻기
			UserManageVO umVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				umVO = new UserManageVO();
				umVO.setId(rs.getString("user_id"));
				umVO.setName(rs.getString("user_name"));
				umVO.setJoinDate(rs.getDate("user_registration_date"));
				umVO.setPostCount(rs.getInt("post_count"));
				umVO.setReviewCount(rs.getInt("comment_count"));
				umVO.setJoinType(rs.getString("user_registration_state"));
				
				list.add(umVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
