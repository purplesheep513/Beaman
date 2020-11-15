<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
%>
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao" />
<jsp:useBean class="com.koreait.Member.Member" id="member" />
<jsp:setProperty property="*" name="member" />
<%
	request.setCharacterEncoding("UTF-8");
	if(member.getPw()==null){
		if (mem_dao.edit2(member) == 1) {
			%>
			<script>
				alert("수정 되었습니다.");
				location.href = "mypage_login.jsp";
			</script>
			<%
				} else {
			%>
			<script>
				alert("실패했습니다.");
				history.back();
			</script>
			<%
				}
	}else{
		if (mem_dao.edit(member) == 1) {
			%>
			<script>
				alert("수정 되었습니다.");
				location.href = "mypage_login.jsp";
			</script>
			<%
				} else {
			%>
			<script>
				alert("실패했습니다.");
				history.back();
			</script>
			<%
				}
	}
			%>
