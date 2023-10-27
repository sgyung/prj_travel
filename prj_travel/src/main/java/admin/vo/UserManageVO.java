package admin.vo;

import java.sql.Date;

public class UserManageVO {
	private String id;
	private String name;
	private Date birthdate;
	private String tel;
	private String zipcode;
	private String addr;
	private String addrDetail;
	private Date joinDate;
	private String joinType;
	private int postCount;
	private int reviewCount;
	
	public UserManageVO() {
		
	}

	
	
	public UserManageVO(String id, String name, Date birthdate, String tel, String zipcode, String addr,
			String addrDetail, Date joinDate, String joinType, int postCount, int reviewCount) {
		super();
		this.id = id;
		this.name = name;
		this.birthdate = birthdate;
		this.tel = tel;
		this.zipcode = zipcode;
		this.addr = addr;
		this.addrDetail = addrDetail;
		this.joinDate = joinDate;
		this.joinType = joinType;
		this.postCount = postCount;
		this.reviewCount = reviewCount;
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

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getJoinType() {
		return joinType;
	}

	public void setJoinType(String joinType) {
		this.joinType = joinType;
	}

	public int getPostCount() {
		return postCount;
	}

	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}



	@Override
	public String toString() {
		return "UserManageVO [id=" + id + ", name=" + name + ", birthdate=" + birthdate + ", tel=" + tel + ", zipcode="
				+ zipcode + ", addr=" + addr + ", addrDetail=" + addrDetail + ", joinDate=" + joinDate + ", joinType="
				+ joinType + ", postCount=" + postCount + ", reviewCount=" + reviewCount + "]";
	}
	
	
}
