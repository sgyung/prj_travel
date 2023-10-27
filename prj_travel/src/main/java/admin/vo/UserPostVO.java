package admin.vo;

import java.sql.Date;

public class UserPostVO {
	private String postId;
	private String userId;
	private String userName;
	private String title;
	private String category;
	private String content;
	private Date postDate;
	private int viewNum;
	
	public UserPostVO() {
		
	}

	public UserPostVO(String postId, String userId, String userName, String title, String category, String content,
			Date postDate, int viewNum) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.userName = userName;
		this.title = title;
		this.category = category;
		this.content = content;
		this.postDate = postDate;
		this.viewNum = viewNum;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	@Override
	public String toString() {
		return "PostVO [postId=" + postId + ", userId=" + userId + ", userName=" + userName + ", title=" + title
				+ ", category=" + category + ", content=" + content + ", postDate=" + postDate + ", viewNum=" + viewNum
				+ "]";
	}

	
	
}
