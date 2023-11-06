package user.vo;

public class TourReservedDetailVO {
	String reserveDate, reserveTime, userName, tourName;
	int reserveAdult, reserveChild;
	public TourReservedDetailVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TourReservedDetailVO(String reserveDate, String reserveTime, String userName, String tourName,
			int reserveAdult, int reserveChild) {
		super();
		this.reserveDate = reserveDate;
		this.reserveTime = reserveTime;
		this.userName = userName;
		this.tourName = tourName;
		this.reserveAdult = reserveAdult;
		this.reserveChild = reserveChild;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getReserveTime() {
		return reserveTime;
	}
	public void setReserveTime(String reserveTime) {
		this.reserveTime = reserveTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTourName() {
		return tourName;
	}
	public void setTourName(String tourName) {
		this.tourName = tourName;
	}
	public int getReserveAdult() {
		return reserveAdult;
	}
	public void setReserveAdult(int reserveAdult) {
		this.reserveAdult = reserveAdult;
	}
	public int getReserveChild() {
		return reserveChild;
	}
	public void setReserveChild(int reserveChild) {
		this.reserveChild = reserveChild;
	}
	
}