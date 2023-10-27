package user.vo;

public class UserIdPwVO {
	private String id,pw;

	public UserIdPwVO() {
		super();
	}

	public UserIdPwVO(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	@Override
	public String toString() {
		return "UserIdPwVO [id=" + id + ", pw=" + pw + "]";
	}
	
}
