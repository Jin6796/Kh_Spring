package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.vo.DeptVO;

@Service
public class DeptDao {
	Logger logger = LogManager.getLogger(DeptDao.class);

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public List<Map<String, Object>> deptList(Map<String,Object> pMap) { 
		logger.info(pMap.get("deptno"));
		List<Map<String,Object>> deptList = null;
		deptList = sqlSessionTemplate.selectList("deptList", pMap);
		logger.info("pMap: " + pMap);
		return deptList;
	}
	public List<DeptVO> deptList2(Map<String, Object> pMap) {
		logger.info(pMap.get("deptno"));
		List<DeptVO> deptList = null;
		sqlSessionTemplate.selectOne("deptList",pMap);
		logger.info("pMap : "+pMap);
		deptList = (List<DeptVO>)pMap.get("key");
		for(int i=0;i<deptList.size();i++) {
			DeptVO dvo = deptList.get(i);
			logger.info(dvo.getDeptno());
		}
		return deptList;
	}
	// insert의 경우 채번하는 쿼리를 내부에 쓸 수 있게 되어 있기 때문에 return 타입이 Object이다.
	// 그래서 update를 써 int타입을 뱉을 수 있게 해주는 것
	public int deptInsert(Map<String, Object> pMap) {
		int result = 0;
		result = sqlSessionTemplate.update("deptInsert", pMap);
		return result;
	}

}
