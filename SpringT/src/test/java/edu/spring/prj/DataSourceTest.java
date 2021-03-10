package edu.spring.prj;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class DataSourceTest {
	private static final Logger LOGGER =
			LoggerFactory.getLogger(DataSourceTest.class);
	
	// Spring Framework�� �����ϴ� DataSource ��ü�� ���Թ���
	// - root-context.xml���� bean���� ����� Datasource ��ü�� ���Թ���
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void testDataSource() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
			LOGGER.info("DataSource ���� ����");
		} catch (SQLException e) {
			LOGGER.info("DataSource ���� ���� : " + e.getMessage());
		} finally {
			try {
				conn.close();
				LOGGER.info("DataSource ���� ��ȯ ����");
			} catch (SQLException e) {
				LOGGER.error("DataSource ���� ��ȯ ���� : " + e.getMessage());
			}
		}
	}
	
}
