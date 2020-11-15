<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

String u_code = (String)session.getAttribute("u_code");

System.out.println(u_code);

String name = request.getParameter("in_name");
String email = request.getParameter("in_email");
String in_choice= request.getParameter("in_choice");
String in_title = request.getParameter("in_title");
String inquiry = request.getParameter("inquiry");



String m_answeryn = "N";

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
String m_date = formatter.format(new java.util.Date());



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
      String sql2 = "select count(*) from mun2 where m_code like 'M%'";
      sql = "INSERT INTO mun2(u_code, u_name, u_email, m_code, m_title, m_content, m_category, m_date, m_answeryn) values (?,?,?,?,?,?,?,?,?)";
      System.out.println(sql);
      
      String m_code="0";
       Statement stmt = conn.createStatement();
       rs =stmt.executeQuery(sql2);
       if(rs.next()){
        m_code = Integer.toString(rs.getInt(1)+1);
       }else { m_code = "1";}
       if(m_code.length() <2){
        m_code = "M000"+m_code;
       }else if(m_code.length()>=2 && m_code.length()<3){
        m_code = "M00" + m_code;
       }else if(m_code.length()>=3 && m_code.length()<4){
        m_code = "M0" + m_code;
       }else if(m_code.length()>=4 && m_code.length()<5){
        m_code = "M" + m_code;
       }
      
      
      
      
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, u_code);
      pstmt.setString(2, name);
      pstmt.setString(3, email);
      pstmt.setString(4, m_code);
      session.setAttribute("m_code" ,m_code);
      pstmt.setString(5, in_title);
      pstmt.setString(6, inquiry);
      pstmt.setString(7, in_choice);
      pstmt.setString(8, m_date);
      pstmt.setString(9, m_answeryn);
      pstmt.executeUpdate();
      
      if(rs.next()){
         u_code = rs.getString(1);   

      
      }
      
   }
   
   
   %>
   <script>
      alert("등록 되었습니다.");
      location.href="inquire_history_regist.jsp";
   </script>
<%
      
   
   
   
   
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

</body>
</html>