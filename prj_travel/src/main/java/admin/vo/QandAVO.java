package admin.vo;

import java.util.Date;

public class QandAVO {
	private String qAndAId;
	private String areaId;
	private String userId;
	private String restaurantId;
	private String title;
	private String category;
	private String content;
	private String state;
	private Date registrationDate;
	private String answer;
	private String answerType;
	private Date answerDate;
	
	public QandAVO() {
		
	}

	public QandAVO(String qAndAId, String areaId, String userId, String restaurantId, String title,
			String category, String content, String state, Date registrationDate, String answer, String answerType,
			Date answerDate) {
		super();
		this.qAndAId = qAndAId;
		this.areaId = areaId;
		this.userId = userId;
		this.restaurantId = restaurantId;
		this.title = title;
		this.category = category;
		this.content = content;
		this.state = state;
		this.registrationDate = registrationDate;
		this.answer = answer;
		this.answerType = answerType;
		this.answerDate = answerDate;
	}

	public String getQAndAId() {
		return qAndAId;
	}

	public void setQAndAId(String qAndAId) {
		this.qAndAId = qAndAId;
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

	public String getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(String restaurantId) {
		this.restaurantId = restaurantId;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
	}

	public Date getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}

	@Override
	public String toString() {
		return "QuestionBoardVO [qAndAId=" + qAndAId + ", areaId=" + areaId + ", userId=" + userId + ", restaurantId="
				+ restaurantId + ", title=" + title + ", category=" + category + ", content=" + content + ", state="
				+ state + ", registrationDate=" + registrationDate + ", answer=" + answer + ", answerType=" + answerType
				+ ", answerDate=" + answerDate + "]";
	}

	
	
}
