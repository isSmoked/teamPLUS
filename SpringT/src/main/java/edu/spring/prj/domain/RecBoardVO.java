package edu.spring.prj.domain;

import java.util.Date;

public class RecBoardVO {
	private int rno;
	private String userid;
	private String education;
	private String recruit_title;
	private Date r_date;
	private String work_area;
	private String workday;
	private String position;
	private String career;
	private String salary;
	private String responsibility;
	private String eligibility;
	private String recruitstep;
	private String requireddoc;
	private String applyway;
	private String applyperiod;
	private String password;
	private int rhit;
	private String rname;
	
	
	public RecBoardVO() {}


	public RecBoardVO(int rno, String userid, String education, String recruit_title, Date r_date, String work_area,
			String workday, String position, String career, String salary, String responsibility, String eligibility,
			String recruitstep, String requireddoc, String applyway, String applyperiod, String password, int rhit,
			String rname) {
		super();
		this.rno = rno;
		this.userid = userid;
		this.education = education;
		this.recruit_title = recruit_title;
		this.r_date = r_date;
		this.work_area = work_area;
		this.workday = workday;
		this.position = position;
		this.career = career;
		this.salary = salary;
		this.responsibility = responsibility;
		this.eligibility = eligibility;
		this.recruitstep = recruitstep;
		this.requireddoc = requireddoc;
		this.applyway = applyway;
		this.applyperiod = applyperiod;
		this.password = password;
		this.rhit = rhit;
		this.rname = rname;
	}


	public int getRno() {
		return rno;
	}


	public void setRno(int rno) {
		this.rno = rno;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getEducation() {
		return education;
	}


	public void setEducation(String education) {
		this.education = education;
	}


	public String getRecruit_title() {
		return recruit_title;
	}


	public void setRecruit_title(String recruit_title) {
		this.recruit_title = recruit_title;
	}


	public Date getR_date() {
		return r_date;
	}


	public void setR_date(Date r_date) {
		this.r_date = r_date;
	}


	public String getWork_area() {
		return work_area;
	}


	public void setWork_area(String work_area) {
		this.work_area = work_area;
	}


	public String getWorkday() {
		return workday;
	}


	public void setWorkday(String workday) {
		this.workday = workday;
	}


	public String getPosition() {
		return position;
	}


	public void setPosition(String position) {
		this.position = position;
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


	public String getResponsibility() {
		return responsibility;
	}


	public void setResponsibility(String responsibility) {
		this.responsibility = responsibility;
	}


	public String getEligibility() {
		return eligibility;
	}


	public void setEligibility(String eligibility) {
		this.eligibility = eligibility;
	}


	public String getRecruitstep() {
		return recruitstep;
	}


	public void setRecruitstep(String recruitstep) {
		this.recruitstep = recruitstep;
	}


	public String getRequireddoc() {
		return requireddoc;
	}


	public void setRequireddoc(String requireddoc) {
		this.requireddoc = requireddoc;
	}


	public String getApplyway() {
		return applyway;
	}


	public void setApplyway(String applyway) {
		this.applyway = applyway;
	}


	public String getApplyperiod() {
		return applyperiod;
	}


	public void setApplyperiod(String applyperiod) {
		this.applyperiod = applyperiod;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public int getRhit() {
		return rhit;
	}


	public void setRhit(int rhit) {
		this.rhit = rhit;
	}


	public String getRname() {
		return rname;
	}


	public void setRname(String rname) {
		this.rname = rname;
	}


	@Override
	public String toString() {
		return "RecBoardVO [rno=" + rno + ", userid=" + userid + ", education=" + education + ", recruit_title="
				+ recruit_title + ", r_date=" + r_date + ", work_area=" + work_area + ", workday=" + workday
				+ ", position=" + position + ", career=" + career + ", salary=" + salary + ", responsibility="
				+ responsibility + ", eligibility=" + eligibility + ", recruitstep=" + recruitstep + ", requireddoc="
				+ requireddoc + ", applyway=" + applyway + ", applyperiod=" + applyperiod + ", password=" + password
				+ ", rhit=" + rhit + ", rname=" + rname + "]";
	}


	

}
