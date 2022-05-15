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
import com.mycompany.idev.dto.Schedules;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.SchedulesMapper;

@Controller
@RequestMapping("/ticket")
public class TicketController {
	private static final Logger logger = LoggerFactory.getLogger(TicketController.class);
	
	@Autowired
	PerformanceMapper perform_mapper;
	
	@Autowired
	SchedulesMapper schedules_mapper;
	
	@RequestMapping("list.do")
	public String performList(Model model) {
		List<Performance> list = perform_mapper.selectTicketPerform();
		model.addAttribute("list", list);
		return "ticket/performList";
	}
	
	@GetMapping("choice.do")
	public String choice(int idx, int tidx, Model model) {
		
		List<Schedules> list = schedules_mapper.selectSchedule(idx);
		model.addAttribute("idx", idx);
		model.addAttribute("tidx", tidx);
		model.addAttribute("list", list);
		return "ticket/ticketSchedule";
	}
	
	
	
}
