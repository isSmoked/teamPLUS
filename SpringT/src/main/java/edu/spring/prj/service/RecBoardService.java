package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

// CRUD(CREATE, READ, UPDATE, DELETE)
public interface RecBoardService {
	public abstract List<RecBoardVO> read(); // 전체 글 읽어오기
	
	public abstract RecBoardVO read_by_rno(int rno) throws Exception; // 클릭한 글 읽어오기
	public abstract int create(RecBoardVO RecVO); // 글 등록
	public abstract int delete(int rno); // 글 삭제
	
	public abstract int getTotalNumsOfRecords();
	public abstract List<RecBoardVO> read(PageCriteria criteria);
	
	public abstract List<RecBoardVO> read(String userid);
	public abstract List<RecBoardVO> readByKeyword(String keyword);
	public abstract List<RecBoardVO> readByWorkarea(String workarea);
	
	public abstract int boardHit(int rno);
	

	
}
