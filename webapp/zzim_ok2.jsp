<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="com.koreait.zzim.ZzimDAO" %>
<%@ page import="com.koreait.zzim.ZzimDTO" %>
<jsp:useBean class="com.koreait.zzim.ZzimDTO" id="zzim_dto"/>
<jsp:useBean class="com.koreait.zzim.ZzimDAO" id="zzim_dao"/>

    <%
	if(session.getAttribute("id") == null){
%>
<script>
	alert("로그인 후 이용하세요.");
	location.href="login.jsp";
</script>
<%
	}
    String userid = (String)session.getAttribute("id");
    String s_code = request.getParameter("s_code");
    String u_code = request.getParameter("u_code");
    zzim_dto.setS_code(s_code);
    zzim_dto.setU_code(request.getParameter("u_code"));
    
		
			if(zzim_dao.del(zzim_dto)){
			%>
			<script>
			alert('찜목록에서 삭제되었습니다.');
			location.href = "zzim.jsp?u_code=<%=u_code%>";
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
