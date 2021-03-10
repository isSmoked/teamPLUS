<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
.checkMessage {color : red;}
tr {height:50px;}
td {padding-left: 10px;}
</style>
</head>
<body>
	<h2>&nbsp;로그인</h2>
	<hr>
	<form name='loginForm' method="post" action="login-post">
		<table style="width:90%;">
			<tr>
				<td>
					<input type="text" name="userid" id="userid" placeholder="아이디 입력" style="text-transform: lowercase;" required autofocus>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="password" placeholder="비밀번호 입력" required>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="idSaveCheck">&nbsp;아이디 기억하기<br><br>
					<button type="submit">로그인</button>
					<input type="button" value="취소" onclick="location.href='/project'">
				</td>
			</tr>
			<tr>
				<td>
					<a href=# onclick="findId()">아이디찾기</a>&nbsp;|&nbsp;
					<a href=# onclick="findPw()">비밀번호찾기</a>&nbsp;|&nbsp;
					<a href=# onclick="location.href='register'">회원가입</a>
				</td>
			</tr>
		</table>
	<input type="hidden" name="targetUrl" value="${targetUrl }" />
	</form>
	<input type="hidden" id="loginResult" value="${loginResult }">
	<script type="text/javascript">
	// toastr
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
	
	/* 로그인 실패시 알람 */					
	resultAlert();		
	function resultAlert(){
		var loginResult = $('#loginResult').val();
		if (loginResult === 'fail'){
			toastr["error"]("아이디와 비밀번호를 확인해주세요.");
			// 세션 loginResult 복구
			<%session.removeAttribute("loginResult"); %>
			}
	} // resultAlert()
	


	window.name = "login";
	function findId(){
		console.log("findId() CALL");
		var popWidth  = '400'; // 파업사이즈 너비
		var popHeight = '330'; // 팝업사이즈 높이
		
		var winWidth  = document.body.clientWidth;  // 현재창의 너비
		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
		var w = winX + (winWidth - popWidth) / 2;
		var h = winY + (winHeight - popHeight) / 2;
	    window.open('find-id', 'finding', 'status=no, height=' + popHeight  + ', width=' + popWidth  + ', left='+ w + ', top='+ h);
	};
	
	function findPw(){
		console.log("findPw() CALL");
		var popWidth  = '400'; // 파업사이즈 너비
		var popHeight = '330'; // 팝업사이즈 높이
		
		var winWidth  = document.body.clientWidth;  // 현재창의 너비
		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
		var w = winX + (winWidth - popWidth) / 2;
		var h = winY + (winHeight - popHeight) / 2;
	    window.open('find-pw', 'finding', 'status=no, height=' + popHeight  + ', width=' + popWidth  + ', left='+ w + ', top='+ h);
	};
	
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++
	

	$(document).ready(function(){

		/* 쿠키정보 불러오기 */
	    var cookieId = getCookie("cookieId");
	    var cookieCheck = getCookie("cookieCheck");
	    
	    if (cookieCheck === 'Y'){
	        $('#idSaveCheck').prop("checked", true);
	    } else {
	        $('#idSaveCheck').prop("checked", false);
	    }
	    
	    $("#userid").val(cookieId); 
	    
	    /* 아이디저장하기 체크박스 */
	    $('#idSaveCheck').change(function(){
	        if ($('#idSaveCheck').is(":checked")) { 
	            var cookieId = $('#userid').val();
	            setCookie("cookieId", cookieId, 7); 
	            setCookie("cookieCheck", "Y", 7);
	        } else {
	            deleteCookie("cookieId");
	            deleteCookie("cookieCheck");
	        }
	    }); // 아이디저장하기 체크박스 

	    /* 아이디저장하기 키를 입력할 경우 */
	    $('#userid').keyup(function(){
	        if ($('#idSaveCheck').is(":checked")) { 
	            var cookieId = $('#userid').val();
	            setCookie("cookieId", cookieId, 7); 
	            setCookie("cookieCheck", "Y", 7);
	        } else {
	            deleteCookie("cookieId");
	            deleteCookie("cookieCheck");
	        }
	    }); // 아이디저장하기 키입력
	    
	}); // document.ready

	/* 쿠키 설정 */
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
	    exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	} // setCookie
	
	/* 쿠키 삭제 */
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	} // deleteCookie

	/* 쿠키 가져오기 */
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	} // getCookie


	</script>
	
</body>
</html>