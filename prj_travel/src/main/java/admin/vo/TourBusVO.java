package admin.vo;

import java.sql.Date;
import java.util.Arrays;

public class TourBusVO {
	private String id,name,tel,image,routes,operationState,busTourTime,dispatchTimes;
	private String[] route;
	private String[] dispatchTime; 
	private Date startTime,endTime,registrationTime;
	private int totalSeat,adultFare,childFare;
	
	public TourBusVO() {
		
	}

	public TourBusVO(String id, String name, String tel, String image, String routes, String operationState,
			String busTourTime, String dispatchTimes, String[] route, String[] dispatchTime, Date startTime,
			Date endTime, Date registrationTime, int totalSeat, int adultFare, int childFare) {
		super();
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.image = image;
		this.routes = routes;
		this.operationState = operationState;
		this.busTourTime = busTourTime;
		this.dispatchTimes = dispatchTimes;
		this.route = route;
		this.dispatchTime = dispatchTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.registrationTime = registrationTime;
		this.totalSeat = totalSeat;
		this.adultFare = adultFare;
		this.childFare = childFare;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getRoutes() {
		return routes;
	}

	public void setRoutes(String routes) {
		this.routes = routes;
	}

	public String getOperationState() {
		return operationState;
	}

	public void setOperationState(String operationState) {
		this.operationState = operationState;
	}

	public String getBusTourTime() {
		return busTourTime;
	}

	public void setBusTourTime(String busTourTime) {
		this.busTourTime = busTourTime;
	}

	public String getDispatchTimes() {
		return dispatchTimes;
	}

	public void setDispatchTimes(String dispatchTimes) {
		this.dispatchTimes = dispatchTimes;
	}

	public String[] getRoute() {
		return route;
	}

	public void setRoute(String[] route) {
		this.route = route;
	}

	public String[] getDispatchTime() {
		return dispatchTime;
	}

	public void setDispatchTime(String[] dispatchTime) {
		this.dispatchTime = dispatchTime;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getRegistrationTime() {
		return registrationTime;
	}

	public void setRegistrationTime(Date registrationTime) {
		this.registrationTime = registrationTime;
	}

	public int getTotalSeat() {
		return totalSeat;
	}

	public void setTotalSeat(int totalSeat) {
		this.totalSeat = totalSeat;
	}

	public int getAdultFare() {
		return adultFare;
	}

	public void setAdultFare(int adultFare) {
		this.adultFare = adultFare;
	}

	public int getChildFare() {
		return childFare;
	}

	public void setChildFare(int childFare) {
		this.childFare = childFare;
	}

	@Override
	public String toString() {
		return "TourBusVO [id=" + id + ", name=" + name + ", tel=" + tel + ", image=" + image + ", routes=" + routes
				+ ", operationState=" + operationState + ", busTourTime=" + busTourTime + ", dispatchTimes="
				+ dispatchTimes + ", route=" + Arrays.toString(route) + ", dispatchTime="
				+ Arrays.toString(dispatchTime) + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", registrationTime=" + registrationTime + ", totalSeat=" + totalSeat + ", adultFare=" + adultFare
				+ ", childFare=" + childFare + "]";
	}

	
	
	
}
