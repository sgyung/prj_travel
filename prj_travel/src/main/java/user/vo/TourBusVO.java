package user.vo;

import java.sql.Date;

public class TourBusVO {
	private String id, name, tel, image;
	private int seat, adultFare, childFare;
	private Date start, end, time;
	
	public TourBusVO() {
		super();
	}
	
	public TourBusVO(String id, String name, String tel, String image, int seat, int adultFare, int childFare,
			Date start, Date end, Date time) {
		super();
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.image = image;
		this.seat = seat;
		this.adultFare = adultFare;
		this.childFare = childFare;
		this.start = start;
		this.end = end;
		this.time = time;
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
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
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
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "TourBusVO [id=" + id + ", name=" + name + ", tel=" + tel + ", image=" + image + ", seat=" + seat
				+ ", adultFare=" + adultFare + ", childFare=" + childFare + ", start=" + start + ", end=" + end
				+ ", time=" + time + "]";
	}
	
}//class
