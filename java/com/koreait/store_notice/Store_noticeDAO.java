package com.koreait.store_notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.koreait.db.DBConn;

public class Store_noticeDAO {

	Connection conn = DBConn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	
}
