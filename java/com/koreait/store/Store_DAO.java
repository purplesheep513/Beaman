package com.koreait.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.Member.Member;
import com.koreait.db.DBConn;


public class Store_DAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Member member;
	
	
	public List<Store> getSearch(String u_code, String search_input) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Store> storeList = new ArrayList<Store>();
		
		try{
			   
			
			conn = DBConn.getConnection();
			String sql = "select s_name ,s_star, s_intro, s_code, s_addr, s_category,s_img from store where s_name like '%"+ search_input +"%'";
			pstmt = conn.prepareStatement(sql);
				 
			rs= pstmt.executeQuery();		
			while (rs.next()) {
				Store store = new Store();
				store.setS_name(rs.getString(1));
				store.setS_star(rs.getString(2));
				store.setS_intro(rs.getString(3));
				store.setS_code(rs.getString(4));
				store.setS_addr(rs.getString(5));
				store.setS_category(rs.getString(6));
				store.setReview1(Integer.parseInt(String.valueOf(getReview(rs.getString(4)))));
				store.setReview2(Integer.parseInt(String.valueOf(getOReview(rs.getString(4)))));
				store.setZzimCheck(Integer.parseInt(String.valueOf(zzimCheck(u_code, rs.getString(4)))));
				store.setM_file(rs.getString("s_img"));
				storeList.add(store);
			
			}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBConn.close(conn, pstmt,rs);
			}
			return storeList;
		}   
		

	public List<Store> storeList(String loc, String category, String u_code,int start, int recNum,String gottenSql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Store> storeList = new ArrayList<Store>();
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(gottenSql);
			pstmt.setString(1, category);
			pstmt.setInt(2, start);
			pstmt.setInt(3, recNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Store store = new Store();
				store.setS_name(rs.getString(1));
				store.setS_star(rs.getString(2));
				store.setS_intro(rs.getString(3));
				store.setS_code(rs.getString(4));
				store.setS_addr(rs.getString(5));
				store.setReview1(Integer.parseInt(String.valueOf(getReview(rs.getString(4)))));
				store.setReview2(Integer.parseInt(String.valueOf(getOReview(rs.getString(4)))));
				store.setZzimCheck(Integer.parseInt(String.valueOf(zzimCheck(u_code, rs.getString(4)))));
				store.setM_file(rs.getString("s_img"));
				store.setS_minOrder(rs.getString("s_minOrder"));
				store.setS_deliverytime(rs.getString("s_deliverytime"));
				storeList.add(store);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(conn, pstmt, rs);
		}
		return storeList;
	}


	
	public int getReview(String s_code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConn.getConnection();
			String sql = "select count(*) from review inner join store on review.s_code=store.s_code where store.s_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_code);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(conn, pstmt, rs);
		}
		return 0;
	}
	
	public int getOReview(String s_code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConn.getConnection();
			String sql = "select count(*) from review inner join store on review.s_code=store.s_code where store.s_code=? and review.r_didReply='Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_code);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(conn, pstmt, rs);
		}
		return 0;
	}
	
	public int zzimCheck(String u_code,String s_code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConn.getConnection();
			String sql = "select count(u_code ) FROM zzim_store where u_code=? and s_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			pstmt.setString(2, s_code);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(conn, pstmt, rs);
		}
		return 0;
	}
	
	
	public List<Store> getzzimList(String u_code, int start, int recNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Store> zmlist = new ArrayList<Store>();
		try {
			conn = DBConn.getConnection();
			String sql = "select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			pstmt.setInt(2, start);
			pstmt.setInt(3, recNum);
			rs = pstmt.executeQuery();
				
			while (rs.next()) {
				Store store = new Store();
				store.setS_code(rs.getString("store.s_code"));
				store.setS_name(rs.getString("s_name"));
				store.setS_star(rs.getString("s_star"));
				store.setS_intro(rs.getString("s_intro"));
				store.setS_addr(rs.getString("s_addr"));
				store.setS_minOrder(rs.getString("s_minOrder"));
				store.setS_deliverytime(rs.getString("s_deliverytime"));
				System.out.println(store);
				zmlist.add(store);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt,rs);
		}
		return zmlist;
	}
		
}
