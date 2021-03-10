package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface EmpBoardDAO {
	public abstract List<EmpBoardVO> select(); // 글 전체 가져오기 v

	public abstract int insert(EmpBoardVO EmpVO); // 글 등록 v
	public abstract int delete(int eno); // 글 삭제
	
	public abstract EmpBoardVO select_by_eno(int eno); // 선택한 글 가져오기 v
	
	// 아이디 검색
	public abstract List<EmpBoardVO> select(String userid);
	
	// 제목 검색
	public abstract List<EmpBoardVO> selectByTitle(String keyword);
	
	// 근무지역 검색
	public abstract List<EmpBoardVO> selectByWorkArea(String workarea);
	
	public int boardHit(int eno); // 게시판 조회수
	
	public abstract int getTotalNumsOfRecords();
	public abstract List<EmpBoardVO> select(PageCriteria criteria); // pageing처리된 select
}
