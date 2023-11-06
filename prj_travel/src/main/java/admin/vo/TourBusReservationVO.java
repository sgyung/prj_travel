package admin.vo;

import java.sql.Date;

public class TourBusReservationVO {
	private String reservationId,userId,tourBusId,reservationState;
	private Date tourBusTime,tourBusDate,reservationDate;
	private int adult,child;
	
	public TourBusReservationVO() {
		
	}

	public TourBusReservationVO(String reservationId, String userId, String tourBusId, String reservationState,
			Date tourBusTime, Date tourBusDate, Date reservationDate, int adult, int child) {
		super();
		this.reservationId = reservationId;
		this.userId = userId;
		this.tourBusId = tourBusId;
		this.reservationState = reservationState;
		this.tourBusTime = tourBusTime;
		this.tourBusDate = tourBusDate;
		this.reservationDate = reservationDate;
		this.adult = adult;
		this.child = child;
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

	public Date getTourBusTime() {
		return tourBusTime;
	}

	public void setTourBusTime(Date tourBusTime) {
		this.tourBusTime = tourBusTime;
	}

	public Date getTourBusDate() {
		return tourBusDate;
	}

	public void setTourBusDate(Date tourBusDate) {
		this.tourBusDate = tourBusDate;
	}

	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
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
		return "TourBusReservationVO [reservationId=" + reservationId + ", userId=" + userId + ", tourBusId="
				+ tourBusId + ", reservationState=" + reservationState + ", tourBusTime=" + tourBusTime
				+ ", tourBusDate=" + tourBusDate + ", reservationDate=" + reservationDate + ", adult=" + adult
				+ ", child=" + child + "]";
	}
	
	
}
