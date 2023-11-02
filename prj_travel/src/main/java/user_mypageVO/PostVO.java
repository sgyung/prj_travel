package user_mypageVO;

import java.sql.Date;

public class PostVO {
     
	private String postId;
	private String userId;
	private String postTitle;
	private String postCategory;
	private String postContent;
	private Date postDate;
	private int postViewNum;
	private String deleteState;
	
	//getter,setter
	
	public PostVO() {
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
	public int getPostViewNum() {
		return postViewNum;
	}
	public void setPostViewNum(int postViewNum) {
		this.postViewNum = postViewNum;
	}
	public String getDeleteState() {
		return deleteState;
	}
	public void setDeleteState(String deleteState) {
		this.deleteState = deleteState;
	}
	
	@Override
	public String toString() {
		return "PostVO [postId=" + postId + ", userId=" + userId + ", postTitle=" + postTitle + ", postCategory="
				+ postCategory + ", postContent=" + postContent + ", postDate=" + postDate + ", postViewNum="
				+ postViewNum + ", deleteState=" + deleteState + "]";
	}
	public PostVO(String postId, String userId, String postTitle, String postCategory, String postContent,
			Date postDate, int postViewNum, String deleteState) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.postTitle = postTitle;
		this.postCategory = postCategory;
		this.postContent = postContent;
		this.postDate = postDate;
		this.postViewNum = postViewNum;
		this.deleteState = deleteState;
	}
	
}//class
