<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
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

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "";
String url = "jdbc:mariadb://localhost:3306/tproject3";
String uid = "root";
String upw = "1234";

String u_code = "";
String u_name = "";
String u_email = "";
String u_tel = "";




try{
   Class.forName("org.mariadb.jdbc.Driver");
   conn = DriverManager.getConnection(url, uid, upw);
   if(conn != null){      
      sql = "SELECT u_code, u_name, u_email, u_tel FROM user where u_id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,userid);
      rs = pstmt.executeQuery();
      
      if(rs.next()){
         u_code = rs.getString("u_code");
         u_name = rs.getString("u_name");
         u_email = rs.getString("u_email");
         u_tel = rs.getString("u_tel");

      }
   }
}catch(Exception e){
   e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="./css/style_mypage.css" rel="stylesheet" type="text/css">
    <script src="./jquery-3.5.1.min.js"></script>
</head>
<body>
    <div class="left_menu">
        <div class="img_div"><a href="main.jsp"><img src="./images/logo_web.png" alt="배민글자"><img src="./images/beamin.png" alt=""></a></div>
        <ul class="menu_list">
            <li class="main_menu"><img src="./images/book.png" alt="책"><span onclick="print_sublist()">My page</span>
                <ul class="sub_list">

                    <li class="sub_menu" onclick="chagesrc('i')">-정보수정</li>
                    <li class="sub_menu" onclick="chagesrc('z')">-찜한가게</li>
                    <li class="sub_menu" onclick="chagesrc('h')">-주문내역</li>
                    <li class="sub_menu" onclick="chagesrc('a')">-고객안심센터</li>
                </ul>
            </li>
            <li class="main_menu" onclick="chagesrc('g')"><img src="./images/computer.png" alt="컴">Notice</li>
            <li class="main_menu" onclick="chagesrc('f')"><img src="./images/jaju.png" alt ="자주묻는 질문">자주묻는 질문</li>
            <li class="main_menu" onclick="chagesrc('m')"><img src="./images/mun.png" alt="?">1:1문의</li>
            <li class="main_menu" onclick="chagesrc('e')"><img src="./images/balloon.png" alt="라이더">이벤트</li>
            <li class="main_menu" onclick="chagesrc('r')"><img src="./images/rider.png" alt="라이더"><a href="http://www.baeminriders.kr/" target="_blank" style="text-decoration: none;">라이더 모집</a></li>
        </ul> 
        <script>
            function print_sublist(){
                $(".sub_menu").toggleClass("on");
            }
            function chagesrc(i){
                var iframe1 = document.getElementById("the_iframe");
                switch(i){
                    case 'i':
                        iframe1.setAttribute('src','./mypage_login.jsp?u_code=<%=u_code%>');
                        break;
                    case 'a':
                        iframe1.setAttribute('src','./ansim.jsp?u_code=<%=u_code%>');
                        break;
                    case 'g':
                        iframe1.setAttribute('src','./gong.jsp?u_code=<%=u_code%>');
                        break;
                    case 'm':
                        iframe1.setAttribute('src','./inquire_history_regist.jsp?u_code=<%=u_code%>');
                        break;
                    case 'h':
                        iframe1.setAttribute('src','./history.jsp?u_code=<%=u_code%>');
                        break;
                    case 'z':
                        iframe1.setAttribute('src','./zzim.jsp?u_code=<%=u_code%>');
                        break;
                    case 'e':
                        iframe1.setAttribute('src','./event.jsp?u_code=<%=u_code%>');
                        break; 
                    case 'f':
                        iframe1.setAttribute('src','./inquire_iframe.jsp?u_code=<%=u_code%>');
                        break;          
                    default:
                }

            }
            
        </script>
    </div>
    <div class="right_menu">
        <iframe id="the_iframe" src="gong.jsp" name="the_iframe" frameborder="0"></iframe>
    </div>
</body>

</html>