package user.vo;

import java.sql.Date;

public class QuestionVO {
	private String userId, areaId, title, type, content;
	
	public QuestionVO() {
	}

	public QuestionVO(String userId, String areaId, String title, String type, String content) {
		super();
		this.userId = userId;
		this.areaId = areaId;
		this.title = title;
		this.type = type;
		this.content = content;
	}

	@Override
	public String toString() {
		return "QuestionVO [userId=" + userId + ", areaId=" + areaId + ", title=" + title + ", type=" + type
				+ ", content=" + content + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	
}//class
