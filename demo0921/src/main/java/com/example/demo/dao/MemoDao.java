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
		logger.info("memoInsert 호출 성공 ==> "+ pMap);
		int result = 0;
		try {
			result = sqlSessionTemplate.update("memoInsert", pMap);
			logger.info("result : "+result);
		} catch (DataAccessException e) {
			logger.info("Exception : "+e.toString());
		} 
		return result;
	}

	// 받은 쪾지 중 읽지 않은 쪽지 카운트하기
	public int noReadMemo(Map<String,Object> pMap) {
		logger.info("noReadMemo 호출 성공 ==> "+ pMap); // pMap에 to_id가 있어야 null이 뜨지 않음.
		int cnt = 0;
		cnt = sqlSessionTemplate.selectOne("noReadMemo", pMap);
		logger.info("cnt ==> " + cnt);
		return cnt;
	}
	
	public List<Map<String, Object>> sendMemoList(Map<String, Object> pMap) {
		logger.info("sendMemoList 호출 성공 ==> "+ pMap);
		List<Map<String, Object>> sendMemoList = null;
		sendMemoList = sqlSessionTemplate.selectList("sendMemoList", pMap);
		logger.info(sendMemoList.toString());
		return sendMemoList;
	}

	public List<Map<String, Object>> receiveMemoList(Map<String, Object> pMap) {
		logger.info("receiveMemoList 호출 성공"+ pMap);
		List<Map<String, Object>> receiveMemoList = null;
		receiveMemoList = sqlSessionTemplate.selectList("receiveMemoList", pMap);
		logger.info(receiveMemoList.toString());
		return receiveMemoList;
	}

	public Map<String, Object> memoContent(Map<String, Object> pMap) {
		Map<String, Object> rmap = null;
		rmap = sqlSessionTemplate.selectOne("memoContent", pMap);
		logger.info("memoContent 호출 성공 ==> "+ rmap);
		return rmap;
	}

	public void readYnUpdate(Map<String, Object> pMap) {
//		logger.info("readYnUpdate 호출 성공 ==> "+ pMap);
		sqlSessionTemplate.update("readYnUpdate", pMap);
	}
}