package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.dao.DbConnection;
import user.vo.LoginVO;
import user.vo.SearchIdVO;
import user.vo.SearchPwVO;
import user.vo.UserIdVO;
import user.vo.UserNameVO;
import user.vo.UserIdPwVO;
import user.vo.UserVO;

public class UserDAO {

	private static UserDAO uDAO;
	
	public UserDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public static UserDAO getInstance() {
		if( uDAO == null ) {
			uDAO = new UserDAO();
		}//end if
		return uDAO;
	}//getInstance

	//회원가입 - 중복체크
	public boolean selectId(String id) throws SQLException{
		boolean resultId=false;
		
		DbConnection db = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		try {
		//1. JNDI사용객체 생성
		//2. DataSource 얻기
		//3. Connection 얻기
			con=db.getConn("jdbc/dbcp");
		//4. 쿼리문 생성객체 얻기
			String selectId = "select user_id from T_USER where user_id=?";
			pstmt=con.prepareStatement(selectId);
		//5. 바인드 변수에 값 설정
			pstmt.setString(1, id);
		//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			resultId = rs.next();//조회 결과가 있으면 true 없으면 false
		} finally {
		//7. 연결끊기
			db.dbClose(rs, pstmt, con);
		}
		
		return resultId;
		
	}//selectId
	
	//회원가입 - 입력완료 후 DB에 데이터 삽입
	public void insertUser(UserVO uVO) throws SQLException{
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		//1. JDNI 사용객체 생성
		//2. DataSource 얻기
		//3. Connection 얻기
			con = db.getConn("jdbc/dbcp");
		//4. 쿼리문 생성객체 얻기
			StringBuilder insertUser = new StringBuilder();
			insertUser
			.append("	insert into T_USER									")
			.append("	( user_id, user_pw, user_name, user_birth, user_tel, user_zipcode, user_addr0, user_addr1, user_registration_date, user_registration_state )	")
			.append("	values(?,?,?,?,?,?,?,?,sysdate,?)									");
			
			pstmt=con.prepareStatement(insertUser.toString());
		//5. 바인드 변수 값 설정
			pstmt.setString(1, uVO.getId());
			pstmt.setString(2, uVO.getPw());
			pstmt.setString(3, uVO.getName());
			pstmt.setString(4, uVO.getBirthdate());
			pstmt.setString(5, uVO.getTel());
			pstmt.setString(6, uVO.getZipcode());
			pstmt.setString(7, uVO.getAddr());
			pstmt.setString(8, uVO.getAddrdetail());
			pstmt.setString(9, "Y");
		//6. 쿼리 수행 후 결과 얻기
			pstmt.executeUpdate();
		} finally {
		//7. 연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
	}
	
	//로그인 - 아이디,비밀번호 받고 거기에 맞는 유저 정보(이름) 찾기
	public UserNameVO selectUserLogin( LoginVO lVO )throws SQLException {
		UserNameVO unVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/dbcp");
			//4. 쿼리문 생성객체 얻기
			String selectData = "select user_name from T_USER where user_id=? and user_pw=?";
			pstmt = con.prepareStatement(selectData);
			//5. 바인드변수 값 설정
			pstmt.setString(1, lVO.getId());
			pstmt.setString(2, lVO.getPass());
			//6. 쿼리 실행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {//검색결과 있음
				unVO = new UserNameVO(rs.getString("user_name"));
			}//end if
			
		}finally {
			//7. 연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		return unVO;
	}//selectUserLogin
	
	//아이디 찾기 ( 이름과 전화번호를 받고 해당 유저의 아이디와 가입일을 반환 )
	public UserIdVO selectUserFindId( SearchIdVO siVO )throws SQLException {
		UserIdVO uiVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/dbcp");
			//4. 쿼리문 생성객체 얻기
			String selectData = "select user_id, user_registration_date from T_USER where user_name=? and user_tel=?";
			pstmt = con.prepareStatement(selectData);
			//5. 바인드변수 값 설정
			pstmt.setString(1, siVO.getName());
			pstmt.setString(2, siVO.getTel());
			//6. 쿼리 실행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {//검색결과 있음
				uiVO = new UserIdVO(rs.getString("user_id"), rs.getDate("user_registration_date"));
			}//end if
			
		}finally {
			//7. 연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		return uiVO;
	}//selectUserFindId
	
	//비밀번호 찾기 ( 아이디, 이름, 전화번호를 받고 아이디 , 비밀번호를 반환 )
	public UserIdPwVO selectUserFindPw( SearchPwVO spVO )throws SQLException {
		UserIdPwVO upVO = null;
		
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/dbcp");
			//4. 쿼리문 생성객체 얻기
			String selectData = "select user_id, user_pw from T_USER where user_id=? and user_name=? and user_tel=?";
			pstmt = con.prepareStatement(selectData);
			//5. 바인드변수 값 설정
			pstmt.setString(1, spVO.getId());
			pstmt.setString(2, spVO.getName());
			pstmt.setString(3, spVO.getTel());
			//6. 쿼리 실행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {//검색결과 있음
				upVO = new UserIdPwVO(rs.getString("user_id"),rs.getString("user_pw"));
			}//end if
			
		}finally {
			//7. 연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		return upVO;
	}//selectUserFindId
	
	//비밀번호변경 ( 아이디와 새로운 비밀번호를 받아서 아이디에 해당하는 비밀번호를 새로운 비밀번호로 update )
	public void updateUserFindPw(UserIdPwVO uipVO) throws SQLException{
		DbConnection db = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		//1. JDNI 사용객체 생성
		//2. DataSource 얻기
		//3. Connection 얻기
			con = db.getConn("jdbc/dbcp");
		//4. 쿼리문 생성객체 얻기
			StringBuilder insertUser = new StringBuilder();
			insertUser
			.append("	update T_USER	")
			.append("	set	user_pw=?	")
			.append("	where user_id=?	");
			
			pstmt=con.prepareStatement(insertUser.toString());
		//5. 바인드 변수 값 설정
			pstmt.setString(1, uipVO.getPw());
			pstmt.setString(2, uipVO.getId());
			
		//6. 쿼리 수행 후 결과 얻기
			pstmt.executeUpdate();
		} finally {
		//7. 연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
	}
	
	
}//class


