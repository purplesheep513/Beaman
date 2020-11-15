package com.koreait.mun2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.DBConn;

public class Mun2DAO {
	public boolean insertMun2(Mun2DTO mun2DTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
		conn = DBConn.getConnection();
		String sql = "INSERT INTO mun2(u_name, u_email, m_category, m_title, m_content) values (?,?,?,?,?)";
		System.out.println(sql);
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mun2DTO.getU_name());
		pstmt.setString(2, mun2DTO.getU_email());
		pstmt.setString(3, mun2DTO.getM_category());
		pstmt.setString(4, mun2DTO.getM_title());
		pstmt.setString(5, mun2DTO.getM_content());
		int result = pstmt.executeUpdate();
		if(result>0) {
			return true;
		}else {
			return false;
		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt);
		}
		return false;
	}
	public List<Mun2DTO> selectMun2(){
		List<Mun2DTO> munList = new ArrayList<Mun2DTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DBConn.getConnection();
			String sql = "SELECT m_code, m_title, m_content, m_answer FROM mun2 order by m_code desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Mun2DTO mun2DTO = new Mun2DTO();
				mun2DTO.setM_code(rs.getString("m_code"));
				mun2DTO.setM_title(rs.getString("m_title"));
				mun2DTO.setM_content(rs.getString("m_content"));
				mun2DTO.setM_answer(rs.getString("m_answer"));
				munList.add(mun2DTO);
		}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt,rs);
		}
		return munList;
	}
}
