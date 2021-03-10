package edu.spring.prj;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.persistence.RecBoardDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@WebAppConfiguration
@ContextConfiguration(
		locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml"}
) 
public class BoardDAOTest {
	private static final Logger LOGGER =
			LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Autowired
	private RecBoardDAO recDao;
	
	@Test
	public void testDAO() {
//		testInsert();
//		testSelectAll();
		testSelectByBno();
//		testDelete();
//		testTotalCount();
//		testPaging();
//		testSelectSearch();
	}
	

	private void testPaging() {
		PageCriteria criteria = new PageCriteria(1, 5);
		List<RecBoardVO> list = recDao.select(criteria);
		for(RecBoardVO vo : list) {
			LOGGER.info(vo.toString());
		}
	}

	private void testTotalCount() {
		int result = recDao.getTotalNumsOfRecords();
		LOGGER.info("��ü ������ : " + result);
	}

	private void testDelete() {
		int result = recDao.delete(2);
		if(result == 1) {
			LOGGER.info("delete ����");
		} else {
			LOGGER.info("delete ����");
		}
	}


	public void testInsert() {
		RecBoardVO vo = new RecBoardVO(0, "test", "test", "test", null, "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", 0,"test");
		int result = recDao.insert(vo);
		if(result == 1) {
			LOGGER.info("insert ����");
		} else {
			LOGGER.info("insert ����");
		}
	}
	
	/*
	 * private void testSelectAll() { List<RecBoardVO> list = recDao.select();
	 * for(RecBoardVO vo : list) { LOGGER.info(vo.toString()); } }
	 */
	
	private void testSelectByBno() {
		RecBoardVO vo = recDao.select_by_rno(2);
		if(vo != null) {
			LOGGER.info(vo.toString());
		} else {
			LOGGER.info("������ ����");
		}
	}

}
