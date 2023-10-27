package admin.vo;

import java.util.Date;

public class PostVO {
	
	private String postId;
	private String userId;
	private String postTitle;
	private String postCategory;
	private String postContent;
	private Date postDate;
	private String postState;
	private int postViewNum;
	
	public PostVO() {
		
	}

	public PostVO(String postId, String userId, String postTitle, String postCategory, String postContent,
			Date postDate, String postState, int postViewNum) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.postTitle = postTitle;
		this.postCategory = postCategory;
		this.postContent = postContent;
		this.postDate = postDate;
		this.postState = postState;
		this.postViewNum = postViewNum;
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

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostCategory() {
		return postCategory;
	}

	public void setPostCategory(String postCategory) {
		this.postCategory = postCategory;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	public String getPostState() {
		return postState;
	}

	public void setPostState(String postState) {
		this.postState = postState;
	}

	public int getPostViewNum() {
		return postViewNum;
	}

	public void setPostViewNum(int postViewNum) {
		this.postViewNum = postViewNum;
	}

	@Override
	public String toString() {
		return "PostVO [postId=" + postId + ", userId=" + userId + ", postTitle=" + postTitle + ", postCategory="
				+ postCategory + ", postContent=" + postContent + ", postDate=" + postDate + ", postState=" + postState
				+ ", postViewNum=" + postViewNum + "]";
	}

	
	
	
}
