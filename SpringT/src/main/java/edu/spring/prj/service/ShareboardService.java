package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface ShareboardService {
	public abstract List<ShareboardVO> read();
	public abstract ShareboardVO read(int bno);
	public abstract int create(ShareboardVO vo);
	public abstract int update(ShareboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<ShareboardVO> read(PageCriteria criteria);
	// 공지사항
	public abstract List<ShareboardVO> selectNotice();
	
}
















