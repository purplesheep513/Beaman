<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean class="com.koreait.Member.Member" id="member"/>
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao"/>
<jsp:setProperty property="*" name="member"/>
	

<% 
String u_code;
String userid = (String)session.getAttribute("id");
String my_pw = request.getParameter("my_pw");

if(mem_dao.mylogin(member,userid) != null){
	
	session.setAttribute("u_code", member.getU_code());


			
%>
	<script>
		alert("확인되었습니다.");
		location.href="info_modi.jsp?u_code=<%=member.getU_code()%>";
	</script>
<%
			}else{
%>
	<script>
		alert("아이디 또는 비밀번호를 확인하세요.");
		history.back();
	</script>
	<%	} %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 로그인</title>
</head>
<body>

</body>
</html>