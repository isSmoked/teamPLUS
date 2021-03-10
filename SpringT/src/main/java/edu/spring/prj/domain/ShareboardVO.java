package edu.spring.prj.domain;

import java.util.Date;

public class ShareboardVO {
	private int shareboard_bno;
	private String userid;
	private String shareboard_title;
	private String shareboard_content;
	private Date shareboard_date;
	private int shareboard_readcount;
	private int shareboard_replycount;
	private int shareboard_notice;
	private String table_name;
	
	public ShareboardVO() {
	}

	public ShareboardVO(int shareboard_bno, String userid, String shareboard_title, String shareboard_content,
			Date shareboard_date, int shareboard_readcount, int shareboard_replycount, int shareboard_notice,
			String table_name) {
		super();
		this.shareboard_bno = shareboard_bno;
		this.userid = userid;
		this.shareboard_title = shareboard_title;
		this.shareboard_content = shareboard_content;
		this.shareboard_date = shareboard_date;
		this.shareboard_readcount = shareboard_readcount;
		this.shareboard_replycount = shareboard_replycount;
		this.shareboard_notice = shareboard_notice;
		this.table_name = table_name;
	}

	public int getShareboard_bno() {
		return shareboard_bno;
	}

	public void setShareboard_bno(int shareboard_bno) {
		this.shareboard_bno = shareboard_bno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getShareboard_title() {
		return shareboard_title;
	}

	public void setShareboard_title(String shareboard_title) {
		this.shareboard_title = shareboard_title;
	}

	public String getShareboard_content() {
		return shareboard_content;
	}

	public void setShareboard_content(String shareboard_content) {
		this.shareboard_content = shareboard_content;
	}

	public Date getShareboard_date() {
		return shareboard_date;
	}

	public void setShareboard_date(Date shareboard_date) {
		this.shareboard_date = shareboard_date;
	}

	public int getShareboard_readcount() {
		return shareboard_readcount;
	}

	public void setShareboard_readcount(int shareboard_readcount) {
		this.shareboard_readcount = shareboard_readcount;
	}

	public int getShareboard_replycount() {
		return shareboard_replycount;
	}

	public void setShareboard_replycount(int shareboard_replycount) {
		this.shareboard_replycount = shareboard_replycount;
	}

	public int getShareboard_notice() {
		return shareboard_notice;
	}

	public void setShareboard_notice(int shareboard_notice) {
		this.shareboard_notice = shareboard_notice;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	@Override
	public String toString() {
		return "ShareboardVO [shareboard_bno=" + shareboard_bno + ", userid=" + userid + ", shareboard_title="
				+ shareboard_title + ", shareboard_content=" + shareboard_content + ", shareboard_date="
				+ shareboard_date + ", shareboard_readcount=" + shareboard_readcount + ", shareboard_replycount="
				+ shareboard_replycount + ", shareboard_notice=" + shareboard_notice + ", table_name=" + table_name
				+ "]";
	}
	

	
} // ShareboardVO
