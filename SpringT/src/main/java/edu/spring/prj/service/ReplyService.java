package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.ReplyVO;

public interface ReplyService {

	int create(ReplyVO vo) throws Exception;

	List<ReplyVO> read(int reply_bno);

	int update(ReplyVO vo);

	int delete(int reply_no, int reply_bno, String table_name) throws Exception;

} // ReplyService
