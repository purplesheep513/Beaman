<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="com.koreait.Member.Member" %>
<%@ page import="com.koreait.Member.Member_DAO" %>
<jsp:useBean class="com.koreait.Member.Member" id="member" />
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao" />
<jsp:setProperty property="*" name="member" />
<%
String id = (String)session.getAttribute("id");
	String nick = request.getParameter("nick");
	
	boolean i = mem_dao.nickcheck(member, nick);

if(i){
	session.setAttribute("id", member.getId());
	out.print("no");
} else {
	out.print("ok");
}


%>