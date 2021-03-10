<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>

<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- TODO : 로그인하면 수정이 가능하도록 해서 > userid 입출력 공간 없애기 -->
<title>소모임 게시글</title>

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


	$(document).ready(function(){
		$('#Imwaiting').hide();
		$('#ImAttending').hide();
		$('#blacked').hide();
		
		// 이미 참가된 이용자인지 test
    	var studyCrewWait = '${studyVO.study_crew_wait}';
    	var test = studyCrewWait.split(',');
    	
    	test.forEach(function(a) {
    		if (a === '${loginId}') {
    			$('#testAlreadyAttend').hide();
    			// 참가중이라고 표시하기!
    			$('#Imwaiting').show();
    			$('#blacked').hide();
    		}
    	});
    	
    	// 참가자 명단에 있는지 test
    	var studyCrewUser = '${studyVO.study_crew_user}';
    	var testUser = studyCrewUser.split(',');
    	
    	testUser.forEach(function(a) {
    		if (a === '${loginId}') {
    			$('#testAlreadyAttend').hide();
    			$('#ImAttending').show();
    			$('#blacked').hide();
    		}
    	});
    	
    	// 스터디 블랙리스트에 들어있는지 test
    	var studyCrewBlack = '${studyVO.study_crew_black}';
    	var testBlack = studyCrewBlack.split(',');
    	
    	testBlack.forEach(function(a){
    		if (a == '${loginId}') {
    			$('#testAlreadyAttend').hide();
    			$('#ImAttending').hide();
    			$('#blacked').show();
    		}
    	});
    	
	}); // end document.ready()
	
	// socket
	
	var sock = new WebSocket('ws://' + window.location.host + '/prj/studyBoard/websocket');
	
	sock.onopen = function() {
		console.log('detail - websocket onopend');
		console.log('weill send : ' + message);
	};
	
	sock.onmessage = function (event) {
		// alarm
		if (event.data.split(',')[0] !== 'chatMsg'){
			console.log('aaaaa알림 받음! - ' +  event.data);
			toastr["info"](event.data);
		}
	};
	
	sock.onclose = function (event) {
		console.log('websocket closed : ' + event);
	};
	
	
	function messageSend() {
		console.log('btn_crew_attend to wait pushed!');
		cmd = 'attend';
		msgReceiver = '${studyVO.study_userid}';
		msgSender = '${loginId}';
    	msgBnoSeq = '${studyVO.study_bno}';
    	msgPageSeq = '${page}';
    	
    	message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;
		sock.send(message);
	};
  	  
  	 
  	  function confirmAttendResult() {
  	  	var result = $('#attendAlert').val();
  		console.log('confirmAttendResult() 호츌 result = ' + result);
  	    if (result === 'success') {
  	      toastr['success']('참가 성공!'<br>'대기자 명단에 등록되었습니다');
  	    } else if (result === 'waitOverlap'){
  	      toastr['warning']('이미 참가 신청된 이용자 입니다.');
  	    } else if(result === 'attendOverlap'){
  	      toastr['warning']('이미 참가된 이용자 입니다!');
  	    } else if(result === 'fail') {
  	      toastr['error']('참가 실패!');
  	    }
  	  }
  	  
	</script>
</head>
<body>
	<br>
	<br>
	<br>
	
  	<h2 style="text-indent: 20%"><span style="font-size:60%;">title &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>${studyVO.study_title }</h2>
  	
  <br><br>
  
  <input type="hidden" id="studyBno" value="${studyVO.study_bno }"/>
  
 <div class="form-group row mb-3">
	<strong for="inputTitle" class="col-sm-2 col-form-label">작성자</strong>
	<label>${studyVO.study_userid }</label>
  </div>
  
  <div class="form-group row mb-3">
    <fmt:formatDate value="${studyVO.study_date }"
    pattern="YYYY-MM-dd E a HH:mm" var="cdate"/>
    <strong for="inputTitle" class="col-sm-2 col-form-label">작성일</strong>
    <label> ${cdate }</label>
  </div>
  
  <!-- 참석자 테이블 -->
 <div>
  <%-- userid1(작성자 아이디)만 세션으로 넘겨 받자! --%>
  <%-- table - choose - foreach --%>
  <!-- 테이블 합치게되면, 마이 세부사항 테이블의 마이페이지로 보낼 링크 추가! --> 
  <%-- TODO : 현재 detail.jsp가 출력되지 않음! --%>
  
  <table class="table table-hover" id="List">
  	<thead>
  		<tr class="active">
  			<th style="width:60px;">번호</th>
  			<th style="width:200px;">참여자</th>
  		</tr>
  </thead>
  	<!-- 이미 참가명단에 있을 때, 아이디가 모두 보이도록 설정 / 미등록 - 앞 한글자만 보이기 -->
  	<c:choose>
  		<c:when test="${studyVO.study_crew_count >= 2 && makerUserid ne loginId}">
  			<tbody>	
  				<c:set value="${studyVO.study_crew_user }" var="UserString" />
				<c:forEach items="${fn:split(UserString , ',') }" var="crewUser" varStatus="status">
					<tr>
						<td>${status.count }</td> <!-- 숫자가 1부터 증가한다 -->
						<td>${crewUser }</td>
					</tr>
				</c:forEach>
  			</tbody>
  		</c:when>
  	</c:choose>
  </table>
  </div>
  
	<c:if test="${studyVO.study_crew_count == 1}">
		<p> &nbsp;&nbsp;참여자가 없습니다! </p>
	</c:if>
  
  
  
    <hr>
    
  <div class="form-group row mb-3"> <!-- 희망분야 / 희망지역 -->
  <strong for="inputTitle" class="col-sm-2 col-form-label">희망분야</strong>
  	<script type="text/javascript">
   		var studyPart = '${studyVO.study_part}';
    	console.log(studyPart);
    	var result = studyPart.split(",");
    	console.log(result);  // 두 개로 잘 나눠졌다.
    	
    	result.forEach(function(a){
    		document.write(a + ' ');
    	});
    </script>
    
    </div>
    
    <div class="form-group row mb-3">
	    <strong for="inputTitle" class="col-sm-2 col-form-label">희망지역</strong>
	   	<p> ${studyVO.study_location } - ${studyVO.study_detail_location }</p>
	   	<br>
	</div>
	
    <div>
	    <div id="map" style="width:600px;height:500px;"></div>
    </div>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f39da671a98c86a90ede9cdc71c31be8&libraries=services"></script>
    <script>
    	var detailLocation = '${studyVO.study_detail_location }';
    	var locSelect = '${studyVO.study_location }';
    	
    	console.log('detailLocation : ' + detailLocation);
    	console.log('logSelect : ' + locSelect);
    	
		function LocationSearching() {
			// 옵션의 VALUE값 저장
			if (locSelect === '서울 남서부') {
				map.setCenter(new kakao.maps.LatLng(37.49004970425619, 126.91708238973078));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.49004970425619, 126.91708238973078)
				});
				console.log('서울 남서부');
			} else if (locSelect === '서울 남부') {
				map.setCenter(new kakao.maps.LatLng(37.490075443929626, 127.02816689687076));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.490075443929626, 127.02816689687076)
				});
				console.log('서울 남부');
			} else if (locSelect === '서울 서부') {
				map.setCenter(new kakao.maps.LatLng(37.52502103743962, 126.85514043001302));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.52502103743962, 126.85514043001302)
				});
				console.log('서울 서부');
			} else if (locSelect === '서울 동부') {
				map.setCenter(new kakao.maps.LatLng(37.556747857870256, 127.13502944872182));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.556747857870256, 127.13502944872182)
				});
				console.log('서울 동부');
			} else if (locSelect === '서울 북서부') {
				map.setCenter(new kakao.maps.LatLng(37.57742186436631, 126.93482695883466));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.57742186436631, 126.93482695883466)
				});
				console.log('서울 북서부');
			} else if (locSelect === '서울 중부') {
				map.setCenter(new kakao.maps.LatLng(37.5638167939192, 127.00166383447396));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.5638167939192, 127.00166383447396)
				});
				console.log('서울 중부');
			} else if (locSelect === '서울 북부') {
				map.setCenter(new kakao.maps.LatLng(37.61109226590018, 127.0451558145559));
				ps.keywordSearch(detailLocation, placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.61109226590018, 127.0451558145559)
				});
				console.log('서울 북부');
			}
		}
    	
		
    	
	 	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.52502103743962, 126.85514043001302), // 지도의 중심좌표
		        level: 9 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
		
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(detailLocation, placesSearchCB, {
		    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
		    location: new kakao.maps.LatLng(37.52502103743962, 126.85514043001302)
		}); 
		

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
			
			
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
		
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}
		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
		
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:6px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		        
		        var location = place.place_name;
		        console.log('location : ' + location);
		       
		    });
		}
		
		setZoomable(false);
		// 버튼 클릭에 따라 지도 확대, 축소 기능을 막거나 풀고 싶은 경우에는 map.setZoomable 함수를 사용합니다
		function setZoomable(zoomable) {
		    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
		    map.setZoomable(zoomable);
		}
		
		setDraggable(false);
		// 버튼 클릭에 따라 지도 이동 기능을 막거나 풀고 싶은 경우에는 map.setDraggable 함수를 사용합니다
		function setDraggable(draggable) {
		    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
		    map.setDraggable(draggable);    
		}
		
		// 쓰레드 타임슬립
		setTimeout(function() {
			LocationSearching();			
		}, 300);
    </script>
	
    
  
  
  
  <hr>
  
  <div> <!-- 내용 -->
    <p>${studyVO.study_content }</p>
  </div>
  
  <hr>
  <div id="testAlreadyAttend">
    <!-- 모임에 이미 가입되어있는지 Controller에서 test하자! -->
    <c:if test="${not empty loginId && studyVO.study_crew_count < studyVO.study_crew_limit }">
    	<form action="attend" method="get" id="waitTest"> <!-- bno / member / userid -->
   			<a href="attend?member=${studyVO.study_crew_count}&userid=${loginId}&page=${page}&bno=${studyVO.study_bno}"><input class="btn btn-dark" type="button" id="btn_attend" value="참가" onclick="messageSend();"></a>
   		</form>
    </c:if>
  </div>
  
  <div id="ImAttending">
  	<input class="btn btn-light" style="color:red;" type="button" value="이미 참가중입니다!" >
  </div>
  
  <div id="blacked">
  	<input class="btn btn-dark" style="color:red;" type="button" value="참가에 거절된 이용자입니다!">
  </div>
  
  <div id="Imwaiting"><br>
  	<input class="btn btn-light" style="color:blue;" type="button" value="참가 대기중입니다!" >
  </div>
  
  
  <input id="attendAlert" type="hidden" value="${attend_result }">
  
  	<br>	<br>	<br> 	<br>	<br>	<br>
</body>
</html>