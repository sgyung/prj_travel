package admin.vo;

public class TagVO {
	private String id;
	private String tagName;
	
	public TagVO() {
		
	}

	public TagVO(String id, String tagName) {
		super();
		this.id = id;
		this.tagName = tagName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	@Override
	public String toString() {
		return "TagVO [id=" + id + ", tagName=" + tagName + "]";
	}

	
	
	
}
