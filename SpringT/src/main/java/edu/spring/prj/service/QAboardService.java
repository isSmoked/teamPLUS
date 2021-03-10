package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface QAboardService {
	public abstract List<QAboardVO> read();
	public abstract QAboardVO read(int bno);
	public abstract int create(QAboardVO vo);
	public abstract int update(QAboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<QAboardVO> read(PageCriteria criteria);
	// 공지사항
	public abstract List<QAboardVO> selectNotice();
}
















