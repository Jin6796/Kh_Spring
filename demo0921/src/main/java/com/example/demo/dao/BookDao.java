package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

@Service
public class BookDao {
	Logger logger = LoggerFactory.getLogger(BookDao.class);
	
	@Autowired(required=false)
	private SqlSessionTemplate sqlSessionTemplate = null;

	public List<Map<String, Object>> bookList(Map<String, Object> pMap) {
		logger.info("bookList 호출 성공 ==> " +pMap.toString());
		List<Map<String, Object>> bookList = null;
		bookList = sqlSessionTemplate.selectList("bookList", pMap);
		logger.info(bookList.toString());
		return bookList;
	}
}
