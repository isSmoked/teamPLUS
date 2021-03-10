package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.persistence.RecBoardDAO;
import edu.spring.prj.persistence.RecBoardDAOImple;

@Service // Component
//스프링 프레임워크에게 서비스 계층(Service/Business layer)의
//컴포넌트암울 알려주는 어노테이션
public class RecBoardServiceImple implements RecBoardService{
	private static final Logger LOGGER =
			LoggerFactory.getLogger(RecBoardServiceImple.class);
	
	@Autowired
	private RecBoardDAO recDao;
	

	/*
	 * @Override public List<RecBoardVO> read() { LOGGER.info("read() 호출"); return
	 * recDao.select(); }
	 */

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public RecBoardVO read_by_rno(int rno) throws Exception {
		LOGGER.info("read_by_rno() 호출 : bno = " + rno);
		recDao.boardHit(rno);
		return recDao.select_by_rno(rno);
	}
	
	@Override
	public List<RecBoardVO> read() {
		LOGGER.info("read() 호출");
		return recDao.select();
	}

	@Override
	public int create(RecBoardVO RecVO) {
		LOGGER.info("create() 호출");
		return recDao.insert(RecVO);
	}

	@Override
	public int delete(int rno) {
		LOGGER.info("delete() 호출");
		return recDao.delete(rno);
	}

	@Override
	public int getTotalNumsOfRecords() {
		LOGGER.info("getTotalNumsOfRecords() 호출");
		return recDao.getTotalNumsOfRecords();
	}

	@Override
	public List<RecBoardVO> read(PageCriteria criteria) {
		LOGGER.info("read() 호출 : page = " + criteria.getPage());
		return recDao.select(criteria);
	}




	@Override
	public List<RecBoardVO> read(String userid) {
		LOGGER.info("read() userid = " + userid);
		return recDao.select(userid);
	}


	@Override
	public List<RecBoardVO> readByKeyword(String keyword) {
		LOGGER.info("readByKeyword 호출 : keyword = " + keyword);
		return recDao.selectByTitle(keyword);
	}


	@Override
	public List<RecBoardVO> readByWorkarea(String workarea) {
		LOGGER.info("readByWorkarea() 호출");
		return recDao.selectByWorkArea(workarea);
	}

	// 조회수
	@Override
	public int boardHit(int rno) {
		LOGGER.info("boardHit() 호출");
		return recDao.boardHit(rno);
	}

	
}
