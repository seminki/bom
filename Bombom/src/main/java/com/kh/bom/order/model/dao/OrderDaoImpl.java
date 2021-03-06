package com.kh.bom.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Inorder;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;
import com.kh.bom.review.model.vo.Review;

@Repository
public class OrderDaoImpl implements OrderDao {

	// 결제하기
	@Override
	public int insertOrder(SqlSession session, Order order) {
		return session.insert("order.insertOrder", order);
	}

	@Override
	public int deleteInbasket(SqlSession session, String basketNo) {
		return session.delete("order.deleteInbasket", basketNo);
	}

	@Override
	public int deleteBasket(SqlSession session, String basketNo) {
		return session.delete("order.deleteBasket", basketNo);
	}

	// 장바구니에 담긴 상품들 가져오기
	@Override
	public List<Basket> selectBasket(SqlSession session, String memNo) {
		return session.selectList("order.selectBasket", memNo);
	}

	// 장바구니번호 가져오기
	@Override
	public Basket selectBasketOne(SqlSession session, String memNo) {
		return session.selectOne("order.selectBasketOne", memNo);
	}

	// 장바구니에 담긴 상품 하나 삭제하기
	@Override
	public int deleteBasketOne(SqlSession session, Basket b) {
		return session.delete("order.deleteBasketPdt", b);
	}

	// 장바구니에 담긴 상품중 옵션삭제하기
	@Override
	public int deleteBasketOption(SqlSession session, String optionNo) {
		return session.delete("order.deleteBasketOption", optionNo);
	}

	// 나의 주문내역
	@Override
	public List<Order> selectOrderList(SqlSession session, String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderList", memNo, new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}

	// 주문내역 페이징 -카운트
	@Override
	public int selectOrderCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderCount", memNo);
	}

	// 배송준비 ct
	@Override
	public int shipReadyCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shipReadyCount", memNo);
	}

	// 주문대기 ct
	@Override
	public int ordWaitCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.ordWaitCount", memNo);
	}

	// 주문완료
	@Override
	public int ordEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.ordEndCount", memNo);
	}

	// 배송중 ct
	@Override
	public int shippingCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shippingCount", memNo);
	}

	// 배송완료 ct
	@Override
	public int shipEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shipEndCount", memNo);
	}

	// 주문취소 ct
	@Override
	public int buyEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.buyEndCount", memNo);
	}

	// 상세주문내역
	@Override
	public List<Order> selectOrderDetail(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderDetail", orderNo);
	}

	// 상세주문내역 내에서 주문정보
	@Override
	public Order selectOrderOne(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderOne", orderNo);
	}

	// 주문취소(요청)했을때
	@Override
	public int cancelOrder(SqlSession session, Order o) {
		// TODO Auto-generated method stub
		return session.delete("order.cancelOrder", o);
	}

	// 구매확정
	@Override
	public int buyConfirm(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.update("order.buyConfirm", orderNo);
	}

	// 구매확정시 포인트 적립
	@Override
	public int insertOrdPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.insert("order.insertOrdPoint", p);
	}

	// 취소완료 ct
	@Override
	public int cancelEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.cancelEndCount", memNo);
	}

	// 반품요청 ct
	@Override
	public int returnWaitCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.returnWaitCount", memNo);
	}

	// 반품완료 ct
	@Override
	public int returnEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.returnEndCount", memNo);
	}

	// 반품요청했을때
	@Override
	public int returnRequest(SqlSession session, Order o) {
		// TODO Auto-generated method stub
		return session.delete("order.returnRequest", o);
	}

	@Override
	public int returnOrdPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.update("order.cancelOrdPoint", p);
	}

	// 장바구니 생성
	@Override
	public int insertBasket(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.insert("order.insertBasket", memNo);
	}

	// 장바구니에 담길 상품들 가져와서 inbasket에 넣기
	@Override
	public int insertInbasket(SqlSession session, Inbasket i) {
		// TODO Auto-generated method stub
		return session.insert("order.insertInbasket", i);
	}

	// 장바구니번호 가져오기
	@Override
	public Basket selectBasketNo(SqlSession session, String memNo) {
		return session.selectOne("order.selectBasketNo", memNo);
	}

	// 장바구니에 담긴 상품 중 옵션있는 목록가져오기
	@Override
	public List<Inbasket> selectInbasket(SqlSession session, String basketNo) {
		return session.selectList("order.selectInbasket", basketNo);
	}

	// 장바구니 담긴 상품목록 가져오기
	@Override
	public List<Inbasket> selectInbasketList(SqlSession session, String basketNo) {
		return session.selectList("order.selectInbasketList", basketNo);
	}

	// 장바구니에 담겼던 목록 -> 결제완료 후 -> inorder에 집어넣기
	@Override
	public int insertInorder(SqlSession session, Inorder i) {
		return session.insert("order.insertInorder", i);
	}

	// 리뷰작성시 inorder revYn Y로 변경
	@Override
	public int updateRevYn(SqlSession session, Map map) {
		return session.update("order.updateRevYn", map);
	}

	//장바구니 수량 변경
	@Override
	public int updateQty(SqlSession session, Inbasket i) {
		return session.update("order.updateQty", i);
	}

}
