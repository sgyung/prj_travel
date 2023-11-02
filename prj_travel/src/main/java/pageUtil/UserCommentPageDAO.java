package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.UserCommentVO;
import admin.vo.UserPostVO;
import kr.co.dao.DbConnection;

public class UserCommentPageDAO {
	private static UserCommentPageDAO ucpDAO;
	
	private UserCommentPageDAO() {
		
	}
	
	public static UserCommentPageDAO getInstance() {
		if(ucpDAO == null) {
			ucpDAO = new UserCommentPageDAO();
		}
		return ucpDAO;
	}
	
	public int userCommentTotalCount(PageVO pVO, String id) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("	select a.user_id, a.user_name, count(b.comment_id) as comment_count	")
			.append("		from t_user a left join post_comment b on a.user_id = b.user_id	")
			.append("	where	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "b.comment_content";
				}
				
				selectCnt.append(field ).append(" like '%' || ? || '%'").append(" and ");
			
			}//end if
			
			selectCnt.append(" a.user_id = ?	")
			.append(" group by a.user_id, a.user_name ");

			pstmt = con.prepareStatement(selectCnt.toString());
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				if ("1".equals(pVO.getField())) {
	                pstmt.setString(1, pVO.getKeyword());
	                pstmt.setString(2, id);
	            } else {
	                pstmt.setString(1, id);
	            }
	        } else {
	            pstmt.setString(1, id);
	        }
			
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt("comment_count");
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
	public List<UserCommentVO> selectUserCommnet(PageVO pVO, String id) throws SQLException{
		List<UserCommentVO> list = new ArrayList<UserCommentVO>();
		
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
			StringBuilder selectCommnet = new StringBuilder();
			selectCommnet
	        .append("	select * from ( ")
	        .append(" 	select b.comment_id,	a.user_name, a.user_id, b.comment_date,	b.comment_content, ")
	        .append("	row_number() over (order by b.comment_date desc) as rnum	 ")
	        .append(" 	from t_user a left join post_comment b on a.user_id = b.user_id		 ")
	        .append(" 	where  a.user_id=? ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "b.comment_content";
				}

				selectCommnet.append(	field	).append(" like '%' || ? || '%' ").append(" and a.user_id=?	");
			}
			selectCommnet.append("	) where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectCommnet.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setString(bindCnt++, id);
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			UserCommentVO ucVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ucVO = new UserCommentVO();
				ucVO.setCommentId(rs.getString("comment_id"));
				ucVO.setUserName(rs.getString("user_name"));
				ucVO.setUserId(rs.getString("user_id"));
				ucVO.setRegistrationDate(rs.getDate("comment_date"));
				ucVO.setContent(rs.getString("comment_content"));
				
				list.add(ucVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
}
