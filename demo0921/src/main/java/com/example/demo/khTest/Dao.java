package com.example.demo.khTest;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class Dao {
	@Autowired(required = false)
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public Board selectBoard(Map<String, Object> pMap) {
		Board board = null;
		board = sqlSessionTemplate.selectOne("boardMapper.selectBoard", pMap);
		return board;
	}
}


