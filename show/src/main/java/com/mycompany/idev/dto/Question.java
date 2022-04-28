package com.mycompany.idev.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	private int question_idx;
	private String id;
	private String question_title;
	private String question_content;
	private Date question_date;
	private String status;
}
