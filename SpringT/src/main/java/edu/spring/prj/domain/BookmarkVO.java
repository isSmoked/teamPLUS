package edu.spring.prj.domain;

import java.util.Date;

public class BookmarkVO {
	private String userid;
	private String bookmark_table_name;
	private String bookmark_bno;
	private String bookmark_no;
	private Date bookmark_date;
	private String bookmark_title;
	private String bookmark_writer;
	
	public BookmarkVO() {
	}

	public BookmarkVO(String userid, String bookmark_table_name, String bookmark_bno, String bookmark_no,
			Date bookmark_date, String bookmark_title, String bookmark_writer) {
		super();
		this.userid = userid;
		this.bookmark_table_name = bookmark_table_name;
		this.bookmark_bno = bookmark_bno;
		this.bookmark_no = bookmark_no;
		this.bookmark_date = bookmark_date;
		this.bookmark_title = bookmark_title;
		this.bookmark_writer = bookmark_writer;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBookmark_table_name() {
		return bookmark_table_name;
	}

	public void setBookmark_table_name(String bookmark_table_name) {
		this.bookmark_table_name = bookmark_table_name;
	}

	public String getBookmark_bno() {
		return bookmark_bno;
	}

	public void setBookmark_bno(String bookmark_bno) {
		this.bookmark_bno = bookmark_bno;
	}

	public String getBookmark_no() {
		return bookmark_no;
	}

	public void setBookmark_no(String bookmark_no) {
		this.bookmark_no = bookmark_no;
	}

	public Date getBookmark_date() {
		return bookmark_date;
	}

	public void setBookmark_date(Date bookmark_date) {
		this.bookmark_date = bookmark_date;
	}

	public String getBookmark_title() {
		return bookmark_title;
	}

	public void setBookmark_title(String bookmark_title) {
		this.bookmark_title = bookmark_title;
	}

	public String getBookmark_writer() {
		return bookmark_writer;
	}

	public void setBookmark_writer(String bookmark_writer) {
		this.bookmark_writer = bookmark_writer;
	}

	@Override
	public String toString() {
		return "BookmarkVO [userid=" + userid + ", bookmark_table_name=" + bookmark_table_name + ", bookmark_bno="
				+ bookmark_bno + ", bookmark_no=" + bookmark_no + ", bookmark_date=" + bookmark_date
				+ ", bookmark_title=" + bookmark_title + ", bookmark_writer=" + bookmark_writer + "]";
	}

	
	
}
