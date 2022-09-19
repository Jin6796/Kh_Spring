package com.spring4.tr;

import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;

public class DeptDao {
	Logger logger = Logger.getLogger(DeptDao.class);

	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	// deptInsert
	public int deptInsert(Map<String, Object> pMap) {
		// 값이 제대로 들어오는지 확인하기 위해서 업데이트 직전에 파라미터 값 확인하기
		logger.info(pMap);
		int result = 0;
		result = sqlSessionTemplate.update("detpInsert", pMap);
		return result;
	}

}
