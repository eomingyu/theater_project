<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
</head>
<body>
<h3>공지사항 등록</h3>
<hr>
<div style="margin:auto;">
	<form action="insert.do" method="post">
		<table class="notice" id="title">
			<tr>
				<th class="notice" width="20%">제목</th>
				<td width="80%">
					<textarea style="width:100%;resize: none;" 
					rows="1" name="notice_title" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
						<textarea  rows="20" cols="80" name="notice_content" 
		                style="border:1px solid gray;width:100%;resize: none;" placeholder="내용을 입력하세요." required="required"></textarea>
					</div>
				</td>
			</tr>
		</table>
		<div style="text-align:center;">
			<button>등록</button>
			<button type="button" onclick="location.href='noticelist.do'">취소</button>
		</div>
	</form>
</div>
</body>
</html>