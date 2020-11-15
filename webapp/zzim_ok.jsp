<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="com.koreait.zzim.ZzimDAO" %>
<%@ page import="com.koreait.zzim.ZzimDTO" %>
<jsp:useBean class="com.koreait.zzim.ZzimDTO" id="zzim_dto" />
<jsp:useBean class="com.koreait.zzim.ZzimDAO" id="zzim_dao" />
<%
	if (session.getAttribute("id") == null) {
%>
<script>
	alert("로그인 후 이용하세요.");
	location.href="login.jsp";
</script>
<%
	}
String userid = (String) session.getAttribute("id");
String s_code = request.getParameter("s_code");
String s_category = request.getParameter("s_category");
String location = request.getParameter("loc");
zzim_dto.setS_code(s_code);
zzim_dto.setU_code(request.getParameter("u_code"));

String k = zzim_dao.zzim(zzim_dto);

if (k.equals("삭제")) {
%>
			<script>
			alert('찜목록에서 삭제되었습니다.');
			location.href = "store_list.jsp?s_category=<%=s_category%>&loc=<%=location%>";
			</script>

<%
	} else if (k.equals("추가")) {
%>
<script>
			alert('찜목록에 추가되엇습니다.');
			location.href ="store_list.jsp?s_category=<%=s_category%>&loc=<%=location%>";
</script>

<%
	}else {
%>
<script>
					alert('찜목록수정 실패');
					location.href ="store_list.jsp?s_category=<%=s_category%>&loc=<%=location%>";
</script>

<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜</title>

</head>
<body>

</body>
</html>
