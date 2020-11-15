package com.koreait.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConn {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			String url = "jdbc:mariadb://127.0.0.1:3306/tproject3";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);	
		}catch(ClassNotFoundException cnfe){
			System.out.println("드라이버 로딩 실패");
			System.out.println(cnfe);
		}catch(SQLException sqle){
			System.out.println("DB 접속 오류");
			System.out.println(sqle);
		}catch(Exception e){
			System.out.println("알 수 없는 오류");
			System.out.println(e);
		}
		return conn;
	}
	
	public static void close(Connection conn, PreparedStatement pstmt) {
		try {
			if(pstmt != null) { pstmt.close(); }
		}catch(Exception e) { e.printStackTrace(); }
		try {
			if(conn != null) { conn.close(); }
		}catch(Exception e) { e.printStackTrace(); }
	}
	
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs != null) { rs.close(); }
		}catch(Exception e) { e.printStackTrace(); }
		close(conn, pstmt);
	}
}
