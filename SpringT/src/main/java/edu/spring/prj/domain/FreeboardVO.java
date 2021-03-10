package edu.spring.prj.domain;

import java.util.Date;

public class FreeboardVO {
	private int freeboard_bno;
	private String userid;
	private String freeboard_title;
	private String freeboard_content;
	private Date freeboard_date;
	private int freeboard_readcount;
	private int freeboard_replycount;
	private int freeboard_notice;
	private String table_name;

	public FreeboardVO() {
	}

	public FreeboardVO(int freeboard_bno, String userid, String freeboard_title, String freeboard_content,
			Date freeboard_date, int freeboard_readcount, int freeboard_replycount, int freeboard_notice,
			String table_name) {
		super();
		this.freeboard_bno = freeboard_bno;
		this.userid = userid;
		this.freeboard_title = freeboard_title;
		this.freeboard_content = freeboard_content;
		this.freeboard_date = freeboard_date;
		this.freeboard_readcount = freeboard_readcount;
		this.freeboard_replycount = freeboard_replycount;
		this.freeboard_notice = freeboard_notice;
		this.table_name = table_name;
	}

	public int getFreeboard_bno() {
		return freeboard_bno;
	}

	public void setFreeboard_bno(int freeboard_bno) {
		this.freeboard_bno = freeboard_bno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getFreeboard_title() {
		return freeboard_title;
	}

	public void setFreeboard_title(String freeboard_title) {
		this.freeboard_title = freeboard_title;
	}

	public String getFreeboard_content() {
		return freeboard_content;
	}

	public void setFreeboard_content(String freeboard_content) {
		this.freeboard_content = freeboard_content;
	}

	public Date getFreeboard_date() {
		return freeboard_date;
	}

	public void setFreeboard_date(Date freeboard_date) {
		this.freeboard_date = freeboard_date;
	}

	public int getFreeboard_readcount() {
		return freeboard_readcount;
	}

	public void setFreeboard_readcount(int freeboard_readcount) {
		this.freeboard_readcount = freeboard_readcount;
	}

	public int getFreeboard_replycount() {
		return freeboard_replycount;
	}

	public void setFreeboard_replycount(int freeboard_replycount) {
		this.freeboard_replycount = freeboard_replycount;
	}

	public int getFreeboard_notice() {
		return freeboard_notice;
	}

	public void setFreeboard_notice(int freeboard_notice) {
		this.freeboard_notice = freeboard_notice;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	@Override
	public String toString() {
		return "FreeboardVO [freeboard_bno=" + freeboard_bno + ", userid=" + userid + ", freeboard_title="
				+ freeboard_title + ", freeboard_content=" + freeboard_content + ", freeboard_date=" + freeboard_date
				+ ", freeboard_readcount=" + freeboard_readcount + ", freeboard_replycount=" + freeboard_replycount
				+ ", freeboard_notice=" + freeboard_notice + ", table_name=" + table_name + "]";
	}

	
	
} // FreeboardVO