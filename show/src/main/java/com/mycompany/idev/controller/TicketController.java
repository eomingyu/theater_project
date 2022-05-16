package com.mycompany.idev.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.idev.dto.Performance;
import com.mycompany.idev.dto.Schedules;
import com.mycompany.idev.dto.Seat;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.SchedulesMapper;
import com.mycompany.idev.mapper.SeatMapper;

@Controller
@RequestMapping("/ticket")
public class TicketController {
	private static final Logger logger = LoggerFactory.getLogger(TicketController.class);
	
	@Autowired
	PerformanceMapper perform_mapper;
	
	@Autowired
	SchedulesMapper schedules_mapper;
	
	@Autowired
	SeatMapper seat_mapper;
	
	@RequestMapping("list.do")
	public String performList(Model model) {
		List<Performance> list = perform_mapper.selectTicketPerform();
		model.addAttribute("list", list);
		return "ticket/performList";
	}
	
	@GetMapping("choice.do")
	public String choice(int idx, int tidx, Model model) {
		Performance perform = perform_mapper.getOne(idx);
		List<Schedules> list = schedules_mapper.selectSchedule(idx);
		model.addAttribute("perform",perform);
		model.addAttribute("idx", idx);
		model.addAttribute("tidx", tidx);
		model.addAttribute("list", list);
		return "ticket/ticketSchedule";
	}
	
	@PostMapping("choiceSeat.do")
	public String choiceSeat(int perform_idx,@RequestParam int theater_idx,Date perform_date, String start_time, Model model) {
		int schedule_idx = schedules_mapper.getIdx(perform_idx, perform_date, start_time);
		int seat = seat_mapper.leftSeat(theater_idx,schedule_idx);
		List<Seat> allseat = seat_mapper.getAll(theater_idx);
		List<Seat> reservedseat = seat_mapper.reservedSeat(theater_idx, schedule_idx);

		model.addAttribute("theater_idx",theater_idx);
		model.addAttribute("schedule_idx", schedule_idx);
		model.addAttribute("seat", seat);
		model.addAttribute("allseat", allseat);
		model.addAttribute("reservedseat", reservedseat);
		return "ticket/ticketSeat";
	}
	
	
}
