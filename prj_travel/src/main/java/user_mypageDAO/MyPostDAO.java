package user_mypageDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.dao.DbConnection;
import user_mypageVO.PostVO;

public class MyPostDAO {
	
private static MyPostDAO pDAO;
	
	public MyPostDAO() {
	}
	
	public static MyPostDAO getInstance() {
		if(pDAO == null){
			pDAO = new MyPostDAO();
		}
		return pDAO;
	}
	
	public List<PostVO>selectAllPost(String id)throws SQLException{
		List<PostVO> allpostList =new ArrayList<PostVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PostVO pVO=null;
		
		DbConnection db =DbConnection.getInstance();		
		
		try {
		 con =db.getConn("jdbc/dbcp");
		 
		 StringBuilder selectAllPost=new StringBuilder();
		 selectAllPost
		 .append("   select POST_ID, USER_ID, POST_TITLE, CARTEGORY_ID, POST_CONTENT, POST_UPLOAD_DATE, POST_VIEW_NUM, DELETE_STATE")
		.append("   from post                           ")
		.append("where user_id=?                     "); 
		 
		 pstmt = con.prepareStatement(selectAllPost.toString());
		 
		 pstmt.setString(1, id);
		 
		 rs = pstmt.executeQuery();
		
		 while(rs.next()) {
			 pVO =new PostVO();
			 pVO.setPostId(rs.getString("post_id"));
			 pVO.setUserId(rs.getString("user_id"));
			 pVO.setPostTitle(rs.getString("post_title"));
			 pVO.setPostCategory(rs.getString("cartegory_id"));
			 pVO.setPostContent(rs.getString("post_content"));
			 pVO.setPostDate(rs.getDate("post_upload_date"));
			 pVO.setPostViewNum(rs.getInt("post_view_num"));
			 pVO.setDeleteState(rs.getString("delete_state"));
			 
			 allpostList.add(pVO);
		 }
		}finally {
			
		}
		return allpostList;
	}//selectAllPost
	
	public List<PostVO>selectPagePost(String id, int start, int end)throws SQLException{
		List<PostVO> allpostList =new ArrayList<PostVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PostVO pVO=null;
		
		DbConnection db =DbConnection.getInstance();		
		
		try {
			con =db.getConn("jdbc/dbcp");
			
			StringBuilder selectAllPost=new StringBuilder();
			selectAllPost
			.append("	select alldata.*	")
			.append("	from (select row_number() over(order by post_upload_date desc ) num, POST_ID,	")
			.append("	USER_ID, POST_TITLE, c.CARTEGORY_name, POST_CONTENT,POST_UPLOAD_DATE, POST_VIEW_NUM, DELETE_STATE	")
			.append("	from post p, post_cartegory c where p.cartegory_id= c.cartegory_id and  user_id= ?	) alldata	")
			.append("	where num between ? and ?	")
			;
			pstmt = con.prepareStatement(selectAllPost.toString());
			
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				pVO =new PostVO();
				pVO.setPostId(rs.getString("post_id"));
				pVO.setUserId(rs.getString("user_id"));
				pVO.setPostTitle(rs.getString("post_title"));
				pVO.setPostCategory(rs.getString("cartegory_name"));
				pVO.setPostContent(rs.getString("post_content"));
				pVO.setPostDate(rs.getDate("post_upload_date"));
				pVO.setPostViewNum(rs.getInt("post_view_num"));
				pVO.setDeleteState(rs.getString("delete_state"));
				
				allpostList.add(pVO);
			}
		}finally {
			
		}
		return allpostList;
	}//selectAllPost
	public int selectTotalPost(String id) throws SQLException {
		int result = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db =DbConnection.getInstance();		
		
		try {
			con =db.getConn("jdbc/dbcp");
			
			pstmt = con.prepareStatement("	select count(*) cnt from post where user_id = ?	");
			pstmt.setString(1,  id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}//end if
		} finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		return result;
	}//selectTotalPost

}//class
