package com.project.javabucksStore.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuMapper {
	
	@Autowired
	private SqlSession sqlsession;

}
