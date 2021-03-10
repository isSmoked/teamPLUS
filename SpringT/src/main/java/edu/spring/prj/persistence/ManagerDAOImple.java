package edu.spring.prj.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.ManagerVO;
import edu.spring.prj.domain.MemberVO;

@Repository
public class ManagerDAOImple implements ManagerDAO {
	private static final Logger logger = LoggerFactory.getLogger(ManagerDAOImple.class);
	private static final String NAMESPACE = "edu.spring.prj.ManagerMapper";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int updateNotice(FreeboardVO vo) {
		logger.info("Manager DAO updateNotice() CALL");
		return sqlSession.update(NAMESPACE + ".update_notice", vo);
	}

	@Override
	public int updateBlacklist(MemberVO vo) {
		logger.info("Manager DAO updateBlacklist() CALL");
		return sqlSession.update(NAMESPACE + ".update_blacklist", vo);
	}

	@Override
	public MemberVO detail(MemberVO vo) {
		logger.info("Manager DAO detail() CALL");
		return sqlSession.selectOne(NAMESPACE + ".detail", vo);
	}

	@Override
	public List<MemberVO> searchMember(ManagerVO vo) {
		logger.info("Manager DAO search_member() CALL");
		return sqlSession.selectList(NAMESPACE + ".ajax_paging", vo);
	}

	@Override
	public int getTotalNumsOfSearching(ManagerVO vo) {
		logger.info("Manager DAO getTotalNumsOfSearching() 호출");
		return sqlSession.selectOne(NAMESPACE + ".ajax_total_count", vo);
	}

	@Override
	public int delete(String userid) {
		logger.info("Manager DAO delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", userid);
	}

	@Override
	public int registerManager(MemberVO vo) {
		logger.info("Manager DAO registerManager() 호출");
		return sqlSession.insert(NAMESPACE + ".register", vo);
	}


}
