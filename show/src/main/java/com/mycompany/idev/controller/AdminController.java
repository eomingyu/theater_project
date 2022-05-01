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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.idev.HomeController;
import com.mycompany.idev.dto.Member;
import com.mycompany.idev.dto.Notice;
import com.mycompany.idev.dto.PageDto;
import com.mycompany.idev.mapper.MemberMapper;
import com.mycompany.idev.mapper.NoticeMapper;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	NoticeMapper notice_mapper;
	
	@RequestMapping("/main.do")
	public String main() {
		return "admin/main";
	}
	
	@RequestMapping("memberList.do")
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
	@RequestMapping("search.do")
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
	
	@RequestMapping("noticeList.do")
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
	
	@RequestMapping("noticeSearch.do")
	public String noticeSearch(@RequestParam(required=false, defaultValue = "1")
				int pageNo, String columns, String find, Model model) {
		logger.info("[My]"+columns);
		Map<String,String> map = new HashMap<>();
		map.put("columns",columns);
		map.put("find",find);
		
		PageDto page = new PageDto(pageNo,10,notice_mapper.getSearchCount(map));
		
		int startNo = page.getStartNo();
		int endNo = page.getEndNo();
		List<Notice> list = notice_mapper.searchPageList(columns,find,startNo,endNo);
		logger.info("[My]"+list);
		
		model.addAttribute("columns",columns);
		model.addAttribute("find",find);
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "admin/noticeList";
	}
	
	@GetMapping("detail")
	public String noticeDetail(int idx, int pageNo, Model model) {
		//관리자 페이지에서는 조회수 증가 x
		Notice detail = notice_mapper.selectOne(idx);
		
		model.addAttribute("detail", detail);
		model.addAttribute("pageNo", pageNo);
		
		
		return "admin/noticeDetail";
	}
	
}
