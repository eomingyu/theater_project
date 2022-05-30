<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 스케줄 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(210ms)
		if(${message != null}) alert('${message}');
	},210);
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
<script type="text/javascript">
function validCheck(){
	const reg = /([0-9]{4}-[0-9]{2}-[0-9]{2})/;
	const frm = document.forms[0];
	console.log(frm.date.value);
	if(frm.performance.value=="none")
		alert('공연을 선택해주세요.')
	else if(!reg.test(frm.date.value)){
		alert('공연일자를 선택해주세요.')
	}
	else if(frm.start_time.value=="none")
		alert('공연시작시간을 선택해주세요.')
	else
		frm.submit();
}
</script>
</head>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section class="sections">
	<h3>공연 스케줄 등록</h3>
	<hr>
	<form action="scheduleinsert.do" method="post">
		<div>
			<label for="performance">공연 선택</label>
			<select name="perform_idx" id="performance">
				<option value="none" selected disabled>----선택----</option>
				<c:forEach var="vo" items="${perform}">
					<option value="${vo.perform_idx}">${vo.perform_title}</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="date">공연일자 선택</label>
			<input type="date" name="perform_date" id="date" required>
		</div>
		<div>
			<label for="time">공연시작시간 선택</label>
			<select name="start_time" id="time">
				<option value="none" selected disabled>----선택----</option>
				<option value="14:00">14:00</option>
				<option value="14:30">14:30</option>
				<option value="15:00">15:00</option>
				<option value="15:30">15:30</option>
				<option value="16:00">16:00</option>
				<option value="16:30">16:30</option>
				<option value="17:00">17:00</option>
				<option value="17:30">17:30</option>
				<option value="18:00">18:00</option>
				<option value="18:30">18:30</option>
				<option value="19:00">19:00</option>
				<option value="19:30">19:30</option>
			</select>
		</div>
		<div>
			<button type="button" class="adbutton" onclick="validCheck()">등록</button>
			<button type="button" class="adbutton" onclick="location.href='main.do'">취소</button>
		</div>
		<br>
		<div id="info">
			
		</div>
		<div id="datetime"></div>
	</form>
</section>
<script type="text/javascript">
function toDate(timestamp){				//timestamp => date 변환 함수 yyyy-MM-dd
	var date= new Date(timestamp);
	var year = date.getFullYear()
	var month = date.getMonth()+1
	var date2 =  date.getDate()
	if(month<10)
		month= "0"+month;
	if(date2<10)
		date2="0"+date2;
	var fulldate = year+"-"+month+"-"+date2;
	return fulldate;
}
function toDate2(timestamp){				//timestamp => date 변환 함수 MM월 dd일 (요일)
	var date= new Date(timestamp);
	var year = date.getFullYear()
	var month = date.getMonth()+1
	var date2 =  date.getDate()
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	var dayOfWeek = week[date.getDay()];
	var fulldate = month+"월 "+date2+"일 "+"("+dayOfWeek+")";
	return fulldate;
}
document.querySelector("#performance").addEventListener('change',function(){
	const frm = document.forms[0];
    const perform_idx = frm.perform_idx.value;
    //if(perform_idx!=none){
		const xhr = new XMLHttpRequest();
	
	    xhr.open('GET','${pageContext.request.contextPath}/asyncperform/'+perform_idx);
	    xhr.send();
	    xhr.onload = function() {
	        if(xhr.status ==200) {
	            console.log(xhr.response);
	            const info = JSON.parse(xhr.response).info;
	            const datetime = JSON.parse(xhr.response).datetime;
	            console.log(info);
	            console.log(datetime);
	            var text = "";
	            if (info!=null) {
	            	document.querySelector('#info').innerHTML='공연 제목 : '+info.perform_title
	            		+'<br>'+'극장 : '+info.theater_name
	            		+'<br>'+'공연 일자 : '+toDate(info.start_date)+' ~ '+toDate(info.end_date);
	            	document.getElementById("date").min=toDate(info.start_date)
	            	document.getElementById("date").max=toDate(info.end_date)
	            	console.log(document.getElementById("date"))
	            }
	            if(datetime!=null){
	            	for(var i=0;i<datetime.length;i++){
						var pdate = datetime[i].perform_date;
						var stime = datetime[i].start_time;
	            		text+=toDate2(pdate)+"  "+stime+'<br>'
	            	}
	            	document.querySelector('#datetime').innerHTML= '공연 스케줄<br>'+text
	            }
	        }else {
	            console.error('Error',xhr.status,xhr.statusText);
	        }
	    };
   // }
});

		
</script>
</body>
</html>