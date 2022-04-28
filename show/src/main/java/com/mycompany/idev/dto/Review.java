package com.mycompany.idev.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private int review_idx;
	private String id;
	private int perform_idx;
	private int review_view;
	private String review_content;
	private Date review_date;
	private int comment_count;
	private int review_like;
}
