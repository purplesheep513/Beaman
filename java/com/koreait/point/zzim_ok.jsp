<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
	if(session.getAttribute("id") == null){
%>
<script>
	alert("로그인 후 이용하세요.");
	location.href="login.jsp";
</script>
<%
	}
    String userid = (String)session.getAttribute("id");
    String s_code = request.getParameter("s_code");
    String s_category = request.getParameter("s_category");
    String location = request.getParameter("loc");
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	String url = "jdbc:mariadb://localhost:3306/tproject3";
	String uid = "root";
	String upw = "1234";
	String u_code = "";
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		
		if(conn != null){      
			sql = "select u_code FROM user where u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				u_code = rs.getString(1);
			}

			
			sql = "select * FROM zzim_store where u_code=? and s_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			pstmt.setString(2, s_code);
			rs = pstmt.executeQuery();

			if(rs.next()){
			sql ="delete from zzim_store where u_code=? and s_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			pstmt.setString(2, s_code);
			rs = pstmt.executeQuery();
			%>
			<script>
			alert('찜목록에서 삭제되었습니다.');
			location.href = "store_list.jsp?s_category=<%=s_category%>&loc=<%=location %>";
			</script>

			<%
			}else{
			sql= "insert into zzim_store (u_code,s_code) values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_code);
			pstmt.setString(2, s_code);
			rs = pstmt.executeQuery();
			%>
			<script>
			alert('찜목록에 추가되엇습니다.');
			location.href ="store_list.jsp?s_category=<%=s_category%>&loc=<%=location %>";
			</script>

			<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>찜</title>
	
</head>
<body>

</body>
</html>
