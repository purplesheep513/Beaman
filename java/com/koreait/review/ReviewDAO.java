package com.koreait.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.koreait.db.DBConn;

public class ReviewDAO {
	Connection conn = DBConn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	String sql2 = "";
	ResultSet rs2 = null;
	Statement stmt =null;
	
	public boolean insertreview(ReviewDTO reviewDTO) {
		
		String cnt = "1";
		try {
		       sql2 ="select count(*) from review where r_code like 'r%'";
	           Statement stmt = conn.createStatement();
	           
	            rs =stmt.executeQuery(sql2);
	            if(rs.next()){
	               cnt = Integer.toString(rs.getInt(1)+1);
	            }else { cnt = "1";}
	            if(cnt.length() <2){
	               cnt = "r000"+cnt;
	            }else if(cnt.length()>=2 && cnt.length()<3){
	               cnt = "r00" + cnt;
	            }else if(cnt.length()>=3 && cnt.length()<4){
	               cnt = "r0" + cnt;
	            }else if(cnt.length()>=4 && cnt.length()<5){
	               cnt = "r" + cnt;
	            }
	           System.out.println(cnt);
	         
	         sql = "INSERT INTO review(u_code, s_code, r_title, r_content, r_star1, r_star2, r_star3, r_star, r_date, r_didReply, r_code) values(?,?,?,?,?,?,?,?,?,?,?)";
	         System.out.println(sql);
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, reviewDTO.getU_code());
	         pstmt.setString(2, reviewDTO.getS_code());
	         pstmt.setString(3, reviewDTO.getR_title());
	         pstmt.setString(4, reviewDTO.getR_content());
	         pstmt.setDouble(5, reviewDTO.getR_star1());
	         pstmt.setDouble(6, reviewDTO.getR_star2());
	         pstmt.setDouble(7, reviewDTO.getR_star3());
	         pstmt.setDouble(8, reviewDTO.getR_star());
	         pstmt.setString(9, reviewDTO.getR_date());
	         pstmt.setString(10, reviewDTO.getDidReply());
	         pstmt.setString(11, reviewDTO.getR_code());

	         int k = pstmt.executeUpdate();
	         if(k>0) {
	        	 return true;
	         }else {
	        	 return false;
	         }
	      }catch(Exception e){
		      e.printStackTrace();
	   }finally {
		   DBConn.close(conn, pstmt);
	   }
	   	return false;
}

}
