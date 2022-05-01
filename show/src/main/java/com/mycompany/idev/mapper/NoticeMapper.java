package com.mycompany.idev.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mycompany.idev.dto.Notice;

public interface NoticeMapper {
	List<Notice> selectAll();
	Notice selectOne(int idx);
	List<Notice> getPageList(Map<String,Integer> map);
	int getCount();
	List<Notice> search(Map<String,String> map);
	List<Notice> searchPageList(@Param("columns") String columns, @Param("find") String find, 
								@Param("startNo") int startNo, @Param("endNo") int endNo);
	int getSearchCount(Map<String,String> map);
	void readCount(int idx);

}
