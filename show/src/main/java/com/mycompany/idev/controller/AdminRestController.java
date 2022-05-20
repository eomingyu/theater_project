package com.mycompany.idev.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.idev.dto.Performance;
import com.mycompany.idev.dto.Schedules;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.SchedulesMapper;

@RestController
public class AdminRestController {
	private static final Logger logger = LoggerFactory.getLogger(AdminRestController.class);
	
	@Autowired
	PerformanceMapper perform_mapper;
	
	@Autowired
	SchedulesMapper schedule_mapper;
	
	@ResponseBody
	@RequestMapping(value="/asyncperform/{perform_idx}",method=RequestMethod.GET
	,produces = "application/json;charset=utf-8")
	public String getOne(@PathVariable int perform_idx) {
		Performance info = perform_mapper.getOne(perform_idx);
		List<Schedules> datetime = schedule_mapper.getDateTime(perform_idx);
		Map<String,Object> map = new HashMap<>();
		map.put("info",info);
		map.put("datetime", datetime);
		ObjectMapper objmapper = new ObjectMapper();
		String json_result=null;
		try {
			json_result = objmapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json_result;
	}
	
}
