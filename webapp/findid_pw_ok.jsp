<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    String email_id = request.getParameter("email_id");
    String name_id = request.getParameter("name_id");

    String u_id =null;
  		System.out.println("!");
  		System.out.println(email_id);
  		System.out.println(name_id);
    		
  		Connection conn = null;
  		   PreparedStatement pstmt = null;
  		   ResultSet rs = null;
  		
  		   String sql = "";
  	
		   String url = "jdbc:mariadb://localhost:3306/tproject3";
		   String uid = "root";
		   String upw = "1234";	   
try{
		      Class.forName("org.mariadb.jdbc.Driver");
		      conn = DriverManager.getConnection(url, uid, upw);
		      if(conn != null){
		System.out.println("!!");
   
			/* 입력된 정보(이름과 이메일)를 입력하면 아이디를 찾을 수 있다. */		  
	sql="select u_id from user where u_email = ? and u_name= ?";
		System.out.println("!!!");
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email_id);
		pstmt.setString(2, name_id);
		System.out.println("!!!!");
		
		rs = pstmt.executeQuery();
	  	   	   
		System.out.println("!!!!!");
		System.out.println(u_id);
	if(rs.next()) {

		u_id = rs.getString(1);			
	} else {
		%>
			<script>
				alert("정보를 다시입력해주세요.")
				location.href="findid_pw.jsp"
			</script>
		<% 
	}
  } 
}catch(Exception e) {
		e.printStackTrace();
	}

  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
	<div id="findidall" style="text-align: center; line-height: 40px;  width: 500px; height: 400px; box-sizing: border-box; border: 1px solid black; background-color: white;  margin-top:200px; margin-left:700px">
        <div class="header_logo" style="background-color: #2AC1BC;">
            <img src="./images/popup_logo.png" alt="아이디 찾기" style="width: auto; height: 70px;">
        </div>
        <div>
            <h2 class="find_tit">아이디 찾기</h2>
            <p class="finally_idpw"><label for="findid_name">아이디 :<%=u_id%></label></p>
        </div>
        <div style=" width: 250px; margin: 0; background-color: #2AC1BC; margin-left:130px; margin-top:60px">
            <a href="javascript:history.back()" id="btnid_end" style="color: white; font-size: 18px; width: 400px; background-color: #2AC1BC; border: 0; height: 50px; font-size: 16px; color: white; margin-left: 0; margin-top: 60px; text-decoration: none;">뒤로가기</a>
        </div>
    </div>
</body>
</html>