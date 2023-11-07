package admin.vo;

public class ReservationCountVO {

	private String tourName;
	private String tourbusId;
	private int unapprovedCount;
	
	public ReservationCountVO() {
	
	}

	public ReservationCountVO(String tourName, String tourbusId, int unapprovedCount) {
		super();
		this.tourName = tourName;
		this.tourbusId = tourbusId;
		this.unapprovedCount = unapprovedCount;
	}

	public String getTourName() {
		return tourName;
	}

	public void setTourName(String tourName) {
		this.tourName = tourName;
	}

	public String getTourbusId() {
		return tourbusId;
	}

	public void setTourbusId(String tourbusId) {
		this.tourbusId = tourbusId;
	}

	public int getUnapprovedCount() {
		return unapprovedCount;
	}

	public void setUnapprovedCount(int unapprovedCount) {
		this.unapprovedCount = unapprovedCount;
	}

	@Override
	public String toString() {
		return "ReservationCountVO [tourName=" + tourName + ", tourbusId=" + tourbusId + ", unapprovedCount="
				+ unapprovedCount + "]";
	}

	
	
	
	
}
