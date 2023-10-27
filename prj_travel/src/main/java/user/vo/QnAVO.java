package user.vo;

import java.sql.Date;

public class QnAVO {
	private String qnaId, areaId, userId, title, category, content, state, answer, answerType;
	private Date registrationDate, answerDate;
	private int totalCnt;
	
	public QnAVO() {
	}

	public QnAVO(String qnaId, String areaId, String userId, String title, String category, String content,
			String state, Date registrationDate, String answer, String answerType, Date answerDate, int totalCnt) {
		this.qnaId = qnaId;
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
		this.totalCnt = totalCnt;
	}

	public String getQnaId() {
		return qnaId;
	}

	public void setQnaId(String qnaId) {
		this.qnaId = qnaId;
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

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	@Override
	public String toString() {
		return "QnAVO [qnaId=" + qnaId + ", areaId=" + areaId + ", userId=" + userId + ", title=" + title
				+ ", category=" + category + ", content=" + content + ", state=" + state + ", registrationDate="
				+ registrationDate + ", answer=" + answer + ", answerType=" + answerType + ", answerDate=" + answerDate
				+ ", totalCnt=" + totalCnt + "]";
	}
	
}//class
