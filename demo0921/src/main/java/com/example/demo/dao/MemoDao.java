package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.demo.logic.MemberLogic;

@Service // 모델 계층에 붙이는 @Component의 자손 어노테이션!
public class MemoDao {
	Logger logger = LoggerFactory.getLogger(MemoDao.class);
	@Autowired(required = false)
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public int memoinsert(Map<String, Object> pMap) {
		logger.info("memoinsert 호출 성공 ==> "+ pMap);
		int result = 0;
		try {
			sqlSessionTemplate.selectOne("proc_memoinsert", pMap);
			if(pMap.get("result")!=null) {
				result = Integer.parseInt(pMap.get("result").toString());				
			}
			logger.info("result : "+result);
		} catch (DataAccessException e) {
			logger.info("Exception : "+e.toString());
		} 
		return result;
	}
}