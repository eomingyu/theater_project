package com.mycompany.idev.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Temp {
	private int sequence;
	private int ticket_no;
	private String perform;
	private String theater;
	private Date perform_date;
	private String start_time;
	private String seat;
	private int num;
	private Timestamp ticket_date;
	
}
