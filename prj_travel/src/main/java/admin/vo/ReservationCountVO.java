package admin.vo;

public class ReservationCountVO {

	private String tourName;
	private int unapprovedCount;
	
	public ReservationCountVO() {
	
	}

	public ReservationCountVO(String tourName, int unapprovedCount) {
		this.tourName = tourName;
		this.unapprovedCount = unapprovedCount;
	}

	public String getTourName() {
		return tourName;
	}

	public void setTourName(String tourName) {
		this.tourName = tourName;
	}

	public int getUnapprovedCount() {
		return unapprovedCount;
	}

	public void setUnapprovedCount(int unapprovedCount) {
		this.unapprovedCount = unapprovedCount;
	}

	@Override
	public String toString() {
		return "ReservationCountVO [tourName=" + tourName + ", unapprovedCount=" + unapprovedCount + "]";
	}
	
	
	
}
