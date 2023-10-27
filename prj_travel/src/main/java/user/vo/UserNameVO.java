package user.vo;

public class UserNameVO {
	private String name;
		
		
	//로그인 후 헤더에 이름 나오게 하기위한
	public UserNameVO() {
		super();
	}


	public UserNameVO(String name) {
		super();
		this.name = name;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	@Override
	public String toString() {
		return "UserNameVO [name=" + name + "]";
	}
	
}
