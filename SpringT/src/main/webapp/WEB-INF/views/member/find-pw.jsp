<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>비밀번호 찾기</title>
</head>
<body>
    
    <div>
		<form name="findPw" action="findPassword" method="post">
			<h2>비밀번호 찾기</h2>
			<p>
				이메일로 임시비밀번호를 보내드립니다.<br>
			</p>	
			<div>
				<input type="text" name="userid" placeholder="ID를 입력해주세요." autofocus required>
			</div>
			
			<div>
				<input type="email" name="email" placeholder="email을 입력해주세요" required>
				<p>'@'포함한 이메일주소를 정확히 입력해주세요.</p>
			</div>

			<div>
				<button type="submit">비밀번호찾기</button>
				<button type="button" id="btn_cancel">취소</button>
			</div>
		</form>
	</div>
    
    <input type="hidden" id="checkResult" value="${findPwCheck}">
    
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
    
    window.onload = function(){
    	/* 취소버튼 */
	    var btn_cancel = window.document.findPw.btn_cancel;
        btn_cancel.onclick = function(){
            window.close();
        };
    };
    
    checkResult();
    function checkResult() {
    	var checkResult = $('#checkResult').val();
    	console.log("리다이렉트어트리부트 : " + checkResult);
	    if(checkResult == "fail") {
	    	toastr["error"]("아이디와 이메일을 확인해주세요.");
	    }
    	
    }

</script>
</body>
</html>