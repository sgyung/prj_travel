package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.CommentVO;
import kr.co.dao.DbConnection;

public class CommentPageDAO {
	private static CommentPageDAO cpDAO;
	
	private CommentPageDAO() {
		
	}
	
	public static CommentPageDAO getInstance() {
		if(cpDAO == null) {
			cpDAO = new CommentPageDAO();
		}
		return cpDAO;
	}
	
	public int commentTotalCount(String postId) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder commentTotalCount = new StringBuilder();
			commentTotalCount
			.append("		select count(*) cnt					")
			.append("		from post a inner join post_comment b on a.post_id = b.post_id	")
			.append("		where a.post_id = ?							");
			

			pstmt = con.prepareStatement(commentTotalCount.toString());
			
	                pstmt.setString(1, postId);
	       
	        
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt("cnt");
			}
		}finally {
			db.dbClose(rs, pstmt, con);
		}
		return totalCount;
	}
	
	public List<CommentVO> selectComment(PageVO pVO, String postId) throws SQLException{
		List<CommentVO> list = new ArrayList<CommentVO>();
		
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
			StringBuilder selectComment = new StringBuilder();
			selectComment
			.append("select * from ( ")
	        .append("select b.comment_id, a.user_id, b.comment_content, b.comment_date, ")
	        .append("row_number() over (order by b.comment_date desc) as rnum ")
	        .append("from post a inner join post_comment b on a.post_id = b.post_id ")
	        .append("where a.post_id = ?) where rnum between ? and ?  ");

			pstmt = con.prepareStatement(selectComment.toString());
			
		// 5. 바인드 변수에 값 설정
			
			
			pstmt.setString(1, postId);
			pstmt.setInt(2, pVO.getStartNum());
			pstmt.setInt(3, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			CommentVO cVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cVO = new CommentVO();
				cVO.setCommentId(rs.getString("comment_id"));
				cVO.setUserId(rs.getString("user_id"));
				cVO.setContent(rs.getString("comment_content"));
				cVO.setRegistrationDate(rs.getDate("comment_date"));
				
				list.add(cVO);
			}
			System.out.println(list.toString());
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
}
