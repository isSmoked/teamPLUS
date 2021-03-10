<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>개인회원</title>
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
	<h2>&nbsp;개인회원정보</h2>
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
						<button class="btn btn-dark" id="btn_pwUpdate" onclick="pwUpdate()">비밀번호변경</button>
						<button class="btn btn-dark" type="button" id="btn_pwCancel" style="display:none;">취소</button>
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
					<button class="btn btn-dark" type="button" id="btn_phoneUpdate" onclick="phoneUpdate()">수정</button>
					<button class="btn btn-dark" type="button" id="btn_phoneCancel" style="display:none;">취소</button>
				</td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td>
					<input type="text" id="email" value="${loginVO.email }" style="border:none;" placeholder="정보를 입력해주세요." readonly>
					<input type="hidden" id="hiddenEmail" value="${loginVO.email }">
				</td>
				<td>
					<button class="btn btn-dark" type="button" id="btn_emailUpdate" onclick="emailUpdate()">수정</button>
					<button class="btn btn-dark" type="button" id="btn_emailCancel" style="display:none;">취소</button>
				</td>
			</tr>
		</table>
		<hr>

	<p>&nbsp;&nbsp;&nbsp;<b>[상세정보]</b></p>
		<table>
			<tr>
				<td>성별</td>
				<td>
					<label>
						<input type="radio" class="detail" name="gender" value="male" onclick="return(false);" 
							<c:if test="${personalVO.personal_gender eq null }">checked</c:if>
							<c:if test="${personalVO.personal_gender eq 'male' }">checked</c:if>>&nbsp;남
					</label>
							&nbsp;&nbsp;&nbsp;
					<label>
						<input type="radio" class="detail" name="gender" value="female" onclick="return(false);"
							<c:if test="${personalVO.personal_gender eq 'female' }">checked</c:if>>&nbsp;여
					</label>
					<input type="hidden" id="hiddenGender" value="${personalVO.personal_gender }">
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" class="detail" id="name" value="${personalVO.personal_name }" 
				style="border:none;" maxlength="50" placeholder="정보를 입력해주세요.">
				<input type="hidden" id="hiddenName" value="${personalVO.personal_name }">
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" class="detail" id="birth" value="${personalVO.personal_birth }" 
				style="border:none;" maxlength="20" placeholder="정보를 입력해주세요."> <!-- 데이트피커넣어주기 -->
				<input type="hidden" id="hiddenBirth" value="${personalVO.personal_birth }">
			</tr>
			<tr>
				<td>주소</td>
				<td><button type="button" id="btn_searchAddress" onclick="daumPostcode()" style="display:none;">주소검색</button></td>
			</tr>
			<tr>
				<td>- 우편번호</td>
				<td>
					<input type="text" class="detail" id="postcode" placeholder="정보를 입력해주세요." style="border:none;">
				</td>
			</tr>
			<tr>
				<td>- 도로명</td>
				<td><input type="text" class="detail" id="roadAddress" placeholder="정보를 입력해주세요." style="min-width: 300px; border:none;"></td>
			</tr>
			<tr>
				<td>- 상세주소</td>
				<td>					
					<input type="text" class="detail" id="detailAddress" placeholder="정보를 입력해주세요." style="min-width: 300px; border:none;">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="btn btn-dark" type="button" id="btn_detailUpdate">수정</button>
					<button class="btn btn-dark" type="button" id="btn_detailCancel" style="display:none;">취소</button>
					<div id="VOaddress" style="display:none;">${personalVO.personal_address }</div>
				</td>
			</tr>
		</table>
		<hr>

	<p>&nbsp;&nbsp;&nbsp;<b>[활동사항]</b></p>
		<table>
			<tr>
				<td>학력</td>
				<td><input type="text" class="activity" id="education" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>경력</td>
				<td><input type="text" class="activity" id="career" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>자격증</td>
				<td><input type="text" class="activity" id="certificate" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>인턴,대외활동</td>
				<td><input type="text" class="activity" id="intern" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>교육이수</td>
				<td><input type="text" class="activity" id="activity" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>수상</td>
				<td><input type="text" class="activity" id="award" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>해외경험</td>
				<td><input type="text" class="activity" id="abroad" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>어학</td>
				<td><input type="text" class="activity" id="language" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>포트폴리오</td>
				<td><input type="text" class="activity" id="portfolio" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>병역</td>
				<td><input type="text" class="activity" id="militaryService" placeholder="정보를 입력해주세요."></td>
			</tr>
			<tr>
				<td>자기소개서</td>
				<td><textarea class="activity" id="introduction" rows="4" style="width: 100%;" placeholder="정보를 입력해주세요."></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="btn btn-dark" type="button" id="btn_activityUpdate">수정</button>
					<button class="btn btn-dark" type="button" id="btn_activityCancel" style="display:none;">취소</button>
				</td>
			</tr>
		</table>
	<hr>
	<br>
	&nbsp;&nbsp;&nbsp;<a href="#leave" onclick="leave()"><input class="btn btn-dark" type="button" value="회원탈퇴"></a>
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
					
	$(document).ready(function() {
		// 인풋 리드온리, 숨기기
		$('.detail').attr("readonly", true);
		$('.activity').attr("readonly", true);
		
		// JSON 주소 불러오기
		if ($('#VOaddress').html() != "") {
			callAddress();
		}
		
		// JSON 활동사항 불러오기
		if ($('#VOjson').html() != "") {
			callActivity();
		}

	}); // document.ready()
	
	function callAddress(){
		console.log("제이슨 주소 : " + $('#VOaddress').html());
		  var jsonAddress = JSON.parse($('#VOaddress').html());
			$('#roadAddress').val(jsonAddress.roadAddress);
			$('#detailAddress').val(jsonAddress.detailAddress);
			$('#postcode').val(jsonAddress.postcode);
	} // callAddress()
	
	// JSON 활동사항 불러오기
	function callActivity(){
		console.log("제이슨 활동사항 : " + $('#VOjson').html());
		 var jsonData = JSON.parse($('#VOjson').html());
			$('#education').val(jsonData.education);
			$('#career').val(jsonData.career);
			$('#certificate').val(jsonData.certificate);
			$('#intern').val(jsonData.intern);
			$('#activity').val(jsonData.activity);
			$('#award').val(jsonData.award);
			$('#abroad').val(jsonData.abroad);
			$('#language').val(jsonData.language);
			$('#portfolio').val(jsonData.portfolio);
			$('#militaryService').val(jsonData.militaryService);
			$('#introduction').val(jsonData.introduction);
	} // callActivity()
					
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
	
				
	
	/* 상세정보 수정버튼 */
	$('#btn_detailUpdate').click(function() {
		if (document.getElementById('btn_detailCancel').style.display === 'inline'){
			var detail = {};
			var address = {
					postcode : $('#postcode').val(),
					roadAddress : $('#roadAddress').val(),
					detailAddress : $('#detailAddress').val()
			};
			var jsonAddress = JSON.stringify(address);
			detail.userid = $('#userid').val();
			detail.personal_name = $('#name').val();
			detail.personal_birth = $('#birth').val();
			detail.personal_gender = $('[name="gender"]:checked').val();
			detail.personal_address = jsonAddress; 
			
			console.log(detail);
			
			$.ajax({
				url : "updateDetailPersonal",
				type : "post",
				data : detail,
				success : function(data){
					if (data === 1){
						$('[name="gender"]').attr("onclick", "return(false)");
						$('.detail').attr("readonly", true);
						$('.detail').attr("style", "border:none");
						$('#roadAddress').attr("style", "min-width:300px; border:none;");
						$('#detailAddress').attr("style", "min-width:300px; border:none;");
						$('#btn_detailUpdate').html("수정");
						$('#btn_detailCancel').attr("style", "display:none");
						$('#btn_searchAddress').attr("style", "display:none");
						$('#hiddenGender').val(detail.personal_gender);
						$('#hiddenName').val(detail.personal_name);
						$('#hiddenBirth').val(detail.personal_birth);
						$('#VOaddress').html(jsonAddress);
						
						toastr["success"]("상세 정보가 수정되었습니다.");
					} else {
						toastr["error"]("상세 정보 수정 실패.");
					}
				}, error : function(data){
					console.log("error : " + data);
					alert("error");
				}
			}); // ajax
							
		} else {
			$('[name="gender"]').attr("onclick", "");
			$('.detail').attr("readonly", false);
			$('.detail').attr("style", "border:1px solid");
			$('#roadAddress').attr("style", "min-width:300px");
			$('#detailAddress').attr("style", "min-width:300px");
			$('#btn_detailUpdate').html("수정완료"	);
			$('#btn_detailCancel').attr("style", "display:inline");
			$('#btn_searchAddress').attr("style", "display:inline");
			$('#name').focus();
		}
	}); // 상제정보 수정버튼
	
	/* 상세정보 취소버튼 */
	$('#btn_detailCancel').click(function(){
		if ($('#VOaddress').html() != "") {
			callAddress();
		}
		if ($('#hiddenGender').val() != ""){
			var gender = $('#hiddenGender').val();
			$('[name="gender"]').val([gender]);
		}
		if ($('#hiddenName').val() != ""){
			$('#name').val($('#hiddenName').val());
		}
		if ($('#hiddenBirth').val() != ""){
			$('#birth').val($('#hiddenBirth').val());
		}
		
		$('[name="gender"]').attr("onclick", "return(false)");
		$('.detail').attr("readonly", true);
		$('.detail').attr("style", "border:none");
		$('#roadAddress').attr("style", "min-width:300px; border:none;");
		$('#detailAddress').attr("style", "min-width:300px; border:none;");
		$('#btn_detailUpdate').html("수정");
		$('#btn_detailCancel').attr("style", "display:none");
		$('#btn_searchAddress').attr("style", "display:none");
		/* history.go(0); */
	}); // 상제정보 취소버튼
		
	/* 활동사항 수정 */
	$('#btn_activityUpdate').click(function(){
		if (document.getElementById('btn_activityCancel').style.display === 'inline'){
			var obj = {
					education : $('#education').val(),
					career : $('#career').val(),
					certificate : $('#certificate').val(),
					intern : $('#intern').val(),
					activity : $('#activity').val(),
					award : $('#award').val(),
					abroad : $('#abroad').val(),
					language : $('#language').val(),
					portfolio : $('#portfolio').val(),
					militaryService : $('#militaryService').val(),
					introduction : $('#introduction').val()
	 			};
				var jsonObj = { 
						userid : $('#userid').val(),
						personal_json : JSON.stringify(obj)
					};

				$.ajax({
					url : "updateDetailPersonal",
					type : "post",
					data : jsonObj,
					success : function(data){
						if (data === 1){
							$('.activity').attr("readonly", true);
							$('.activity').attr("style", "border:none");
							$('#btn_activityUpdate').html("수정");
							$('#btn_activityCancel').attr("style", "display:none");
							$('#VOjson').html(JSON.stringify(obj));
							toastr["success"]("활동사항이 수정되었습니다.");
						} else {
							toastr["error"]("활동사항 수정 실패.");
						}
					}, error : function(data){
						alert("error : " + data);
					}
				}); // ajax
				
		} else {
			$('.activity').attr("readonly", false);
			$('.activity').attr("style", "border:1px solid");
			$('#btn_activityUpdate').html("수정완료");
			$('#btn_activityCancel').attr("style", "display:inline");
			$('#education').focus();
		} // else
	}); // 활동사항 수정

	/* 활동사항 수정 취소 */
	$('#btn_activityCancel').click(function(){
		if ($('#VOjson').html() != "") {
			callActivity();
		}
		$('.activity').attr("readonly", true);
		$('.activity').attr("style", "border:none");
		$('#btn_activityUpdate').html("수정");
		$('#btn_activityCancel').attr("style", "display:none");
	}); // 활동사항 수정 취소
	
	/* 다음 주소API */
	function daumPostcode(){
		var popWidth  = '630'; // 파업사이즈 너비
		var popHeight = '600'; // 팝업사이즈 높이
		var winWidth  = document.body.clientWidth;  // 현재창의 너비
		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
		var w = winX + (winWidth - popWidth) / 2;
		var h = winY + (winHeight - popHeight) / 2;
		
		new daum.Postcode({
	        oncomplete: function(data) {
	               document.getElementById('postcode').value = data.zonecode;
	               document.getElementById("roadAddress").value = data.roadAddress;
	        	},
			width: popWidth,
			height: popHeight
		
		    }).open({
		    	popupName: 'postcodePopup',
		        left: w,
		        top: h
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