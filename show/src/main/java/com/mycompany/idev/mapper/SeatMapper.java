package com.mycompany.idev.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.idev.dto.Seat;

public interface SeatMapper {
	int leftSeat(@Param("theater_idx") int theater_idx, @Param("schedule_idx") int schedule_idx);
	List<Seat> getAll(@Param("theater_idx") int theater_idx);
	List<Seat> reservedSeat(@Param("theater_idx") int theater_idx, @Param("schedule_idx") int schedule_idx);
	Seat getOne(int seat_idx);
}
