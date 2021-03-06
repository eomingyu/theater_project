package com.mycompany.idev.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mycompany.idev.dto.Answer;
import com.mycompany.idev.dto.Member;
import com.mycompany.idev.dto.Notice;
import com.mycompany.idev.dto.PageDto;
import com.mycompany.idev.dto.Performance;
import com.mycompany.idev.dto.Question;
import com.mycompany.idev.dto.Schedules;
import com.mycompany.idev.dto.Theater;
import com.mycompany.idev.mapper.AnswerMapper;
import com.mycompany.idev.mapper.MemberMapper;
import com.mycompany.idev.mapper.NoticeMapper;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.QuestionMapper;
import com.mycompany.idev.mapper.SchedulesMapper;
import com.mycompany.idev.mapper.TheaterMapper;
import com.mycompany.idev.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	NoticeMapper notice_mapper;
	
	@Autowired
	QuestionMapper question_mapper;
	
	@Autowired
	AnswerMapper answer_mapper;
	
	@Autowired
	PerformanceMapper perform_mapper;
	
	@Autowired
	SchedulesMapper schedule_mapper;
	
	@Autowired
	TheaterMapper theater_mapper;
	
	private final AdminService service;
	
	public AdminController(AdminService service) {
		this.service = service;
	}
	
	@RequestMapping("/main.do")
	public String main() {
		return "admin/main";
	}
//회원 목록	
	@RequestMapping("memberlist.do")
	public String list(@RequestParam(required=false, defaultValue = "1")
	int pageNo,Model model) {
		PageDto page = new PageDto(pageNo,10,mapper.getCount());
		
		Map<String,Integer> map = new HashMap<>();
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<Member> list = mapper.getPageList(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/memberList";
	}
//검색하여 조회
	@RequestMapping("membersearch.do")
	public String search(@RequestParam(required=false, defaultValue = "1")
			int pageNo,@RequestParam String columns,
			@RequestParam(value = "find") String[] finds,Model model) {
		String find = finds[0];
		if(columns.equals("authority")) find=finds[1];
		logger.info("[My]"+columns);
		Map<String,String> map = new HashMap<>();
		map.put("columns",columns);
		map.put("find",find);
		
		PageDto page = new PageDto(pageNo,10,mapper.getSearchCount(map));
		
		int startNo = page.getStartNo();
		int endNo = page.getEndNo();
		List<Member> list = mapper.searchPageList(columns,find,startNo,endNo);
		logger.info("[My]"+list);
		
		model.addAttribute("columns",columns);
		model.addAttribute("find",find);
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/memberList";
	}
//관리자로 변경	
	@PostMapping("adminupdate.do")
	public String adminUpdate(String id, Model model) {
		Member vo = mapper.getOne(id);
		model.addAttribute("vo",vo);
		return "admin/memberUpdate";
	}
	@PostMapping("adminupdatesave.do")
	public String adminUpdateSave(String id, RedirectAttributes rda) {
		mapper.updateAdmin(id);
		rda.addFlashAttribute("message",id+"님을 관리자로 등록하였습니다.");
		return "redirect:memberlist.do";
	}
//회원 삭제	
	@PostMapping("memberdelete.do")
	public String memberDelete(String id, Model model) {
		Member vo = mapper.getOne(id);
		model.addAttribute("vo",vo);
		return "admin/memberDelete";
	}
	@PostMapping("memberdeletesave.do")
	public String memberDeleteSave(String id, RedirectAttributes rda) {
		mapper.deleteMember(id);
		rda.addFlashAttribute("message",id+"님의 회원 정보를 삭제하였습니다.");
		return "redirect:memberlist.do";
	}	
	
	
//공지사항-----------------------------------------
	@RequestMapping("noticelist.do")
	public String noticeList(@RequestParam(required=false, defaultValue = "1")
	int pageNo,Model model) {
		PageDto page = new PageDto(pageNo,10,notice_mapper.getCount());
		
		Map<String,Integer> map = new HashMap<>();
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<Notice> list = notice_mapper.getPageList(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		return "admin/noticeList";
	}
	
	@RequestMapping("noticesearch.do")
	public String noticeSearch(@RequestParam(required=false, defaultValue = "1")
				int pageNo, String columns, String find, Model model) {
		//logger.info("[My]"+columns);
		Map<String,String> map = new HashMap<>();
		map.put("columns",columns);
		map.put("find",find);
		
		PageDto page = new PageDto(pageNo,10,notice_mapper.getSearchCount(map));
		
		int startNo = page.getStartNo();
		int endNo = page.getEndNo();
		List<Notice> list = notice_mapper.searchPageList(columns,find,startNo,endNo);
		//logger.info("[My]"+list);
		
		model.addAttribute("columns",columns);
		model.addAttribute("find",find);
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/noticeList";
	}
	
	@RequestMapping("noticedetail.do")
	public String noticeDetail(int idx,@RequestParam(required=false, defaultValue = "1") int pageNo, Model model) {
		//관리자 페이지에서는 조회수 증가 x
		Notice detail = notice_mapper.selectOne(idx);
		
		model.addAttribute("detail", detail);
		model.addAttribute("pageNo", pageNo);
		
		
		return "admin/noticeDetail";
	}
	@PostMapping("noticeupdate.do")
	public String noticeUpdate(int idx,int pageNo,Model model) {
		Notice detail = notice_mapper.selectOne(idx);
		model.addAttribute("detail", detail);
		model.addAttribute("pageNo", pageNo);
		
		return "admin/noticeUpdate";
	}
	@PostMapping("noticeupdatesave.do")
	public String noticeUpdateSave(@RequestParam(required=false, defaultValue = "1") int pageNo,
//		Notice notice, RedirectAttributes rda){
		int idx, String title,String content, RedirectAttributes rda) {
//		notice_mapper.updateNotice(notice);
//		rda.addAttribute("idx", notice.getNotice_idx());
		notice_mapper.updateNotice(title,content,idx);
		rda.addAttribute("idx", idx);
		rda.addAttribute("pageNo", pageNo);
		rda.addFlashAttribute("message","글이 수정되었습니다.");
		return "redirect:noticedetail.do";
	}
	@GetMapping("noticeinsert.do")
	public String noticeInsert() {
		
		return "admin/noticeInsert";
	}
	
	@PostMapping("noticeinsert.do")
	public String noticeInsertSave(Notice vo, RedirectAttributes rda) {
		notice_mapper.insertNotice(vo);
		rda.addFlashAttribute("message", "공지사항이 등록되었습니다.");
		
		return "redirect:noticelist.do";
	}
	
	
	@PostMapping("noticedelete.do")
	public String noticeDelete(int idx, int pageNo, RedirectAttributes rda) {
		notice_mapper.deleteNotice(idx);
		rda.addAttribute("pageNo", pageNo);
		rda.addFlashAttribute("message","글이 삭제되었습니다.");
		return "redirect:noticelist.do";
	}
	

//공연 등록
	@GetMapping("performinsert.do")
	public String performInsert(Model model) {
		List<Theater> list = theater_mapper.selectAll();
		model.addAttribute("list", list);
		return "admin/performInsert";
	}
	@PostMapping("performinsert.do")
	public String performInsertSave(Performance vo,RedirectAttributes rda){
		logger.info("[My]"+vo);
		try {
			service.fileSave(vo);
			rda.addFlashAttribute("message","공연이 등록되었습니다.");
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} 
		return "redirect:performinsert.do";
	}

//1:1 문의 목록
	@RequestMapping("questionlist.do")
	public String questionList(@RequestParam(required=false, defaultValue = "1")
	int pageNo,Model model) {
		PageDto page = new PageDto(pageNo,10,question_mapper.getCount());
		
		Map<String,Integer> map = new HashMap<>();
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<Question> list = question_mapper.getPageList(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/questionList";
	}
//검색하여 조회
	@RequestMapping("questionsearch.do")
	public String questionSearch(@RequestParam(required=false, defaultValue = "1")
			int pageNo,@RequestParam String columns,
			@RequestParam(value = "find") String[] finds,Model model) {
		String find = finds[0];
		if(columns.equals("status")) find=finds[1];
		logger.info("[My]"+columns);
		Map<String,String> map = new HashMap<>();
		map.put("columns",columns);
		map.put("find",find);
		
		PageDto page = new PageDto(pageNo,10,question_mapper.getSearchCount(map));
		
		int startNo = page.getStartNo();
		int endNo = page.getEndNo();
		List<Question> list = question_mapper.searchPageList(columns,find,startNo,endNo);
		logger.info("[My]"+list);
		
		model.addAttribute("columns",columns);
		model.addAttribute("find",find);
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/questionList";
	}
//1:1 문의 상세	
	@GetMapping("questiondetail.do")
	public String questionDetail(int idx,@RequestParam(required=false, defaultValue = "1") int pageNo, Model model) {
		Question detail = question_mapper.selectOne(idx);
		List<Answer> answer = answer_mapper.selectAnswer(idx);
		model.addAttribute("detail", detail);
		model.addAttribute("answer", answer);
		model.addAttribute("pageNo", pageNo);
		return "admin/questionDetail";
	}
//1:1 문의 답변 등록	
	@PostMapping("questiondetail.do")
	public String answerInsert(Answer vo,@RequestParam(required=false, defaultValue = "1") int pageNo, RedirectAttributes rda) {
		service.insertAnswer(vo);
		
		rda.addAttribute("idx", vo.getQuestion_idx());
		rda.addAttribute("pageNo", pageNo);
		rda.addFlashAttribute("message", "답변이 등록되었습니다.");
		return "redirect:questiondetail.do";
	}
//공연 스케줄 등록
	@GetMapping("scheduleinsert.do")
	public String scheduleInsert(Model model) {
		List<Performance> perform = perform_mapper.selectScheduledPerform();
		model.addAttribute("perform", perform);
		return "admin/scheduleInsert";
	}
	@PostMapping("scheduleinsert.do")
	public String scheduleInsertSave(Schedules vo,RedirectAttributes rda) {
		schedule_mapper.insertSchedule(vo);
		rda.addFlashAttribute("message","공연 스케줄이 등록되었습니다.");
		return "redirect:scheduleinsert.do";
	}
//관리자 승인
	@GetMapping("memberapprove.do")
	public String memberApprove(@RequestParam(required=false, defaultValue = "1")
	int pageNo,Model model) {
		PageDto page = new PageDto(pageNo,10,mapper.getAppCount());
		
		Map<String,Integer> map = new HashMap<>();
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<Member> list = mapper.getAppList(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/memberAppList";
	}
	
	@PostMapping("memberok.do")
	public String memberOk(String id,RedirectAttributes rda) {
		mapper.updateAdmin(id);
		rda.addFlashAttribute("message",id+"님의 관리자 가입을 승인하였습니다.");
		
		return "redirect:memberapprove.do";
	}
	@PostMapping("memberno.do")
	public String memberNo(String id,RedirectAttributes rda) {
		mapper.deleteMember(id);
		rda.addFlashAttribute("message",id+"님의 관리자 가입을 거절하였습니다.");
		
		return "redirect:memberapprove.do";
	}
}