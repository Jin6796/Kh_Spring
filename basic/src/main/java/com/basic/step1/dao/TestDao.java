package com.basic.step1.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestDao {
	Logger logger = LoggerFactory.getLogger(TestDao.class);

	@Autowired(required=false)
	private SqlSessionTemplate sqlSessionTemplate = null;

	public List<Map<String, Object>> testList(Map<String, Object> pmap) {
		logger.info("Dao - testList 호출 성공");
		List<Map<String, Object>> testList = null;
		testList = sqlSessionTemplate.selectList("testList", pmap);
		return testList;
	}
	
	public void testDeleteAll(String[] adeptnos) {
		logger.info("Dao - testDeleteAll 호출 성공");
		List<String> list = new ArrayList<>();
		for(int i=0; i<adeptnos.length; i++) {
			list.add(i, adeptnos[i]);
		}
		sqlSessionTemplate.delete("testDeleteAll", list);
	}

	public void testInsertAll() {
		logger.info("Dao - testInsertAll 호출 성공");
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String,Object> pMap = new HashMap<>();
		pMap.put("test_no", 10);
		pMap.put("test_title", "다중 테스트 1");
		pMap.put("test_content", "멀티 추가 1");
		list.add(pMap);
		
		pMap = new HashMap<>();
		pMap.put("test_no", 20);
		pMap.put("test_title", "다중 테스트 2");
		pMap.put("test_content", "멀티 추가 2");
		list.add(pMap);
		
		pMap = new HashMap<>();
		pMap.put("test_no", 20);
		pMap.put("test_title", "다중 테스트 3");
		pMap.put("test_content", "멀티 추가 3");
		list.add(pMap);
		sqlSessionTemplate.update("testInsertAll", list);
		
	}
}
