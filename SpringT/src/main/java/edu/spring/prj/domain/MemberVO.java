package edu.spring.prj.domain;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class MemberVO {
	// member_table
	@NotEmpty(message="* 아이디를 입력해주세요.")
	private String userid;
	@NotEmpty(message="* 비밀번호를 입력해주세요.")
	private String password;
	@NotEmpty(message="* 이메일을 입력해주세요.")
	private String email;
	@NotEmpty(message="* 연락처를 입력해주세요.")
	private String phone;
	private Date register_date;
	private String part;
	private int blacklist;
	
	// detail_personal
	private String personal_name;
	private String personal_birth;
	private String personal_gender;
	private String personal_address;
	private String personal_json;
	private Date personal_update_date;
	
	// detail_company
	private String company_number;
	private String company_name;
	private String company_president;
	private String company_address;
	private String company_manager;
	private String company_manager_phone;
	private String company_manager_email;
	private String company_json;
	private Date company_update_date;
	
	private String table_name;

	public MemberVO() {
	}

	public MemberVO(String userid, String password, String email, String phone, Date register_date, String part,
			int blacklist, String personal_name, String personal_birth, String personal_gender, String personal_address,
			String personal_json, Date personal_update_date, String company_number, String company_name,
			String company_president, String company_address, String company_manager, String company_manager_phone,
			String company_manager_email, String company_json, Date company_update_date, String table_name) {
		super();
		this.userid = userid;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.register_date = register_date;
		this.part = part;
		this.blacklist = blacklist;
		this.personal_name = personal_name;
		this.personal_birth = personal_birth;
		this.personal_gender = personal_gender;
		this.personal_address = personal_address;
		this.personal_json = personal_json;
		this.personal_update_date = personal_update_date;
		this.company_number = company_number;
		this.company_name = company_name;
		this.company_president = company_president;
		this.company_address = company_address;
		this.company_manager = company_manager;
		this.company_manager_phone = company_manager_phone;
		this.company_manager_email = company_manager_email;
		this.company_json = company_json;
		this.company_update_date = company_update_date;
		this.table_name = table_name;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}

	public String getPart() {
		return part;
	}

	public void setPart(String part) {
		this.part = part;
	}

	public int getBlacklist() {
		return blacklist;
	}

	public void setBlacklist(int blacklist) {
		this.blacklist = blacklist;
	}

	public String getPersonal_name() {
		return personal_name;
	}

	public void setPersonal_name(String personal_name) {
		this.personal_name = personal_name;
	}

	public String getPersonal_birth() {
		return personal_birth;
	}

	public void setPersonal_birth(String personal_birth) {
		this.personal_birth = personal_birth;
	}

	public String getPersonal_gender() {
		return personal_gender;
	}

	public void setPersonal_gender(String personal_gender) {
		this.personal_gender = personal_gender;
	}

	public String getPersonal_address() {
		return personal_address;
	}

	public void setPersonal_address(String personal_address) {
		this.personal_address = personal_address;
	}

	public String getPersonal_json() {
		return personal_json;
	}

	public void setPersonal_json(String personal_json) {
		this.personal_json = personal_json;
	}

	public Date getPersonal_update_date() {
		return personal_update_date;
	}

	public void setPersonal_update_date(Date personal_update_date) {
		this.personal_update_date = personal_update_date;
	}

	public String getCompany_number() {
		return company_number;
	}

	public void setCompany_number(String company_number) {
		this.company_number = company_number;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCompany_president() {
		return company_president;
	}

	public void setCompany_president(String company_president) {
		this.company_president = company_president;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}

	public String getCompany_manager() {
		return company_manager;
	}

	public void setCompany_manager(String company_manager) {
		this.company_manager = company_manager;
	}

	public String getCompany_manager_phone() {
		return company_manager_phone;
	}

	public void setCompany_manager_phone(String company_manager_phone) {
		this.company_manager_phone = company_manager_phone;
	}

	public String getCompany_manager_email() {
		return company_manager_email;
	}

	public void setCompany_manager_email(String company_manager_email) {
		this.company_manager_email = company_manager_email;
	}

	public String getCompany_json() {
		return company_json;
	}

	public void setCompany_json(String company_json) {
		this.company_json = company_json;
	}

	public Date getCompany_update_date() {
		return company_update_date;
	}

	public void setCompany_update_date(Date company_update_date) {
		this.company_update_date = company_update_date;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	@Override
	public String toString() {
		return "MemberVO [userid=" + userid + ", password=" + password + ", email=" + email + ", phone=" + phone
				+ ", register_date=" + register_date + ", part=" + part + ", blacklist=" + blacklist
				+ ", personal_name=" + personal_name + ", personal_birth=" + personal_birth + ", personal_gender="
				+ personal_gender + ", personal_address=" + personal_address + ", personal_json=" + personal_json
				+ ", personal_update_date=" + personal_update_date + ", company_number=" + company_number
				+ ", company_name=" + company_name + ", company_president=" + company_president + ", company_address="
				+ company_address + ", company_manager=" + company_manager + ", company_manager_phone="
				+ company_manager_phone + ", company_manager_email=" + company_manager_email + ", company_json="
				+ company_json + ", company_update_date=" + company_update_date + ", table_name=" + table_name + "]";
	}



	
} // MemberVO
