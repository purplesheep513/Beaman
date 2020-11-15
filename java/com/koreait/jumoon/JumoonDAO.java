package com.koreait.jumoon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.DBConn;
import com.koreait.store.Store;

public class JumoonDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	String sql2 = "";
	ResultSet rs2 = null;
	String m_price =null;
	
	
	public List<JumoonDTO> selectJumoon(String u_code) {
		conn = DBConn.getConnection();
		List<JumoonDTO> jumoonList = new ArrayList<JumoonDTO>();
		try {
			sql = "SELECT s_code, m_name, m_price, j_quantity FROM jumoon where u_code=? and j_progress = 'D'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				JumoonDTO jumoon = new JumoonDTO();
				jumoon.setS_code(rs.getString("s_code"));
				jumoon.setM_name(rs.getString("m_name"));
				jumoon.setM_price(rs.getInt("m_price"));
				jumoon.setJ_quantity(rs.getInt("j_quantity"));
				jumoonList.add(jumoon);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(conn, pstmt, rs);
		}
		return jumoonList;
	}
	public Store getStore (String s_code) {
		conn = DBConn.getConnection();
		sql2 = "SELECT s_name, s_img from store where s_code=?";
		Store s = null;

		try {
			s = new Store();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, s_code);
			rs2 = pstmt.executeQuery();

			if (rs2.next()) {
				s.setS_name(rs2.getString("s_name"));
				s.setM_file("gege");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt);
		}
		
		return s;
	}
}
