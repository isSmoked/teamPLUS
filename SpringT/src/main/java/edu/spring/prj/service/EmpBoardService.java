package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface EmpBoardService {
	public abstract List<EmpBoardVO> read(); // 전체 글 읽어오기

	public abstract int create(EmpBoardVO EmpVO); // 글 등록
	public abstract int delete(int eno); // 글 삭제
	
	public abstract EmpBoardVO read_by_eno(int eno) throws Exception; // 클릭한 글 읽어오기
	
	public abstract int getTotalNumsOfRecords();
	public abstract List<EmpBoardVO> read(PageCriteria criteria);
	
	public abstract List<EmpBoardVO> read(String userid);
	public abstract List<EmpBoardVO> readByKeyword(String keyword);
	public abstract List<EmpBoardVO> readByWorkarea(String workarea);
	
	public abstract int boardHit(int eno);
	
}
