package com.kh.bom.notice.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.notice.model.vo.Notice;

public interface NoticeDao {
	
	List<Notice> selectNoticeList(SqlSession session,int cPage,int numPerpage);
	
	int selectCount(SqlSession session);
	
	Notice selectNoticeOne(SqlSession session,String noticeNo);
	
	int insertNotice(SqlSession session, Notice notice);
	
	int deleteNotice(SqlSession session,String noticeNo);
	
    int updateNotice(SqlSession session, Notice notice);

}
