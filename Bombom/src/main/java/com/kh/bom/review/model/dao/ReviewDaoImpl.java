package com.kh.bom.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.vo.Review;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	
	@Override
	public List<Order> selectOrder(SqlSession session, Map map) {
		return session.selectList("order.selectOrder", map);
	}

	@Override
	public int insertReview(SqlSession session, Review r) {
		return session.insert("review.insertReview", r);
	}

	@Override
	public int deleteRevivew(SqlSession session, String revNo) {
		return session.update("review.deleteReview", revNo);
	}

	@Override
	public int updateReview(SqlSession session, Review r) {
		return session.update("review.updateReview", r);
	}





}
