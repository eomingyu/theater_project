package com.mycompany.idev.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review_comment {
	private int comment_idx;
	private String id;
	private int review_idx;
	private String comment_content;
	private Timestamp comment_date;
}
