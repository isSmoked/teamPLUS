<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>

<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<title>소모임장 전용 소모임 게시글</title>
</head>
<body>
	<input id="updateAlert" type="hidden" value="${update_result }">
	<br>
	<br>
	<br>
	
  	<h2 style="text-indent: 20%"><span style="font-size:60%;">title &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>${studyVO.study_title }</h2>
  	
  	<br><br>
	<!-- 최종 수정일 -->
	<div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label">
		<fmt:formatDate value="${studyVO.study_date }"
		pattern="YYYY-MM-dd E a HH:mm" var="cdate" />
		<strong style="100%">최종 수정 일  </strong></label> 
			<div class="col-sm-10">
				<label> ${cdate } </label>
			</div>
	</div>
	
	<!-- 모임 장소 -->
	<div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label">
			<strong>희망 장소 </strong>
		</label>
		<label class="col-sm-10"> ${studyVO.study_location } ${studyVO.study_detail_location }</label>
	</div>
	
	<hr>
	
	<div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label">
			<strong>참여 대기자</strong>
		</label>
	<table class="table table-hover" id="List">
		<thead>
			<tr class="active">
				<th style="width:60px;"> 번호</th>
				<th style="width:60px;"> 참여자</th>
				<th style="width:30px;"> </th>
				<th style="width:50px;"> </th>
			</tr>
		</thead>
		<tbody>
			<c:set value="${studyVO.study_crew_wait }" var="UserString" />
			<c:forEach items="${fn:split(UserString, ',')}" var="crewUser" varStatus="status">
				<c:if test="${ crewUser ne '0' && crewUser ne studyVO.study_userid}">
					<tr>
						<td>${status.count }</td>
						<td style="color: black; text-decoration: none;
	          				text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" >${crewUser }<input type="hidden" value="${crewUser }" id="crewUser"></td>
						
						<!-- 참여동의 버튼 -->
						<td>
						<form action="attend-wait" method="get">
							<a href="attend-wait?member=${studyVO.study_crew_count }&userid=${crewUser }&bno=${studyVO.study_bno }&page=${page}">
								<input class="btn btn-dark" type="button" value="참가동의" id="btn_crew_attend" onclick="messagingOK()">
							</a>
						</form>
						</td>
						
						<!-- 참여 거절 버튼 -->
						<td>
							<input class="btn btn-dark" type="button" id="ask-reject" value="대기자에서 제거"/> 
							<p id="reasonPartion"></p>
							<form action="attend-reject" method="get">
							<a href="attend-reject?member=${studyVO.study_crew_count }&userid=${crewUser }&bno=${studyVO.study_bno }&page=${page}">
								<input class="btn btn-dark" type="button" value="확인" id="btn_crew_delete" onclick="messagingNO()">
							</a>
							</form>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${studyVO.study_crew_wait eq '0' || studyVO.study_crew_wait eq '' }">
		<strong>                대기중인 참가자가 없습니다.</strong>
	</c:if>
	</div>
	<hr>
	
	<!-- 이미 참여확정된 사람들의 목록 -->
	<div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label">
			<strong>참가자</strong>
		</label>
	<table class="table table-hover" id="List">
		<thead>
			<tr class="active">
				<th style="width:30px;"> 번호</th>
				<th style="width:30px;"> 참여자</th>
				<th style="width:30px;"> </th>
			</tr>
		</thead>
		
		<tbody>
			<c:set value="${studyVO.study_crew_user }" var="UserString" />
			<c:forEach items="${fn:split(UserString, ',')}" var="crewUserA" varStatus="status">
				<tr>
					<c:if test="${crewUserA ne studyVO.study_userid }">
						<td>${status.count - 1}</td>
						<td style="color: black; text-decoration: none;
	          				text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" >${crewUserA }<input type="hidden" value="${crewUserA }" id="crewUserA"></td>
						<td><a href="attend-delete?member=${studyVO.study_crew_count }&userid=${crewUserA }&bno=${studyVO.study_bno }&page=${page}"><input class="btn btn-dark" type="button" value="모임에서 제거" name="btn_crew_delete" onclick="messagingDE();"></a></td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<hr>
	<a href="update?bno=${studyVO.study_bno }&page=${page}"><input class="btn btn-dark" type="button" value="글 수정"></a> 
    <a href="delete?bno=${studyVO.study_bno }"><input class="btn btn-dark" type="button" value="글 삭제"></a>
    <a href="list?page=${page }"><input class="btn btn-light" type="button" value="글 목록"></a>
    
    <input id="attendAlert" type="hidden" value="${attend_result }">
    <input id="deleteAlert" type="hidden" value="${attend_delete_result }">
    <input id="deleteWaitAlert" type="hidden" value="${wait_reject_result }">
    
    <script type="text/javascript">
    	
  		//toastr
		toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-bottom-center",
		  "preventDuplicates": true,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": "5000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		} // toastr
    

	    $(document).ready(function(){
			$('#btn_crew_delete').hide();
		});
	    
    	// socket
    	
    	var cmd = 'something';
    	var msgReceiver = 'anybody';
    	
    	// 하나의 소켓으로 여러갈래로 보내는법 >
    	// form / a - href / button(onclick-method)
    	// L javascript에 method별로 접근
    	
    	function messagingOK() {
    		console.log('btn_crew_attend pushed!');
    		cmd = 'attendOK';
    		msgReceiver = $('#crewUser').val();
    		message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;
    		sock.send(message);
    	};
    	
    	function messagingNO() {
    		console.log('btn_crew_reject pushed!');
    		var reason = $('#reason').val();
    		cmd = 'attendNO';
    		msgReceiver = $('#crewUser').val();
    		message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq + '*' + reason;
    		sock.send(message);
    	};
    	
    	function messagingDE() {
    		console.log('btn_crew_delete pushed!');
    		cmd = 'deleteNO';
    		msgReceiver = $('#crewUserA').val();
    		message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;
    		sock.send(message);
    	};
    	
    	$('#ask-reject').click(function() {
    		// 거절 버튼이 눌리면 사유를 선택할수 있게 보여준다.
    		var added = '<label><input type="text" id="reason" placeholder="사유를 입력하세요" value="사유없음" /></label>';
    		const reasonPart = document.getElementById('reasonPartion');
    		reasonPart.innerHTML = added;
    		$('#btn_crew_delete').show();
    		$('#ask-reject').hide();
    	});
    	
    	var msgSender = '${loginId}';
    	var msgBnoSeq = '${studyVO.study_bno}';
    	var msgPageSeq = '${page}';
    	
    	var message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;

    	// WebSocket
	  	var URL = window.location.host + window.location.pathname;
	  	var serverURL = URL.split("/")[0];
	  	console.log('url : ' + URL);
	  	console.log('host : ' + window.location.host);
	  	
	  	
	  	var sock = new WebSocket('ws://' + window.location.host + '/prj/studyBoard/websocket');
	  		
       	sock.onopen = function() {
       		console.log('websocket onopened');
       		console.log('will send : ' + message);
       	};
       	
       	sock.onmessage = function (event) {
    		// alarm
    		if (event.data.split(',')[0] !== 'chatMsg'){
    			console.log('알림 받음! - ' +  event.data);
    			toastr["info"](event.data);
    		}
    	};
       	
       	sock.onclose = function (event) {
             	console.log('websocket closed : ' + event);
        };
       	
       	
    	// ----------------------------------------------------------------------
    	confirmAttendResult();
	  	function confirmAttendResult() {
	    	var result = $('#attendAlert').val();
	    	if (result === 'success') {
	    		toastr["success"]('이용자가 모임에 등록 되었습니다');
	   		} else if(result === 'fail'){
	   			toastr["error"]('모임 등록이 실패하였습니다.')
	    	}
	  	}
	  	
	  	confirmDeleteResult();
	  	function confirmDeleteResult() {
	  		var result = $('#deleteAlert').val();
	  		if (result === 'success') {
	  			toastr["success"]('이용자가 모임에서 퇴출되었습니다.');
	  		} else if (result === 'fail') {
	  			toastr["error"]('이용자를 모임에서 내보내는데 실패하였습니다.');
	  		}
	  	}
	  	
	  	confirmDeleteWaitResult();
	  	function confirmDeleteWaitResult() {
	  		var result = $('#deleteWaitAlert').val();
	  		if (result === 'success') {
	  			toastr["success"]('이용자가 대기자 명단에서 삭제되었습니다.');
	  		} else if (result === 'fail') {
	  			toastr["error"]('이용자를 대기자 명단에서 삭제하는데 실패하였습니다.');
	  		}
	  	}
	  	
	  	
    </script>
	
	
	
</body>
</html>