<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = null;
	if(session.getAttribute("id") != null){
		userid = (String)session.getAttribute("id");
	}
	
	String sql = "";
	String url = "jdbc:mariadb://localhost:3306/tproject3";
	String uid = "root";
	String upw = "1234";
	
	int jPrice = Integer.parseInt(request.getParameter("jumoon_price"));	
	int remainPoint = Integer.parseInt(request.getParameter("jumoon_rp"));
	//요청사항
	String request_text = request.getParameter("request_text");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String user_code = "";
	String user_name = "";
	String user_addr = "";
	int user_point = 0;
	int used_point = 0;
	int al_point = 0;	//point 테이블의 원래 p_usepoint의 변수
	String cnt = "0";
	
	//결제 페이지에서 다른 주소로 배달 클릭 시 해당 값 저장
	String address1 = request.getParameter("sample5_address");
	String address2 = request.getParameter("address_detail");
	String address3 = request.getParameter("else");
	System.out.println(address1 + "" + address2 + "" + address3);
	
	
	try{
		Class.forName("org.mariadb.jdbc.Driver");
	    conn = DriverManager.getConnection(url, uid, upw);
	    
	    if(conn != null){	    	
	    	 //j_code
	    	 sql ="select count(*) from jumoon where j_code like 'J%'";
	    	 Statement stmt = conn.createStatement();
	    		 
	    		rs =stmt.executeQuery(sql);
	    		if(rs.next()){
	    		  cnt = Integer.toString(rs.getInt(1)+1);
	    		}else { cnt = "0";}
	    		if(cnt.length() <2){
	    		  cnt = "J000"+cnt;
	    	    }else if(cnt.length()>=2 && cnt.length()<3){
	    		  cnt = "J00" + cnt;
	    		}else if(cnt.length()>=3 && cnt.length()<4){
	    		  cnt = "J0" + cnt;
	    		}else if(cnt.length()>=4 && cnt.length()<5){
	    		  cnt = "J" + cnt;
	    		}
	    }
	}catch(Exception e) {
		e.printStackTrace();
	}
	
	//j_name
	String s_code = request.getParameter("jumoon_scode");
	String jNames[] = request.getParameterValues("hiddenMenuPay");
	String jName = "";
	
	//j_quantity
	int jQtyy = 0;
	String[] jQtyLength = request.getParameterValues("hiddenQuantityPay");
	int[] jQty = new int[jQtyLength.length];
	
	//주문한 갯수만큼 for문 이용하여 저장

		try{
		      Class.forName("org.mariadb.jdbc.Driver");
		      conn = DriverManager.getConnection(url, uid, upw);
		    	  
		      if(conn != null){
		    	  Statement stmt = conn.createStatement();
		      	for(int i=0; i<jNames.length; i++){
		jName = jNames[i];
		jName = jName.replace("<br>","");
		jQty[i] = Integer.parseInt(jQtyLength[i]);
		jQtyy = jQty[i];
		      	  //주문자 정보 확인
		    	  sql = "SELECT u_code, u_name, u_addr2, u_addr3 FROM user WHERE u_id='" + userid + "';";
		    	  stmt = conn.createStatement();
		    	  rs =stmt.executeQuery(sql);
		    	  if(rs.next()) {
		    		  user_code = rs.getString("u_code");
		    		  user_name = rs.getString("u_name");
		    		  String user_addr2 = rs.getString("u_addr2");
		    		  String user_addr3 = rs.getString("u_addr3");
		    		  user_addr = user_addr2 + "" + user_addr3;
		    	  }
		    	  
		    	  //사용한 포인트(j_usedpoint) 확인
		    	  sql = "SELECT 0.05*sum(m_price),sum(j_usedPoint ) FROM jumoon j2 WHERE u_code='" + user_code + "' and j_progress ='D'";	
		    	  stmt = conn.createStatement();
		    	  rs =stmt.executeQuery(sql);
		    	  if(rs.next()) {
		    		  user_point = rs.getInt(1);//총포인트
		    		  used_point = user_point - rs.getInt(2) - remainPoint;//사용한 포인트
		    
		    	  }
		    	  
		    	  //남은 포인트를 user 테이블에 업데이트
		    	  sql = "UPDATE user SET u_point =" + remainPoint + " WHERE u_code='" + user_code + "';"; 
		    	  stmt = conn.createStatement();
		    	  int result = stmt.executeUpdate(sql);
		    	  if(result > 0) {
		    		  System.out.println("유저포인트업데이트성공");
		    	  }else{
		    		  System.out.println("유저포인트업데이트실패");
		    	  }
		    	  
		    	  //jumoon 테이블에 저장
		    	  sql = "INSERT INTO jumoon (s_code, u_code, u_name, u_addr1, j_code, m_name, j_progress, j_quantity)" 
			    	  		 + "values (?,?,?,?,?,?,?,?)";
			    	  pstmt = conn.prepareStatement(sql);
			    	  pstmt.setString(1, s_code);
			    	  pstmt.setString(2, user_code);
			    	  pstmt.setString(3, user_name);
			    	  //다른 주소로 배송 입력 시 해당 주소로 저장, 미입력시 가입 시 기재한 주소로 저장
			    	  if(address1 == "") {
			    	  	pstmt.setString(4, user_addr);
			    	  }else{
			    		pstmt.setString(4, address1 + "" + address2 + "" + address3);
			    	  }
			    	  pstmt.setString(5, cnt);
			    	  pstmt.setString(6, jName);
			    	  pstmt.setString(7, "O");	
			    	  pstmt.setInt(8, jQtyy);	    

			    	  
			    	  pstmt.executeUpdate();
	}	
		      	sql = "update jumoon set j_usedPoint = ?, m_price=?, j_request=? where j_code=? and m_name=?";
		      	pstmt = conn.prepareStatement(sql);
		      	pstmt.setInt(1,used_point);
		      	pstmt.setInt(2, (jPrice-used_point));
		      	pstmt.setString(3, request_text);
		      	pstmt.setString(4, cnt);
		      	pstmt.setString(5, jNames[0].replace("<br>",""));
		      	pstmt.executeUpdate();
		    	  %>
		          <script>
		          	alert("주문이 완료되었습니다");
		          	location.href='main.jsp';
		          </script>
		          <% 
		      }
		}catch(Exception e) {
			e.printStackTrace();
		}		
		

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
</head>
<body>

</body>
</html>