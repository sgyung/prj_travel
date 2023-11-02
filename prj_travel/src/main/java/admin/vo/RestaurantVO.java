package admin.vo;

import java.sql.Date;

public class RestaurantVO {
	private String id,name,addr,tel,serviceHour,detailInfo,image;
	private double longitude,latitude;
	private int starScore,like,reviewCount,viewNum;
	private Date registraitionDate;
	
	public RestaurantVO() {
		
	}

	public RestaurantVO(String id, String name, String addr, String tel, String serviceHour, String detailInfo,
			String image, double longitude, double latitude, int starScore, int like, int reviewCount, int viewNum,
			Date registraitionDate) {
		super();
		this.id = id;
		this.name = name;
		this.addr = addr;
		this.tel = tel;
		this.serviceHour = serviceHour;
		this.detailInfo = detailInfo;
		this.image = image;
		this.longitude = longitude;
		this.latitude = latitude;
		this.starScore = starScore;
		this.like = like;
		this.reviewCount = reviewCount;
		this.viewNum = viewNum;
		this.registraitionDate = registraitionDate;
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

	public String getDetailInfo() {
		return detailInfo;
	}

	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
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

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	public Date getRegistraitionDate() {
		return registraitionDate;
	}

	public void setRegistraitionDate(Date registraitionDate) {
		this.registraitionDate = registraitionDate;
	}

	@Override
	public String toString() {
		return "RestaurantVO [id=" + id + ", name=" + name + ", addr=" + addr + ", tel=" + tel + ", serviceHour="
				+ serviceHour + ", detailInfo=" + detailInfo + ", image=" + image + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", starScore=" + starScore + ", like=" + like + ", reviewCount="
				+ reviewCount + ", viewNum=" + viewNum + ", registraitionDate=" + registraitionDate + "]";
	}
	
	
}
