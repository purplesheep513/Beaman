<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String loc = (String)session.getAttribute("loc");
String s_category = (String)session.getAttribute("s_category");
String what = request.getParameter("what");
session.setAttribute("what",what);
System.out.println(loc);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
location.href="store_list.jsp?location=<%=loc%>&s_category=<%=s_category%>"
</script>
</body>
</html>