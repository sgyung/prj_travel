package admin.vo;

import java.util.Date;

public class UserCommentVO {
	private String commentId;
	private String userId;
	private String userName;
	private String postId;
	private String content;
	private Date registrationDate;
	
	public UserCommentVO() {
		
	}

	public UserCommentVO(String commentId, String userId, String userName, String postId, String content,
			Date registrationDate) {
		super();
		this.commentId = commentId;
		this.userId = userId;
		this.userName = userName;
		this.postId = postId;
		this.content = content;
		this.registrationDate = registrationDate;
	}

	public String getCommentId() {
		return commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
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

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	@Override
	public String toString() {
		return "UserCommentVO [commentId=" + commentId + ", userId=" + userId + ", userName=" + userName + ", postId="
				+ postId + ", content=" + content + ", registrationDate=" + registrationDate + "]";
	}
	
	
}
