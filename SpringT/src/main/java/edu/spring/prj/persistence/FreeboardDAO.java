package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface FreeboardDAO {
	public abstract List<FreeboardVO> select();
	public abstract FreeboardVO select(int bno);
	public abstract int insert(FreeboardVO vo);
	public abstract int update(FreeboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<FreeboardVO> select(PageCriteria criteria);
	public abstract List<FreeboardVO> select(String userid);
	public abstract List<FreeboardVO> selectByTitleOrContent(String keyword);
	public abstract int updateReplyCount(int amount, int bno);
	// 공지사항
	public abstract List<FreeboardVO> selectNotice();
}