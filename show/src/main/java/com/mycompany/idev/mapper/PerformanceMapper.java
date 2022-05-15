package com.mycompany.idev.mapper;

import java.util.List;

import com.mycompany.idev.dto.Performance;

public interface PerformanceMapper {
	int insertPerform(Performance perform);
	List<Performance> selectScheduledPerform();
	List<Performance> selectTicketPerform();
	Performance getOne(int idx);
}
