package edu.spring.prj.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

	@Repository // Component
	// - 영속 계층(Persistence Layer)의 DB 관련 기능을 담당
	// - Spring Component bean으로 등록함
	// - 스프링 프레임워크가 bean을 생성하기 위해서는
	//	root-context.xml에 bean으로 등록해야함
	// - <context:component-scan .../>
	public class RecBoardDAOImple implements RecBoardDAO{
		private static final Logger LOGGER =
				LoggerFactory.getLogger(RecBoardDAOImple.class);
		
		private static final String NAMESPACE =
				"edu.spring.prj.RecBoardMapper";
		
		// MyBatis의 SqlSession을 사용하기 위해서
				// 스프링 프레임워크가 생성한 bean을 주입(injection)받음
				@Autowired
				private SqlSession sqlSession;
				
				
				/*
				 * @Override public List<RecBoardVO> select() { LOGGER.info("select() 호출");
				 * return sqlSession.selectList(NAMESPACE + ".select_all"); // .select_all :
				 * board-mapper.xml의 id와 매칭 }
				 */
				
				// select_all
				@Override
				public List<RecBoardVO> select() {
					LOGGER.info("select() 호출");
					return sqlSession.selectList(NAMESPACE + ".select_all");
				}
				
				// select_by_rno
				@Override
				public RecBoardVO select_by_rno(int rno) {
					LOGGER.info("select_by_rno 호출() : bno" + rno);
					return sqlSession.selectOne(NAMESPACE + ".select_by_recruit_bno", rno);
				}

				

				@Override
				public int insert(RecBoardVO RecVO) {
					LOGGER.info("insert() 호출");
					return sqlSession.insert(NAMESPACE + ".insert", RecVO);
				}

				@Override
				public int delete(int rno) {
					LOGGER.info("delete() 호출");
					return sqlSession.delete(NAMESPACE + ".delete", rno);
				}

				@Override
				public int getTotalNumsOfRecords() {
					LOGGER.info("getTotalNumsOfRecords() 호출");
					return sqlSession.selectOne(NAMESPACE + ".total_count");
				}

				@Override
				public List<RecBoardVO> select(PageCriteria criteria) {
					LOGGER.info("select() 호출 : page = " + criteria.getPage());
					return sqlSession.selectList(NAMESPACE + ".paging", criteria);
				}

				@Override
				public int boardHit(int rno) {
					LOGGER.info("boardHit() 호출");
					return sqlSession.update(NAMESPACE + ".boardHit", rno);
				}

				@Override
				public List<RecBoardVO> select(String userid) {
					LOGGER.info("select() 호출 : userid = " + userid);
					userid = "%" + userid + "%";
					return sqlSession.selectList(NAMESPACE + ".selectByUserid", userid);
				}

				@Override
				public List<RecBoardVO> selectByTitle(String keyword) {
					LOGGER.info("selectByTitle() : keyword = " + keyword);
					keyword = "%" + keyword + "%";
					return sqlSession.selectList(NAMESPACE + ".selectBykeyword", keyword);
				}

				@Override
				public List<RecBoardVO> selectByWorkArea(String workarea) {
					LOGGER.info("selectByWorkArea() : workarea = " + workarea);
					workarea = "%" + workarea + "%";
					return sqlSession.selectList(NAMESPACE + ".selectByworkarea", workarea);
				}

		
}
