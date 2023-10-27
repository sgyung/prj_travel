package user.vo;

import java.sql.Date;

public class UserIdVO {
	private String id;
	private Date joindate;
	
	public UserIdVO() {
		super();
	}

	//계정찾기 후 아이디,가입일자 나오게 하기위한
	public UserIdVO(String id, Date joindate) {
		super();
		this.id = id;
		this.joindate = joindate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

	@Override
	public String toString() {
		return "UserIdVO [id=" + id + ", joindate=" + joindate + "]";
	}
	
}
