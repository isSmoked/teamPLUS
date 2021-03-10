<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
.checkMessage{color:red;}
.error {color:red;}
tr {height:50px;}
td {padding-left: 10px;}
</style>
</head>
<body>
	<h2>&nbsp;회원가입</h2>
	<hr>
	<form:form commandName="memberVO" name="registerForm" action="register" method="post">
	<table>
		<tr>
			<td>
				회원구분 :
			</td>
			<td>
				<label><input type="radio" name="part" value="personal" checked="checked">&nbsp;개인회원</label>
				&nbsp;&nbsp;&nbsp;
				<label><input type="radio" name="part" value="company">&nbsp;기업회원</label>
			</td>
		</tr>
		<tr>
			<td>
				아이디 :
			</td>
			<td>
				<input type="text" name="userid" id="userid" maxlength="12" placeholder="아이디 입력" style="text-transform: lowercase;" autofocus required>
			</td>
			<td>
				<div class="checkMessage" id="idCheck">
				<form:errors path="userid" cssClass="error"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				비밀번호 :
			</td>
			<td>
				<input type="password" name="password" id="password" maxlength="25" placeholder="비밀번호 입력" required>
			</td>
			<td>
				<div class="checkMessage" id="passwordCheck">
				<form:errors path="password" cssClass="error"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				비밀번호확인 :
			</td>
			<td>
				<input type="password" id="passwordConfirm" maxlength="25" placeholder="비밀번호 확인" required>
			</td>
			<td>
				<div class="checkMessage" id="passwordConfirmCheck"></div>
			</td>
		</tr>
		<tr>
			<td>
				연락처 :
			</td>
			<td>
				<input type="text" name="phone" id="phone" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
				maxlength="20" placeholder="숫자만 입력" required>
			</td>
			<td>
				<div class="checkMessage" id="phoneCheck">
				<form:errors path="phone" cssClass="error"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				이메일 :
			</td>
			<td>
				<input type="email" name="email" id="email" placeholder="example@example.com" required>
			</td>
			<td>
				<div class="checkMessage" id="emailCheck">
				<form:errors path="email" cssClass="error"/>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<br>
				<p style="font-weight:bold;">* 이메일은 아이디와 비밀번호를 찾는데 이용됩니다.</p>
				<p>* 정확한 이메일을 입력해주세요.</p>
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="button" onclick="validate()" value="회원가입">
				<input type="button" value="취소" onclick="location.href='/project'">
	 		</td>
		</tr>
	</table>
	</form:form>
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
					
				
	var checkId = false;
	var checkPassword = false;
	var checkPasswordConfirm = false;
	var checkPhone = false;
	var checkEmail = false;
	
	
	/* 아이디 */
	$('#userid').change(function() {
		var regexId = /^[a-zA-Z0-9-_]{3,12}$/;
		var regexIdSpecial = /[\{\}\[\]\/?.,;:|\)*~`!^\+<>@\#$%&\\\=\(\'\"]/;
		var userid = $('#userid').val();
		var ajaxId = {};
		ajaxId.userid = userid;

		if (userid == ""){
			$('#idCheck').text("* 아이디를 입력해주세요.");
			checkId = false;
		} else if (regexIdSpecial.test(userid)) {
			$('#idCheck').text("* 특수기호는 '-', '_' 만 사용할 수 있습니다.");
			checkId = false;
		} else if (userid.length < 3) {
			$('#idCheck').text("* 3글자 이상 입력해주세요.");
			checkId = false;
		} else {			
		
		$.ajax({
			url : "checkAjax",
			type : "post",
			data : ajaxId,
			success : function(data) {
				if (data === 1) {
					console.log(data + ", 중복있음");							
						// 1 : 아이디가 중복되는 문구
						$("#idCheck").text("* 사용중인 아이디입니다.");
						checkId = false;
					} else {
						console.log(data + ", 중복없음");	
						if (regexId.test(userid)){
							// 0 : 아이디 길이 / 문자열 검사
							// 사용가능한 아이디
							$("#idCheck").text("");
							checkId = true;
						} else {
							$('#idCheck').text("* 영문자, 숫자, '-', '_' 그리고 3~12자리만 가능합니다.");
							checkId = false;
						}
					}
				}, error : function() {
						console.log("실패");
				}
			}); // ajax
		} // else
	}); // userid.change()
	
		
	/* 비밀번호 */
	$('#password').change(function(){
		var regexPassword = /^(?=.*[a-zA-Z])(?=.*[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"])(?=.*[0-9]).{8,25}$/;
		var password = $('#password').val();
		
    	if ($('#password').val() == "") {
    		$('#passwordCheck').text("* 비밀번호를 입력해주세요");
    		checkPassword = false;
    	} else if (!regexPassword.test(password)) {
			$('#passwordCheck').text("* 숫자+영문자+특수문자 8~25자리만 가능 합니다.");
    		checkPassword = false;
		} else {
    		$("#passwordCheck").text("");
    		checkPassword = true;
    	}
    });
	
	$('#password').change(function(){
		if ($('#passwordConfirm').val() == "") {
			checkPasswordConfirm = false;
		} else if ($('#password').val() != $("#passwordConfirm").val()) {
			$('#passwordConfirmCheck').text("* 비밀번호가 일치하지않습니다");
			checkPasswordConfirm = false;
		} else if ($('#password').val() == $("#passwordConfirm").val()) {
			$('#passwordConfirmCheck').text("");
			checkPasswordConfirm = true;
		}
	});
	
	/* 비밀번호 확인 */
	$('#passwordConfirm').change(function(){
	    if ($('#passwordConfirm').val() == "") {
	    	$('#passwordConfirmCheck').text("* 비밀번호를 확인해주세요");
	    	checkPasswordConfirm = false;
	    } else if ($('#password').val() != $("#passwordConfirm").val()) {
			$('#passwordConfirmCheck').text("* 비밀번호가 일치하지않습니다");
	    	checkPasswordConfirm = false;
		} else {
	    	$('#passwordConfirmCheck').text("");
	    	checkPasswordConfirm = true;
	    }
	});
	      
	    
	/* 연락처 */
	$('#phone').change(function(){
    	if ($('#phone').val() == "") {
    		$('#phoneCheck').text("* 연락처를 입력해주세요");
    		checkPhone = false;
    	} else {
    		$("#phoneCheck").text("");
    		checkPhone = true;
    	}
    });
    
    
	/* 이메일 */    
    $('#email').change(function(){
    	var regexEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    	var email = $('#email').val();
		var ajaxEmail = {};
		ajaxEmail.email = email;

		if ($('#email').val() == "") {
    		$('#emailCheck').text("* 이메일을 입력해주세요");
    		checkEmail = false;
    	} else if (!regexEmail.test(email)) {
    		$('#emailCheck').text("* 이메일 형식이 올바르지 않습니다.");
    		checkEmail = false;
    	} else {

			$.ajax({
				url : "checkAjax",
				type : "post",
				data : ajaxEmail,
				success : function(data){
					if (data === 1) {
						// 1: 같은 이메일이 존재할 경우
						$("#emailCheck").text("* 이미 사용 중인 이메일입니다.");
						checkEmail = false;
					} else {
						// 0 : 같은 이메일이 존재하지 않는 경우
						$("#emailCheck").text("");
			    		checkEmail = true;
					}
					console.log("test success : " + data);				
				}, error : function(data){
					console.log("test error : " + data);
				}
			}); // ajax
    	} // else
    }); // email.change()

	
	// 회원가입버튼 누르면 실행
	function validate() {
		if (checkId == false) {
			toastr["error"]("아이디를 확인해주세요.");
		} else if (checkPassword == false) {
			toastr["error"]("비밀번호를 확인해주세요.");
		} else if (checkPasswordConfirm == false) {
			toastr["error"]("비밀번호를 확인해주세요.");
		} else if (checkEmail == false) {
			toastr["error"]("이메일을 확인해주세요.");
		} else if (checkPhone == false) {
			toastr["error"]("연락처를 확인해주세요.");
		} else {
			document.registerForm.submit();
		}
	} // validate()
		
	</script>
   
</body>
</html>