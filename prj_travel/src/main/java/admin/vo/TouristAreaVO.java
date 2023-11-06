package admin.vo;

import java.sql.Date;
import java.util.Arrays;

public class TouristAreaVO {
	private String id,name,addr,tel,serviceHour,priceInfo,slope,detailInfo,image,thumbnail,deleteState,tags,conveniences;
	private String[] tagName,convenienceName; 
	private double longitude,latitude;
	private int starScore,like,reviewCount,viewNum;
	private Date registraitionDate;
	
	public TouristAreaVO() {
		
	}

	public TouristAreaVO(String id, String name, String addr, String tel, String serviceHour, String priceInfo,
			String slope, String detailInfo, String image, String thumbnail, String deleteState, String tags,
			String conveniences, String[] tagName, String[] convenienceName, double longitude, double latitude,
			int starScore, int like, int reviewCount, int viewNum, Date registraitionDate) {
		super();
		this.id = id;
		this.name = name;
		this.addr = addr;
		this.tel = tel;
		this.serviceHour = serviceHour;
		this.priceInfo = priceInfo;
		this.slope = slope;
		this.detailInfo = detailInfo;
		this.image = image;
		this.thumbnail = thumbnail;
		this.deleteState = deleteState;
		this.tags = tags;
		this.conveniences = conveniences;
		this.tagName = tagName;
		this.convenienceName = convenienceName;
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

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
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

	public String getConveniences() {
		return conveniences;
	}

	public void setConveniences(String conveniences) {
		this.conveniences = conveniences;
	}

	public String[] getTagName() {
		return tagName;
	}

	public void setTagName(String[] tagName) {
		this.tagName = tagName;
	}

	public String[] getConvenienceName() {
		return convenienceName;
	}

	public void setConvenienceName(String[] convenienceName) {
		this.convenienceName = convenienceName;
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
		return "TouristAreaVO [id=" + id + ", name=" + name + ", addr=" + addr + ", tel=" + tel + ", serviceHour="
				+ serviceHour + ", priceInfo=" + priceInfo + ", slope=" + slope + ", detailInfo=" + detailInfo
				+ ", image=" + image + ", thumbnail=" + thumbnail + ", deleteState=" + deleteState + ", tags=" + tags
				+ ", conveniences=" + conveniences + ", tagName=" + Arrays.toString(tagName) + ", convenienceName="
				+ Arrays.toString(convenienceName) + ", longitude=" + longitude + ", latitude=" + latitude
				+ ", starScore=" + starScore + ", like=" + like + ", reviewCount=" + reviewCount + ", viewNum="
				+ viewNum + ", registraitionDate=" + registraitionDate + "]";
	}

	
}
