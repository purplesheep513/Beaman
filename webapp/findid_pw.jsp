<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID/PassWord찾기</title>
    <link href="css/style_findid_pw.css" rel="stylesheet" type="text/css">
    <script src="jquery-3.5.1.min.js"></script>
    <script src="./js/script_find.js"></script>
</head>

<body>
    <div class="find_id_pw">
        <div class="find_id_pw_title">
            <h2>ID/PW찾기</h2>
        </div>
        <div class="find_id_pw_main">
            <div class="find_id">
                <p><a href="#" id="btnId">ID찾기</a></p>
            </div>
            <div class="find_pw">
                <p><a href="#" id="btnPw">PassWord 찾기</a></p>
            </div>
        </div>
        <div class="find_jungbo">
            <div class="find_id_jungbo" id="id_bo">
            <form method="post" action="findid_pw_ok.jsp">
                <p class="p_lo">이름 <input type="text" id="name_id" name="name_id"></p>
                <p class="p_lo">이메일 주소 <input type="text" id="email_id" name="email_id"></p>
                <div class="btn"><input type="submit" value="다음" id="btnid_next" name="btnid_next" style="width: 400px; height: 60px; background-color: #2AC1BC; margin: 0 auto; text-align: center; vertical-align: middle; color: white;" ></div>
            </form>
            </div>
            <form method="post" action="findid_pw_ok2.jsp">
            <div class="find_pw_jungbo" id="pw_bo">
                <p class="p_po">아이디 <input type="text" id="name_pw" name="name_pw"></p>
                <p class="p_po">이메일 주소 <input type="text" id="email_pw" name="email_pw"></p>
                <!-- onclick 함수지정안함!!!!!!! -->
                <div class="btn"><input type="submit" value="다음" id="btnpw_next" name="btnpw_next" style="width: 400px; height: 60px; background-color: #2AC1BC; margin: 0 auto; text-align: center; vertical-align: middle; color: white;"></div>
            </div>
           </form>
        </div>
        <div class="go_to_login"><a href="login.jsp">로그인 페이지로</a></div>
    </div>
</body>
</html>



