package com.mycompany.idev.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Answer {
	private int answer_idx;
	private int question_idx;
	private String answer_writer;
	private String answer_content;
	private Date answer_date;
}
