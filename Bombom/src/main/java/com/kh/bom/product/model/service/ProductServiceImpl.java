package com.kh.bom.product.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.dao.ProductDao;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public Product selectProductOne(String pdtNo) {
		return dao.selectProductOne(session, pdtNo);
	}
	
	@Override
	public List<ProductOption> selectpdtOption(String pdtNo) {
		return dao.selectpdtOption(session, pdtNo);
	}

	@Override
	public List<Inquiry> inquiryList(String pdtNo, int cPage, int numPerpage) {
		return dao.inquiryList(session, pdtNo, cPage, numPerpage);
	}

	@Override
	public int inquiryCount(String pdtNo) {
		// TODO Auto-generated method stub
		return dao.inquiryCount(session, pdtNo);
	}
	
	@Override
	public List<Review> reviewList(String pdtNo, int cPage, int numPerpage) {
		return dao.reviewList(session, pdtNo, cPage, numPerpage);
	}
	
	@Override
	public int reviewCount(String pdtNo) {
		return dao.reviewCount(session, pdtNo);
	}

	//제품 개수
	@Override
	public int productCount(String category) {
		// TODO Auto-generated method stub
		return dao.productCount(session,category);
	}
	//세일 제품 개수
	@Override
	public int countSale() {
		// TODO Auto-generated method stub
		return dao.countSale(session);
	}
	//전체 제품 출력
	@Override
	public List<Product> selectProductList(int cPage,int numPerPage,String sort,String category) {
		// TODO Auto-generated method stub
		return dao.selectProductList(session,cPage,numPerPage,sort,category);
	}
	//신상품 리스트
	@Override
	public List<Product> selectNewCateList(String category) {
		// TODO Auto-generated method stub
		return dao.selectNewCateList(session,category);
	}

	//세일 제품 리스트
	@Override
	public List<Product> selectSaleList(int cPage, int numPerPage, String sort, String category) {
		// TODO Auto-generated method stub
		return dao.selectSaleList(session,cPage,numPerPage,sort,category);
	}




	

}
