package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.spring.prj.domain.StudyVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.persistence.StudyDAO;

@Service
public class StudyServiceImple implements StudyService{

	private static final Logger logger =
			LoggerFactory.getLogger(StudyServiceImple.class);
	
	@Autowired
	private StudyDAO dao;
	
	
	@Override
	public List<StudyVO> read() {
		logger.info("read() 호출");
		return dao.select();
	}

	@Override
	public StudyVO read(int study_bno) {
		logger.info("read() 호출 study_bno : " + study_bno);
		return dao.select(study_bno);
	}

	@Override
	public int create(StudyVO vo) {
		logger.info("create() 호출");
		return dao.insert(vo);
	}

	@Override
	public int update(StudyVO vo) {
		logger.info("update() 호출");
		return dao.update(vo);
	}

	@Override
	public int delete(int studyBno) {
		logger.info("delete() 호출");
		return dao.delete(studyBno);
	}

	@Override
	public int getTotalNumsofRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return dao.getTotalNumsOfRecords();
	}

	@Override
	public List<StudyVO> read(PageCriteria criteria) {
		logger.info("read() 호출 : page = " + criteria.getPage());
		return dao.select(criteria);
	}
	
	/* USERID로 검색 */
	@Override
	public List<StudyVO> read(String chat_userid) {
		logger.info("read() 호출 : study_userid = " + chat_userid);
		return dao.select(chat_userid);
	}
	
	/* 제목 + 내용으로 검색 */
	@Override
	public List<StudyVO> readByKeyword(String keyword) {
		logger.info("read(keyword) 호출 : keyword = " + keyword);
		return dao.selectByTitleOrContent(keyword);
	}

	/* 장소 검색 */
	@Override
	public List<StudyVO> readByLocation(String keyword) {
		logger.info("read(location) 호출 : keyword = " + keyword);
		return dao.selectByLocation(keyword);
	}
	
	/* 조회수 카운팅 */
	@Override
	public int updateReadCount(int study_bno) {
		logger.info("updateReadcount() 호출");
		return dao.updateReadCount(study_bno);
	}
	
	/* 참여인원 카운팅 */
	// 대기 > 참여
	@Override
	public int updateCrew(StudyVO vo){
		// 신청자수 증가
		logger.info("updateCrew() 호출");
		return dao.updateCrew(vo);
	}
	
	// > 대기
	@Override
	public int updateCrewWait(StudyVO vo) {
		logger.info("updateCrewWait() 호출");
		return dao.updateCrewWait(vo);
	}
	
	// 참여(삭제)
	@Override
	public int deleteCrew(StudyVO vo) {
		logger.info("deleteCrew() 호출");
		return dao.deleteCrew(vo);
	}
	
	// 대기(삭제)
	@Override
	public int deleteCrewWait(StudyVO vo) {
		logger.info("deleteCrewWait() 호출");
		return dao.deleteWait(vo);
	}
}
