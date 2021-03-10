package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.ManagerVO;
import edu.spring.prj.domain.MemberVO;
import edu.spring.prj.persistence.ManagerDAO;

@Service
public class ManagerServiceImple implements ManagerService {
	private static final Logger logger = LoggerFactory.getLogger(ManagerServiceImple.class);

	@Autowired
	private ManagerDAO dao;

	@Override
	public int updateNotice(FreeboardVO vo) {
		logger.info("ManagerService updateNotice() CALL");
		return dao.updateNotice(vo);
	}

	@Override
	public int updateBlacklist(MemberVO vo) {
		logger.info("ManagerService updateBlacklist() CALL");
		return dao.updateBlacklist(vo);
	}

	@Override
	public MemberVO detail(MemberVO vo) {
		logger.info("ManagerService detail() CALL");
		return dao.detail(vo);
	}

	@Override
	public List<MemberVO> searchMember(ManagerVO vo) {
		logger.info("ManagerService search_member() CALL");
		return dao.searchMember(vo);
	}

	@Override
	public int getTotalNumsOfSearching(ManagerVO vo) {
		logger.info("ManagerService getTotalNumsOfSearching() CALL");
		return dao.getTotalNumsOfSearching(vo);
	}

	@Override
	public int delete(String userid) {
		logger.info("ManagerService delete() CALL");
		return dao.delete(userid);
	}

	@Override
	public int registerManager(MemberVO vo) {
		logger.info("ManagerService registerManager() CALL");
		return dao.registerManager(vo);
	}
	
	
} // ManagerServiceImple
