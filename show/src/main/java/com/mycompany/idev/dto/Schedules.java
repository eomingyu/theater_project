package com.mycompany.idev.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedules {
	private int schedule_idx;
	private int perform_idx;
	private String theater;
	private Date perform_date;
	private String start_time;
}
