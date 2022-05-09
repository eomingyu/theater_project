<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 답변 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(100ms)
		if(${message != null}) alert('${message}');
	},100);
</script>
</head>
<body>
<h3>1:1 문의 답변 등록</h3>
<hr>
<h4>문의</h4>
<div style="margin:auto;">
	<table class="notice" id="title">
		<tr>
			<th class="notice" width="20%">제목</th>
			<td width="80%" colspan="3">${detail.question_title}</td>
		</tr>
		<tr>
			<th class="notice" width="20%">아이디</th>
			<td width="30%">${detail.id}</td>
			<th class="notice" width="20%">문의 유형</th>
			<td width="30%"></td>
		</tr>
		<tr>
			<th class="notice" width="20%">문의 일자</th>
			<td width="30%">
				<fmt:formatDate value="${detail.question_date}" pattern="yyyy-MM-dd"/>
			</td>
			<th class="notice" width="20%">답변 상태</th>
			<td width="30%">${detail.status}</td>
		</tr>
		<tr>
			<td><pre>${detail.question_content}</pre></td>
		</tr>
	</table>
</div>
<h4>답변</h4>
<div style="margin:auto;">
	<table>
		<c:forEach var="vo" items="${answer}">
			<tr><td style="text-align:right;">${vo.answer_date}</td></tr>
			<tr><td><pre>${vo.answer_content}</pre></td></tr>
		</c:forEach>
		<c:if test="${fn:length(answer)==0 }">
			<tr>
				<td style="color:gray;">등록된 답변이 없습니다.</td>
			</tr>
		</c:if>
	</table>
</div>
<h4>답변 작성</h4>
<form action="questiondetail.do" method="post">
	<input type="hidden" name="question_idx" value="${detail.question_idx}">
	<textarea rows="15" cols="60"name="answer_content" 
		style="border:1px solid gray;width:100%;resize: none;" 
		placeholder="내용을 입력하세요." required="required"></textarea>
	<button>등록</button>
	<button type="reset">취소</button>
	<button type="button" onclick="location.href='questionlist.do'">목록</button>

</form>
</body>
</html>