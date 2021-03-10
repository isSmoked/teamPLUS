<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>비밀번호 찾기</title>
</head>
<body>
<h2>비밀번호 찾기</h2>

메일로 임시비밀번호가 전송되었습니다.<br>
<br>
메일을 확인해주세요.<br>
<br>

<input type="button" value="창닫기" onclick="closing()">
<br>
<br>

<div id="message" style="color:blue;"></div>


<script type="text/javascript">

var time = 10; //기준시간 작성
var min = ""; //분
var sec = ""; //초

//setInterval(함수, 시간) : 주기적인 실행
var x = setInterval(function() {
	//parseInt() : 정수를 반환
	min = parseInt(time/60); //몫을 계산
	sec = time%60; //나머지를 계산

	document.getElementById("message").innerHTML = sec + "초 뒤에 창이 닫힙니다.";
	time--;

	//타임아웃 시
	if (time < 0) {
		clearInterval(x); //setInterval() 실행을 끝냄
		document.getElementById("message").innerHTML = "창이닫힙니다.";
		self.close();
	}
}, 1000);

function closing(){
	window.close();
}

</script>
 
</body>
</html>