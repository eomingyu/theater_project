<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}

</style>
<script type="text/javascript">
	function updateAdmin(id,authority){
		if(authority==0)
			location.href="javascript:void(0);"
		else{
			var form = document.createElement('form');
			var input = document.createElement('input');
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'id');
			input.setAttribute('value', id);
			
			
			form.appendChild(input);
			form.setAttribute('method', 'post');
			form.setAttribute('action', 'adminupdate.do')
			document.body.appendChild(form);
			form.submit();
		}
	}
	function deleteMember(id){
		
			var form = document.createElement('form');
			var input = document.createElement('input');
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'id');
			input.setAttribute('value', id);
			
			
			form.appendChild(input);
			form.setAttribute('method', 'post');
			form.setAttribute('action', 'memberdelete.do')
			document.body.appendChild(form);
			form.submit();
	
	}
</script>
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(210ms)
		if(${message != null}) alert('${message}');
	},210);
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section>
	<h3>회원 목록</h3>
	<hr>
	<div style="margin:auto;">
		<div style="text-align:right;">
			<form action="membersearch.do" method="post">
				<select name="columns" id="columns">
					<option value="id">아이디</option>
					<option value="name">이름</option>
					<option value="authority">권한</option>
				</select>
				<!-- 아래 find는 2개 중에 하나만 화면에 표시  -->
				<span id="content">
					<input name="find" placeholder="검색할 내용 입력" value="${find}">
				</span>
				<span id="authority">
					<select name="find" id="authorities">
					<!-- 사용자 선택하는 텍스트와 db테이블에 저장된 값이 다릅니다. -->
						<option value="1">일반 회원</option>
						<option value="0">관리자</option>
						<option value="3">승인 대기</option>
					</select>
				</span>
				<button>검색</button>
				<button type="button" onclick="location.href='memberlist.do'">전체보기</button>
			</form>
		</div>
		<table>
			<tr>
			<th width="8%">No</th>
			<th width="15%">아이디</th>
			<th width="15%">이름</th>
			<th width="20%">생년월일</th>
			<th width="20%">가입일자</th>
			<th width="10%">구분</th>
			<th width="7%"></th>
			</tr>
			<c:forEach var="vo" items="${list}" varStatus="status">
			<tr class="list">
				<td>${status.count+(page.pageNo-1)*10}</td> 	
		 		<td><%-- <a href="detail?idx=${vo.id}&pageNo=${page.pageNo}" class="title"> --%>${vo.id}</td>
		 		<td>${vo.name }</td>
		 		<td>${vo.birth_date}</td>
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
		 		<c:if test="${vo.authority==3}">
		 			<span style="color:blue;">승인 대기</span>
		 		</c:if>
		 		<%-- <c:choose>
		 			<c:when test="${vo.authority==1}">
		 				<span>일반 회원</span>
		 			</c:when>
		 			<c:otherwise>
		 				<span style="color:red;font-weight:bolder;">관리자</span>
		 			</c:otherwise>
		 		</c:choose> --%>
		 		</td>
		 		<td>
	<div class="dropdown">
	  <button class="dropbtn">•••</button>
	  <div class="dropdown-content">
	    <a href="javascript:updateAdmin('${vo.id}',${vo.authority})">관리자로 변경</a>
	    <a href="javascript:deleteMember('${vo.id}')">회원 삭제</a>
	  </div>
	</div>
	<%-- 	 			<form action="memberUpdate.do" method="post">
		 			<input type="hidden" name="id" value="${vo.id}">
						<button>정보 변경</button>
					</form> --%>
				</td>
		 	</tr>
	 	 	</c:forEach>
	 	 	<!-- list의 데이터가 없을 때 list애트리뷰트가 null X,size()가 0(jstl의 함수) -->
		<c:if test="${fn:length(list)==0 }">
					<tr>
						<td colspan="7" style="text-align:center;"><br>조회 결과가 없습니다.</td>
					</tr>
		</c:if>
		</table>
	</div>
	
	<div style="text-align: center;">		<!-- a태그에서 onclick 사용할 땐 자바스크립트라고 표시 -->
		<a class="pagenum" onclick="javascript:goPage(1)">&lt;&lt;</a>   <!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
		<a class="${page.startPage>1? 'pagenum':'none'}" 
			 onclick="javascript:goPage('${page.startPage-1 }')">&lt;</a>  
		
		<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">  <!-- 페이지목록의 범위  -->
			<c:choose>
				<c:when test="${i==page.pageNo}">	<!-- 현재 페이지인 경우 링크 제거 -->
					<span class="pagenum">${i}</span>
				</c:when>
				<c:otherwise>
					<a class="pagenum" onclick="javascript:goPage('${i}')">${i}</a>     <!-- 현재페이지 i값으로 변경  -->
				</c:otherwise>			
			</c:choose>
		</c:forEach>
		
		<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}" 
			onclick="javascript:goPage('${page.endPage+1 }')">&gt;</a> 
		<a class="pagenum" onclick="javascript:goPage('${page.totalPage }')">&gt;&gt;</a>
	</div>
	<form action="" method="post">
		<input name="columns" type="hidden">
		<input name="find" type="hidden">		<!-- find[0] -->
		<input name="find" type="hidden">		<!-- find[1] -->
		<input name="pageNo" type="hidden">
	</form>
</section>
<script type="text/javascript">
var href=window.location.pathname;				//memberList.do 또는 search.do 가져오기
	function goPage(no){
		const frm = document.forms[1];
		frm.action=href;
		frm.pageNo.value=no;
		frm.columns.value='${columns}';
		if('${columns}'=='authority')			
			frm.find[1].value='${find}';		//컨트롤러에서 find 값 2개를 배열로 받기 때문  ArrayIndexOutOfBoundsException
		else
			frm.find[0].value='${find}';
		frm.submit();
	}
   		//조회 후에 select 남아있게 하기
		const sel = document.querySelectorAll("#columns>option");	/* > 자식요소  */
		sel.forEach(function(item){
			if(item.value=='${columns}'){
				item.selected='selected';
				//column 애트리뷰트 값과 일치하는 option 항목일 때입니다.
			}
		});
		document.querySelectorAll("#authorities>option").forEach(function(item){
			if(item.value=='${find}'){
				item.selected='selected';
			}
		});
		//화면 표시 변경하기
 		const authority = document.getElementById('authority');		//span grade
		const content = document.getElementById('content');
		if('${columns}'=='authority'){
			authority.style.display='inline-block';
			content.style.display='none';
		}else{
			content.style.display='inline-block';
			authority.style.display='none';
		}
 		//검색 컬럼 선택 변경될 때
		document.getElementById('columns').addEventListener("change",changeView);
		
		function changeView(){
			const col = document.forms[0].columns.value;
			if(col=='authority'){
				authority.style.display='inline-block';
				content.style.display='none';
			}else{
				content.style.display='inline-block';
				authority.style.display='none';
				//form 요소 가져오기
				document.forms[0].elements[1].value="";
			}
		}
		
		//authority.style.display='none';		//안보이게 하는 방법
   </script>

</body>
</html>