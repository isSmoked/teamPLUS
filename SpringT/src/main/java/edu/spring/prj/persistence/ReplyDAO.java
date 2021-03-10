package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.ReplyVO;

public interface ReplyDAO {
	
	int insert(ReplyVO vo);

	List<ReplyVO> select(int reply_bno);

	int update(ReplyVO vo);

	int delete(int reply_no);
	
} // ReplyDAO
