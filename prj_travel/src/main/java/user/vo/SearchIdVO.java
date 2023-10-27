package user.vo;

public class SearchIdVO {
	private String name,tel;

	public SearchIdVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SearchIdVO(String name, String tel) {
		super();
		this.name = name;
		this.tel = tel;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	@Override
	public String toString() {
		return "SearchIdVO [name=" + name + ", tel=" + tel + "]";
	}
	
}
