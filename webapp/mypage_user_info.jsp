<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean class="com.koreait.Member.Member" id="member"/>
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao"/>

<c:set var="pointList" value="${mem_dao.getPoint(param.u_code)}"/>

<%
	if(session.getAttribute("id") == null){
%>
<script>
	alert("로그인 후 이용하세요.");
	location.href="login.jsp";
</script>
<%
	}

String u_code = request.getParameter("u_code");
String userid = (String)session.getAttribute("id");

member.setU_code(u_code);
member.setId(userid);


if(mem_dao.userInfo(member) != null){
	String name = member.getName();
	String tel =  member.getTel();
	String email1 = member.getEmail1();
	String email2 = member.getEmail2();
	int point = member.getU_point();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>배달의 민족</title>
    <link href="css/style_mypage_user_info.css" rel="stylesheet" type="text/css">
    <style>
    	#plus , #minus {display: none;}
    	#plus.on, #minus.on {display: block;}
    	#plus.off, #minus.off {display: none;}
    </style>
    <script src="./jquery-3.5.1.min.js"></script>
</head>
<body>
    <div class="content_div">
        <div class="cont_up">
            <img src="./images/thinking.png" alt="배민">
            <div class="cont_up_middle">
                <div><span>고마운분,</span><%=name%>님</div>
                <p><%=tel %></p>
                <p>email : <%=email1 %> @ <%=email2 %></p>
<%} %>
            </div>
            <div class="cont_up_right">
                <input type="button" value="수정" onClick="location.href='mypage_login.jsp'">
            </div>
        </div>
        <div class="cont_down">
            <table>
                <tr>
                    <td>보유 포인트</td>
                    <td>사용 포인트</td>
                    <td>적립횟수</td>
                </tr>
                <tr>
                    <td>
                    <c:set var="total" value="${0}"/>
                    <c:if test="${not empty pointList}">
					<c:forEach var="item" items="${pointList}" varStatus="status">
					    <c:set var="total" value="${total+item.u_point-item.u_usedPoint}" />
					    	<c:if test="${status.last eq true}">
					    	${total }
					    	</c:if>
					</c:forEach>
					</c:if>
					<c:if test="${empty pointList}">
					0
					</c:if>
                    P<a onclick="openPlus()"><img src="./images/w.png" alt=""></a></td>
                    <td>
						<c:set var="total" value="${0}"/>
						<c:if test="${not empty pointList}">
						<c:forEach var="item" items="${pointList}" varStatus="status">
						    <c:set var="total" value="${total+item.u_usedPoint}" />
						    <c:if test="${status.last eq true}">${total}</c:if>
						</c:forEach>
						</c:if>
						<c:if test="${empty pointList}">0</c:if>
                    P<a onclick="openMinus()"><img src="./images/w.png" alt=""></a></td>
                    <td>
                    	<c:if test="${not empty pointList}">
	                    <c:forEach var="item" items="${pointList}" varStatus="status">
    						<c:if test="${status.last eq true}">${status.count}</c:if>
						</c:forEach>
						</c:if>
						<c:if test="${empty pointList}">0</c:if>
						회
					</td>
                </tr>
            </table>
        </div>
    </div>
    <div id="plus">
    	<table width="700px">
	    	<colgroup>
				<col width="25%">
				<col width="*">
				<col width="25%">
			</colgroup>
    		<tr>
    			<th>적립일</th>
    			<th>가게이름</th>
    			<th>적립포인트</th>
    		</tr>
    		<c:forEach var="item" items="${pointList}" varStatus="status">
				<c:if test="${item.u_point != 0}">
					<tr>
						<td>${fn:substring(item.sample3_address, 0, fn:length(item.sample3_address)-11)}</td>
						<td>${item.tel}</td>
						<td>+${item.u_point} P</td>
					</tr>
				</c:if>
			</c:forEach>
    	</table>
    </div>
    <div id="minus">
    	<table width="700px">
	    	<colgroup>
				<col width="25%">
				<col width="*">
				<col width="25%">
			</colgroup>
    		<tr>
    			<th>사용일</th>
    			<th>가게이름</th>
    			<th>차감포인트</th>
    		</tr>
    		<c:forEach var="item" items="${pointList}" varStatus="status">
    			<c:if test="${item.u_usedPoint != 0}">
						<tr>
							<td>${fn:substring(item.sample3_address, 0, fn:length(item.sample3_address)-11)}</td>
							<td>${item.tel}</td>
							<td>-${item.u_usedPoint} P</td>
						</tr>
				</c:if>
			</c:forEach>
    	</table>
    </div>
</body>
</html>
<script>
function openPlus(){
	$('#plus').toggleClass( 'on' );
	$("#minus").removeClass("on")
}

function openMinus(){
	$('#minus').toggleClass( 'on' );
	$("#plus").removeClass("on")
}
</script>