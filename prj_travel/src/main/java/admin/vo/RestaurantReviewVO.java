package admin.vo;

import java.sql.Date;

public class RestaurantReviewVO {
	private String reviewId;
	private String userId;
	private Date reviewDate;
	private int starScore;
	private String content;
	private String restaurantId;
	private String restaurantName;
	private int reviewCnt;
	
	public RestaurantReviewVO() {
		
	}

	public RestaurantReviewVO(String reviewId, String userId, Date reviewDate, int starScore, String content,
			String restaurantId, String restaurantName, int reviewCnt) {
		super();
		this.reviewId = reviewId;
		this.userId = userId;
		this.reviewDate = reviewDate;
		this.starScore = starScore;
		this.content = content;
		this.restaurantId = restaurantId;
		this.restaurantName = restaurantName;
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

	public String getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(String restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public int getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	@Override
	public String toString() {
		return "RestaurantReviewVO [reviewId=" + reviewId + ", userId=" + userId + ", reviewDate=" + reviewDate
				+ ", starScore=" + starScore + ", content=" + content + ", restaurantId=" + restaurantId
				+ ", restaurantName=" + restaurantName + ", reviewCnt=" + reviewCnt + "]";
	}

	
}
