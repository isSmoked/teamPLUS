<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>모임 작성 페이지</title>
</head>
<!-- 작성되야 할 데이터 : content / title / part / location / userid -->
<body><br>
	<br>
	<br>
	<br>
	
	<h2 class="indent">모임글 작성 페이지</h2>
	
	<br><br><br>
  	<div class="container">
  	<div class="col-md-12">
  	<form action="register" method="POST" id="registerForm">

	<input type="hidden" name="study_userid" value="${loginId }"/>
    <input type="hidden" name="study_crew_user" value="${loginId }"/>
    <input type="hidden" name="study_crew_black" value=" " />
     
    <!-- 제목 -->
	<div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
           <div class="col-sm-10">
	            <input type="text" name="study_title" class="form-control" id="inputTitle" value="${studyVO.study_title }" required/>
           </div>
	</div>
	
	 <div class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label">
		<strong>희망 인원</strong></label>
		<div class="col-sm-10">
    	<select name="study_crew_limit" class="form-control">
    		<option value="4" selected>4</option>
    		<option value="5">5</option>
    		<option value="6">6</option>
    		<option value="7">7</option>
    		<option value="8">8</option>
    	</select>
    	</div>
    </div>
   
    <hr>
    <div  class="form-group row mb-3">
		<label for="inputTitle" class="col-sm-2 col-form-label"><strong>희망 분야</strong></label>
		<div id=part class="checkbox-group col-sm-10">	
	      <input class="form-control" type="checkbox" name="study_part" value="Front_end"/>Front-end&nbsp;
	      <input class="form-control" type="checkbox" name="study_part" value="Back_end"/>Back-end&nbsp;
	      <input class="form-control" type="checkbox" name="study_part" value="Server"/>Server&nbsp;
	      <input class="form-control" type="checkbox" name="study_part" value="Full_stack"/>Full-stack&nbsp;
	    </div>
    </div>
    
   
    
   <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>희망 지역</strong></label>
     <select name="study_location" id="study_location" onchange="changingLocation()">
     	<option value="서울 서부" selected="selected">서울 서부 - 강서, 양천, 구로</option>
     	<option value="서울 남서부">서울 남서부 - 영등포, 금천, 동작</option>
     	<option value="서울 남부">서울 남부 - 관악, 서초, 강남, 송파</option>
     	<option value="서울 동부">서울 동부 - 강동, 광진, 성동, 중랑</option>
     	<option value="서울 북서부">서울 북서부 - 서대문, 은평, 마포</option>
     	<option value="서울 중부">서울 중부 - 중구, 용산, 종로</option>
     	<option value="서울 북부">서울 북부 - 성북, 강북, 노원, 도봉, 동대문</option>
     </select>
   </div>
   <div>
      <hr>
      
      <div class="form-group row mb-3">
		  <label for="inputTitle" class="col-sm-2 col-form-label"><strong>선택된 스터디카페</strong></label>
		<input style="width: 50%;" type="text" id="study_detail_location" name="study_detail_location" value="${studyVO.study_detail_location }"/>
		<br>
      	<!-- 카카오맵 API -->
    	<div id="map" style="width:600px;height:500px;"></div>
    	<!-- NAVER 검색 API -->
    	<div id="cafeSearch" style="float:right;height:500px;"></div>
   	  </div>

		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f39da671a98c86a90ede9cdc71c31be8&libraries=services"></script>
		<script>
		var searchRange = 9;
		var locSelect = document.getElementById("study_location");
		
		// 희망지역 변경에 따른 지도 재설정 메소드
		 function changingLocation() {
			var selectValue = locSelect.options[locSelect.selectedIndex].value;
			
			// 옵션의 VALUE값 저장
			if (selectValue === '서울 남서부') {
				map.setCenter(new kakao.maps.LatLng(37.49004970425619, 126.91708238973078));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.49004970425619, 126.91708238973078)
				});
			} else if (selectValue === '서울 남부') {
				map.setCenter(new kakao.maps.LatLng(37.490075443929626, 127.02816689687076));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.490075443929626, 127.02816689687076)
				});
			} else if (selectValue === '서울 서부') {
				map.setCenter(new kakao.maps.LatLng(37.52502103743962, 126.85514043001302));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.52502103743962, 126.85514043001302)
				});
			} else if (selectValue === '서울 동부') {
				map.setCenter(new kakao.maps.LatLng(37.556747857870256, 127.13502944872182));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.556747857870256, 127.13502944872182)
				});
			} else if (selectValue === '서울 북서부') {
				map.setCenter(new kakao.maps.LatLng(37.57742186436631, 126.93482695883466));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.57742186436631, 126.93482695883466)
				});
			} else if (selectValue === '서울 중부') {
				map.setCenter(new kakao.maps.LatLng(37.5638167939192, 127.00166383447396));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.5638167939192, 127.00166383447396)
				});
			} else if (selectValue === '서울 북부') {
				map.setCenter(new kakao.maps.LatLng(37.61109226590018, 127.0451558145559));
				ps.keywordSearch('스터디', placesSearchCB, {
				    // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
				    location: new kakao.maps.LatLng(37.61109226590018, 127.0451558145559)
				});
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
			ps.keywordSearch('스터디', placesSearchCB, {
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
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			        
			        // 옵션 선택(지역) + 해당 스터디카페 이름 묶어서 저장
			        var selectValue = locSelect.options[locSelect.selectedIndex].value;
			       
			        var location = place.place_name;
			        console.log('location : ' + location);
			        
			        document.getElementById('study_detail_location').value = location;
			        console.log(document.getElementById('study_detail_location').value);
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
			
		
		</script>
    </div>
	
    <hr>
    
      <div class="form-group row mb-3">
		 <label for="inputTitle" class="col-sm-2 col-form-label"><strong>글 내용</strong></label>
		 <div class="col-sm-10">
      		<textarea rows="20" cols="120" name="study_content" class="form-control" required>${studyVO.study_content }</textarea>
      	 </div>
      </div>
    
    <c:if test="${loginId ne null }">
    	 <div>
	        <input id="submit" type="submit" class="btn btn-dark" value="완료" onclick="button_click();" >
	     </div>
    </c:if>
    
    <c:if test="${loginId eq null }">
    	<p>로그아웃 상태입니다!</p>
    	<a href="list?page=${page }">
    	<input class="btn btn-light" type="button"  value="글목록으로 돌아가기!"></a>
    </c:if>
    
    
  </form>
  
  </div>
  </div>
 
</body>
</html>

