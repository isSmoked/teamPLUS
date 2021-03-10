package edu.spring.prj;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import edu.spring.prj.domain.RecBoardVO;

@RunWith(SpringJUnit4ClassRunner.class) 
@WebAppConfiguration
@ContextConfiguration(
		locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml"}
) 
public class SqlSessionTest {
	private static final Logger LOGGER =
			LoggerFactory.getLogger(SqlSessionTest.class);
	
	private static final String NAMESPACE =
			"edu.spring.prj.RecBoardMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void testInsert() {
		RecBoardVO vo = new RecBoardVO(0, "test", "test", "test", null, "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", 0,"test");
		int result = sqlSession.insert(NAMESPACE + ".insert", vo);
		// .insert : mapper.xml�� id��
		LOGGER.info(result + "�� ����");
	}
}
