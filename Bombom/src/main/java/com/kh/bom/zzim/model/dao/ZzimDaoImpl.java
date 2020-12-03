package com.kh.bom.zzim.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.zzim.model.vo.Zzim;

@Repository
public class ZzimDaoImpl implements ZzimDao {

	@Override
	public List<Zzim> selectZzimList(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectList("zzim.selectZzimList",memNo);
	}

	@Override
	public int insertZzim(SqlSession session, Zzim z) {
		// TODO Auto-generated method stub
		return session.insert("zzim.insertZzim",z);
	}
	
	
}