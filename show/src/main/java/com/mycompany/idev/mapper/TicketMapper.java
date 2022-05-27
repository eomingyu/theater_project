package com.mycompany.idev.mapper;

import java.util.List;

import com.mycompany.idev.dto.Ticket;

public interface TicketMapper {
	void insertTicket(Ticket vo);
	List<Ticket> getTicket(int ticket_no);
	List<Ticket> getIdTicket(String id);
	void cancelTicket(int ticket_no);
	List<Ticket> getIdCancelledTicket(String id);
}
