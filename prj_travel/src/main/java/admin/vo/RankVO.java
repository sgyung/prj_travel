package admin.vo;

public class RankVO {

	private String name;
	private int like;
	
	public RankVO() {
		
	}

	public RankVO(String name, int like) {
		this.name = name;
		this.like = like;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	@Override
	public String toString() {
		return "RankVO [name=" + name + ", like=" + like + "]";
	}
	
	
	
}
