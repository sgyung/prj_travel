package user.vo;

import java.sql.Date;

public class MyTourBusVO {
	private String id, name, state, reservedTime;
	private Date reservedDate;
	private int adult, child;
	
	public MyTourBusVO() {
		super();
	}
	public MyTourBusVO(String id, String name, String state, String reservedTime, Date reservedDate, int adult, int child) {
		super();
		this.id = id;
		this.name = name;
		this.state = state;
		this.reservedTime = reservedTime;
		this.reservedDate = reservedDate;
		this.adult = adult;
		this.child = child;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReservedTime() {
		return reservedTime;
	}
	public void setReservedTime(String reservedTime) {
		this.reservedTime = reservedTime;
	}
	public Date getReservedDate() {
		return reservedDate;
	}
	public void setReservedDate(Date reservedDate) {
		this.reservedDate = reservedDate;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "MyTourBusVO [id=" + id + ", name=" + name + ", state=" + state + ", reservedTime=" + reservedTime
				+ ", reservedDate=" + reservedDate + ", adult=" + adult + ", child=" + child + "]";
	}
	
}//class
