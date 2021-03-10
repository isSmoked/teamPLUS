<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>아이디 찾기</title>
<style type="text/css">
.link {cursor: pointer;}
.link:hover {color:blue;}
</style>
</head>
<body>
    <form name="findId" action="postFindId" method="post">
	    <h2>아이디 찾기</h2>
	    <p>가입하신 이메일을 입력해주세요.</p>
	    <div>
	        <input type="email" name="email" placeholder="email을 입력해주세요" autofocus required>
		    <p>'@'포함한 이메일주소를 정확히 입력해주세요.</p>
	    </div>
	    <div>
	        <input type="submit" name="btn_find" value="아이디찾기">
	        <input type="button" name="btn_cancel" value="취소">
	    </div>
    </form>
    <br>
    <div>
    	<c:if test="${id ne null }">
	    	아이디는 <span style="color:blue;">${id }</span>입니다.
	    	<br>
	    	<p class="link" onclick="idToParent()" style="font-weight: bold;">[로그인하러 가기]</p>
    	</c:if>
   	</div>
    
    <input type="hidden" id="userid" value="${id }">
    	 
<script type="text/javascript">
    var btn_cancel = window.document.findId.btn_cancel;
    
    window.onload = function(){
        btn_cancel.onclick = function(){
            window.close();
        };
    };

    function idToParent(){
    	// opener.location.href="http://localhost:8080/project/member/login";
    	// opener.location.replace('login');
    	opener.document.getElementById("userid").value = $('#userid').val();
    	window.close();
    }
    
</script>
</body>
</html>