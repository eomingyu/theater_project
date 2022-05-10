package com.mycompany.idev.service;

import com.mycompany.idev.dto.Answer;
import com.mycompany.idev.dto.Performance;

public interface AdminService {
	int fileSave(Performance perform);
	void insertAnswer(Answer answer);
}
