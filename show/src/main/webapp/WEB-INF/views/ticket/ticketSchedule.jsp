<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜/시간 선택</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
ul{
	list-style:none;
	padding-left:1px;]
}
.poster{
	margin:20px;
}

.clearp{
	display:flex;
	justify-content:center;
}
.clearp2{
	display:flex;
	justify-content:center;
	margin-bottom: 10px;
}
.perform_info{
	margin:20px;
	align-items:center;
	width:380px;
}

.clearp2>div{
	width:210px;
	margin:0;
	padding:0;
	padding-top:5px;
	padding-bottom:5px;
	text-align: center;
}
.clearp2> .choice{
	background-color: #444;
	color: #fff;
}
.clearp2> .choice2{
	border-left:3px solid #333; 
	border-right:3px solid #333;
	background-color: #444;
	color: #fff; 
}

.clearp2>.top{
	background-color: #3498db;
	color: white;
	font-weight: bold;
}
</style>
<script type="text/javascript">
function validCheck(){
	var form=document.forms[0];
	var pdate = form.perform_date;
	var stime = form.start_time;

		if(pdate.value==""){
			alert('날짜를 선택해주세요')
		}
		else if(stime.value==""){
			alert('시간을 선택해주세요')
		}
		else
			form.submit();
	}
</script>
</head>
<body>
<div class="clearp2">
	<div class="choice top">1. 날짜/시간 선택</div>
	<div class="choice2">2. 좌석 선택</div>
	<div class="choice">3. 결제</div>
</div>
<div class="clearp">
	<div class="poster">
	<img src="/upload/${perform.poster}" width="175px" height="250px" style="object-fit:contain">
	</div>
	<div class="perform_info">
		<h3>${perform.perform_title}</h3>
		<hr>
		<ul>
			<li><span>공연 일정 : </span>
				<fmt:formatDate value="${perform.start_date}" pattern="yyyy년 MM월 dd일"/> ~ 
				<fmt:formatDate value="${perform.end_date}" pattern="yyyy년 MM월 dd일"/>
			</li>
			<li><span>공연 장소 : </span>${perform.theater_name}</li>
			<li><span>입 장 료  : </span>${perform.theater_fee}</li>
			<li><span>관람 등급 : </span>${perform.grade} 관람가</li>
			<li><span></span></li>
			<li><span></span></li>
		</ul>
	</div>
</div>

<div class="clearp2">
	<div class="choice">날짜 선택</div>
	<div class="choice2">시간 선택</div>
	<div class="choice">다음 단계</div>
</div>
<form action="choiceSeat.do" method="post">
	<div class="clearp2">

		<div>
 		<c:forEach var="vo" items="${list}">
 			<div id="schedule">
			<label><span class="pdate"></span>
			<input type="radio" name="perform_date" value="${vo.perform_date}"></label>
 			</div>
		</c:forEach> 
		</div>
		<input type="hidden" name="perform_idx" value="${perform.perform_idx}">
		<input type="hidden" name="theater_idx" value="${perform.theater_idx}">
		<div class="selecttime">
			<div style="color:gray;">날짜를 선택해주세요.</div>
		</div>
		<div>
		<button type="button" onclick="validCheck();">좌석선택</button>
		</div>
	</div>
</form>
<script type="text/javascript">
var ex=document.getElementsByName("perform_date");
var pdate=document.getElementsByClassName("pdate");
console.log(ex);
console.log(pdate);
for(var i=0; i<ex.length;i++){
	pdate[i].innerText=toDate2(ex[i].value)
}
var temp=0;
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
//공연 일자 선택시 공연 시간 출력
var radios=document.querySelectorAll('input[name="perform_date"]')
if(radios){
radios.forEach((radio) => {
	radio.addEventListener('change',function(event){
	var current = event.currentTarget
	if (current.checked){
		
	const frm = document.forms[0];
    const perform_date = frm.perform_date.value;
    const perform_idx = frm.perform_idx.value;
		const xhr = new XMLHttpRequest();
	
	    xhr.open('GET','${pageContext.request.contextPath}/asyncticket/'+perform_date+"-"+perform_idx);
	    xhr.send();
	    xhr.onload = function() {
	        if(xhr.status ==200) {
	            console.log(xhr.response);
	            const info = JSON.parse(xhr.response).info;
	            console.log(info);
	            console.log(info.length);
	            console.log(info[0]);
	            console.log(info[2]);
	            console.log(JSON.parse(xhr.response));
	            document.querySelector('.selecttime').innerHTML=''
	             info.forEach(function(infoItem){
	            	 var label = document.createElement('label');
					 var schedule_idx=infoItem.schedule_idx;	            	 
	            	 var start_time =infoItem.start_time;
	            	 label.innerText=start_time;
	            	 label.setAttribute('for', start_time)
	            	 var input = document.createElement('input');
	            	 input.setAttribute('type', 'radio');
					 input.setAttribute('name', 'start_time');
					 input.setAttribute('id', start_time);
	     			 input.setAttribute('value', start_time);
 
	     			document.querySelector('.selecttime').appendChild(label);
	     			document.querySelector('.selecttime').appendChild(input);

	            		
	            });      
	        }else {
	            console.error('Error',xhr.status,xhr.statusText);
	        }
	};   
	    
	}
});
})
}





</script>
</body>
</html>