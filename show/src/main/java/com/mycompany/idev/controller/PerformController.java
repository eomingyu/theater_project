package com.mycompany.idev.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.idev.dto.Performance;
import com.mycompany.idev.mapper.PerformanceMapper;

@Controller
@RequestMapping("/perform")
public class PerformController {
	private static final Logger logger = LoggerFactory.getLogger(PerformController.class);
	
	@Autowired
	PerformanceMapper perform_mapper;
	
	
	@GetMapping("nowlist.do")
	public String performList(Model model) {
		List<Performance> lastlist = perform_mapper.selectLastPerform();
		List<Performance> nowlist = perform_mapper.selectTicketPerform();
		model.addAttribute("lastlist", lastlist);
		model.addAttribute("nowlist", nowlist);
		return "perform/performLists";
	}
	@GetMapping("detailnow.do")
	public String performDetailNow(int idx,Model model) {
		Performance detail = perform_mapper.selectNowDetail(idx);
		model.addAttribute("detail", detail);
		return "perform/performDetail";
	}
	@GetMapping("detaillast.do")
	public String performDetailLast(int idx,Model model) {
		Performance detail = perform_mapper.selectLastDetail(idx);
		model.addAttribute("detail", detail);
		return "perform/performDetail";
	}
}
