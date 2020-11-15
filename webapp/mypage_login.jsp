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
<title>마이페이지 로그인</title>
<link href="./css/style_w.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
	if(userid != null) {
%>
    <div class="mypageLogin">
        <p>
            <h1 class="font_wait">잠깐!</h1>
        </p>
        <p class="mytext">보안을 위해</p>
        <p class="mytext">다시 한 번 로그인해주세요</p>
        <div class="my_login">
            <form name="my_log_form" method="post" action="mypage_login_ok.jsp">
                <ul id="myIdPw">
                    <li><input type="text" placeholder="아이디" id="id" name="id" value="<%=userid%>" disabled></li>
                    <li><input type="password" placeholder="비밀번호" id="pw" name="pw"></li>

                </ul>       
                <ul id="mylogBtn">
                    <li><input type="submit" value="로그인" name="submit" id="login_btn"></li>
                </ul>
            </form>
            <%
	}else {
		
	}
%>
        </div>
    </div>
</body>
</html>

