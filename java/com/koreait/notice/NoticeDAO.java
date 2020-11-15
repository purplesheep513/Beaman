package com.koreait.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.DBConn;

public class NoticeDAO {
	
	public List<NoticeDTO> selectNotice() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			conn = DBConn.getConnection();
			String sql = "SELECT n_idx, n_title, n_content, n_regdate ";
			sql += "FROM notice order by n_idx desc limit 0,8";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setN_idx(rs.getInt("n_idx"));
				notice.setN_title(rs.getString("n_title"));
				notice.setN_content(rs.getString("n_content"));
				notice.setN_regdate(rs.getString("n_regdate").substring(0,10));
				noticeList.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConn.close(conn, pstmt,rs);
		}
		return noticeList;
	}
}
