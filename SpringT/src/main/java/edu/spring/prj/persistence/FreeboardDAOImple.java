package edu.spring.prj.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.pageutil.PageCriteria;

@Repository
public class FreeboardDAOImple implements FreeboardDAO {
	private static final Logger logger = LoggerFactory.getLogger(FreeboardDAOImple.class);
	private static final String NAMESPACE = "edu.spring.prj.FreeboardMapper";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<FreeboardVO> select() {
		logger.info("DAO select() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_all");
		// .select_all : board-mapper.xml의 id와 매칭
	}

	@Override
	public FreeboardVO select(int bno) {
		logger.info("DAO select() 호출 : bno = " + bno);
		return sqlSession.selectOne(NAMESPACE + ".select_by_bno", bno);
	}

	@Override
	public int insert(FreeboardVO vo) {
		logger.info("DAO insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public int update(FreeboardVO vo) {
		logger.info("DAO update() 호출");
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	@Override
	public int delete(int bno) {
		logger.info("DAO delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", bno);
	}

	@Override
	public int getTotalNumsOfRecords(PageCriteria criteria) {
		logger.info("DAO getTotalNumsOfRecords() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count", criteria);
	}

	@Override
	public List<FreeboardVO> select(PageCriteria criteria) {
		logger.info("DAO select() 호출 : page = " + criteria.getPage());
		return sqlSession.selectList(NAMESPACE + ".paging", criteria);
	}

	@Override
	public List<FreeboardVO> select(String userid) {
		logger.info("DAO select() 호출 : userid = " + userid);
		userid = "%" + userid + "%";
		return sqlSession.selectList(NAMESPACE + ".select_by_userid", userid);
	}

	@Override
	public List<FreeboardVO> selectByTitleOrContent(String keyword) {
		logger.info("DAO selectByTitleOrContent() : keyword = " + keyword);
		keyword = "%" + keyword + "%";
		return sqlSession.selectList(NAMESPACE + ".select_by_title_content", keyword);
	}
	
	@Override
	public int updateReplyCount(int amount, int bno) {
		Map<String, Integer> args = new HashMap<String, Integer>();
		args.put("amount", amount);
		args.put("bno", bno);
		return sqlSession.update(NAMESPACE + ".update_reply_count", args);
	}

	@Override
	public List<FreeboardVO> selectNotice() {
		logger.info("DAO notice() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_notice");
	}

}
