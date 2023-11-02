package user_mypageVO;

import java.sql.Date;

public class QandAVO {
 
	private String qandAId;
	private String areaId;
	private String userId;
	private String title;
	private String category;
	private String content;
	private String state;
	private Date registrationDate;
	private String answer;
	private char answerType;
	private Date answerDate;
	
	//getter,settter
	public String getQandAId() {
		return qandAId;
	}
	public void setQandAId(String qandAId) {
		this.qandAId = qandAId;
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
	public char getAnswerType() {
		return answerType;
	}
	public void setAnswerType(char answerType) {
		this.answerType = answerType;
	}
	public Date getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}
	
	public QandAVO() {
	}
	@Override
	public String toString() {
		return "QandAVO [qandAId=" + qandAId + ", areaId=" + areaId + ", userId=" + userId + ", title=" + title
				+ ", category=" + category + ", content=" + content + ", state=" + state + ", registrationDate="
				+ registrationDate + ", answer=" + answer + ", answerType=" + answerType + ", answerDate=" + answerDate
				+ "]";
	}
	public QandAVO(String qandAId, String areaId, String userId, String title, String category, String content,
			String state, Date registrationDate, String answer, char answerType, Date answerDate) {
		super();
		this.qandAId = qandAId;
		this.areaId = areaId;
		this.userId = userId;
		this.title = title;
		this.category = category;
		this.content = content;
		this.state = state;
		this.registrationDate = registrationDate;
		this.answer = answer;
		this.answerType = answerType;
		this.answerDate = answerDate;
	}
	
}
