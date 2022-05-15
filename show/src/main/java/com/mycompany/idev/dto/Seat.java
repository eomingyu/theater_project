package com.mycompany.idev.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Seat {
	private int seat_idx;
	private int theater_idx;
	private String seat_grade;
	private int seat_price;
	private String seat_row;
	private int num;
}
