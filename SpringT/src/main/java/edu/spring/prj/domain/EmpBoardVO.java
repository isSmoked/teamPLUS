package edu.spring.prj.domain;

import java.util.Date;

public class EmpBoardVO {
	private int eno;
	private String userid;
	private String employ_title;
	private Date e_date;
	private String work_area;
	private String uname;
	private String career;
	private String salary;
	private String birth;
	private String gender;
	private String email;
	private Integer oaddress;
	private String address;
	private String emplementtype;
	private String education;
	private String certificates;
	private String awards;
	private String selfintroduce;
	private String militeryservice;
	private String phone;
	private String detail_address;
	private int hit;
	
	public EmpBoardVO() {}

	public EmpBoardVO(int eno, String userid, String employ_title, Date e_date, String work_area, String uname,
			String career, String salary, String birth, String gender, String email, Integer oaddress, String address,
			String emplementtype, String education, String certificates, String awards, String selfintroduce,
			String militeryservice, String phone, String detail_address, int hit) {
		super();
		this.eno = eno;
		this.userid = userid;
		this.employ_title = employ_title;
		this.e_date = e_date;
		this.work_area = work_area;
		this.uname = uname;
		this.career = career;
		this.salary = salary;
		this.birth = birth;
		this.gender = gender;
		this.email = email;
		this.oaddress = oaddress;
		this.address = address;
		this.emplementtype = emplementtype;
		this.education = education;
		this.certificates = certificates;
		this.awards = awards;
		this.selfintroduce = selfintroduce;
		this.militeryservice = militeryservice;
		this.phone = phone;
		this.detail_address = detail_address;
		this.hit = hit;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getEmploy_title() {
		return employ_title;
	}

	public void setEmploy_title(String employ_title) {
		this.employ_title = employ_title;
	}

	public Date getE_date() {
		return e_date;
	}

	public void setE_date(Date e_date) {
		this.e_date = e_date;
	}

	public String getWork_area() {
		return work_area;
	}

	public void setWork_area(String work_area) {
		this.work_area = work_area;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getOaddress() {
		return oaddress;
	}

	public void setOaddress(Integer oaddress) {
		this.oaddress = oaddress;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmplementtype() {
		return emplementtype;
	}

	public void setEmplementtype(String emplementtype) {
		this.emplementtype = emplementtype;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getCertificates() {
		return certificates;
	}

	public void setCertificates(String certificates) {
		this.certificates = certificates;
	}

	public String getAwards() {
		return awards;
	}

	public void setAwards(String awards) {
		this.awards = awards;
	}

	public String getSelfintroduce() {
		return selfintroduce;
	}

	public void setSelfintroduce(String selfintroduce) {
		this.selfintroduce = selfintroduce;
	}

	public String getMiliteryservice() {
		return militeryservice;
	}

	public void setMiliteryservice(String militeryservice) {
		this.militeryservice = militeryservice;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDetail_address() {
		return detail_address;
	}

	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	@Override
	public String toString() {
		return "EmpBoardVO [eno=" + eno + ", userid=" + userid + ", employTitle=" + employ_title + ", edate=" + e_date
				+ ", workArea=" + work_area + ", uname=" + uname + ", career=" + career + ", salary=" + salary
				+ ", birth=" + birth + ", gender=" + gender + ", email=" + email + ", oaddress=" + oaddress
				+ ", address=" + address + ", emplementType=" + emplementtype + ", education=" + education
				+ ", certificates=" + certificates + ", awards=" + awards + ", selfintroduce=" + selfintroduce
				+ ", militeryService=" + militeryservice + ", phone=" + phone + ", detailAddress=" + detail_address
				+ ", hit=" + hit + "]";
	}

	
	
}
