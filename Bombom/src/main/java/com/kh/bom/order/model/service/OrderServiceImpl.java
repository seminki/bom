package com.kh.bom.order.model.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.order.model.dao.OrderDao;
import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Inorder;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;
import com.kh.bom.review.model.vo.Review;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao dao;
	@Autowired
	private SqlSession session;

	// 결제하기
	@Override
	public List<Inorder> insertOrder(Order order, String basketNo) {
		int result = dao.insertOrder(session, order);
		String orderNo = order.getOrderNo();
//		System.out.println("service로 넘어온 오더넘버 : " + orderNo);
		List<Inbasket> list = dao.selectInbasketList(session, basketNo);
//		System.out.println("장바구니에 넘어온 리스트 : " + list);
		List<Inorder> inList = new ArrayList<Inorder>();
		if (result > 0) {
			// insert 성공하면 inorder에도 insert시키기
			for (Inbasket i : list) {
				Inorder io = new Inorder(orderNo, i.getPdtNo(), i.getPdtOptionNo(), i.getInbasQty(), null);
//				System.out.println("리스트 포문 :" + io);
				dao.insertInorder(session, io);
				inList.add(io);
			}
		}
		return inList;
	}

	@Override
	public List<Inbasket> selectInbasketList(String basketNo) {
		return dao.selectInbasketList(session, basketNo);
	}

	@Override
	public int insertInorder(Inorder i) {
		return dao.insertInorder(session, i);
	}

	@Override
	public int deleteBasket(String basketNo) {
		// int result = dao.deleteInbasket(session, basketNo);
		// if(result>0) {
		int result = dao.deleteBasket(session, basketNo);
		// }
		return result;
	}

	@Override
	public List<Basket> selectBasket(String memNo) {
		return dao.selectBasket(session, memNo);
	}

	@Override
	public Basket selectBasketOne(String memNo) {
		return dao.selectBasketOne(session, memNo);
	}

	@Override
	public int deleteBasketOne(Basket b) {
		return dao.deleteBasketOne(session, b);
	}

	@Override
	public int deleteBasketOption(String optionNo) {
		return dao.deleteBasketOption(session, optionNo);
	}

	@Override
	public List<Order> selectOrderList(String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectOrderList(session, memNo, cPage, numPerpage);
	}

	@Override
	public int selectOrderCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderCount(session, memNo);
	}

	// 배송준비 ct
	@Override
	public int shipReadyCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shipReadyCount(session, memNo);
	}

	@Override
	public int ordWaitCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.ordWaitCount(session, memNo);
	}

	@Override
	public int ordEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.ordEndCount(session, memNo);
	}

	@Override
	public int shippingCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shippingCount(session, memNo);
	}

	@Override
	public int shipEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shipEndCount(session, memNo);
	}

	@Override
	public int buyEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.buyEndCount(session, memNo);
	}

	@Override
	public List<Order> selectOrderDetail(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderDetail(session, orderNo);
	}

	@Override
	public Order selectOrderOne(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderOne(session, orderNo);
	}

	// 주문취소
	@Override
	@Transactional
	public int cancelOrder(Order o) {

		return dao.cancelOrder(session, o);

	}

	// 구매확정
	@Override
	@Transactional
	public int buyConfirm(String orderNo, Point p) {

		int result = dao.buyConfirm(session, orderNo);
		if (result > 0) {
			p.setOrderNo(orderNo);
			result = dao.insertOrdPoint(session, p);
		}

		return result;
	}

	@Override
	public int insertBasket(String memNo) {
		// TODO Auto-generated method stub
		return dao.insertBasket(session, memNo);
	}

	@Override
	public int insertInbasket(Inbasket i) {
		// TODO Auto-generated method stub
		return dao.insertInbasket(session, i);
	}

	public int cancelEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.cancelEndCount(session, memNo);
	}

	@Override
	public int returnWaitCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.returnWaitCount(session, memNo);
	}

	@Override
	public int returnEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.returnEndCount(session, memNo);
	}

	// 반품요청
	@Override
	public int returnRequest(Order o, Point p) {

		int result = dao.returnRequest(session, o);
		if (result > 0) {
			p.setOrderNo(o.getOrderNo());
			result = dao.returnOrdPoint(session, p);
		}
		return result;

	}

	// 회원의 장바구니안에 pdt_option_no 가져오기
	@Override
	public List<Inbasket> selectInbasket(String memNo) {
		Basket b = dao.selectBasketNo(session, memNo);
		List<Inbasket> ii = new ArrayList<Inbasket>();
		if (b != null)
			ii = dao.selectInbasket(session, b.getBasketNo());
		return ii;
	}

	@Override
	public int updateQty(Inbasket i) {
		return dao.updateQty(session, i);
	}

}
