package user.vo;

public class SearchPwVO {
	private String id,name,tel;

	public SearchPwVO() {
		super();
	}

	public SearchPwVO(String id, String name, String tel) {
		super();
		this.id = id;
		this.name = name;
		this.tel = tel;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
		return "SearchPwVO [id=" + id + ", name=" + name + ", tel=" + tel + "]";
	}
	
}
