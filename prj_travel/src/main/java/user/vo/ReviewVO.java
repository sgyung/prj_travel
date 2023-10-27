package user.vo;

import java.sql.Date;

public class ReviewVO {
	private String reviewId , areaId, userId, content;
	private Date date;
	private int starScore;
	
	public ReviewVO() {
	}

	public ReviewVO(String reviewId, String areaId, String userId, String content, Date date, int starScore) {
		this.reviewId = reviewId;
		this.areaId = areaId;
		this.userId = userId;
		this.content = content;
		this.date = date;
		this.starScore = starScore;
	}

	
	@Override
	public String toString() {
		return "ReviewVO [reviewId=" + reviewId + ", touristAreaId=" + areaId + ", userId=" + userId
				+ ", content=" + content + ", date=" + date + ", starScore=" + starScore + "]";
	}

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getStarScore() {
		return starScore;
	}

	public void setStarScore(int starScore) {
		this.starScore = starScore;
	}

	public String getReviewId() {
		return reviewId;
	}

	public void setReviewId(String reviewId) {
		this.reviewId = reviewId;
	}
	
	
	
}//class
