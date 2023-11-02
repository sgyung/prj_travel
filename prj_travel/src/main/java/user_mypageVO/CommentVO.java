package user_mypageVO;

import java.util.Date;

public class CommentVO {
	
	private String commentId;
	private String userId;
	private String postId;
	private String content;
	private String user;
	private Date registrationDate;
	
	public CommentVO() {
		
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

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
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
				+ content + ", user=" + user + ", registrationDate=" + registrationDate + "]";
	}

	public CommentVO(String commentId, String userId, String postId, String content, String user,
			Date registrationDate) {
		super();
		this.commentId = commentId;
		this.userId = userId;
		this.postId = postId;
		this.content = content;
		this.user = user;
		this.registrationDate = registrationDate;
	}
	
}
