package user_mypageVO;

import java.sql.Date;

public class ReviewVO {
 
	private String ReviewId;
	private String userId;
	private Date reviewDate;
	private int starScore;
	private String content;
	private String typeId;
	
	//getter,setter
	public String getReviewId() {
		return ReviewId;
	}
	public void setReviewId(String reviewId) {
		ReviewId = reviewId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getStarScore() {
		return starScore;
	}
	public void setStarScore(int starScore) {
		this.starScore = starScore;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
 	
	public ReviewVO() {
	}
	@Override
	public String toString() {
		return "ReviewVO [ReviewId=" + ReviewId + ", userId=" + userId + ", reviewDate=" + reviewDate + ", starScore="
				+ starScore + ", content=" + content + ", typeId=" + typeId + "]";
	}
	public ReviewVO(String reviewId, String userId, Date reviewDate, int starScore, String content, String typeId) {
		super();
		ReviewId = reviewId;
		this.userId = userId;
		this.reviewDate = reviewDate;
		this.starScore = starScore;
		this.content = content;
		this.typeId = typeId;
	}
	
}
