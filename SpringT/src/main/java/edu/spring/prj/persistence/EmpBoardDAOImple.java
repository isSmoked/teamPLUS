package edu.spring.prj.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

@Repository
public class EmpBoardDAOImple implements EmpBoardDAO{
	public static final Logger LOGGER =
			LoggerFactory.getLogger(EmpBoardDAOImple.class);
	
	private static final String NAMESPACE =
			"edu.spring.prj.EmpBoardMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<EmpBoardVO> select() {
		LOGGER.info("select() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_all");
	}

	@Override
	public EmpBoardVO select_by_eno(int eno) {
		LOGGER.info("select_by_eno() 호출 : eno" + eno);
		return sqlSession.selectOne(NAMESPACE + ".select_by_eno", eno);
	}


	@Override
	public int insert(EmpBoardVO EmpVO) {
		LOGGER.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".empinsert", EmpVO);
	}

	@Override
	public int delete(int eno) {
		LOGGER.info("delelte() 호출");
		return sqlSession.delete(NAMESPACE + ".empdelete", eno);
	}

	@Override
	public int getTotalNumsOfRecords() {
		LOGGER.info("getTotalNumsOfRecords() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	}

	@Override
	public List<EmpBoardVO> select(PageCriteria criteria) {
		LOGGER.info("select() 호출 : page = " + criteria.getPage());
		return sqlSession.selectList(NAMESPACE + ".paging", criteria);
	}

	// 게시판 조회수
	@Override
	public int boardHit(int eno) {
		LOGGER.info("boardHit() 호출");
		return sqlSession.update(NAMESPACE + ".boardHit", eno);
	}

	@Override
	public List<EmpBoardVO> select(String userid) {
		LOGGER.info("select() 호출 : userid = " + userid);
		userid = "%" + userid + "%";
		return sqlSession.selectList(NAMESPACE + ".selectByUserid", userid);
	}

	@Override
	public List<EmpBoardVO> selectByTitle(String keyword) {
		LOGGER.info("selectByTitle() : keyword = " + keyword);
		keyword = "%" + keyword + "%";
		return sqlSession.selectList(NAMESPACE + ".selectBykeyword", keyword);
	}

	@Override
	public List<EmpBoardVO> selectByWorkArea(String workarea) {
		LOGGER.info("selectByWorkArea() : workarea = " + workarea);
		workarea = "%" + workarea + "%";
		return sqlSession.selectList(NAMESPACE + ".selectByworkarea", workarea);
	}
	

	
}
