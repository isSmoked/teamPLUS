package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface FreeboardService {
	public abstract List<FreeboardVO> read();
	public abstract FreeboardVO read(int bno);
	public abstract int create(FreeboardVO vo);
	public abstract int update(FreeboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<FreeboardVO> read(PageCriteria criteria);
	// 공지사항
	public abstract List<FreeboardVO> selectNotice();
	
}