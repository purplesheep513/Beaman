<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean class="com.koreait.Member.Member" id="member"/>
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao"/>
<jsp:setProperty property="*" name="member"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피곤하구만</title>
</head>
<body>
<%
		if(mem_dao.join(member) == 1){
%>
<script>
alert("회원가입이 완료되었습니다.");
location.href="login.jsp";
</script>
<%
		}else{
%>
<script>
alert("회원가입에 실패했습니다.");
history.back();
</script>
<%
		}
%>

<p><%=member.getEmail1() %></p>
<p><%=member.getSample3_address() %></p>
<p><%=member.getId() %></p>
</body>
</html>