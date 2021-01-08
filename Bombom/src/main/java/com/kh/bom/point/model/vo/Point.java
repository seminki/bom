package com.kh.bom.point.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Point {
	private String memNo;
	private String orderNo;
	private Date pointDate;
	private String pointContent;
	private int pointChange;
}
