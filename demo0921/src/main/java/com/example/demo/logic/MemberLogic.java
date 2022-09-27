package com.example.demo.logic;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dao.MemoDao;
import com.example.demo.vo.MemberVO;
// ApplicationContext(BeanFactory 기능을 내장하고 있어서 이른 인스턴스화를 지원하는 것이 디폴트다)
@Service
public class MemberLogic {
	Logger logger = LoggerFactory.getLogger(MemberLogic.class);
	
	@Autowired(required=false)
	private MemberDao memberDao = null;
	
	@Autowired(required=false)
	private MemoDao memoDao = null;
	
	// 등록 시에 프로시저를 사용하면 트랜잭션 처리를 따로 하지 않아도 된다.
	public int memberInsert(Map<String, Object> pMap) {
		logger.info("memberInsert 호출");
		int result = 0;
		result = memberDao.memberinsert(pMap);
		return result;
	}
	
	public List<Map<String, Object>> memberList(Map<String, Object> pMap) {
		logger.info("memberList 호출");
		List<Map<String, Object>> memberList = null;
		memberList = memberDao.memberList(pMap);
		return memberList;
	}

	public MemberVO login(Map<String, Object> pMap) {
		logger.info("login 호출");
		MemberVO mVO = null;
		// 읽지 않은 쪽지 담기
		int cnt = 0;
		mVO = memberDao.login(pMap);
		// 로그인한거지?
		if(mVO != null) {
			String to_id = null;
			to_id = mVO.getMem_id();
			pMap.put("to_id", to_id);
			cnt = memoDao.noReadMemo(pMap);
			mVO.setCount(cnt);
		}
		return mVO;
	}
}
