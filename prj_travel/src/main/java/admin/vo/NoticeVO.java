package admin.vo;

import java.util.Date;

public class NoticeVO {

	private String id;
	private String title;
	private String content;
	private int viewNum;
	private Date registrationDate;
	
	public NoticeVO() {
		
	}

	public NoticeVO(String id, String title, String content, int viewNum, Date registrationDate) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.viewNum = viewNum;
		this.registrationDate = registrationDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	@Override
	public String toString() {
		return "NoticeVO [id=" + id + ", title=" + title + ", content=" + content + ", viewNum=" + viewNum
				+ ", registrationDate=" + registrationDate + "]";
	}
	
	
}
