package edu.spring.prj.service;

import edu.spring.prj.domain.ChatVO;

public interface ChatService {
	public abstract int create(ChatVO vo);
	public abstract ChatVO read(String chat_userid);
	public abstract ChatVO read(int chat_bno);
	public abstract int update(ChatVO vo);
	public abstract ChatVO readDesc();
}
