<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    request.setCharacterEncoding("UTF-8");

    String name_pw = request.getParameter("name_pw");
    String email_pw = request.getParameter("email_pw");
	String ranPw = "";
 	String pw="";
    		
  		Connection conn = null;
  		   PreparedStatement pstmt = null;
  		   ResultSet rs = null;
  		
  		   String sql1 = "";
  		   String sql2 = "";
  	
  		   String url = "jdbc:mariadb://localhost:3306/tproject3";
  		   String uid = "root";
  		   String upw = "1234";
     try{
  		      Class.forName("org.mariadb.jdbc.Driver");
  		      conn = DriverManager.getConnection(url, uid, upw);  		      
  	/* 입력한 아이디와 이메일이 db에 있는 정보와 일치한지 확인 */	      
  		      
     if(conn != null){
  		System.out.println("!!");
  
  		sql1="select u_pwd from user where u_id = ? and u_email= ?";
		System.out.println("!!!");
		pstmt = conn.prepareStatement(sql1);
		pstmt.setString(1, name_pw);
		pstmt.setString(2, email_pw);
		System.out.println("!!!!");
  		
		rs = pstmt.executeQuery();
  		
	 	if(rs.next()) {
  	  		pw = rs.getString(1);	
  	  		
  	  	 /*	임시비밀번호 생성 문  */  		
  	  	  char pwCollection[] = new char[] {
                     '1','2','3','4','5','6','7','8','9','0',
                     'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                     'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                     '!','@','#','$','%','^','&','*','(',')'};//배열에 선언
   for (int i = 0; i < 10; i++) {
     int selectRandomPw = (int)(Math.random()*(pwCollection.length));//Math.rondom()은 0.0이상 1.0미만의 난수를 생성해 준다.
     ranPw += pwCollection[selectRandomPw];
   }  	  		
  	  	/* 생성한 임시번호로 비밀번호를 수정하는 부분 */	
   sql2="UPDATE user SET u_pwd = password(?) where u_id = ? and u_email = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, ranPw);
		pstmt.setString(2, name_pw);
		pstmt.setString(3, email_pw);		
		pstmt.executeUpdate();

  	  	if(rs.next()) {
  	  		ranPw = rs.getString("u_pwd");	 			
  	  	}	
		System.out.println(pw);
  	  	}else{
  		%>
  			<script>
  			alert("정보를 다시입력해주세요.")		/* 입력된 정보가 틀릴 시에 뜨는 안내문*/
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
<title>비밀번호 찾기</title>
</head>
<body>
	 <div id="findpwall" style="text-align: center; line-height: 40px;  width: 500px; height: 400px; box-sizing: border-box; border: 1px solid black; background-color: white; margin-top:200px; margin-left:700px">
         <div class="header_logo" style="background-color: #2AC1BC;">
             <img src="./images/popup_logo.png" alt="비밀번호 찾기"  style="width: auto; height: 70px;">
         </div>
         <div>
             <h2 class="find_tit">비밀번호 찾기</h2>
             <p class="finally_idpw"><label for="findid_name">임시비밀번호 : <%=ranPw%> </label></p>
         </div>
         <div style=" width: 250px; margin: 0; background-color: #2AC1BC; margin-left:130px; margin-top:60px">
             <a href="javascript:history.back()" id="btnid_end" style="color: white; font-size: 18px; width: 400px; background-color: #2AC1BC; border: 0; height: 50px; font-size: 16px; color: white; margin-left: 0; margin-top: 60px; text-decoration: none;">뒤로가기</a>
         </div>
     </div>
</body>
</html>