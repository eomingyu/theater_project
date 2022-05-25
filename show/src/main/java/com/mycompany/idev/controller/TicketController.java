package com.mycompany.idev.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.mycompany.idev.dto.Temp;
import com.mycompany.idev.dto.Ticket;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.SchedulesMapper;
import com.mycompany.idev.mapper.SeatMapper;
import com.mycompany.idev.mapper.TicketMapper;

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
	
	@Autowired
	TicketMapper ticket_mapper;
	
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
	
	@PostMapping("ticketpayment.do")
	public String ticketPayment(int schedule_idx,int[] choiceseat,String ticketno,int payprice, Model model) {
		String seats = Arrays.toString(choiceseat);
		int number = choiceseat.length;
		Seat seat1;
		String seat2="";
		for(int i=0;i<number;i++) {
			seat1 = seat_mapper.getOne(choiceseat[i]);
			seat2 += seat1.getSeat_row()+"-"+seat1.getNum()+", ";
		}
		String choicedseat=seat2.substring(0, seat2.length()-2);
		Schedules scheduleinfo = schedules_mapper.getInfo(schedule_idx);
		Performance performinfo = perform_mapper.getOne(scheduleinfo.getPerform_idx());
		model.addAttribute("schedule_idx", schedule_idx);
		model.addAttribute("scheduleinfo", scheduleinfo);
		model.addAttribute("performinfo", performinfo);
		model.addAttribute("ticketno", ticketno);
		model.addAttribute("choiceseat", seats);
		model.addAttribute("choicedseat", choicedseat);
		model.addAttribute("number", number);
		model.addAttribute("payprice", payprice);
		return "ticket/ticketPayment";
	}
	@PostMapping("ticketsuccess.do")
	public String ticketSuccess(int schedule_idx,String choiceseat,String ticket_no, Model model) {
		String arr = choiceseat.substring(1, choiceseat.length()-1);
		String[] arr2 = arr.split(", ");
		int[] arr3 = new int[arr2.length];
		for (int i = 0; i < arr2.length; i++) {
            arr3[i] = Integer.parseInt(arr2[i]);
        }
		logger.info(ticket_no);
		logger.info(ticket_no);
		int ticketno = Integer.parseInt(ticket_no);
		int number = arr3.length;
		Ticket vo = new Ticket();
		vo.setId("aaaa3");
		vo.setSchedule_idx(schedule_idx);
		vo.setTicket_no(ticketno);
		for(int i=0;i<number;i++) {
			vo.setSeat_idx(arr3[i]);
			ticket_mapper.insertTicket(vo);
		}
		Seat seat1;
		String seat2="";
		for(int i=0;i<number;i++) {
			seat1 = seat_mapper.getOne(arr3[i]);
			seat2 += seat1.getSeat_row()+"-"+seat1.getNum()+", ";
		}
		String choicedseat=seat2.substring(0, seat2.length()-2);
		Schedules scheduleinfo = schedules_mapper.getInfo(schedule_idx);
		Performance performinfo = perform_mapper.getOne(scheduleinfo.getPerform_idx());
		model.addAttribute("scheduleinfo", scheduleinfo);
		model.addAttribute("performinfo", performinfo);
		model.addAttribute("ticketno", ticket_no);
		model.addAttribute("choicedseat", choicedseat);
		model.addAttribute("number", number);
		return "ticket/ticketSuccess";
	}
	@GetMapping("ticket.do")
	public String getTickets() {
		
		return "ticket/test";
	}
	@PostMapping("ticket.do")
	public String getTicket(String id,Model model) {
		List<Ticket> ticketnos = ticket_mapper.getIdTicket(id);
		//예매한 수
		int number = ticketnos.size();
		//회원 예매번호 목록
		List<Integer> ticketnos2 = new ArrayList<>();
		for(int i=0;i<number;i++) {
			ticketnos2.add(ticketnos.get(i).getTicket_no());
		}
		
		int schedulelist[] = new int[number];
		//행 열 번호 좌석 리스트
		String seatlist[] = new String[number];
		//선택 좌석 수
		int numlist[] = new int[number];
		//예매 일시 리스트
		Timestamp ticketdatelist[] = new Timestamp[number];
		List<Schedules> scheduleinfo = new ArrayList<>();
		List<Performance> performinfo = new ArrayList<>();
		for(int i=0;i<number;i++) {
			//예매 번호로 조회한 정보
			List<Ticket> a = ticket_mapper.getTicket(ticketnos2.get(i));
			if(a.get(0)!=null) {
				schedulelist[i]=a.get(0).getSchedule_idx();
				ticketdatelist[i] = a.get(0).getTicket_date();
				int[] seats = new int[a.size()];
				numlist[i]=a.size();
				for(int j=0;j<a.size();j++) {
					seats[j]= a.get(j).getSeat_idx();
				}
				Seat seat1;
				String seat2="";
				for(int j=0;j<numlist[i];j++) {
					seat1 = seat_mapper.getOne(seats[j]);
					seat2 += seat1.getSeat_row()+"-"+seat1.getNum()+", ";
				}
				String choicedseat=seat2.substring(0, seat2.length()-2);
				logger.info(choicedseat);
				seatlist[i]=choicedseat;
			}
		}
		for(int i=0;i<number;i++) {
			scheduleinfo.add(schedules_mapper.getInfo(schedulelist[i]));
			performinfo.add(perform_mapper.getOne(scheduleinfo.get(i).getPerform_idx()));
		}
		List<Temp> list = new ArrayList<>();
		for (int i=0;i<number;i++) {
			Temp temp = new Temp();
			temp.setTicket_no(ticketnos2.get(i));
			temp.setPerform(performinfo.get(i).getPerform_title());
			temp.setTheater(performinfo.get(i).getTheater_name());
			temp.setPerform_date(scheduleinfo.get(i).getPerform_date());
			temp.setStart_time(scheduleinfo.get(i).getStart_time());
			temp.setSeat(seatlist[i]);
			temp.setNum(numlist[i]);
			list.add(temp);
		}
		model.addAttribute("list", list);
		return "ticket/test";
	}
	
}
