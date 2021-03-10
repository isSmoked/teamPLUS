package edu.spring.prj.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.StudyVO;
import edu.spring.prj.pageutil.PageCriteria;

@Repository
public class StudyDAOImple implements StudyDAO {

	private static final Logger logger =
			LoggerFactory.getLogger(StudyDAOImple.class);
	
	private static final String NAMESPACE =
			"edu.spring.prj.StudyMapper";
	
	@Autowired
	public SqlSession sqlSession;
	
	
	/* 등록 - INSERT */
	@Override
	public int insert(StudyVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	/* 전체 - SELECT */
	@Override
	public List<StudyVO> select() {
		logger.info("select() 호출");
		return sqlSession.selectList(NAMESPACE + ".selectAll");
	}

	/* 선택 - SELECT */
	@Override
	public StudyVO select(int study_bno) {
		logger.info("select() 호출");
		return sqlSession.selectOne(NAMESPACE + ".selectByBno", study_bno);
	}

	/* 수정 - UPDATE */
	@Override
	public int update(StudyVO vo) {
		logger.info("update() 호출");
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	/* 삭제 - DELETE */
	@Override
	public int delete(int study_bno) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", study_bno);
	}

	/* 페이지 갯수 확인 */
	/* 전체 페이지수 */
	@Override
	public int getTotalNumsOfRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return sqlSession.selectOne(NAMESPACE + ".totalCount");
	}

	/* 정해진 갯수만큼의 게시물 불러오기 */
	@Override
	public List<StudyVO> select(PageCriteria criteria) {
		logger.info("select() 호출 : page = " + criteria.getPage());
		return sqlSession.selectList(NAMESPACE + ".paging", criteria);
	}

	/* USERID로 검색 */
	@Override
	public List<StudyVO> select(String studyUserid) {
		logger.info("select() 호출 : userid = " + studyUserid);
		studyUserid = "%" + studyUserid + "%";
		return sqlSession.selectList(NAMESPACE + ".selectByUserid", studyUserid);
	}

	/* 제목+내용으로 검색 */
	@Override
	public List<StudyVO> selectByTitleOrContent(String keyword) {
		logger.info("selectByTitleOrContent() : keyword = " + keyword);
		keyword = "%" + keyword + "%";
		return sqlSession.
		selectList(NAMESPACE + ".selectByTitleContent", keyword);
	}

	/* 장소 검색 */
	@Override
	public List<StudyVO> selectByLocation(String keyword) {
		logger.info("selectByLocation() : keyword = " + keyword);
		keyword = "%" + keyword + "%";
		return sqlSession.selectList(NAMESPACE + ".selectByLocation", keyword);
	}
	
	/* 조회수 카운팅 */
	@Override
	public int updateReadCount(int study_bno) {
		logger.info("updateReadcount() 호출");
		return sqlSession.update(NAMESPACE + ".updateReadCount", study_bno);
	}
	
	/* 참여인원 업데이트 */
	// 대기 > 참여
	@Override
	public int updateCrew(StudyVO vo) {
		logger.info("updateCrewCount() 호출");
		return sqlSession.update(NAMESPACE + ".updateToCrewCount", vo);
	}
	
	// 대기 신규
	@Override
	public int updateCrewWait(StudyVO vo) {
		logger.info("updateCrewWait() 호출");
		return sqlSession.update(NAMESPACE + ".updateToCrewWait", vo);
	}
	
	// 참여(제거)
	@Override
	public int deleteCrew(StudyVO vo) {
		logger.info("deleteCrew() 호출");
		return sqlSession.update(NAMESPACE + ".deleteToCrewCount", vo);
	}
	
	// 대기(제거)
	@Override
	public int deleteWait(StudyVO vo) {
		logger.info("deleteWait() 호출");
		return sqlSession.update(NAMESPACE + ".deleteToCrewWait", vo);
	}
}
