<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sql = request.getParameter("sql");
String what = request.getParameter("what");
session.setAttribute("what", what);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
location.href="zzim.jsp?sql=<%=sql%>&what=<%=what%>"
</script>
</body>
</html>