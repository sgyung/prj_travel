package user.vo;

import java.sql.Date;

public class UserVO {
	private String id,pw,name,birthdate,tel,zipcode,addr,addrdetail,jointype;
	private Date joindate;
	
	public UserVO() {
		super();
	}

	public UserVO(String id, String pw, String name, String birthdate, String tel, String zipcode, String addr,
			String addrdetail, String jointype, Date joindate) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.birthdate = birthdate;
		this.tel = tel;
		this.zipcode = zipcode;
		this.addr = addr;
		this.addrdetail = addrdetail;
		this.jointype = jointype;
		this.joindate = joindate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
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

	public String getAddrdetail() {
		return addrdetail;
	}

	public void setAddrdetail(String addrdetail) {
		this.addrdetail = addrdetail;
	}

	public String getJointype() {
		return jointype;
	}

	public void setJointype(String jointype) {
		this.jointype = jointype;
	}

	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

	@Override
	public String toString() {
		return "UserVO [id=" + id + ", pw=" + pw + ", name=" + name + ", birthdate=" + birthdate + ", tel=" + tel
				+ ", zipcode=" + zipcode + ", addr=" + addr + ", addrdetail=" + addrdetail + ", jointype=" + jointype
				+ ", joindate=" + joindate + "]";
	}
	
	
	
}
