package com.mycompany.idev.mapper;

import java.util.List;

import com.mycompany.idev.dto.Answer;

public interface AnswerMapper {
	List<Answer> selectAnswer(int idx);
	void insertAnswer(Answer vo);
}
