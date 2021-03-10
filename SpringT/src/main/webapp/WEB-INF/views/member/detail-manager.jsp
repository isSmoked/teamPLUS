<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>관리자</title>
<style type="text/css">
tr {height:30px;}
td {padding-left: 10px;}
.msg {color: red;}
.activity {
border:none;
min-width: 300px;
}
</style>
</head>
<body>
	<h2>&nbsp;관리자정보</h2>
	<hr>
	<p>&nbsp;&nbsp;&nbsp;<b>[로그인 정보]</b></p>
		<table>
			<tr>
				<td>아이디</td>
				<td><input style="border:none; outline:none;" type="text" id="userid" value="${loginId }" readonly></td>
			</tr>

			<tr>
				<td>
					비밀번호
				</td>
				<td>
					<div id="pwUpdateOptions" style="display:none;">
						<input type="password" id="pwOld" maxlength="25" placeholder="현재 비밀번호 입력"><div class="msg" id="msgPwOld"></div>
						<input type="password" id="pw" maxlength="25" placeholder="변경할 비밀번호 입력"><div class="msg" id="msgPw"></div>
						<input type="password" id="pwConfirm" maxlength="25" placeholder="변경할 비밀번호 확인"><div class="msg" id="msgPwConfirm"></div>
					</div>
					<div>
						<button id="btn_pwUpdate" onclick="pwUpdate()">비밀번호변경</button>
						<button type="button" id="btn_pwCancel" style="display:none;">취소</button>
	 				</div>
				</td>
			</tr>
			
			<tr>
				<td>연락처</td>
				<td>
					<input type="text" id="phone" value="${loginVO.phone }" maxlength="20" placeholder="정보를 입력해주세요."
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="border:none;" readonly>
					<input type="hidden" id="hiddenPhone" value="${loginVO.phone }">
				</td>
				<td>
					<button type="button" id="btn_phoneUpdate" onclick="phoneUpdate()">수정</button>
					<button type="button" id="btn_phoneCancel" style="display:none;">취소</button>
				</td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td>
					<input type="text" id="email" value="${loginVO.email }" style="border:none;" placeholder="정보를 입력해주세요." readonly>
					<input type="hidden" id="hiddenEmail" value="${loginVO.email }">
				</td>
				<td>
					<button type="button" id="btn_emailUpdate" onclick="emailUpdate()">수정</button>
					<button type="button" id="btn_emailCancel" style="display:none;">취소</button>
				</td>
			</tr>
		</table>
	<hr>
	<br>
	&nbsp;&nbsp;&nbsp;<a href="#leave" onclick="leave()">회원탈퇴</a>
	<hr>

	<br>
	<br>
	<br>
	<br>
	<br>

	<!-- JSON 입력과 조회를 위한 태그 -->
	<div style="display:none;" id="VOjson">${personalVO.personal_json }</div>
	<input id="updateResult" type="hidden" value="${updateResult}">

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
					

					
	/* 비밀번호 입력칸 확인용 */
	var checkPwOld = false;
	var checkPassword = false;
	var checkPasswordConfirm = false;
	
	/* 비밀번호 업데이트 */
	function pwUpdate(){
		if(document.getElementById('pwUpdateOptions').style.display === 'inline') {
			validatePw();
  	    } else {
  	        document.getElementById('pwUpdateOptions').style.display = 'inline';
  	        document.getElementById('btn_pwCancel').style.display = 'inline';
  	        document.getElementById('btn_pwUpdate').textContent = '변경';
  	        document.getElementById('pwOld').focus();
  	    }
	} // pwUpdate()
	
	/* 비밀번호변경 취소버튼 */
	$('#btn_pwCancel').click(function(){
		$('#pwOld').val("");
		$('#pw').val("");
		$('#pwConfirm').val("");
		$('#msgPwOld').text("");
		$('#msgPw').text("");
		$('#msgPwConfirm').text("");
	    document.getElementById('pwUpdateOptions').style.display = 'none';
	    document.getElementById('btn_pwCancel').style.display = 'none';
        document.getElementById('btn_pwUpdate').textContent = '비밀번호변경';
	}); // btn_pwCancel
		
	/* 현재비밀번호 */
	$('#pwOld').change(function(){
		var pwOld = $('#pwOld').val();
		if (pwOld === "") {
			$('#msgPwOld').text("* 현재 비밀번호를 입력해주세요.");
			checkPwOld = false;
		} else {
			$('#msgPwOld').text("");
			checkPwOld = true;
		}
	});
	
	/* 새로운 비밀번호 */
	$('#pw').change(function(){
		var regexPassword = /^(?=.*[a-zA-Z])(?=.*[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"])(?=.*[0-9]).{8,25}$/;
		var pw = $('#pw').val();
    	if (pw === "") {
    		$('#msgPw').text("* 비밀번호를 입력해주세요");
    		checkPassword = false;
    	} else if (!regexPassword.test(pw)) {
			$('#msgPw').text("* 숫자+영문자+특수문자 8~25자리만 가능 합니다.");
    		checkPassword = false;
		} else {
    		$("#msgPw").text("");
    		checkPassword = true;
    	}
    });
	
	$('#pw').change(function(){
		var pw = $('#pw').val();
		var pwConfirm = $('#pwConfirm').val();
		if (pwConfirm === "") {
			checkPasswordConfirm = false;
		} else if (pw != pwConfirm) {
			$('#msgPwConfirm').text("* 비밀번호가 일치하지않습니다");
			checkPasswordConfirm = false;
		} else if (pw === pwConfirm) {
			$('#msgPwConfirm').text("");
			checkPasswordConfirm = true;
		}
	});

	/* 새로운 비밀번호 확인 */
	$('#pwConfirm').change(function(){
		var pw = $('#pw').val();
		var pwConfirm = $('#pwConfirm').val();
	    if (pwConfirm === "") {
	    	$('#msgPwConfirm').text("* 비밀번호를 확인해주세요");
	    	checkPasswordConfirm = false;
	    } else if (pw != pwConfirm) {
			$('#msgPwConfirm').text("* 비밀번호가 일치하지 않습니다");
	    	checkPasswordConfirm = false;
		} else {
	    	$('#msgPwConfirm').text("");
	    	checkPasswordConfirm = true;
	    }
	});
	
	/* 비밀번호 변경 */
	function validatePw() {
		if (checkPwOld == false) {
			toastr["error"]("현재 비밀번호를 확인해주세요.");
			$('#pwOld').focus();
		} else if (checkPassword == false) {
			toastr["error"]("변경할 비밀번호를 확인해주세요.");
			$('#pw').focus();
		} else if (checkPasswordConfirm == false) {
			toastr["error"]("비밀번호를 확인해주세요.");
			$('#pwConfirm').focus();
		} else {
			// 현재 비밀번호 확인
			var oldPw = {};
			oldPw.userid = $('#userid').val();
			oldPw.password = $('#pwOld').val();
			$.ajax({
				url : "checkAjax",
				type : "post",
				data : oldPw,
				success : function(data){
					if (data === 1){
						console.log("현재 비밀번호 확인 완료");
						updatePw();
					} else {
						// data == 0 : 현재비밀번호 틀림
						toastr["error"]("현재 비밀번호를 확인해주세요.");
						$('#pwOld').focus();
					}
				}, error : function(data){
					alert("fail");
				} // error
			}); // ajax for check old pw
		} // else
	} // validatePw()
	
	function updatePw(){
		console.log("updatePw() start");
		// 비밀번호 업데이트
		var pwData = {};
		pwData.userid = $('#userid').val();
		pwData.password = $('#pw').val();
		
		$.ajax({
			url : "updateLoginInfo",
			type : "post",
			data : pwData,
			success : function(data){
				if (data === 1){
					$('#pwOld').val("");
					$('#pw').val("");
					$('#pwConfirm').val("");
					document.getElementById('pwUpdateOptions').style.display = 'none';
		  	        document.getElementById('btn_pwCancel').style.display = 'none';
		  	        document.getElementById('btn_pwUpdate').textContent = '비밀번호변경';
					toastr["success"]("비밀번호가 변경되었습니다.");
				} else {
					toastr["error"]("비밀번호 변경 실패.");
				}
			} // success
		}); // ajax for update pw
	} // updatePw()
	
	
	/* 연락처 수정 */
	function phoneUpdate(){
		if(document.getElementById('btn_phoneCancel').style.display === 'inline') {
			if ($('#phone').val() === ""){
				toastr["error"]("연락처를 입력해주세요.");
			} else {
			
			var p = {};
			p.userid = $('#userid').val();
			p.phone = $('#phone').val();
			$.ajax({
				url : "updateLoginInfo",
				type : "post",
				data : p,
				success : function(data){
					if (data === 1){
						document.getElementById('btn_phoneUpdate').textContent = '수정';
						document.getElementById('btn_phoneCancel').style.display = 'none';
						document.getElementById('hiddenPhone').value = p.phone;
						$('#phone').attr("style", "border:none");
						$('#phone').attr("readonly", true);
						toastr["success"]("연락처가 수정되었습니다.");
					} else {
						toastr["error"]("연락처 수정 실패.");
					}
				}, error : function(data){
					alert("error : " + data);
				}
			}); // ajax
			
			} // else
  	    } else {
			document.getElementById('btn_phoneUpdate').textContent = '수정완료';
			document.getElementById('btn_phoneCancel').style.display = 'inline';
			$('#phone').attr("style", "border:1px solid");
			$('#phone').attr("readonly", false);
  	        document.getElementById('phone').focus();
  	    }
	} // phoneUpdate()
	
	/* 연락처 수정 취소버튼 */
	$('#btn_phoneCancel').click(function(){
		document.getElementById('btn_phoneUpdate').textContent = '수정';
		document.getElementById('btn_phoneCancel').style.display = 'none';
		$('#phone').val($('#hiddenPhone').val()); // 연락처 값 원래대로.
		$('#phone').attr("style", "border:none");
		$('#phone').attr("readonly", true);
	}); // btn_phoneCancel
			
	
	/* 이메일 수정 */
	function emailUpdate(){
		if(document.getElementById('btn_emailCancel').style.display === 'inline') {
			var p = {};
			p.email = $('#email').val();
			var regexEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			if (p.email === "") {
	    		toastr["error"]("이메일을 입력해주세요");
	    	} else if (!regexEmail.test(p.email)) {
	    		toastr["error"]("이메일 형식이 올바르지 않습니다.");
	    	} else if (p.email === $('#hiddenEmail').val()){
	    		toastr["warning"]("현재 메일주소와 같습니다.");
	    	} else {
				// 이메일 중복 확인
				$.ajax({
					url : "checkAjax",
					type : "post",
					data : p,
					success : function(data){
						if (data === 0){
							updateEmail();
						} else {
							toastr["error"]("사용중인 이메일 입니다.");
						}
					}
				}); // ajax for checkAjax
	    	}
			
  	    } else {
			document.getElementById('btn_emailUpdate').textContent = '수정완료';
			document.getElementById('btn_emailCancel').style.display = 'inline';
			$('#email').attr("style", "border:1px solid");
			$('#email').attr("readonly", false);
  	        document.getElementById('email').focus();
  	    }
	} // emailUpdate()
	
	/* 이메일 수정 취소버튼 */
	$('#btn_emailCancel').click(function(){
		document.getElementById('btn_emailUpdate').textContent = '수정';
		document.getElementById('btn_emailCancel').style.display = 'none';
		$('#email').val($('#hiddenEmail').val()); // 연락처 값 원래대로.
		$('#email').attr("style", "border:none");
		$('#email').attr("readonly", true);
	}); // btn_emailCancel
	
	function updateEmail(){
		var p = {};
		p.userid = $('#userid').val();
		p.email = $('#email').val();
		// 이메일 수정
		$.ajax({
			url : "updateLoginInfo",
			type : "post",
			data : p,
			success : function(data){
				if (data === 1){
					document.getElementById('btn_emailUpdate').textContent = '수정';
					document.getElementById('btn_emailCancel').style.display = 'none';
					document.getElementById('hiddenEmail').value = p.email;
					$('#email').attr("style", "border:none");
					$('#email').attr("readonly", true);
					toastr["success"]("연락처가 수정되었습니다.");
				} else {
					toastr["error"]("연락처 수정 실패.");
				}
			}
		}); // ajax for update email
	} // updateEmail()
	
				
	
	/* 다음 주소API */
	function daumPostcode(){
		var width = 500;
		var height = 600;
		new daum.Postcode({
	        oncomplete: function(data) {
	               document.getElementById('postcode').value = data.zonecode;
	               document.getElementById("roadAddress").value = data.roadAddress;
	        	}
		    }).open({
		    	popupName: 'postcodePopup',
		        left: (window.screen.width / 2) - (width / 2),
		        top: (window.screen.height / 2) - (height / 2)
		    });
	} // daumPostcode()	
	
	/* 회원탈퇴 */
	function leave(){
		console.log("회원탈퇴");
		if (confirm("회원 탈퇴 시 삭제된 데이터는 복구할 수 없습니다.\n정말로 탈퇴하시겠습니까?")){
			console.log("회원탈퇴 시작");
			var userid = $('#userid').val();
			console.log(userid);
			$.ajax({
				type : 'delete',
				url : 'managerRest/' + userid,
				success : function(data){
					if (data === 1){
						alert("탈퇴 되었습니다.")
						window.location.replace("http://localhost:8080/project/");
					} else {
						toastr["error"]("탈퇴 실패.");
					}
				}, error : function(error){
					alert("error : " + error);
				}
			}); // ajax
		} else {
			console.log("회원탈퇴 취소");
		}
	} // 회원탈퇴
			
	</script>
</body>
</html>