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
<title>로그인</title>
</head>
<body>
	<%
	if(mem_dao.login(member) != null){
		session.setAttribute("id", member.getId());
		session.setAttribute("u_code", member.getU_code());
%>
	<script>
		alert("로그인 되었습니다.");
		location.href="main.jsp";
	</script>
<%
			}else{
%>
	<script>
		alert("아이디 또는 비밀번호를 확인하세요.");
		history.back();
	</script>
<%
			}

%>
</body>
</html>