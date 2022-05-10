package com.mycompany.idev.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.idev.dto.Answer;
import com.mycompany.idev.dto.Performance;
import com.mycompany.idev.dto.Question;
import com.mycompany.idev.mapper.AnswerMapper;
import com.mycompany.idev.mapper.PerformanceMapper;
import com.mycompany.idev.mapper.QuestionMapper;

@Service
public class AdminServiceImpl implements AdminService {
	
	private final PerformanceMapper dao;
	
	
	public AdminServiceImpl(PerformanceMapper dao) {
		this.dao = dao;
	}
	
	@Autowired	
	private AnswerMapper answer_dao;
	
	@Autowired
	private QuestionMapper question_dao;


	public int fileSave(Performance vo) {
		// 서버에서 전송받은 파일을 저장할 폴더를 정합니다. : c:\\upload
		String path = "c:\\upload";
		MultipartFile image = vo.getPics();									//업로드한 이미지 가져오기
		String temp = image.getOriginalFilename();
		String ext = temp.substring(temp.lastIndexOf('.'), temp.length()); 			// 확장자만 추출
		StringBuilder newfile= new StringBuilder("poster_")
				.append(UUID.randomUUID().toString().substring(0, 8)).append(ext);	// 파일명 중복 방지 랜덤 문자열
		// 새로운 파일명
		File sfile = new File(path + "\\" + newfile);
			try {
				image.transferTo(sfile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 								// 서버에 저장할 파일객체로 전송 (서버 업로드)
			vo.setPoster(newfile.toString());
			return dao.insertPerform(vo);
	}
	
	@Transactional
	public void insertAnswer(Answer vo) {
		answer_dao.insertAnswer(vo);
		Question detail = question_dao.selectOne(vo.getQuestion_idx());
		if(detail.getStatus().equals("답변 대기"))
			question_dao.updateStatus(vo.getQuestion_idx());
	}
	
	
}
