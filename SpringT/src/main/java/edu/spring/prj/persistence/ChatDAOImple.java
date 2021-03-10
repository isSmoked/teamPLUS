package edu.spring.prj.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.spring.prj.domain.ChatVO;

@Repository
public class ChatDAOImple implements ChatDAO {

	private static final Logger logger =
			LoggerFactory.getLogger(ChatDAOImple.class);
	
	private static final String NAMESPACE =
			"edu.spring.prj.ChatMapper";
	
	@Autowired
	public SqlSession sqlsession;
	
	// 등록
	@Override
	public int insert(ChatVO vo) {
		logger.info("insert() 호출");
		return sqlsession.insert(NAMESPACE + ".chatInsert", vo);
	}

	// 하나 가져오기(아이디로)
	@Override
	public ChatVO select(String chat_userid) {
		logger.info("select() 호출 chatUserid - " + chat_userid);
		return sqlsession.selectOne(NAMESPACE + ".chatSelectByUserid", chat_userid);
	}
	
	// 번호로 하나 가져오가
	@Override
	public ChatVO select(int chat_bno)  {
		logger.info("select() 호출 chatBno - " + chat_bno);
		return sqlsession.selectOne(NAMESPACE + ".chatSelectByBno", chat_bno);
	}

	// 수정
	// TODO 수정은 bno로 해야겠다!
	// TODO layout-default > 메시지 핸들링 수정해야한다!
	@Override
	public int update(ChatVO vo) {
		logger.info("update() 호출 vo - " + vo.toString());
		return sqlsession.update(NAMESPACE + ".chatUpdate", vo);
	}
	
	// 제일 최근 쿼리 가져오기
	@Override
	public ChatVO selectDesc() {
		logger.info("selectDesc() 호출");
		return sqlsession.selectOne(NAMESPACE + ".chatSelectByDesc");
	}

}
