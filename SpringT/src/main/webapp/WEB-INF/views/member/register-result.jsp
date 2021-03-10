<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>회원가입이 완료되었습니다.</title>
<style type="text/css">
.regiResult {padding-left: 10px;}
</style>
</head>
<body>
<div class="regiResult">
<h2>환영합니다. ★(°▽°)ﾉ</h2>

<h2>회원가입이 완료되었습니다.</h2>
<hr>
<p>아이디 : ${registerVO.userid}</p>
<p>연락처 : ${registerVO.phone}</p>
<p>이메일 : ${registerVO.email}</p>
<br>
<a href="login">로그인 하러 가볼까요?</a>
</div>

</body>
</html>