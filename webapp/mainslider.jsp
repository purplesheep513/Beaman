<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="noticeDTO" class="com.koreait.notice.NoticeDTO" />
<jsp:useBean id="noticeDAO" class="com.koreait.notice.NoticeDAO" />

<c:set var="noticeList" value="${noticeDAO.selectNotice() }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배달의 민족</title>
<script type="text/javascript" src="jquery-3.5.1.min.js"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/main.js"></script>
<style>	
	#notice_yo td:first-child {
		width: 340px;
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;
		text-align:left;
	}
</style>
</head>
<body>
	<div id="slider_notice">
		<div id="slider">
			<img src="images/btn_rollbutt_off.png" class="control_next"> <img
				src="images/btn_rollbutt_off.png" class="control_prev">
			<ul>
				<li><img src="./images/bamin_event1.jpg" class="slider-image"></li>
				<li><img src="./images/bamin_event2.jpg" class="slider-image"></li>
				<li><img src="./images/bamin_event3.jpg" class="slider-image"></li>
			</ul>
		</div>
		<%
			
		%>
		<div id="notice_alram">
			<h2>Notice</h2>
			<table>
				<!-- 				<tr id="notice_no">
						<th>번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>날짜</th>
					</tr> -->
				<c:forEach var="item" items="${noticeList }" varStatus="status">
					<tr id="notice_yo">
						<td><a href="gong.jsp?n_name=${item.n_title }">${item.n_title }</a></td>
						<td>${item.n_regdate }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div id="rider_recruit">
		<a href="mypage_gong.jsp"><img src="./images/notice_brief.png"></a>
		<a href="mypage.jsp"><img src="./images/myPage_brief.png"></a>
		<a href="http://www.baeminriders.kr/" target="_blank"> <img
			src="./images/bmrider.png">
		</a>
	</div>
	</div>
</body>
</html>