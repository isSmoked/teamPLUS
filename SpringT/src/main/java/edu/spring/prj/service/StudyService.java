package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.StudyVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface StudyService {
	public abstract List<StudyVO> read();
	public abstract StudyVO read(int chat_bno);
	public abstract int create(StudyVO vo);
	public abstract int update(StudyVO vo);
	public abstract int delete(int chat_bno);
	
	public abstract  int getTotalNumsofRecords();
	public abstract List<StudyVO> read(PageCriteria criteria);
	
	public abstract List<StudyVO> read(String chat_userid);
	public abstract List<StudyVO> readByKeyword(String keyword);
	public abstract List<StudyVO> readByLocation(String keyword);
	
	public abstract int updateReadCount(int chat_bno);
	
	public abstract int updateCrew(StudyVO vo);
	public abstract int updateCrewWait(StudyVO vo);		
	public abstract int deleteCrew(StudyVO vo);			// 참여인원 목록에서 제거
	public abstract int deleteCrewWait(StudyVO vo);		// 대기인원 목록에서 제거
}
