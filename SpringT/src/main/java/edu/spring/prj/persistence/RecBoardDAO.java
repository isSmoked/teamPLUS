package edu.spring.prj.persistence;

import java.util.List;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface RecBoardDAO {
	
	public abstract List<RecBoardVO> select(); // 글 전체 가져오기 v
	public abstract int insert(RecBoardVO RecVO); // 글 등록 v
	public abstract int delete(int rno); // 글 삭제
	public abstract RecBoardVO select_by_rno(int rno); // 선택한 글 가져오기 v
	
	// 아이디 검색
	public abstract List<RecBoardVO> select(String userid);
	
	// 제목 검색
	public abstract List<RecBoardVO> selectByTitle(String keyword);
	
	// 근무지역 검색
	public abstract List<RecBoardVO> selectByWorkArea(String workarea);
	
	// 데이터 갯수 확인용
	public abstract int getTotalNumsOfRecords();
	public abstract List<RecBoardVO> select(PageCriteria criteria); // pageing처리된 select
	
	public abstract int boardHit(int rno); // 게시판 조회수
	
}
