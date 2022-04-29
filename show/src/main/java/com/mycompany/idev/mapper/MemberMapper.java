package com.mycompany.idev.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mycompany.idev.dto.Member;

public interface MemberMapper {
	Member list();
	List<Member> getPageList(Map<String,Integer> map);
	int getCount();
	List<Member> search(Map<String,String> map);
	List<Member> searchPageList(@Param("columns") String columns, @Param("find") String find, 
								@Param("startNo") int startNo, @Param("endNo") int endNo);
//	List<Members> searchPageList(Map<String,String> map,Map<String,Integer> map2);
	int getSearchCount(Map<String,String> map);
}
