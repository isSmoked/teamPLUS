package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.persistence.EmpBoardDAO;

@Service
public class EmpBoardServiceImple implements EmpBoardService{
	private static final Logger LOGGER =
			LoggerFactory.getLogger(EmpBoardServiceImple.class);
	
	
	@Autowired
	private EmpBoardDAO empDao;
	
	@Override
	public List<EmpBoardVO> read() {
		LOGGER.info("read() 호출");
		return empDao.select();
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public EmpBoardVO read_by_eno(int eno) throws Exception {
		LOGGER.info("read_by_eno() 호출 : eno = " + eno);
		empDao.boardHit(eno);
		return empDao.select_by_eno(eno);
	}

	

	@Override
	public int create(EmpBoardVO EmpVO) {
		LOGGER.info("create() 호출");
		return empDao.insert(EmpVO);
	}

	@Override
	public int delete(int eno) {
		LOGGER.info("delete() 호출");
		return empDao.delete(eno);
	}

	@Override
	public int getTotalNumsOfRecords() {
		LOGGER.info("getTotalNumsOfRecords() 호출");
		return empDao.getTotalNumsOfRecords();
	}

	@Override
	public List<EmpBoardVO> read(PageCriteria criteria) {
		LOGGER.info("read() 호출 : page = " + criteria.getPage());
		return empDao.select(criteria);
	}

	@Override
	public List<EmpBoardVO> read(String userid) {
		LOGGER.info("read() userid = " + userid);
		return empDao.select(userid);
	}

	@Override
	public List<EmpBoardVO> readByKeyword(String keyword) {
		LOGGER.info("readByKeyword 호출 : keyword = " + keyword);
		return empDao.selectByTitle(keyword);
	}

	@Override
	public List<EmpBoardVO> readByWorkarea(String workarea) {
		LOGGER.info("readByWorkarea() 호출");
		return empDao.selectByWorkArea(workarea);
	}

	@Override
	public int boardHit(int eno) {
		LOGGER.info("boardHit() 호출");
		return empDao.boardHit(eno);
	}

	
	
}
