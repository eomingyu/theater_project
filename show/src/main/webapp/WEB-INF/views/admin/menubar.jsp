<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

	
</script>
<header>
	<nav>
		<div class="menubar">
			<button id="logo" type="button" onclick="location.href='main.do'">FREDDO</button>
			<button class="accordion" type="button" onclick="location.href='main.do'">
				<span class="icon"><i class="fa-solid fa-house"></i></span>관리자 메인
			</button>
			<button class="accordion">
			<span class="icon"><i class="fa-solid fa-address-book"></i></span>회원 목록</button>
			<div class="panel">
				<div>
					<a href="memberlist.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>회원 목록
					</a>
				</div>
				<div>
					<a href="memberapprove.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>관리자 가입 승인
					</a>
				</div>
			</div>
		<button class="accordion">
			<span class="icon"><i class="fa-solid fa-masks-theater"></i></span>공연</button>
			<div class="panel">
				<div>
					<a href="performinsert.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>공연 등록
					</a>
				</div>
				<div>
					<a href="scheduleinsert.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>공연 스케줄 등록
					</a>
				</div>
			</div>
		<button class="accordion">
			<span class="icon"><i class="fa-solid fa-circle-question"></i></span>1:1 문의</button>
			<div class="panel">
				<div>
					<a href="questionlist.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>1:1 문의 목록
					</a>
				</div>
			</div>
		<button class="accordion">
			<span class="icon"><i class="fa-solid fa-note-sticky"></i></span>공지사항</button>
			<div class="panel">
				<div>
					<a href="noticelist.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>공지사항 목록
					</a>
				</div>
				<div>
					<a href="noticeinsert.do">
						<span class="icon"><i class="fa-solid fa-angle-right"></i></span>공지사항 등록
					</a>
				</div>
			</div>		
		</div>	
	</nav>
</header>
<script type="text/javascript">
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    }
  });
}
var href=window.location.pathname;
//회원 목록, 관리자 변경 메뉴 시 아코디언1 열림
if(href.indexOf('member')!=-1 || href.indexOf('adminupdate')!=-1){
	acc[1].classList.add("active");
	acc[1].nextElementSibling.style.maxHeight = acc[1].nextElementSibling.scrollHeight + "px";
}
//공연,스케줄 등록 시 아코디언2 열림
else if(href.indexOf('perform')!=-1 || href.indexOf('schedule')!=-1){
	acc[2].classList.add("active");
	acc[2].nextElementSibling.style.maxHeight = acc[2].nextElementSibling.scrollHeight + "px";
}
//문의 메뉴 시 아코디언3 열림
else if(href.indexOf('question')!=-1){
	acc[3].classList.add("active");
	acc[3].nextElementSibling.style.maxHeight = acc[3].nextElementSibling.scrollHeight + "px";
}
//공지 메뉴시 아코디언4 열림
else if(href.indexOf('notice')!=-1){
	acc[4].classList.add("active");
	acc[4].nextElementSibling.style.maxHeight = acc[4].nextElementSibling.scrollHeight + "px";
}
</script>