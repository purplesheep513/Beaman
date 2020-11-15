package com.koreait.store;

public class Store {
private String s_code;
private String s_name;
private String u_code;
private String s_addr;
private String s_category;
private String s_star;
private String s_minOrder;
private String s_intro;
private String s_deliverytime;
private String review;
private int review1;
private int review2;
private int zzimCheck;
private String O_review;
private String location;
private String m_file;


public String getReview() {
	return review;
}
public void setReview(String review) {
	this.review = review;
}
public int getZzimCheck() {
	return zzimCheck;
}
public void setZzimCheck(int zzimCheck) {
	this.zzimCheck = zzimCheck;
}
public String getM_file() {
	return m_file;
}
public void setM_file(String m_file) {
	this.m_file = m_file;
}
public String getLocation() {
	return location;
}
public void setLocation(String location) {
	this.location = location;
}
public String getS_code() {
	return s_code;
}
public void setS_code(String s_code) {
	this.s_code = s_code;
}
public String getS_name() {
	return s_name;
}
public void setS_name(String s_name) {
	this.s_name = s_name;
}
public String getU_code() {
	return u_code;
}
public void setU_code(String u_code) {
	this.u_code = u_code;
}
public String getS_addr() {
	return s_addr;
}
public void setS_addr(String s_addr) {
	this.s_addr = s_addr;
}
public String getS_category() {
	return s_category;
}
public void setS_category(String s_category) {
	this.s_category = s_category;
}
public String getS_star() {
	return s_star;
}
public void setS_star(String s_star) {
	this.s_star = s_star;
}
public String getS_minOrder() {
	return s_minOrder;
}
public void setS_minOrder(String s_minOrder) {
	this.s_minOrder = s_minOrder;
}
public String getS_intro() {
	return s_intro;
}
public void setS_intro(String s_intro) {
	this.s_intro = s_intro;
}
public String getS_deliverytime() {
	return s_deliverytime;
}
public void setS_deliverytime(String s_deliverytime) {
	this.s_deliverytime = s_deliverytime;
}
public String getO_review() {
	return O_review;
}
public void setO_review(String o_review) {
	O_review = o_review;
}


public int getReview1() {
	return review1;
}
public void setReview1(int review1) {
	this.review1 = review1;
}
public int getReview2() {
	return review2;
}
public void setReview2(int review2) {
	this.review2 = review2;
}
@Override
public String toString() {
	return s_code +"/"+ s_name+"/" + u_code + "/" + s_addr + "/" + s_category + "/" + s_star + "/" + s_minOrder + "/" + s_intro + "/" + s_deliverytime + "/" +  "/" + O_review+"/"+ review1 + "/" + review2;
}



}
