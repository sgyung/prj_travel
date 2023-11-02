package pageUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.vo.PostVO;
import admin.vo.QandAVO;
import kr.co.dao.DbConnection;

public class BoardPageDAO {
	private static BoardPageDAO bpDAO;
	
	private BoardPageDAO() {
		
	}
	
	public static BoardPageDAO getInstance() {
		if(bpDAO == null) {
			bpDAO = new BoardPageDAO();
		}
		return bpDAO;
	}
	
	public int boardRestaurantTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("	select count(*) cnt	")
			.append("		from post a inner join post_cartegory b on a.cartegory_id = b.cartegory_id	")
			.append("	where b.cartegory_name = '맛집' and a.delete_state = 'N'	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "a.user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "a.post_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "a.post_content";
				}
				
				selectCnt.append(" and ").append(field ).append(" like '%' || ? || '%'");
			
			}//end if
			
			selectCnt.append(" order by a.post_upload_date desc  ");

			pstmt = con.prepareStatement(selectCnt.toString());
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				if ("1".equals(pVO.getField())) {
	                pstmt.setString(1, pVO.getKeyword());
	            }
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
	
	public int boardTouristTotalCount(PageVO pVO) throws SQLException {
		int totalCount = 0;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = db.getConn("jdbc/dbcp");
			
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("	select count(*) cnt	")
			.append("		from post a inner join post_cartegory b on a.cartegory_id = b.cartegory_id	")
			.append("	where b.cartegory_name = '관광지' and a.delete_state = 'N'	");
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "a.user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "a.post_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "a.post_content";
				}
				
				selectCnt.append(" and ").append(field ).append(" like '%' || ? || '%'");
			
			}//end if
			
			selectCnt.append(" order by a.post_upload_date desc  ");

			pstmt = con.prepareStatement(selectCnt.toString());
			
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				if ("1".equals(pVO.getField())) {
	                pstmt.setString(1, pVO.getKeyword());
	            }
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
	
	public List<PostVO> selectRestaurantBoard(PageVO pVO) throws SQLException{
		List<PostVO> list = new ArrayList<PostVO>();
		
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
			StringBuilder selectRestaurantBoard = new StringBuilder();
			selectRestaurantBoard
			 .append("	select * from (")
			    .append("	select a.post_id, a.user_id, a.post_title, a.post_content, a.post_upload_date, a.post_view_num, a.delete_state, b.cartegory_name,	 ")
			    .append("	row_number() over (order by a.post_upload_date desc) rnum 	")
			    .append("	from post a		")
			    .append("	inner join post_cartegory b on a.cartegory_id = b.cartegory_id 	")
			    .append("	where b.cartegory_name='맛집' and a.delete_state = 'N'	 ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "post_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "post_content";
				}

				selectRestaurantBoard.append(" and ").append(field).append(" like '%' || ? || '%' ");
			}
			selectRestaurantBoard.append(") where rnum between ? and ?");
			
			pstmt = con.prepareStatement(selectRestaurantBoard.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			PostVO postVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				postVO = new PostVO();
				postVO.setPostId(rs.getString("post_id"));
				postVO.setUserId(rs.getString("user_id"));
				postVO.setPostTitle(rs.getString("post_title"));
				postVO.setPostCategory(rs.getString("cartegory_name"));
				postVO.setPostContent(rs.getString("post_content"));
				postVO.setPostDate(rs.getDate("post_upload_date"));
				postVO.setPostViewNum(rs.getInt("post_view_num"));
				postVO.setPostState(rs.getString("delete_state"));
				
				list.add(postVO);
			}
			System.out.println(list.toString());
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
	public List<PostVO> selectTouristBoard(PageVO pVO) throws SQLException{
		List<PostVO> list = new ArrayList<PostVO>();
		
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
			StringBuilder selectTouristBoard = new StringBuilder();
			selectTouristBoard
			 .append("select * from (")
			    .append("select a.post_id, a.user_id, a.post_title, a.post_content, a.post_upload_date, a.post_view_num, a.delete_state, b.cartegory_name, ")
			    .append("row_number() over (order by a.post_upload_date desc) rnum ")
			    .append("from post a ")
			    .append("inner join post_cartegory b on a.cartegory_id = b.cartegory_id ")
			    .append("where b.cartegory_name='관광지' and a.delete_state = 'N' ");

			if (pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				String field = "";
				
				if ("1".equals(pVO.getField())) {
					field = "user_id";
				}
				
				if ("2".equals(pVO.getField())) {
					field = "post_title";
				}
				
				if ("3".equals(pVO.getField())) {
					field = "post_content";
				}

				selectTouristBoard.append(" and ").append(field).append(" like '%' || ? || '%' ");
			}
			selectTouristBoard.append(") where rnum between ? and ?");
			
			pstmt = con.prepareStatement(selectTouristBoard.toString());
			
		// 5. 바인드 변수에 값 설정
			int bindCnt = 1;
			if(pVO.getKeyword() != null && !"".equals(pVO.getKeyword()) && !"null".equals(pVO.getKeyword())) {
				pstmt.setString(bindCnt++, pVO.getKeyword());
			}
			
			pstmt.setInt(bindCnt++, pVO.getStartNum());
			pstmt.setInt(bindCnt++, pVO.getEndNum());
			
		// 6. 쿼리문 수행 후 결과 얻기
			PostVO postVO = null;
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				postVO = new PostVO();
				postVO.setPostId(rs.getString("post_id"));
				postVO.setUserId(rs.getString("user_id"));
				postVO.setPostTitle(rs.getString("post_title"));
				postVO.setPostCategory(rs.getString("cartegory_name"));
				postVO.setPostContent(rs.getString("post_content"));
				postVO.setPostDate(rs.getDate("post_upload_date"));
				postVO.setPostViewNum(rs.getInt("post_view_num"));
				postVO.setPostState(rs.getString("delete_state"));
				
				list.add(postVO);
			}
			
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return list;
	}
	
}
