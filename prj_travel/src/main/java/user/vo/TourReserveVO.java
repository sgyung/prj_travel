package user.vo;

import java.sql.Date;

public class TourReserveVO {
	private String reserveId, userId, tourId, name, time, state;
	private Date reserveDate, registDate;
	private int adult, child;
	
	
	public TourReserveVO() {
		super();
	}


	public TourReserveVO(String reserveId, String userId, String tourId, String name, String time, String state,
			Date reserveDate, Date registDate, int adult, int child) {
		super();
		this.reserveId = reserveId;
		this.userId = userId;
		this.tourId = tourId;
		this.name = name;
		this.time = time;
		this.state = state;
		this.reserveDate = reserveDate;
		this.registDate = registDate;
		this.adult = adult;
		this.child = child;
	}


	public String getReserveId() {
		return reserveId;
	}


	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getTourId() {
		return tourId;
	}


	public void setTourId(String tourId) {
		this.tourId = tourId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public Date getReserveDate() {
		return reserveDate;
	}


	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}


	public Date getRegistDate() {
		return registDate;
	}


	public void setRegistDate(Date registDate) {
		this.registDate = registDate;
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


	@Override
	public String toString() {
		return "TourReserveVO [reserveId=" + reserveId + ", userId=" + userId + ", tourId=" + tourId + ", name=" + name
				+ ", time=" + time + ", state=" + state + ", reserveDate=" + reserveDate + ", registDate=" + registDate
				+ ", adult=" + adult + ", child=" + child + "]";
	}


	
}
