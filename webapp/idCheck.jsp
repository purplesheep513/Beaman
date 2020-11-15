<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page import="com.koreait.Member.Member" %>
<%@ page import="com.koreait.Member.Member_DAO" %>
<jsp:useBean class="com.koreait.Member.Member" id="member" />
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao" />
<jsp:setProperty property="*" name="member" />



<%
String id = request.getParameter("userid");
	boolean i = mem_dao.idcheck(member, id);

if(i){
	session.setAttribute("code", member.getU_code());
	out.print("no");
} else {
	out.print("ok");
}
%>