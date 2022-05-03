<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
<script type="text/javascript">
function deleteOk(){
	if(confirm('해당 글을 삭제하시겠습니까?')==true){
		document.forms[1].submit();
	}
}
</script>
<script type="text/javascript">
	if(${message != null}) alert('${message}');
</script>
</head>
<body>
<h3>공지사항</h3>
<hr>
<div style="margin:auto;">
	<table class="notice" id="title">
		<tr>
			<td class="notice" width="20%">제목</td>
			<td colspan="5"><div>${detail.notice_title}</div></td>
		</tr>
		<tr>
			<td class="notice" width="20%">작성일</td>
			<td colspan="2">${detail.notice_date}</td>
			<td class="notice" width="20%">조회수</td>
			<td colspan="2">${detail.notice_view}</td>
		</tr>
		<tr>
			<td colspan="6">
				<div>
					<pre>${detail.notice_content}</pre>
				</div>
			</td>
		</tr>
	</table>
	
</div>
<!-- 수정, 삭제, 목록 버튼 -->
<div style="text-align:center;">	
		<form action="update.do" method="post">
			<input name="idx" type="hidden" value="${detail.notice_idx}">
			<input name="detail" type="hidden" value="${detail}">
			<input name="pageNo" type="hidden" value="${pageNo}">
			<button>수정</button>
		</form>
		
		<form action="delete.do" method="post">
 			<input name="idx" type="hidden" value="${detail.notice_idx}">
 			<input name="pageNo" type="hidden" value="${pageNo}">
		 	<button type="button" onclick="deleteOk()">삭제</button>
		 </form>
		 
	<form action="" method="post" name="formlist">
		<input name="columns" type="hidden">
		<input name="find" type="hidden">		
		<input name="pageNo" type="hidden" value="${pageNo}">
		<button type="button" onclick="goList()">목록</button>
	</form>
</div>

<script type="text/javascript">
const url = new URL(window.location.href);	
const urlParams = url.searchParams;			//URLSearchParams 객체
//console.log(urlParams.get('find'))		//파라미터 값 가져오기
	function goList(){
		const frm = document.formlist;
		if(urlParams.get('find')==""){
			frm.action="noticeList.do";
		}
		else{
			frm.action="noticeSearch.do";
			frm.columns.value=urlParams.get('columns');
			frm.find.value=urlParams.get('find');
		}
		frm.submit();
	}
</script>
</body>
</html>