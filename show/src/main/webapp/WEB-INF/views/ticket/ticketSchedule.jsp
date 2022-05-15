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
</head>
<body>
	<form action="">
 		<c:forEach var="vo" items="${list}">
 			<div id="schedule">
			<label for="${vo.perform_date}">${vo.perform_date}</label>
			<input type="radio" name="perform_date" id="${vo.perform_date}" value="${vo.perform_date}">
 			</div>
		</c:forEach> 
		<input type="hidden" name="perform_idx" value="${idx}">
		<input type="hidden" name="theater_idx" value="${tidx}">
		<div class="selecttime">
		
		</div>
		<div class="selectseat">
		
		</div>

	</form>
<script type="text/javascript">
console.log('${list}')

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
	     			 var input2 = document.createElement('input');
	            	 input2.setAttribute('type', 'hidden');
					 input2.setAttribute('name', 'schedule_idx');
	     			 input2.setAttribute('value', schedule_idx);
	     				 
	     			document.querySelector('.selecttime').appendChild(label);
	     			document.querySelector('.selecttime').appendChild(input);
	     			document.querySelector('.selecttime').appendChild(input2);

	            		
	            });      
	        }else {
	            console.error('Error',xhr.status,xhr.statusText);
	        }
	    };
	}
});
})
}


//공연 시간 선택시 잔여석 출력
var radios=document.querySelectorAll('input[name="start_time"]')
if(radios){
radios.forEach((radio) => {
	

radio.addEventListener('change',function(event){
	var current = event.currentTarget
	if (current.checked){
		
	
	const frm = document.forms[0];
    const perform_date = frm.perform_date.value;
    const perform_idx = frm.perform_idx.value;
    const theater_idx = frm.theater_idx.value;
    const schedule_idx = frm.schedule_idx.value;
		const xhr = new XMLHttpRequest();
	
	    xhr.open('GET','${pageContext.request.contextPath}/asyncseat/'+theater_idx+"-"+schedule_idx);
	    xhr.send();
	    xhr.onload = function() {
	        if(xhr.status ==200) {
	            console.log(xhr.response);
	            const seat = JSON.parse(xhr.response).seat;
	            console.log(seat);
	            document.querySelector('.selectseat').innerHTML=seat+'석'
	            
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