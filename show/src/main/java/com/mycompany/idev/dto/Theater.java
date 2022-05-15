package com.mycompany.idev.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Theater {
	private int theater_idx;
	private String theater_name;
	private String theater_fee;
	private int seat_number;
}
