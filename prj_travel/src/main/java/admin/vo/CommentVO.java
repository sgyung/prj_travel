package admin.vo;

import java.util.Date;

public class CommentVO {
	
	private String commentId;
	private String userId;
	private String postId;
	private String content;
	private Date registrationDate;
	
	public CommentVO() {
		
	}

	public CommentVO(String commentId, String userId, String postId, String content, Date registrationDate) {
		this.commentId = commentId;
		this.userId = userId;
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
		return "CommentVO [commentId=" + commentId + ", userId=" + userId + ", postId=" + postId + ", content="
				+ content + ", registrationDate=" + registrationDate + "]";
	}
	
	
}
