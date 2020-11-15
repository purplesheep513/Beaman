package com.koreait.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.DBConn;




public class Member_DAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Member member;
	String sql="";
	
	public int join(Member member) {
		String sql2 = "select count(*) from user where u_code like 'u%'";
		String sql = "INSERT INTO user(u_code, u_id, u_pwd, " +
				"u_nick, u_email, u_name, u_tel, u_addr1, u_addr2, " +
				"u_addr3, u_agree, u_point ) values (?,?,PASSWORD(?),?,?,?,?,?,?,?,?,?)";
		try {
			conn = DBConn.getConnection();
			Statement stmt = conn.createStatement();
			String cnt="0";
	    	  rs =stmt.executeQuery(sql2);
	    	  if(rs.next()){
	    		  cnt = Integer.toString(rs.getInt(1)+1);
	    	  }else { cnt = "1";}
	    	  if(cnt.length() <2){
	    		  cnt = "u000"+cnt;
	    	  }else if(cnt.length()>=2 && cnt.length()<3){
	    		  cnt = "u00" + cnt;
	    	  }else if(cnt.length()>=3 && cnt.length()<4){
	    		  cnt = "u0" + cnt;
	    	  }else if(cnt.length()>=4 && cnt.length()<5){
	    		  cnt = "u" + cnt;
	    	  }
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cnt);
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getPw());
			pstmt.setString(4, member.getnName());
			String email;
			if(member.getEmail2()!=null) {
			email= member.getEmail1()+"@"+ member.getEmail2();
			}else {
				email = member.getEmail1() + "@" + member.getMonth();
			}
			pstmt.setString(5, email);
			pstmt.setString(6, member.getName());
			pstmt.setString(7, member.getTel());
			pstmt.setString(8, member.getSample3_postcode());
			pstmt.setString(9, member.getSample3_address());
			pstmt.setString(10, member.getSample3_detailAddress());
			String agree="";
			if(member.getChk().length>1) {
				agree="Y";
			}else {agree="N";}
			pstmt.setString(11, agree);
			pstmt.setString(12, "0");
			
			if(pstmt.executeUpdate() != 0) {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return 0;
	}
	
	public Member login(Member member) {
		String sql = "SELECT u_code FROM user WHERE u_id=? AND u_pwd=PASSWORD(?) AND u_code like'u%'";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()){
				member.setU_code(rs.getString(1));
				return member;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return null;
	}
	
	public Member userInfo(Member member) {
		String sql = "SELECT u_name, u_email, u_tel FROM user where u_id=? ";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			if(rs.next()){
				member.setName(rs.getString("u_name"));
				String emails[] = rs.getString("u_email").split("@");
				member.setEmail1(emails[0]);
				member.setEmail2(emails[1]);
				member.setTel(rs.getString("u_tel"));
				return member;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return null;
	}
	
	public List<Member> getPoint(String u_code){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Member> pointList = new ArrayList<Member>();
		try {
			conn = DBConn.getConnection();
			String sql = "SELECT m_price, j_usedPoint, s_name, j_date from jumoon left outer join store on jumoon.s_code=store.s_code where jumoon.j_progress='D' and jumoon.u_code=? order by j_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Member mem = new Member();
				mem.setU_point((rs.getInt("m_price"))/20);
				mem.setU_usedPoint(rs.getInt("j_usedPoint"));
				mem.setTel(rs.getString("s_name"));
				mem.setSample3_address(rs.getString("j_date"));
				pointList.add(mem);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt, rs);
		}
		return pointList;
	}
	
	public String getUcodeForId(String u_id) {
		String u_code="";
		
		try {
			sql = "select u_code FROM user where u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				u_code = rs.getString("u_code");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return u_code;
	}
	public int edit(Member member) {

		String sql ="UPDATE user SET u_pwd=PASSWORD(?), u_nick=?, u_email=?, u_tel=?, u_addr1=?, u_addr2=?, u_addr3=? WHERE u_id=?";
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getnName());
			String email = member.getEmail1()+"@"+ member.getEmail2();
			pstmt.setString(3, email);
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getSample3_postcode());
			pstmt.setString(6, member.getSample3_address());
			pstmt.setString(7, member.getSample3_detailAddress());
			pstmt.setString(8, member.getId());
			if(pstmt.executeUpdate() != 0) {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return 0;
	}
	
	public int edit2(Member member) {

		String sql ="UPDATE user SET u_nick=?, u_email=?, u_tel=?, u_addr1=?, u_addr2=?, u_addr3=? WHERE u_id=?";
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getnName());
			String email = member.getEmail1()+"@"+ member.getEmail2();
			pstmt.setString(2, email);
			pstmt.setString(3, member.getTel());
			pstmt.setString(4, member.getSample3_postcode());
			pstmt.setString(5, member.getSample3_address());
			pstmt.setString(6, member.getSample3_detailAddress());
			pstmt.setString(7, member.getId());
			if(pstmt.executeUpdate() != 0) {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return 0;
	}
	
	public boolean idcheck(Member member, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			conn = DBConn.getConnection();
			String sql = "SELECT u_code FROM user WHERE u_id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return true;
			}else {
				return false;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	public boolean nickcheck(Member member, String nick) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			conn = DBConn.getConnection();
			String sql = "SELECT u_id FROM user WHERE u_nick=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return true;
			}else {
				return false;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	public Member usermodi(Member member,String userid) {
		String email1="";
		String email2="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConn.getConnection();
			String sql = "SELECT u_pwd, u_nick, u_email, u_tel, u_addr1, u_addr2, u_addr3 FROM user WHERE u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {

				member.setPw(rs.getString("u_pwd"));
				member.setnName(rs.getString("u_nick"));
				String email = rs.getString("u_email");
				String[] s_email= email.split("@");
				email1=s_email[0];
				email2=s_email[1];
				member.setEmail1(email1);
				member.setEmail2(email2);
				member.setTel(rs.getString("u_tel"));
				member.setSample3_postcode(rs.getString("u_addr1"));
				member.setSample3_address(rs.getString("u_addr2"));
				member.setSample3_detailAddress(rs.getString("u_addr3"));

		}
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		DBConn.close(conn, pstmt);
	}
		return member;
}
	public Member mylogin(Member member,String userid) {
		String sql = "SELECT u_code FROM user WHERE u_id=? AND u_pwd=PASSWORD(?) ";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, member.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()){
				member.setU_code(rs.getString(1));
				return member;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return null;
	}
	public Member mypage(Member member,String userid) {
		 String sql = "SELECT u_code, u_name, u_email, u_tel FROM user where u_id=?";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				member.setU_code(rs.getString("u_code"));
				member.setName(rs.getString("u_name"));
				String emails[] = rs.getString("u_email").split("@");
				member.setEmail1(emails[0]);
				member.setEmail2(emails[1]);
				member.setTel(rs.getString("u_tel"));
				return member;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException sqle){
				throw new RuntimeException(sqle.getMessage());
			}
		}
		return null;
	}
}


	

