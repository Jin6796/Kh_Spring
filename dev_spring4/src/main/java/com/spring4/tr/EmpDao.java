package com.spring4.tr;

import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.dao.DataAccessException;

public class EmpDao {
	Logger logger = Logger.getLogger(EmpDao.class);
	
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
// 	스프링에서 제공하는 SQLException 대신 사용하는 클래스
	public void empInsert(Map<String, Object> emap) throws DataAccessException {
		// 값이 제대로 들어오는지 확인하기 위해서 업데이트 직전에 파라미터 값 확인하기
		logger.info(emap);
		sqlSessionTemplate.update("empInsert", emap);
	}
}
