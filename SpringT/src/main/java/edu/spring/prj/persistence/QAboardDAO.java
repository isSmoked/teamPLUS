package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface QAboardDAO {
	public abstract List<QAboardVO> select();
	public abstract QAboardVO select(int bno);
	public abstract int insert(QAboardVO vo);
	public abstract int update(QAboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<QAboardVO> select(PageCriteria criteria);
	public abstract List<QAboardVO> select(String userid);
	public abstract List<QAboardVO> selectByTitleOrContent(String keyword);
	public abstract int updateReplyCount(int amount, int bno);
	// 공지사항
	public abstract List<QAboardVO> selectNotice();
}