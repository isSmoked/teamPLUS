package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.spring.prj.domain.ReplyVO;
import edu.spring.prj.persistence.FreeboardDAO;
import edu.spring.prj.persistence.QAboardDAO;
import edu.spring.prj.persistence.ReplyDAO;
import edu.spring.prj.persistence.ShareboardDAO;

@Service
public class ReplyServiceImple implements ReplyService {
	private static final Logger logger = 
			LoggerFactory.getLogger(ReplyServiceImple.class);

	@Autowired
	private ReplyDAO replyDao;
	
	@Autowired 
	private FreeboardDAO freeboardDao;
	  
	@Autowired 
	private QAboardDAO qaboardDao;
	  
	@Autowired 
	private ShareboardDAO shareboardDao;
	
	// @Transactional
	// - 두 개의 데이터베이스 변경이 생길 때
	// 위의 내용이 실행되었고, 아래 내용이 에러가 발생하면
	// 위의 내용은 rollback 되어야 한다.
	// 이러한 기능을 해주는 어노테이션이 Transactional 이다.

	@Transactional
	// root-context.xml 에서 설정한 transactionManager를 weaving

	@Override
	public int create(ReplyVO vo) throws Exception {
		logger.info("Reply create() 호출");
		replyDao.insert(vo);
		logger.info("댓글 입력 성공");
		logger.info("vo 확인 : " + vo.toString());
		// 댓글 카운트
		if (vo.getReply_table_name().equals("freeboard_table")) {
			logger.info("Reply update count : freeboard");
			freeboardDao.updateReplyCount(1, vo.getReply_bno()); 
		} else if (vo.getReply_table_name().equals("qaboard_table")) {
			logger.info("Reply update count : qaboard");
			qaboardDao.updateReplyCount(1, vo.getReply_bno());
		} else if (vo.getReply_table_name().equals("shareboard_table")) {
			logger.info("Reply update count : shareboard");
			shareboardDao.updateReplyCount(1, vo.getReply_bno());
		} else {
			logger.info("댓글 개수 올려주기 실패");
		}
		logger.info("댓글 개수 업데이트 성공");
		return 1;
	}

	@Override
	public List<ReplyVO> read(int reply_bno) {
		logger.info("read() 호출");
		return replyDao.select(reply_bno);
	}

	@Override
	public int update(ReplyVO vo) {
		logger.info("update() 호출");
		return replyDao.update(vo);
	}

	@Override
	public int delete(int reply_no, int reply_bno, String table_name) {
		logger.info("댓글 삭제 시작");
		replyDao.delete(reply_no);
		logger.info("댓글 삭제 성공");
		logger.info("table_name : " + table_name);
		// 댓글 개수 삭제
		if (table_name.equals("freeboard_table")) {
			logger.info("Reply update count : freeboard");
			freeboardDao.updateReplyCount(-1, reply_bno); 
		} else if (table_name.equals("qaboard_table")) {
			logger.info("Reply update count : qaboard");
			qaboardDao.updateReplyCount(-1, reply_bno);
		} else if (table_name.equals("shareboard_table")) {
			logger.info("Reply update count : shareboard");
			shareboardDao.updateReplyCount(-1, reply_bno);
		} else {
			logger.info("댓글 개수 삭제 실패");
		}
		logger.info("게시판 댓글 개수 삭제 성공");
		return 1;
	}

} // ReplyServiceImple
