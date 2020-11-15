<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
request.setCharacterEncoding("UTF-8");
String r_star1 = request.getParameter("star-input1");
String r_star2 = request.getParameter("star-input2");
String r_star3 = request.getParameter("star-input3");
int r_star_int = (Integer.parseInt(r_star1) + Integer.parseInt(r_star2) + Integer.parseInt(r_star3))/3;
String r_star = Integer.toString(r_star_int);

String store_name = request.getParameter("hidden_data1");
String Menu_name = request.getParameter("hidden_data2");
String s_code = request.getParameter("hidden_data3");

String u_code = request.getParameter("u_code");
String r_title = request.getParameter("title");
String r_content = request.getParameter("inquiry");

Date from = new Date();
SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
String to = fm.format(from);
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   String cnt="0";
   String sql = "";
   String sql2 = "";
   String url = "jdbc:mariadb://localhost:3306/tproject3";
   String uid = "root";
   String upw = "1234";
   
   try{//u_code s_code r_content r_star1 r_star2 r_star3 r_star r_date r_didReply r_reply
      Class.forName("org.mariadb.jdbc.Driver");
      conn = DriverManager.getConnection(url, uid, upw);
      if(conn != null){
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

         
         sql = "INSERT INTO review(u_code, s_code, r_title, r_content, r_star1, r_star2, r_star3, r_star, r_date, r_didReply, r_code) values(?,?,?,?,?,?,?,?,?,?,?)";

         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, u_code);
         pstmt.setString(2, s_code);
         pstmt.setString(3, r_title);
         pstmt.setString(4, r_content);
         pstmt.setString(5, r_star1);
         pstmt.setString(6, r_star2);
         pstmt.setString(7, r_star3);
         pstmt.setString(8, r_star);
         pstmt.setString(9, to);
         pstmt.setString(10, "N");
         pstmt.setString(11, cnt);

         pstmt.executeUpdate();
         
         sql = "select avg(r_star) from review where s_code=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, s_code);
         
         rs = pstmt.executeQuery();
         if(rs.next()){
        	 double star = rs.getDouble(1); 
        	 sql = "update store set s_star=? where s_code=?";
        	 pstmt = conn.prepareStatement(sql);
        	 pstmt.setDouble(1, Math.round(star*100)/100.0);
        	 pstmt.setString(2, s_code);
        	 pstmt.executeUpdate();
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
<title>Insert title here</title>
</head>
<body>
<script>
alert("리뷰가 등록되었습니다.")
location.href="history.jsp?u_code=<%=u_code%>"
</script>
</body>
</html>