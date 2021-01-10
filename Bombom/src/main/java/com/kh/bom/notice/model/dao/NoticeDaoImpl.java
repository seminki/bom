package com.kh.bom.notice.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Override
	public List<Notice> selectNoticeList(SqlSession session) {
		
		return session.selectList("notice.selectNoticeList");
	}
	
	@Override
	public List<Notice> selectNoticeList2(SqlSession session) {
		
		return session.selectList("notice.selectNoticeList2");
	}

	@Override
	public int insertNotice(SqlSession session, Notice notice) {
		// TODO Auto-generated method stub
		return session.insert("notice.insertNotice",notice);
	}

	@Override
	public int deleteNotice(SqlSession session, String noticeNo) {
		// TODO Auto-generated method stub
		return session.delete("notice.deleteNotice",noticeNo);
	}

	@Override
	public Notice selectNoticeOne(SqlSession session, String noticeNo) {
		// TODO Auto-generated method stub
		return session.selectOne("notice.selectNoticeOne",noticeNo);
	}
	
	@Override
	public int updateNotice(SqlSession session, Notice notice) {
		// TODO Auto-generated method stub
		return session.update("notice.updateNotice",notice);
	}

	
	
	
}
