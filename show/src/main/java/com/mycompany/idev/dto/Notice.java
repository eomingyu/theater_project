package com.mycompany.idev.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private int notice_idx;
	private String notice_title;
	private String notice_writer;
	private String notice_content;
	private Date notice_date;
	private int notice_view;
	private int next_idx;
	private int last_idx;
	private String next_title;
	private String last_title;
	
}
