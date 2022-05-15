package com.mycompany.idev.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.idev.dto.Schedules;

public interface SchedulesMapper {
	void insertSchedule(Schedules vo);
	List<Schedules> selectSchedule(int idx);
	List<Schedules> selectDate(@Param("perform_date") Date perform_date,@Param("perform_idx") int perform_idx);
}