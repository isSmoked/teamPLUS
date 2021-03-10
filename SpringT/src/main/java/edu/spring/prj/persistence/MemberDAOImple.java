package edu.spring.prj.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.MemberVO;

@Repository
public class MemberDAOImple implements MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImple.class);
	private static final String NAMESPACE = "edu.spring.prj.MemberMapper";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(MemberVO vo) {
		logger.info("DAO register() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		logger.info("DAO login() CALL");
		return sqlSession.selectOne(NAMESPACE + ".login", vo);
	}

	@Override
	public int checkAjax(MemberVO vo) {
		logger.info("DAO checkAjax() 호출");
		return sqlSession.selectOne(NAMESPACE + ".checkAjax", vo);
	}
	
	@Override
	public MemberVO select(String userid) {
		logger.info("DAO selectLogin() 호출 : userid = " + userid);
		return sqlSession.selectOne(NAMESPACE + ".selectLogin", userid);
	}

	@Override
	public MemberVO selectDetailPersonal(String userid) {
		logger.info("DAO selectDetailPersonal() 호출 : userid = " + userid);
		return sqlSession.selectOne(NAMESPACE + ".selectDetailPersonal", userid);
	}

	@Override
	public MemberVO selectDetailCompany(String userid) {
		logger.info("DAO selectDetailCompany() 호출 : userid = " + userid);
		return sqlSession.selectOne(NAMESPACE + ".selectDetailCompany", userid);
	}
	
	@Override
	public int updateDetailPersonal(MemberVO vo) {
		logger.info("DAO updateDetailPersonal() 호출");
		return sqlSession.update(NAMESPACE + ".updateDetailPersonal", vo);
	}

	@Override
	public int updateDetailCompany(MemberVO vo) {
		logger.info("DAO updateDetailCompany() 호출");
		return sqlSession.update(NAMESPACE + ".updateDetailCompany", vo);
	}
	
	@Override
	public int updateLoginInfo(MemberVO vo) {
		logger.info("DAO updateLoginInfo() 호출");
		return sqlSession.update(NAMESPACE + ".updateLoginInfo", vo);
	}

	@Override
	public String findId(MemberVO vo) {
		logger.info("DAO findId() 호출");
		return sqlSession.selectOne(NAMESPACE + ".findId", vo);
	}

	@Override
	public int findPwCheck(MemberVO vo) {
		logger.info("DAO findPwCheck() 호출 : 비번찾기 회원검사");
		return sqlSession.selectOne(NAMESPACE + ".findPwCheck", vo);
	}
			
	@Override
	public void newPassword(MemberVO vo) {
		logger.info("DAO newPassword() 호출 : 임시비밀번호 생성");
		sqlSession.update(NAMESPACE + ".newPassword", vo);
	}

} // MemberDAOImple
