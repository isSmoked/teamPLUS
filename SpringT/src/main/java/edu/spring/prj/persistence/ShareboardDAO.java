package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface ShareboardDAO {
	public abstract List<ShareboardVO> select();
	public abstract ShareboardVO select(int bno);
	public abstract int insert(ShareboardVO vo);
	public abstract int update(ShareboardVO vo);
	public abstract int delete(int bno);
	public abstract int getTotalNumsOfRecords(PageCriteria criteria);
	public abstract List<ShareboardVO> select(PageCriteria criteria);
	public abstract List<ShareboardVO> select(String userid);
	public abstract List<ShareboardVO> selectByTitleOrContent(String keyword);
	public abstract int updateReplyCount(int amount, int bno);
	// 공지사항
	public abstract List<ShareboardVO> selectNotice();
}