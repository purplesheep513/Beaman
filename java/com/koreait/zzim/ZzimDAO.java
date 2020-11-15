package com.koreait.zzim;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import com.koreait.db.DBConn;
public class ZzimDAO {
	
	Connection conn = DBConn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	
	public boolean del(ZzimDTO zzim) {
		try{						      
				sql = "select * FROM zzim_store where u_code=? and s_code=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, zzim.getU_code());
				pstmt.setString(2, zzim.getS_code());
				rs = pstmt.executeQuery();

				if(rs.next()){
				sql ="DELETE from zzim_store where u_code=? and s_code=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, zzim.getU_code());
				pstmt.setString(2, zzim.getS_code());
				rs = pstmt.executeQuery();	
				return true;
				}
				allClose();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return false;		
	}
	
	public void allClose() {
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
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String zzim(ZzimDTO zzim) {
		try{
				sql = "select * FROM zzim_store where u_code=? and s_code=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, zzim.getU_code());
				pstmt.setString(2, zzim.getS_code());
				rs = pstmt.executeQuery();

				if(rs.next()){
					sql ="delete from zzim_store where u_code=? and s_code=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, zzim.getU_code());
					pstmt.setString(2, zzim.getS_code());
					int k  = pstmt.executeUpdate();
					if(k>0) {
						return "삭제";
						
					}
				}else{
				
					sql= "insert into zzim_store (u_code,s_code) values(?,?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, zzim.getU_code());
					pstmt.setString(2, zzim.getS_code());
					int k = pstmt.executeUpdate();
					if(k>0) {
						return "추가";
					}
				}
		}catch(SQLException e) {
			e.printStackTrace();
		
		}
		return "실패";
	}
}
