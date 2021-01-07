package com.kh.bom.point.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.member.model.dao.MemberDao;
import com.kh.bom.point.model.dao.PointDao;
import com.kh.bom.point.model.vo.Point;

@Service
public class PointServiceImpl implements PointService {
	
	@Autowired
	private SqlSession session;
	
	@Autowired
	private PointDao dao;
	@Autowired
	private MemberDao memberDao;

	@Override
	public List<Point> selectPointList(Map<String,String>map,int cPage,int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectPointList(session,map,cPage,numPerpage);
	}

	@Override
	@Transactional(rollbackFor =Exception.class)
	public int insertStampPoint(Point p) throws Exception{
		// TODO Auto-generated method stub
		int result=0;
		try {
			
			result = dao.insertStampPoint(session, p);
			result = memberDao.updateMemBuyCount(session,p.getMemNo());
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
	
		return result;
	}

	@Override
	public int selectCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectCount(session,map);
	}

	@Override
	public int selectTotalPoint(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectTotalPoint(session,memNo);
	}
	
	
	
	
}
