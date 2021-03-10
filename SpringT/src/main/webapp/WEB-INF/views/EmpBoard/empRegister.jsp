<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- daum 도로명주소 찾기 api --> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">

.indent {text-indent: 20%}

</style>

<title>Insert title here</title>
</head>

<body>
<%-- <!-- secondeHeader -->
	<jsp:include page="secondHeader.jsp" flush="true"></jsp:include> --%>
	
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h2 class="indent">Employee 게시판 구직하기</h2>
	<br>
	<br>
	<br>
	<article class="container"> 
		<div class="page-header"> 
			<div class="col-md-6 col-md-offset-3"> 
				</div> 
			</div> 
			<div class="col-sm-6 col-md-offset-3"> 
				<form action="empRegister" method="post" role="form" name="employ_table">
				<div class ="form-group">
						<label for="employTitle">제목</label>
						<input class="form-control" name="employ_title" id="employ_title" type="text" required="required"/>
					</div>
					
					<div class="form-group"> 
						<label for="uname">이름</label> 
						<input type="text" class="form-control" id="uname" name="uname" placeholder="Name"required="required"> 
					<div class="eheck_font" id="name_check"></div> 
					</div> 
					
					</div>
  				<p>작성자 : ${loginId }
      			<input type="hidden" name="userid" value="${loginId}">
  				 
					
					<div class="form-group"> 
						<label for="birth">생년월일</label> 
						<input type="tel" class="form-control" id="birth" name="birth" placeholder="ex) 19990101" required="required"> 
						<div class="eheck_font" id="birth_check"></div> 
					</div> 
					
					<div class="form-group"> 
						<label for="email">이메일 주소</label> 
						<input type="email" class="form-control" id="email" name="email" placeholder="E-mail" required="required"> 
						<div class="eheck_font" id="email_check"></div> 
					</div> 
					
					<div class="form-group"> 
						<label for="phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> 
						<input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone Number" required="required"> 
						<div class="eheck_font" id="phone_check"></div> 
					</div> 
					
					<div class="form-group"> 
						<label for="gender">성별 </label> 
						<select name="gender">
							<option value="woman">여자</option>
							<option value="man">남자</option>
						</select>
					</div> 
					
					<div class="form-group"> 
					<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="oaddress" id="oaddress" type="text" readonly="readonly" > 
						<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button> 
					</div> 
					
					<div class="form-group"> 
						<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="address" id="address" type="text" readonly="readonly" /> 
					</div> 
					
					<div class="form-group"> 
						<input class="form-control" placeholder="상세주소" name="detail_address" id="detailaddress" type="text" required="required"/> 
					</div> 
					
					<div class ="form-group">
						<label for="emplementtype">고용형태</label>
						<select name="emplementtype">
							<option value="intern">인턴</option>
							<option value="contract">계약직</option>
							<option value="regular">정규직</option>
							<option value="freelancer">프리랜서</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="salary">희망연봉</label>
						<select name="salary">
							<option value="twentyFive" selected>~ 2,500</option>
							<option value="thirtyFive">2,500 ~ 3,500</option>
							<option value="fourtyFive">3,500 ~ 4,500</option>
							<option value="fourtyFiveOver">4,500 ~</option>
							<option value="decisionAfter">면접 후 결정</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="militeryservice">병역</label>
						<select name="militeryservice">
							<option value="uncomMiltr">미필</option>
							<option value="comMiltr">군필</option>
							<option value="naMiltr">해당없음</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="work_area">희망근무지</label>
						<select name="work_area">
							<option value="Seoul">서울</option>
							<option value="Gyunggi">경기</option>
							<option value="Incheon">인천</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="education">학력</label>
						<select name="education">
						  	<option value="GraduatedHighsch">고등학교 졸업</option>
						  	<option value="GraduatedCollege">대학교(2,3년) 졸업</option>
							<option value="GraduatedUniversity" selected>대학교(4년) 졸업</option>
						  	<option value="GraduatedMaster">대학원 석사 졸업</option>
						  	<option value="GraduatedDoctor">대학원 박사 졸업</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="career">경력</label>
						<select name="career">
							<option value="newcomer" selected>신입</option>
							<option value="threeYears">1~3년</option>
							<option value="sixYears">4~6년</option>
							<option value="nineYears">7~9년</option>
							<option value="tenOver">10년 이상</option>
						</select>
					</div>
					
					<div class ="form-group">
						<label for="certificates">자격증/어학</label>
						<textarea class="form-control" rows="" cols="" name="certificates" id="certificates"></textarea>						
					</div>
					
					
					
					<div class ="form-group">
						<label for="selfintroduce">자기소개서</label>
						<textarea rows="" cols="" class="form-control" name="selfintroduce" id="selfintroduce" required="required"></textarea>
					</div>
					
					
					<div class="form-group text-center"> 
						<button type="submit" class="btn btn-dark btn_register" onclick="return confirm('글을 등록하면 수정할 수 없습니다.\n 글을 등록하시겠습니까?')">글 등록</button> 
					</div> 
				</form> 
				</div>
				
		</article>
	

  	
  	<script type="text/javascript">
$(document).ready(function() { 
	//모든 공백 체크 정규식 
	var empJ = /\s/g; 

	//아이디 정규식 
	var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/; 

	// 이름 정규식 
	var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 

	// 이메일 검사 정규식 
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 

	// 휴대폰 번호 정규식 
	var phoneJ = /^[0-9\b -]{0,13}$/; 

	var birthJ = false;
	var address = $('#detailAddress'); 
		var frm = document.employTable;
		
		//이름에 특수문자 들어가지 않도록 설정 
		$("#uname").blur(function() { 
			if (nameJ.test($(this).val())) { 
				console.log(nameJ.test($(this).val())); 
				$("#name_check").text(''); 
			} else { 
				$('#name_check').text('한글 2~4자 이내로 입력하세요. (특수기호, 공백 사용 불가)'); $('#name_check').css('color', 'red'); 
			} 
		}); 
		$("#email").blur(function() { 
			if (mailJ.test($(this).val())) { 
				$("#email_check").text(''); 
			} else { 
				$('#email_check').text('이메일 양식을 확인해주세요.'); 
				$('#email_check').css('color', 'red'); 
			} 
		}); 
		
		/* // 성별 체크박스 하나만 체크되도록 설정
		$('input[type="checkbox"][name="gender"]').click(function(){
 
		  if($(this).prop('checked')){
		 
		     $('input[type="checkbox"][name="gender"]').prop('checked',false);
		 
		     $(this).prop('checked',true);
		 
		    }
		  
		   }); */
		
		
		// 생일 유효성 검사 
		var birthJ = false; 
		
		// 생년월일 birthJ 유효성 검사 
		$('#birth').blur(function(){ 
			var dateStr = $(this).val(); 
			var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연) 
			var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월) 
			var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일) 
			var today = new Date(); // 날짜 변수 선언 
			var yearNow = today.getFullYear(); // 올해 연도 가져옴 
			
			if (dateStr.length <=8) { // 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다. 
				if (year > yearNow || year < 1900 ){ 
					$('#birth_check').text('생년월일을 확인해주세요'); 
					$('#birth_check').css('color', 'red'); 
				} else if (month < 1 || month > 12) { 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red'); 
				}else if (day < 1 || day > 31) { 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red'); 
				}else if ((month==4 || month==6 || month==9 || month==11) && day==31) { 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red'); 
				}else if (month == 2) { 
					var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)); if (day>29 || (day==29 && !isleap)) { 
						$('#birth_check').text('생년월일을 확인해주세요 '); 
						$('#birth_check').css('color', 'red'); 
					}else{ 
						$('#birth_check').text(''); 
						birthJ = true; 
					} 
				}else{ 
					$('#birth_check').text(''); 
					birthJ = true; 
				}//end of if 
				}else{ 
					//1.입력된 생년월일이 8자 초과할때 : auth:false 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red'); 
				} 
			}); //End of method /* 
			// 휴대전화 
			$('#phone').blur(function(){ 
				if(phoneJ.test($(this).val())){ 
					console.log(nameJ.test($(this).val())); 
					$("#phone_check").text(''); 
				} else { 
					$('#phone_check').text('휴대폰번호를 확인해주세요 '); 
					$('#phone_check').css('color', 'red'); 
				} 
			}); 
			
			// 전화번호 하이픈 붙이기
			var autoHypenPhone = function(str){
			      str = str.replace(/[^0-9]/g, '');
			      var tmp = '';
			      if( str.length < 4){
			          return str;
			      }else if(str.length < 7){
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3);
			          return tmp;
			      }else if(str.length < 11){
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3, 3);
			          tmp += '-';
			          tmp += str.substr(6);
			          return tmp;
			      }else{              
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3, 4);
			          tmp += '-';
			          tmp += str.substr(7);
			          return tmp;
			      }
			  
			      return str;
			}


			var phone = document.getElementById('phone');

			phone.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenPhone( this.value ) ;  
			}
		}); 
		
		//우편번호 찾기 버튼 클릭시 발생 이벤트 
		function execPostCode() { 
			new daum.Postcode({ 
				oncomplete: function(data) { 
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 
					
					// 도로명 주소의 노출 규칙에 따라 주소를 조합한다. 
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다. 
					var fullRoadAddr = data.roadAddress; // 도로명 주소 변수 
					var extraRoadAddr = ''; // 도로명 조합형 주소 변수 
					
					// 법정동명이 있을 경우 추가한다. (법정리는 제외) 
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. 
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){ 
						extraRoadAddr += data.bname; 
					} 
					// 건물명이 있고, 공동주택일 경우 추가한다. 
					if(data.buildingName !== '' && data.apartment === 'Y'){ 
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName); 
					} 
					
					// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다. 
					if(extraRoadAddr !== ''){ 
						extraRoadAddr = ' (' + extraRoadAddr + ')'; 
					} 
					
					// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다. 
					if(fullRoadAddr !== ''){ 
						fullRoadAddr += extraRoadAddr; 
					} 
					
					// 우편번호와 주소 정보를 해당 필드에 넣는다. 
					console.log(data.zonecode); 
					console.log(fullRoadAddr); 
					/* var a = console.log(data.zonecode); 
					var b = console.log(fullRoadAddr); 
					if(a == null || b = null){ 
						alert("주소를 확인하세요."); 
						return false; 
					} */ 
					
					$("[name=oaddress]").val(data.zonecode); 
					$("[name=address]").val(fullRoadAddr); 
					document.getElementById('oaddress').value = data.zonecode; //5자리 새우편번호 사용 
					document.getElementById('address').value = fullRoadAddr; 
					
					//document.getElementById('mem_detailaddress').value = data.jibunAddress; 
					} 
			}).open(); 
		}



</script>
</body>
</html>