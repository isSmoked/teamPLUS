<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>기업회원</title>
<style type="text/css">

tr {height:30px;}
td {padding-left: 10px;}
.msg {color: red;}
.detail {
border:none;
}
.manager {
border:none;
}
.moreInfo {
border:none;
}
</style>
</head>
<body>
	<h2>&nbsp;기업회원정보</h2>
	<hr>
	<p>&nbsp;&nbsp;&nbsp;<b>[로그인 정보]</b></p>
		<table>
			<tr>
				<td>아이디</td>
				<td><input style="border:none; outline:none;" type="text" id="userid" value="${loginId }" readonly></td>
			</tr>

			<tr>
				<td>비밀번호</td>
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
					<input type="text" id="phone" value="${loginVO.phone }" maxlength="20"
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
					<input type="text" id="email" value="${loginVO.email }" style="border:none;" readonly>
					<input type="hidden" id="hiddenEmail" value="${loginVO.email }">
				</td>
				<td>
					<button type="button" id="btn_emailUpdate" onclick="emailUpdate()">수정</button>
					<button type="button" id="btn_emailCancel" style="display:none;">취소</button>
				</td>
			</tr>
		</table>
		<hr>


	<p>&nbsp;&nbsp;&nbsp;<b>[기업정보]</b></p>
		<table>
			<tr>
				<td>회사명</td>
				<td><input type="text" class="detail" id="name" value="${companyVO.company_name }" placeholder="정보를 입력해주세요." maxlength="30">
					<input type="hidden" id="hiddenName" value="${companyVO.company_name }">
			</tr>
			<tr>
				<td>대표자</td>
				<td><input type="text" class="detail" id="president" value="${companyVO.company_president }" placeholder="정보를 입력해주세요." maxlength="10">
					<input type="hidden" id="hiddenPresident" value="${companyVO.company_president }">
			</tr>
			<tr>
				<td>사업자등록번호</td>
				<td><input type="text" class="detail" id="number" value="${companyVO.company_number }" placeholder="정보를 입력해주세요." maxlength="20">
					<input type="hidden" id="hiddenNumber" value="${companyVO.company_number }">
			</tr>
			<tr>
				<td>주소</td>
				<td><button type="button" id="btn_searchAddress" onclick="daumPostcode()" style="display:none;">주소검색</button></td>
			</tr>
			<tr>
				<td>- 우편번호</td>
				<td>
					<input type="text" class="detail" id="postcode" placeholder="정보를 입력해주세요.">
				</td>
			</tr>
			<tr>
				<td>- 도로명</td>
				<td><input type="text" class="detail" id="roadAddress" placeholder="정보를 입력해주세요." style="min-width: 300px;"></td>
			</tr>
			<tr>
				<td>- 상세주소</td>
				<td>					
					<input type="text" class="detail" id="detailAddress" placeholder="정보를 입력해주세요." style="min-width: 300px;">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="btn_detailUpdate">수정</button>
					<button type="button" id="btn_detailCancel" style="display:none;">취소</button>
					<div id="VOaddress" style="display:none;">${companyVO.company_address }</div>
				</td>
			</tr>
		</table>
	<hr>
		
	<p>&nbsp;&nbsp;&nbsp;<b>[담당자정보]</b></p>
		<table>
			<tr>
				<td>담당자</td>
				<td>
					<input type="text" class="manager" id="manager" value="${companyVO.company_manager }" placeholder="정보를 입력해주세요." maxlength="10">
					<input type="hidden" id="hiddenManager" value="${companyVO.company_manager }">
				</td>
			</tr>
			<tr>
				<td>담당자 연락처</td>
				<td>
					<input type="text" class="manager" id="managerPhone" value="${companyVO.company_manager_phone }" placeholder="정보를 입력해주세요." maxlength="20">
					<input type="hidden" id="hiddenManagerPhone" value="${companyVO.company_manager_phone }">
				</td>
			</tr>
			<tr>
				<td>담당자 이메일</td>
				<td>
					<input type="text" class="manager" id="managerEmail" value="${companyVO.company_manager_email }" placeholder="정보를 입력해주세요.">
					<input type="hidden" id="hiddenManagerEmail" value="${companyVO.company_manager_email }">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="btn_managerUpdate">수정</button>
					<button type="button" id="btn_managerCancel" style="display:none;">취소</button>
				</td>
			</tr>
		</table>
	<hr>

	<p>&nbsp;&nbsp;&nbsp;<b>[추가정보]</b></p>
		<table>
			<tr>
				<td>재무정보</td>
				<td>
					<input type="text" class="moreInfo" id="financial" placeholder="정보를 입력해주세요.">
				</td>
			</tr>
			<tr>
				<td>사원수</td>
				<td>
					<input type="text" class="moreInfo" id="employees" placeholder="정보를 입력해주세요.">
				</td>
			</tr>
			<tr>
				<td>회사소개</td>
				<td>
					<textarea class="moreInfo" id="introduction" rows="4" placeholder="정보를 입력해주세요." style="min-width:300px;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="btn_moreInfoUpdate">수정</button>
					<button type="button" id="btn_moreInfoCancel" style="display:none;">취소</button>
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
	
	<div style="display:none;" id="VOjson">${companyVO.company_json }</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('.detail').attr("readonly", true);
			$('.manager').attr("readonly", true);
			$('.moreInfo').attr("readonly", true);
			
			// JSON 주소 불러오기
			if ($('#VOaddress').html() != "") {
				callAddress();
			}
			
			// JSON 데이터 불러오기
			if ($('#VOjson').html() != "") {
				callMoreInfo();
			}
				
		}); // document.ready()
		
		function callAddress(){
			console.log("제이슨 주소 : " + $('#VOaddress').html());
			  var jsonAddress = JSON.parse($('#VOaddress').html());
				$('#roadAddress').val(jsonAddress.roadAddress);
				$('#detailAddress').val(jsonAddress.detailAddress);
				$('#postcode').val(jsonAddress.postcode);
		} // callAddress()
		
		function callMoreInfo(){
			console.log("제이슨 인풋 저장된 데이터 : " + $('#VOjson').html());
			 var jsonMoreInfo = JSON.parse($('#VOjson').html());
				$('#financial').val(jsonMoreInfo.financial);
				$('#employees').val(jsonMoreInfo.employees);
				$('#introduction').val(jsonMoreInfo.introduction);
		} // callMoreInfo()

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

	/* 기업정보 수정버튼 */
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
			detail.company_name = $('#name').val();
			detail.company_president = $('#president').val();
			detail.company_number = $('#number').val();
			detail.company_address = jsonAddress; 
			
			console.log(detail);
			
			$.ajax({
				url : "updateDetailCompany",
				type : "post",
				data : detail,
				success : function(data){
					if (data === 1){
						$('.detail').attr("readonly", true);
						$('.detail').attr("style", "border:none");
						$('#roadAddress').attr("style", "min-width:300px; border:none;");
						$('#detailAddress').attr("style", "min-width:300px; border:none;");
						$('#btn_detailUpdate').html("수정");
						$('#btn_detailCancel').attr("style", "display:none");
						$('#btn_searchAddress').attr("style", "display:none");
						$('#hiddenName').val(detail.company_name);
						$('#hiddenPresident').val(detail.company_president);
						$('#hiddenNumber').val(detail.company_number);
						$('#VOaddress').html(jsonAddress);
						
						toastr["success"]("기업 정보가 수정되었습니다.");
					} else {
						toastr["error"]("기업 정보 수정 실패.");
					}
				}, error : function(data){
					console.log("error : " + data);
					alert("error : " + data);
				}
			}); // ajax
							
		} else {
			$('.detail').attr("readonly", false);
			$('.detail').attr("style", "border:1px solid");
			$('#roadAddress').attr("style", "min-width:300px; border:1px solid;");
			$('#detailAddress').attr("style", "min-width:300px; border:1px solid;");
			$('#btn_detailUpdate').html("수정완료"	);
			$('#btn_detailCancel').attr("style", "display:inline");
			$('#btn_searchAddress').attr("style", "display:inline");
			$('#name').focus();
		}
	}); // 기업정보 수정버튼
	
	/* 기업정보 취소버튼 */
	$('#btn_detailCancel').click(function(){
		if ($('#VOaddress').html() != "") {
			callAddress();
		}
		if ($('#hiddenName').val() != ""){
			$('#name').val($('#hiddenName').val());
		}
		if ($('#hiddenPresident').val() != ""){
			$('#president').val($('#hiddenPresident').val());
		}
		if ($('#hiddenNumber').val() != ""){
			$('#number').val($('#hiddenNumber').val());
		}
		
		$('.detail').attr("readonly", true);
		$('.detail').attr("style", "border:none");
		$('#roadAddress').attr("style", "min-width:300px; border:none;");
		$('#detailAddress').attr("style", "min-width:300px; border:none;");
		$('#btn_detailUpdate').html("수정");
		$('#btn_detailCancel').attr("style", "display:none");
		$('#btn_searchAddress').attr("style", "display:none");
		/* history.go(0); */
	}); // 기업정보 취소버튼
		
	/* 추가정보 수정 */
	$('#btn_moreInfoUpdate').click(function(){
		if (document.getElementById('btn_moreInfoCancel').style.display === 'inline'){
			var obj = {
					financial : $('#financial').val(),
					employees : $('#employees').val(),
					introduction : $('#introduction').val()
	 			};
				var jsonObj = { 
						userid : $('#userid').val(),
						company_json : JSON.stringify(obj)
					};

				$.ajax({
					url : "updateDetailCompany",
					type : "post",
					data : jsonObj,
					success : function(data){
						if (data === 1){
							$('.moreInfo').attr("readonly", true);
							$('.moreInfo').attr("style", "border:none");
							$('#introduction').attr("style", "min-width:300px; width:100%; border:none;");
							$('#btn_moreInfoUpdate').html("수정");
							$('#btn_moreInfoCancel').attr("style", "display:none");
							$('#VOjson').html(JSON.stringify(obj));
							toastr["success"]("추가정보가 수정되었습니다.");
						} else {
							toastr["error"]("추가 정보 수정 실패.");
						}
					}, error : function(data){
						alert("error : " + data);
					}
				}); // ajax
				
		} else {
			$('.moreInfo').attr("readonly", false);
			$('.moreInfo').attr("style", "border:1px solid");
			$('#introduction').attr("style", "min-width:300px; width:100%; border:1px solid;");
			$('#btn_moreInfoUpdate').html("수정완료");
			$('#btn_moreInfoCancel').attr("style", "display:inline");
			$('#financial').focus();
		} // else
	}); // 추가정보 수정

	/* 추가정보 수정 취소 */
	$('#btn_moreInfoCancel').click(function(){
		if ($('#VOjson').html() != "") {
			callMoreInfo();
		}
		$('.moreInfo').attr("readonly", true);
		$('.moreInfo').attr("style", "border:none");
		$('#introduction').attr("style", "min-width:300px; width:100%; border:none;");
		$('#btn_moreInfoUpdate').html("수정");
		$('#btn_moreInfoCancel').attr("style", "display:none");
	}); // 추가정보 수정 취소

	
	/* 담당자정보 수정 */
	$('#btn_managerUpdate').click(function(){
		if (document.getElementById('btn_managerCancel').style.display === 'inline'){
			var obj = {
					userid : $('#userid').val(),
					company_manager : $('#manager').val(),
					company_manager_phone : $('#managerPhone').val(),
					company_manager_email : $('#managerEmail').val(),
	 			};
			
				$.ajax({
					url : "updateDetailCompany",
					type : "post",
					data : obj,
					success : function(data){
						if (data === 1){
							$('.manager').attr("readonly", true);
							$('.manager').attr("style", "border:none");
							$('#btn_managerUpdate').html("수정");
							$('#btn_managerCancel').attr("style", "display:none");
							$('#hiddenManager').val(obj.company_manager);
							$('#hiddenManagerPhone').val(obj.company_manager_phone);
							$('#hiddenManagerEmail').val(obj.company_manager_email);
							toastr["success"]("담당자정보가 수정되었습니다.");
						} else {
							toastr["error"]("담당자 정보 수정 실패.");
						}
					}, error : function(data){
						alert("error : " + data);
					}
				}); // ajax
				
		} else {
			$('.manager').attr("readonly", false);
			$('.manager').attr("style", "border:1px solid");
			$('#btn_managerUpdate').html("수정완료");
			$('#btn_managerCancel').attr("style", "display:inline");
			$('#manager').focus();
		} // else
	}); // 담당자정보 수정

	/* 담당자정보 수정 취소 */
	$('#btn_managerCancel').click(function(){
		$('#manager').val($('#hiddenManager').val());
		$('#managerPhone').val($('#hiddenManagerPhone').val());
		$('#managerEmail').val($('#hiddenManagerEmail').val());
		$('.manager').attr("readonly", true);
		$('.manager').attr("style", "border:none");
		$('#btn_managerUpdate').html("수정");
		$('#btn_managerCancel').attr("style", "display:none");
	}); // 담당자정보 수정 취소	
		
		
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