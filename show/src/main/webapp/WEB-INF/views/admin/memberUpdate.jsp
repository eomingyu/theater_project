<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 변경</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
<script type="text/javascript">	
	function confirm(id){		//등록할 건지 확인
		var answer = prompt(id+"님을 관리자로 등록하시겠습니까?\n등록하려면 '관리자로 등록'을 입력하세요.","")
		if(answer=='관리자로 등록')
			document.forms[0].submit();
		else
			alert('등록이 취소되었습니다.');
	}
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section>
	<h3>관리자 등록</h3>
	<hr>
	<div style="margin:auto;">
		<table>
			<tr>
			<th width="13%">아이디</th>
			<th width="13%">이름</th>
			<th width="16%">생년월일</th>
			<th width="8%">성별</th>
			<th width="19%">전화번호</th>
			<th width="16%">가입일자</th>
			<th width="10%">구분</th>
			</tr>
			<tr>
		 		<td>${vo.id}</td>
		 		<td>${vo.name }</td>
		 		<td>${vo.birth_date}</td>
		 		<td>${vo.gender}</td>
		 		<td>${vo.phone}</td>
		 		<td>
		 		<fmt:formatDate value="${vo.reg_date }" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
		 		</td>
		 		<td>
		 		<c:if test="${vo.authority==1}">
		 			<span>일반 회원</span>
		 		</c:if>
		 		<c:if test="${vo.authority==0}">
		 			<span style="color:red;font-weight:bolder;">관리자</span>
		 		</c:if>
	
		 		</td>
		 	</tr>
		</table>
		<form action="adminupdatesave.do" method="post">
			<input type="hidden" name="id" value="${vo.id}">
			<div style="text-align:center">
				<button type="button" class="adbutton" onclick="confirm('${vo.id}');">변경</button>
				<button type="button" class="adbutton" onclick="history.back();">취소</button>
			</div>
		</form>
	</div>
</section>
</body>
</html>