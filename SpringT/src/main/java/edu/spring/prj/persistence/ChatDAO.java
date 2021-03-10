package edu.spring.prj.persistence;

import edu.spring.prj.domain.ChatVO;

public interface ChatDAO {
	// 등록
	public abstract int insert(ChatVO vo);
	
	// 검색(아이디로)
	public abstract ChatVO select(String chat_userid);
	
	// 검색(번호로)
	public abstract ChatVO select(int chat_bno);
	
	// 수정
	public abstract int update(ChatVO vo);
	
	// 최근 쿼리 가져오기
	public abstract ChatVO selectDesc();
}
