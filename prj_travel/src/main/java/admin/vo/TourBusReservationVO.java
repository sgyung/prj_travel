package admin.vo;

import java.sql.Date;

public class TourBusReservationVO {
	private String reservationId,userId,tourBusId,reservationState,reservationTime,tourBusName;
	private Date reservationDate,reservationInputDate;
	private int adult,child,totalSeat;
	
	public TourBusReservationVO() {
		
	}

	public TourBusReservationVO(String reservationId, String userId, String tourBusId, String reservationState,
			String reservationTime, String tourBusName, Date reservationDate, Date reservationInputDate, int adult,
			int child, int totalSeat) {
		super();
		this.reservationId = reservationId;
		this.userId = userId;
		this.tourBusId = tourBusId;
		this.reservationState = reservationState;
		this.reservationTime = reservationTime;
		this.tourBusName = tourBusName;
		this.reservationDate = reservationDate;
		this.reservationInputDate = reservationInputDate;
		this.adult = adult;
		this.child = child;
		this.totalSeat = totalSeat;
	}

	public String getReservationId() {
		return reservationId;
	}

	public void setReservationId(String reservationId) {
		this.reservationId = reservationId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTourBusId() {
		return tourBusId;
	}

	public void setTourBusId(String tourBusId) {
		this.tourBusId = tourBusId;
	}

	public String getReservationState() {
		return reservationState;
	}

	public void setReservationState(String reservationState) {
		this.reservationState = reservationState;
	}

	public String getReservationTime() {
		return reservationTime;
	}

	public void setReservationTime(String reservationTime) {
		this.reservationTime = reservationTime;
	}

	public String getTourBusName() {
		return tourBusName;
	}

	public void setTourBusName(String tourBusName) {
		this.tourBusName = tourBusName;
	}

	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}

	public Date getReservationInputDate() {
		return reservationInputDate;
	}

	public void setReservationInputDate(Date reservationInputDate) {
		this.reservationInputDate = reservationInputDate;
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

	public int getTotalSeat() {
		return totalSeat;
	}

	public void setTotalSeat(int totalSeat) {
		this.totalSeat = totalSeat;
	}

	@Override
	public String toString() {
		return "TourBusReservationVO [reservationId=" + reservationId + ", userId=" + userId + ", tourBusId="
				+ tourBusId + ", reservationState=" + reservationState + ", reservationTime=" + reservationTime
				+ ", tourBusName=" + tourBusName + ", reservationDate=" + reservationDate + ", reservationInputDate="
				+ reservationInputDate + ", adult=" + adult + ", child=" + child + ", totalSeat=" + totalSeat + "]";
	}


	
}
