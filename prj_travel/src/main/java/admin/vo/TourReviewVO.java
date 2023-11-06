package admin.vo;

import java.sql.Date;

public class TourReviewVO {
	private String reviewId;
	private String userId;
	private Date reviewDate;
	private int starScore;
	private String content;
	private String touristAreaId;
	private String tourAreaName;
	private int reviewCnt;
	
	public TourReviewVO(){
	
	}

	public TourReviewVO(String reviewId, String userId, Date reviewDate, int starScore, String content,
			String touristAreaId, String tourAreaName, int reviewCnt) {
		super();
		this.reviewId = reviewId;
		this.userId = userId;
		this.reviewDate = reviewDate;
		this.starScore = starScore;
		this.content = content;
		this.touristAreaId = touristAreaId;
		this.tourAreaName = tourAreaName;
		this.reviewCnt = reviewCnt;
	}

	public String getReviewId() {
		return reviewId;
	}

	public void setReviewId(String reviewId) {
		this.reviewId = reviewId;
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

	public String getTouristAreaId() {
		return touristAreaId;
	}

	public void setTouristAreaId(String touristAreaId) {
		this.touristAreaId = touristAreaId;
	}

	public String getTourAreaName() {
		return tourAreaName;
	}

	public void setTourAreaName(String tourAreaName) {
		this.tourAreaName = tourAreaName;
	}

	public int getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	@Override
	public String toString() {
		return "TourReviewVO [reviewId=" + reviewId + ", userId=" + userId + ", reviewDate=" + reviewDate
				+ ", starScore=" + starScore + ", content=" + content + ", touristAreaId=" + touristAreaId
				+ ", tourAreaName=" + tourAreaName + ", reviewCnt=" + reviewCnt + "]";
	}

	

	
	
	
}
