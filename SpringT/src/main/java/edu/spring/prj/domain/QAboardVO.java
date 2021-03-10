package edu.spring.prj.domain;

import java.util.Date;

public class QAboardVO {
	private int qaboard_bno;
	private String userid;
	private String qaboard_title;
	private String qaboard_content;
	private Date qaboard_date;
	private int qaboard_readcount;
	private int qaboard_replycount;
	private int qaboard_notice;
	private String table_name;

	public QAboardVO() {
	}

	public QAboardVO(int qaboard_bno, String userid, String qaboard_title, String qaboard_content, Date qaboard_date,
			int qaboard_readcount, int qaboard_replycount, int qaboard_notice, String table_name) {
		super();
		this.qaboard_bno = qaboard_bno;
		this.userid = userid;
		this.qaboard_title = qaboard_title;
		this.qaboard_content = qaboard_content;
		this.qaboard_date = qaboard_date;
		this.qaboard_readcount = qaboard_readcount;
		this.qaboard_replycount = qaboard_replycount;
		this.qaboard_notice = qaboard_notice;
		this.table_name = table_name;
	}

	public int getQaboard_bno() {
		return qaboard_bno;
	}

	public void setQaboard_bno(int qaboard_bno) {
		this.qaboard_bno = qaboard_bno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getQaboard_title() {
		return qaboard_title;
	}

	public void setQaboard_title(String qaboard_title) {
		this.qaboard_title = qaboard_title;
	}

	public String getQaboard_content() {
		return qaboard_content;
	}

	public void setQaboard_content(String qaboard_content) {
		this.qaboard_content = qaboard_content;
	}

	public Date getQaboard_date() {
		return qaboard_date;
	}

	public void setQaboard_date(Date qaboard_date) {
		this.qaboard_date = qaboard_date;
	}

	public int getQaboard_readcount() {
		return qaboard_readcount;
	}

	public void setQaboard_readcount(int qaboard_readcount) {
		this.qaboard_readcount = qaboard_readcount;
	}

	public int getQaboard_replycount() {
		return qaboard_replycount;
	}

	public void setQaboard_replycount(int qaboard_replycount) {
		this.qaboard_replycount = qaboard_replycount;
	}

	public int getQaboard_notice() {
		return qaboard_notice;
	}

	public void setQaboard_notice(int qaboard_notice) {
		this.qaboard_notice = qaboard_notice;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	@Override
	public String toString() {
		return "QAboardVO [qaboard_bno=" + qaboard_bno + ", userid=" + userid + ", qaboard_title=" + qaboard_title
				+ ", qaboard_content=" + qaboard_content + ", qaboard_date=" + qaboard_date + ", qaboard_readcount="
				+ qaboard_readcount + ", qaboard_replycount=" + qaboard_replycount + ", qaboard_notice="
				+ qaboard_notice + ", table_name=" + table_name + "]";
	}
	



} // qaboardVO
