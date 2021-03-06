package edu.spring.prj.socketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class EchoHandler extends TextWebSocketHandler{
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	/* TODO : 여기서 해당 모임에 관련된 사람들만 검색해서 메시지를 보내야 한다. */
	
	private static final Logger logger =
			LoggerFactory.getLogger(EchoHandler.class);
	
	// 1 대 1
	Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결시
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			logger.info("afterConnectionEstablished() 호출");
			
			String userid = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
			if (userid != null) {	// 로그인 값이 있는 경우만
				logger.info("로그인 값이 있어서 로그인됨! userid = " + userid);
				users.put(userid, session);   // 로그인중 개별유저 저장
				sessions.add(session);
			}
		} // end afterConnectionEstablished()
		
		// 클라이언트가 Data 전송 시
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			logger.info("***** handleTextMessage() 호춯 message : " + message.getPayload());
			// protocol : cmd , 댓글작성자, 게시글 작성자 , seq (reply , user2 , user1 , 12)
			String msg = message.getPayload();
			
			// 들어오는 메시지 > attend,zz,aaa,42,1
			String[] strs = msg.split("[*]");

			for (int i = 0; i < strs.length; i++) {
				logger.info("strs[" + i + "] = " + strs[i]);
			}
			
			if (strs != null && strs.length == 5) {
				String cmd = strs[0];		// 명령어 - 나중에 다른 경로에서 다른 기능의 알림을 추가할때, 구분의 용도
				String receiver = strs[1];	// 수신하는 이용자의 id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// 호출하는 이용자의 id
				
				// 알림을 누르면 해당페이지로 접근하기위해 필요한 매개변수들을 추가 -> detail-admin.jsp
				/* bno, page 전송! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				
				// 참석 Alert
				if (cmd.equals("attend")) {				// 이용자가 모임에 참석할 때 (cmd = attend)
					for (int i = 0; i < waiter.length; i++) {
						logger.info("attend - for()");
						// 작성자가 로그인 해서 있다면
						WebSocketSession boardWriterSession = users.get(waiter[i]);
						
						// 여기 실행과정에서 오류
						if (boardWriterSession != null) {
							TextMessage tmpMsg = new TextMessage(caller + "님이 " + 
									"<div><a type='external' href='/prj/studyBoard/detail-admin?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "번 모임에 참가신청을 하였습니다. </a></div>");
							logger.info("******** 보내려는 메세지 : " + tmpMsg);
							boardWriterSession.sendMessage(tmpMsg);
						} else {
							logger.info(waiter[i] + "님은 로그아웃 중 입니다."); // 로그아웃 중이면 쪽지함에 쌓이도록 설정!
						}
					}
				} else if (cmd.equals("attendOK")) {	// 이용자를 모임에 참석 시킬때 (cmd = attendOK)
					
					logger.info("attend**OK - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "번 모임에 참가 되었습니다. </a></div>");
						logger.info("********* 보내려는 메세지 : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "님은 로그아웃 중입니다.");
					}
					
				} else if (cmd.equals("chatMsg")) {
					
					logger.info("chatMsg - for()");
					
					/* 로그인중인 모든 유저에게 보낼 때 > chatMsg */
					
					for (WebSocketSession sess : sessions) {
//						
						// message handle
						String chatMsg = receiver;
						
						sess.sendMessage(new TextMessage("chatMsg," + caller + " ^ " + chatMsg));
						logger.info("chatMsg 정상적으로 전송 완료!");
					}
					
				} else if (cmd.equals("deleteNO")) {
					
					logger.info("deleteNO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "번 모임에서 쫓겨나게 되었습니다. </a></div>");
						logger.info("********* 보내려는 메세지 : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "님은 로그아웃 중입니다.");
					}
				}
				
			} // end str == 5
			
			if (strs != null && strs.length == 6) {
				
				String cmd = strs[0];		// 명령어 - 나중에 다른 경로에서 다른 기능의 알림을 추가할때, 구분의 용도
				String receiver = strs[1];	// 수신하는 이용자의 id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// 호출하는 이용자의 id
				
				// 알림을 누르면 해당페이지로 접근하기위해 필요한 매개변수들을 추가 -> detail-admin.jsp
				/* bno, page 전송! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				String rejectMessage = strs[5]; 
				
				
				if (cmd.equals("attendNO")) { 	// 이용자를 모임에서 제거할 때 (cmd = attendNO)
					
					logger.info("attend**NO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "번 모임에 [" + rejectMessage + "] 사유로 참가 실패하였습니다. </a></div>");
						logger.info("********* 보내려는 메세지 : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "님은 로그아웃 중입니다.");
					}
				} 
			}
			
		} // end handleTextMessage()
		
		// 연결 해제될 때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			logger.info("afterConnectionClosed " + session + ", " + status);
			String senderId = getMemberId(session);
			if(senderId != null) {	// 로그인 값이 있는 경우만
				logger.info("로그인 값이 있어서 로그아웃가능 ! senderId : " + senderId + " 연결 종료됨");
				users.remove(senderId);
			}
			sessions.remove(session);
		} // end afterConnectionClosed()
		
		// 에러 발생시
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			logger.info("error 발생! : " + session.getId() + " 익셉션 발생: " + exception.getMessage());

		} // end handleTramsportError()
		
		// 웹소켓에 id 가져오기
	    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		private String getMemberId(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			String userid = (String) httpSession.get("loginId"); // 세션에 저장된 m_id 기준 조회
			return userid == null? null: userid;
		} // end getMemberId()
		
		
}
