package user.vo;

import java.util.Date;

public class RestaurantVO {
	private String id, name, addr, tel, serviceHour, priceInfo, slope, image, thumbNail, deleteState, tags;
	private Double longitude, latitude;
	private int starScore, like, reviewCnt, viewNum;
	private Date inputDate;
	
	public RestaurantVO() {
		super();
	}

	public RestaurantVO(String id, String name, String addr, String tel, String serviceHour, String priceInfo,
			String slope, String image, String thumbNail, String deleteState, String tags, Double longitude,
			Double latitude, int starScore, int like, int reviewCnt, int viewNum, Date inputDate) {
		super();
		this.id = id;
		this.name = name;
		this.addr = addr;
		this.tel = tel;
		this.serviceHour = serviceHour;
		this.priceInfo = priceInfo;
		this.slope = slope;
		this.image = image;
		this.thumbNail = thumbNail;
		this.deleteState = deleteState;
		this.tags = tags;
		this.longitude = longitude;
		this.latitude = latitude;
		this.starScore = starScore;
		this.like = like;
		this.reviewCnt = reviewCnt;
		this.viewNum = viewNum;
		this.inputDate = inputDate;
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

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getServiceHour() {
		return serviceHour;
	}

	public void setServiceHour(String serviceHour) {
		this.serviceHour = serviceHour;
	}

	public String getPriceInfo() {
		return priceInfo;
	}

	public void setPriceInfo(String priceInfo) {
		this.priceInfo = priceInfo;
	}

	public String getSlope() {
		return slope;
	}

	public void setSlope(String slope) {
		this.slope = slope;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getThumbNail() {
		return thumbNail;
	}

	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}

	public String getDeleteState() {
		return deleteState;
	}

	public void setDeleteState(String deleteState) {
		this.deleteState = deleteState;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public int getStarScore() {
		return starScore;
	}

	public void setStarScore(int starScore) {
		this.starScore = starScore;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	@Override
	public String toString() {
		return "RestaurantVO [id=" + id + ", name=" + name + ", addr=" + addr + ", tel=" + tel + ", serviceHour="
				+ serviceHour + ", priceInfo=" + priceInfo + ", slope=" + slope + ", image=" + image + ", thumbNail="
				+ thumbNail + ", deleteState=" + deleteState + ", tags=" + tags + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", starScore=" + starScore + ", like=" + like + ", reviewCnt=" + reviewCnt
				+ ", viewNum=" + viewNum + ", inputDate=" + inputDate + "]";
	}
	
}//class
