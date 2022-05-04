<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
<script type="text/javascript">
	function selectCheck(){
		var form=document.forms[0];
		if(form.grade.value=='none')
			alert('관람 등급을 선택해주세요.');
		else
			form.submit();
	}
</script>
</head>
<body>
<h3>공연 등록</h3>
<hr>
<div style="margin:auto;">
	<form action="performInsert.do" method="post" enctype="multipart/form-data">
		<table class="notice" id="title">
			<tr>
				<th class="notice" width="20%">공연 제목</th>
				<td width="80%">
					<input type="text" name="perform_title" required>
				</td>
			</tr>
			<tr>
				<th class="notice" width="20%">관람 시간</th>
				<td width="80%">
					<input type="text" name="showtime" required>
				</td>
			</tr>
			<tr>
				<th class="notice" width="20%">관람 등급</th>
				<td width="80%">
					<select name="grade" id="grade">
						<option value="none" selected disabled>----선택----</option>
						<option value="전체">전체 관람가</option>
						<option value="12세 이상">12세 이상 관람가</option>
						<option value="15세 이상">15세 이상 관람가</option>
						<option value="18세 이상">18세 이상 관람가</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="notice" width="20%">공연 시작 일자</th>
				<td width="80%">
					<input type="date" name="start_date" required>
				</td>
			</tr>
			<tr>
				<th class="notice" width="20%">공연 종료 일자</th>
				<td width="80%">
					<input type="date" name="end_date" required>
				</td>
			</tr>
			<tr>
				<th class="notice" width="20%">공연 포스터</th>
				<td width="80%">
					<input type="file" name="pics" accept="image/*" required>
				</td>
			</tr>
			
			<tr>
				<th class="notice" width="20%">상세 내용</th>
				<td width="80%">
					<div>
						<textarea  rows="20" cols="80" name="detail" 
		                style="width:100%;resize: none;" placeholder="내용을 입력하세요." required="required"></textarea>
					</div>
				</td>
			</tr>
		</table>
		<div style="text-align:center;">
			<button type="button" onclick="selectCheck()">등록</button>
			<button type="button" onclick="location.href='main.do'">취소</button>
		</div>
	</form>
</div>
</body>
</html>