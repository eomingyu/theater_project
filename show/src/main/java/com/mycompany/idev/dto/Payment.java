package com.mycompany.idev.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
	private int payment_no;
	private int ticket_no;
	private Timestamp payment_date;
	private int payment_price;
	private String payment_method;
	private String payment_status;
}
