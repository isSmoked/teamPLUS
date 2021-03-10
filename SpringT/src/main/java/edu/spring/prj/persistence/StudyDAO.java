package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.StudyVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface StudyDAO {
	// 기본 기능
	public abstract List<StudyVO> select();
	public abstract StudyVO select(int study_bno);
	public abstract int insert(StudyVO vo);
	public abstract int update(StudyVO vo);
	public abstract int delete(int study_bno);
	
	// 데이터 갯수 확인용
	public abstract int getTotalNumsOfRecords();
	public abstract List<StudyVO> select(PageCriteria criteria);
	
	// 작성자 검색
	public abstract List<StudyVO> select(String userid);
	
	// 제목 + 내용으로 검색
	public abstract List<StudyVO> selectByTitleOrContent(String keyword);

	// 장소 검색
	public abstract List<StudyVO> selectByLocation(String keyword);
	
	// 조회수 카운팅
	public abstract int updateReadCount(int study_bno);
	
	// 참여인원 업데이트
	// 대기명단 > 참여명단
	public abstract int updateCrew(StudyVO vo);
	// 대기명단 신규 등록
	public abstract int updateCrewWait(StudyVO vo);
	// 참여명단에서 제거
	public abstract int deleteCrew(StudyVO vo);
	// 대기명단에서 제거
	public abstract int deleteWait(StudyVO vo);
}
