<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = null;
	if(session.getAttribute("id") != null){
		userid = (String)session.getAttribute("id");
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body class="login_body">
<%
	if(userid == null){
%>
	
    <div class="login_wrap">
        <h1 class="loginTit"><a href="./main.jsp"><img src="./images/logo_web.png" alt="배민"></a></h1>
		<form method="post" action="login_ok.jsp">
        	<div><input type="text" name="id" placeholder="아이디"></div>
        	<div><input type="password" name="pw" placeholder="비밀번호"></div>

        	<div class="fa_user">
            	<a href="./findid_pw.jsp">아이디/비밀번호 찾기</a>
            	<a href="./add_member.jsp">회원가입</a>
        	</div>
        	<div><input type="submit" value="로그인"></div>
    	 </form>
    </div><!--width330-->
<%
	}else{
%>	
        <div class="login_wrap">
        <h1 class="loginTit"><a href="./main.jsp"><img src="./images/logo_web.png" alt="배민"></a></h1>

        	<div><h2><%=userid%>님 환영합니다.</h2></div>
  

        	<div class="fa_user">
            	<a href="#" onclick="location.href='logout.jsp'">로그아웃</a>
            	<a href="./info_modi.jsp" >회원정보수정</a>
        	</div>
      

    </div><!--width330-->
    <%
	}
    %>
</body>
</html>