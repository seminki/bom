package com.kh.bom.admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EventController {
	@Autowired
	private AdminService service;

	//이벤트관리로 이동
	@RequestMapping("/admin/moveEvent")
	public ModelAndView moveEventList(ModelAndView m) {
		m.addObject("list", service.selectEvent());
		m.setViewName("admin/event/eventList");
		return m;
	}

	// 이벤트 카테고리별 정렬
	@RequestMapping("/admin/eventSort")
	public ModelAndView eventSort(ModelAndView m, @RequestParam(value = "sort") String sort) {
		System.out.println(sort);
		List<Event> list;
		if (sort.equals("전체보기")) {
			list = service.selectEvent();
		} else {// 카테고리별 정렬 선택했을때 //할인, 커뮤니티, 기타
			list = service.selectEventSort(sort);
		}
		m.addObject("list", list);
		m.setViewName("admin/event/eventListAjax");
		return m;
	}

	// 이벤트삭제
	@RequestMapping("/admin/eventDelete")
	public ModelAndView eventDelete(ModelAndView mv, String eventNo) {
		int result = service.eventDelete(eventNo);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "삭제가 완료되었습니다!";
			loc = "/admin/moveEvent";
			icon = "success";
		} else {
			msg = "삭제가 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/admin/eventDeleteList")
	public ModelAndView eventDeleteList(ModelAndView mv, @RequestParam() List<String> eventNo) {
		
		int result = service.eventDeleteList(eventNo);
		
		String msg = "";
		String loc = "";
		String icon = "";
		if (result >0) {
			msg = "삭제가 완료되었습니다!";
			loc = "/admin/moveEvent";
			icon = "success";
		} else {
			msg = "삭제가 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}

	// 이벤트등록페이지로 이동
	@RequestMapping("/admin/moveInsertEvent")
	public String moveEventWriteForm() {
		return "admin/event/eventWrite";
	}

	@RequestMapping("/admin/insertEvent")
	public ModelAndView insertEvent(ModelAndView mv, String eventTitle,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventStartDate,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventEndDate, String eventCategory, int eventSalePer)
			throws ParseException {

		System.out.println(eventStartDate); // 2020-11-11
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = (Date) sf.parse(eventStartDate);
		Date d2 = (Date) sf.parse(eventEndDate);

		Event e = new Event();
		e.setEventTitle(eventTitle);
		e.setEventStartDate(d);
		e.setEventEndDate(d2);
		e.setEventCategory(eventCategory);
		e.setEventSalePer(eventSalePer);
		int result = service.insertEvent(e);

		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "이벤트가 생성되었습니다!:)";
			loc = "/admin/moveEvent";
			icon = "success";
		} else {
			msg = "생성이 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}

	// 이벤트 수정
	@RequestMapping("admin/moveEventUpdate")
	public ModelAndView moveUpdateEvent(ModelAndView mv, String eventNo) {
		Event e = service.selectEvent(eventNo);
		mv.addObject("e", e);
		mv.setViewName("admin/event/eventUpdate");
		return mv;
	}

	@RequestMapping("/admin/eventUpdate")
	public ModelAndView updateEvent(ModelAndView mv, String eventNo, String eventTitle,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventStartDate,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventEndDate, String eventCategory, int eventSalePer)
			throws ParseException {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = (Date) sf.parse(eventStartDate);
		Date d2 = (Date) sf.parse(eventEndDate);
		Event e = new Event();
		e.setEventNo(eventNo);
		e.setEventTitle(eventTitle);
		e.setEventStartDate(d);
		e.setEventEndDate(d2);
		e.setEventCategory(eventCategory);
		e.setEventSalePer(eventSalePer);
		int result = service.updateEvent(e);

		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "이벤트가 수정되었습니다!:)";
			loc = "/admin/moveEvent";
			icon = "success";
		} else {
			msg = "수정이 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}
}
