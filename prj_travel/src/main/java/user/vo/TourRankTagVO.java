package user.vo;

public class TourRankTagVO {
	private String id, name, thumbNail, tags;

	public TourRankTagVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TourRankTagVO(String id, String name, String thumbNail, String tags) {
		super();
		this.id = id;
		this.name = name;
		this.thumbNail = thumbNail;
		this.tags = tags;
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

	public String getThumbNail() {
		return thumbNail;
	}

	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	@Override
	public String toString() {
		return "TourRankTagVO [id=" + id + ", name=" + name + ", thumbNail=" + thumbNail + ", tags=" + tags + "]";
	}
	
}
