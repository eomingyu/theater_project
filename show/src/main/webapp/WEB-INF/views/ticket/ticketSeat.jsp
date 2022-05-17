<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
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
.clearp2{
	display:flex;
	justify-content:center;
	margin-bottom: 10px;
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
.theater1 > label:nth-child(-n+101) {
	display: inline-block;
	width: 25px;
	height: 25px;
	border: 2px solid #c6a700; /*  */
	cursor: pointer;
	background-color: #fdd835;
	margin:3px;
}
.theater1 > label:nth-child(n+102):nth-child(-n+201) {
	display: inline-block;
	width: 25px;
	height: 25px;
	border: 2px solid #338a3e; /*  */
	cursor: pointer;
	background-color: #66bb6a;
	margin:3px;
}

.theater1 > label {
	display: inline-block;
	width: 25px;
	height: 25px;
	border: 2px solid #0093c4; /*  */
	cursor: pointer;
	background-color: #4fc3f7;
	margin:3px;
	border-radius: 3px;
}
.theater1> input[type="checkbox"]:checked + label {
	background-color: #ec407a;
	border: 2px solid #b4004e;
}
.theater1> input[type="checkbox"]{
  	display:none;
}
.theater1{
	width:1000px;
	background-color:#eee;
	padding: 5px;
}


.theater2 > label {
	display: inline-block;
	width: 30px;
	height: 30px;
	border: 2px solid #6b9b37; /*  */
	cursor: pointer;
	background-color: #9ccc65;
	margin:4px;
	border-radius: 3px;
}
.theater2> input[type="checkbox"]:checked + label {
	background-color: #ec407a;
	border: 2px solid #b4004e;
}
.theater2> input[type="checkbox"]{
  	display:none;
}
.theater2{
	width:930px;
	background-color:#eee;
	padding: 5px;
}
.rows2>div{
	display: inline-block;
	width: 30px;
	height: 30px;
	border: 2px solid #bbb;
	background-color: #eee;
	margin:7.5px;
	margin-right:10px;
	text-align: center;
}
#seats{
	width:170px;
	padding:40px;
	height:250px;
}
#price{
	width:100px;
	padding:40px;
}
#stage{
	text-align:center;
	width:500px;
	background-color: #eee;
	border:2px solid #bbb;
	margin:20px;
	font-size: 20px;
}
#cho{
	padding:38px;
	height:250px;
}
#cho2{
	margin-left:50px;
	padding:38px;
	padding-top:0px;
}
#leftseat{
	padding-left: 700px;
}
input:disabled +label{
  background: #444;
  border:2px solid #444;
}
#t1 > input:disabled +label{
  background: #444;
  border:2px solid #444;
}
#totalprice{
	width : 100px;
	padding-right:20px;
	margin-right:30px;
}
.rows > div{
	display: inline-block;
	width: 25px;
	height: 25px;
	border: 2px solid #bbb;
	background-color: #eee;
	margin:7px;
	margin-right:10px;
	text-align: center;
}
#rclass{
	display: inline-block;
	width: 15px;
	height: 15px;
	border: 2px solid #c6a700; /*  */
	background-color: #fdd835;
	margin-top:20px;
	margin:2px;
	border-radius: 2px;
}
#sclass{
	display: inline-block;
	width: 15px;
	height: 15px;
	border: 2px solid #338a3e; /*  */
	background-color: #66bb6a;
	margin:2px;
	border-radius: 2px;
}
#aclass{
	display: inline-block;
	width: 15px;
	height: 15px;
	border: 2px solid #0093c4; /*  */
	background-color: #4fc3f7;
	margin:2px;
	border-radius: 2px;
}
#nclass{
	display: inline-block;
	width: 15px;
	height: 15px;
	border: 2px solid #6b9b37; /*  */
	background-color: #9ccc65;
	margin:2px;
	border-radius: 2px;
}
#classes>div>span{
	font-size:15px;
}
#classes{
	padding-left:70px;
}
</style>
</head>
<body>
<div class="clearp2">
	<div class="choice">1. 날짜/시간 선택</div>
	<div class="choice2 top">2. 좌석 선택</div>
	<div class="choice">3. 결제</div>
</div>
<div class="clearp2">
	<span id="stage">STAGE</span>
</div>
<form action="ticketpayment.do" method="post">
<c:if test="${theater_idx==1}">
<div class="clearp3">
	<div class="rows">
		<div>A</div><br>
		<div>B</div><br>
		<div>C</div><br>
		<div>D</div><br>
		<div>E</div><br>
		<div>F</div><br>
		<div>G</div><br>
		<div>H</div><br>
	</div>
	<div class="theater1" id="t1">
		<c:forEach var="vo" items="${allseat}">
			<input type="checkbox" name="choiceseat" onchange="checkBox(this)" id="${vo.seat_idx}" value="${vo.seat_idx}">
			<label for="${vo.seat_idx}"></label>
		</c:forEach>
		<span id="leftseat">잔여석   <span style="color:blue;">${seat}</span>석/200석</span>
	</div>
</div>
</c:if>	
<c:if test="${theater_idx==2}">
<div class="clearp3">
	<div class="rows2">
		<div>A</div><br>
		<div>B</div><br>
		<div>C</div><br>
		<div>D</div><br>
		<div>E</div><br>
		<div>F</div><br>
	</div>
	<div class="theater2">
		<c:forEach var="vo" items="${allseat}">
			<input type="checkbox" name="choiceseat" onchange="checkBox(this)" id="${vo.seat_idx}" value="${vo.seat_idx}">
			<label for="${vo.seat_idx}"></label>
		</c:forEach>
	<span id="leftseat">잔여석   <span style="color:blue;">${seat}</span>석/120석</span>
	</div>
</div>
</c:if>	

<input type="hidden" name="checkResult" id="checkResult">
<input type="hidden" name="schedule_idx" value="${schedule_idx}">
<input type="hidden" name="ticketno" id="ticketno">
<input type="hidden" name="payprice" id="payprice">
<div class="clearp3">
	<div id="cho">선택 좌석</div>
	<div id="seats"></div>
	<div id="price"></div>
	<div id="classes">
	<c:if test="${theater_idx==1}">
		<div><div id="rclass"></div><span>R석  : 50,000원</span></div> <br>
		<div><div id="sclass"></div><span>S석  : 40,000원</span></div><br>
		<div><div id="aclass"></div><span>A석  : 30,000원</span></div><br>
	</c:if>
	<c:if test="${theater_idx==2}">
		<div><div id="nclass"></div><span>일반석  : 30,000원</span></div><br>
	</c:if>
	</div>
</div>
<div class="clearp3">
	<div><button type="button" onclick="history.back();">이전단계</button></div>
	<div id="cho2">결제 금액</div>
	<div id="totalprice"></div>
	<div><button>다음단계</button></div>
</div>
</form>
<c:forEach var="vo" items="${reservedseat}">
<input type="hidden" name="reserved" id="reserved" value="${vo.seat_idx}">
</c:forEach>
<script type="text/javascript">
//예매된 좌석 disabled
var reserve = document.getElementsByName("reserved");
for(var i=0; i<reserve.length;i++){
	document.getElementById(reserve[i].value).disabled=true;
}
//체크한 좌석 위치 출력
function checkBox(checked){
    var result = document.getElementById("checkResult");
    if( checked.checked==true ){
       // console.log(result.value);
        if(result.value == "" ){
            result.value = checked.getAttribute("value");
        }else{
            result.value += ","+ checked.getAttribute("value");
        }
    }else {

        var resultArr = result.value.split(",");
        for(var i=0; i<resultArr.length; i++){
            if(resultArr[i] == checked.getAttribute("value")){
                resultArr.splice(i,1);
                break;
            }
        }
        result.value  = resultArr.join(",");

    }
var checkeditems=[result.value];
console.log(checkeditems);
if(result.value!=''){

const xhr = new XMLHttpRequest();
var text='';
var price='';
var total_price=0;
xhr.open('GET','${pageContext.request.contextPath}/asyncseat/'+checkeditems);
xhr.send();
xhr.onload = function() {
    if(xhr.status ==200) {
        console.log(xhr.response);
        const seats = JSON.parse(xhr.response).seats;
		console.log(seats)

			for(var i=0;i<seats.length;i++){
				var temp = seats[i].seat_grade+"석 -"+ seats[i].seat_row+"열 -"+seats[i].num+"번<br> "
				text += temp;
				var temp2 = seats[i].seat_price+"원<br>"
				price += temp2;
				total_price += seats[i].seat_price;
			}
				document.getElementById('seats').innerHTML = text+"<br>";
				document.getElementById('price').innerHTML = price;
				document.getElementById('totalprice').innerHTML = total_price+" 원";
				document.getElementById('payprice').value = total_price;
    }else {
        console.error('Error',xhr.status,xhr.statusText);
    }
}; 
 }else{
	 document.getElementById('seats').innerHTML="<br>"
	 document.getElementById('price').innerHTML="<br>"
	 document.getElementById('totalprice').innerHTML="<br>"
	}
}
//예매번호 설정
console.log(new Date().getTime())
	var date= new Date();
	var millis = date.getTime().toString().substring(5,10);
	var year = date.getFullYear().toString().substring(3,4);
	var month = date.getMonth()+1
	var date2 =  date.getDate()
	if(month<10)
		month= "0"+month;
	if(date2<10)
		date2="0"+date2;
	var fulldate = year+month+date2+millis
	var ticketno = parseInt(fulldate);
	document.forms[0].ticketno.value=fulldate
	console.log(document.forms[0].ticketno.value)	
</script>

</body>
</html>