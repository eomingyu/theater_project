<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js" type="text/javascript"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
ul{
	list-style:none;
	padding-left:1px;
}
.poster{
	margin:20px;
}

.clearp{
	display:flex;
	justify-content:center;
	font-size: 18px;
}
.clearp2{
	display:flex;
	justify-content:center;
	margin-bottom: 10px;
}
.perform_info{
	margin:20px;
	align-items:center;
	width:450px;
}
.clearp3{
	display:flex;
	justify-content:center;
	margin-bottom: 10px;
	font-size: 20px;
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
.perform_info>table{
	width:90%;
}
</style>
</head>
<body>
<div class="clearp2">
	<div class="choice">1. 날짜/시간 선택</div>
	<div class="choice2">2. 좌석 선택</div>
	<div class="choice top">3. 결제</div>
</div>
<div class="clearp">
	<div class="poster">
	<img src="/upload/${performinfo.poster}" width="175px" height="250px" style="object-fit:contain">
	</div>
	<div class="perform_info">
		<h4>${performinfo.perform_title}</h4>
		<hr>
		<table style="text-align:left;">
			<tr>
				<th style="width:30%;">극장 :</th>
				<td>${performinfo.theater_name}</td>
			</tr>
			<tr>
				<th>공연일</th>
				<td><fmt:formatDate value="${scheduleinfo.perform_date}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
			<tr>
				<th>공연 시간</th>
				<td>${scheduleinfo.start_time}</td>
			</tr>
			<tr>
				<th>인원</th>
				<td>${number} 명</td>
			</tr>
			<tr>
				<th>좌석</th>
				<td>${choicedseat}</td>
			</tr>
			<tr>
				<th>총 결제 금액</th>
				<td>${payprice} 원</td>
			</tr>
		</table>
	</div>
</div>
<form action="ticketsuccess.do" method="post">
	<input type="hidden" name="schedule_idx" value="${schedule_idx}">
	<input type="hidden" name="choiceseat" value="${choiceseat}">
	<input type="hidden" name="ticket_no" value="${ticketno}">
	<input type="hidden" name="payprice" value="${payprice}">
	<%-- <input type="hidden" name="id" value="${member.id}"> --%>
</form>
<button id="payment">결제하기</button>
<script type="text/javascript">
//문서 준비 시 제일 먼저 실행
$(document).ready(function(){
	   	  $("#payment").click(function(){
	   		  payment();	//버튼 클릭하면 호출
	   	  })
})
var msg;
var frm = document.forms[0]

var payprice = frm.payprice.value
var price = parseInt(payprice)
console.log(price)
function payment(date){
	IMP.init("imp35957459");
	IMP.request_pay({
		//name과 amout만있어도 결제 진행가능
		pg : 'kakaopay', //pg사 선택 (kakao, kakaopay 둘다 가능)
		pay_method: 'kakaopay',
		merchant_uid : 'merchant_' + new Date().getTime(),
		name : '결제테스트', // 상품명
		id : 'aaaa',
		amount : price
	}, function(rsp){
		if(rsp.success){//결제 성공시
			alert('결제 성공하였습니다.');
			frm.submit();

		}
		else{//결제 실패시
			alert('결제 실패하였습니다.')
			 msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            alert(msg);
		}
	});//pay
}
		
</script>
</body>
</html>