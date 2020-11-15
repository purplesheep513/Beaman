<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page isELIgnored="false" %>
<%@   taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="storeDTO" class="com.koreait.store.Store" />
<jsp:useBean id="storeDAO" class="com.koreait.store.Store_DAO" />
<%-- <%
   if(session.getAttribute("id") == null){
%> --%>
<!-- <script>
   alert("로그인 후 이용하세요.");
   location.href="./login.jsp";
</script> -->
<%   
   String getValChk = request.getParameter("getValChk");
   if( getValChk == null){
      getValChk = "normal";
   }
   
   String location = (String)session.getAttribute("loc");
   if(session.getAttribute("loc") == null){location="";};
   /*}  */
   int recNum = 5; // 페이지당 글 개수
   int start = 0;   // 시작글 번호
   int totCnt = 0;   // 전체 글 개수
   int OnwCnt = 0; // 사장님 글 개수
   String pagenum = request.getParameter("pagenum");
   if(pagenum != null && !pagenum.equals("")){
      start = (Integer.parseInt(pagenum)-1) * recNum;
   }else{
      pagenum = "1";
      start = 0;
   }


   request.setCharacterEncoding("UTF-8");
   String store_code = request.getParameter("s_code");
   String userid = (String)session.getAttribute("id");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   PreparedStatement pstmt1 = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   ResultSet rs3 = null;
   ResultSet rs4= null;
   
   String s_name="";
   String s_star = "";
   String s_minOrder = "";
   String s_htpay = "";
   String s_deliverytime = "";
   String s_open = "";
   String s_close = "";
   String s_tel ="";
   String s_intro = "";
   String s_addr ="";
   String s_storeNum = "";
   String m_name =  "";
   String m_price =  "";
   String m_intro =  "";
   String m_code= "";
   String m_file="";
   int o_num=0;
   int s_num=0;
   String s_img="";
   
   int s_tip = 0;
   
   String sql = "";
   String sql1 = "";
   String sql2= "";
   String url = "jdbc:mariadb://localhost:3306/tproject3";
   String uid = "root";
   String upw = "1234";
   
   try{
      Class.forName("org.mariadb.jdbc.Driver");
      conn = DriverManager.getConnection(url, uid, upw);
      if(conn != null){
         sql2="select count(*) from menu where s_code=?";
         pstmt = conn.prepareStatement(sql2);
          pstmt.setString(1, store_code);
          rs3 = pstmt.executeQuery();
          if(rs3.next()){

         //가게코드를 이용해서 배달료 값(s_tip) 저장
         Statement stmt = conn.createStatement();
         sql = "SELECT s_deliveryTip FROM store WHERE s_code = '" + store_code +"';";
         stmt = conn.createStatement();
         rs =stmt.executeQuery(sql);
         if(rs.next()) {
            s_tip = rs.getInt("s_deliveryTip");
         }
         
         sql = "SELECT s_name, s_star, s_minOrder, s_htpay, s_deliverytime, s_storeNum, s_open, s_close, s_tel, s_addr, s_intro, m_name, m_price, m_intro, s_img FROM menu inner join store on store.s_code = menu.s_code where store.s_code=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, store_code);
         rs = pstmt.executeQuery();
         
      }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    <link href="./css/style_storeInfo.css" rel="stylesheet" type="text/css">
    <script src="./jquery-3.5.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="./js/script.js"></script>

<style>
   #go_to_pay {width: 100%; height: 50px; border: none; background-color: #2AC1BC; color: #fff;}
   #tb_order p {color: rgb(102, 94, 94); font-weight: bold; font-size: 18px; height: 100px; margin-bottom: 15px;}

   #tb_price p {color: rgb(102, 94, 94); font-weight: bold; font-size: 18px;  height: 100px; margin-bottom: 15px;}
   #quantity p {color: rgb(102, 94, 94); font-weight: bold; font-size: 18px;  height: 100px; margin-bottom: 15px;}
   #quantity p button {margin-left: 5px;}
   
   .info1 {color: color: rgb(102, 94, 94); font-weight: bold; font-size: 16px;}
   #tot_price {color: color: rgb(102, 94, 94); font-weight: bold; font-size: 18px; padding:10px 10px 10px 15px;}
</style>
</head>

<body>
    <!-- header -->
    <div class="header">
        <div class="box_inner">
            <a href="./main.jsp"><img src="./images/logo_icon.png" alt="배달의민족"></a>
             <%
               if(userid==null){
            %>
            <ul class="user_list">
                <li><a href="./login.jsp">로그인</a></li>
                <li> | </li>
                <li><a href="./add_member.jsp">회원가입</a></li>
            </ul>
              <%
               }else{
            %>
               <ul class="user_list">
               <li><%=userid %>님 환영합니다</li>
                  <li> | </li>
                <li><a href="mypage.jsp">마이페이지</a></li>
                <li> | </li>
                <li><a href="logout.jsp">로그아웃</a></li>
            </ul>
            <%
               }
            %>
        </div>
    </div>
    <!-- header 끝 -->
    <!-- 음식종류별 메뉴 -->
    <div class="box_inner">
        <div class="food_cate_list_div">
            <ul class="food_cate_list">
                <li class="main_search"><!-- 검색하는 돋보기 -->
                   <form action="search.jsp"  class="search_action" method="post"> 
                    <a href="#" class="search_a" onclick="ques_bt()"><img src="./images/search.png"></a>
                    <div class="search_div"> 
                        <input type="search" class="search_input" name="search_input">
                        <button type="submit" value="검색" class="btn_search"><img src="./images/search.png"></button>
                    </div>
                    </form> 
                </li>
                <li><a href="store_list.jsp?s_category=한식&loc=<%=location %>" id="getSName" class="food_cate">한식</a></li>
                <li><a href="store_list.jsp?s_category=분식&loc=<%=location %>" id="getSName" class="food_cate">분식</a></li>
                <li><a href="store_list.jsp?s_category=카페/디저트&loc=<%=location %>" id="getSName" class="food_cate">카페·디저트</a></li>
                <li><a href="store_list.jsp?s_category=일식/돈까스&loc=<%=location %>" id="getSName" class="food_cate">일식·돈까스</a></li>
                <li><a href="store_list.jsp?s_category=치킨&loc=<%=location %>" id="getSName" class="food_cate">치킨</a></li>
                <li><a href="store_list.jsp?s_category=피자/양식&loc=<%=location %>" id="getSName" class="food_cate">피자·양식</a></li>
                <li><a href="store_list.jsp?s_category=아시안&loc=<%=location %>" id="getSName" class="food_cate">아시안</a></li>
                <li><a href="store_list.jsp?s_category=중국집&loc=<%=location %>" id="getSName" class="food_cate">중국집</a></li>
                <li><a href="store_list.jsp?s_category=족발/보쌈&loc=<%=location %>" id="getSName" class="food_cate">족발·보쌈</a></li>
                <li><a href="store_list.jsp?s_category=야식&loc=<%=location %>" id="getSName" class="food_cate">야식</a></li>
                <li><a href="store_list.jsp?s_category=찜/탕&loc=<%=location %>" id="getSName" class="food_cate">찜·탕</a></li>
                <li><a href="store_list.jsp?s_category=도시락&loc=<%=location %>" id="getSName" class="food_cate">도시락</a></li>
                <li><a href="store_list.jsp?s_category=패스트푸드&loc=<%=location %>" id="getSName" class="food_cate">패스트푸드</a></li>
                <li><a href="store_list.jsp?s_category=프랜차이즈&loc=<%=location %>" id="getSName" class="food_cate">프랜차이즈</a></li>
            </ul>
        </div>
        <!-- 음식종류별 메뉴 끝-->
      <!-- Store_info db넣기  -->
      <%
      if(rs.next()){
         s_name = rs.getString("s_name");
         s_star = rs.getString("s_star");
         s_minOrder = rs.getString("s_minOrder");
         s_htpay = rs.getString("s_htpay");
         s_deliverytime = rs.getString("s_deliverytime");
         s_open = rs.getString("s_open");
         s_close = rs.getString("s_close");
         s_tel = rs.getString("s_tel");
         s_intro = rs.getString("s_intro");
         s_addr = rs.getString("s_addr");
         s_storeNum = rs.getString("s_storeNum");
         s_img = rs.getString("s_img");
       
         String imgStr = "";
         if(s_img == null){
            imgStr = "<img src='images/noimg.jpg' width='20' alt='없음'>";
         }else{
        	 imgStr = "<img src='http://localhost:9090/upload/"+s_img+"' width='20' alt='"+s_name+"'>";
         }
      %>
      <!-- db연결 끝 -->
      
        <!-- 간단 가게정보 -->
        <div class="store_container">
            <div class="store_first">
                <div id="for_border">
                    <p><%=s_name%>
                        <button type="button" id="sh-link">링크공유</button>
                    </p>
                </div>
                <div class="store_img">
                <%=imgStr%>
                    <!-- <img src="images/nene.jpeg" alt="가게사진"> -->
                </div>
                <div class="brief_info">
                    <div class="img">
                        <img src="images/star.png" alt="별그림">
                        <img src="images/star.png" alt="별그림">
                        <img src="images/star.png" alt="별그림">
                        <img src="images/star.png" alt="별그림">
                        <span><%=s_star %></span>
                        <p>최소주문금액 <span><%=s_minOrder %></span></p>
                        <p>결제 <span><%=s_htpay %></span></p>
                        <p>배달시간 <span><%=s_deliverytime %></span></p>
                    </div>
                </div>
                <div id="notice">
                    <a href="#" onclick="infoFunc()">
                        <p><img src="images/speaker.png" alt="확성기"> 사장님 알림 <span id="notice_owner"> <%=s_intro %></span> </p>
                    </a>
                </div>
            </div>
            <!-- 간단 가게정보 끝 -->
        </div>
        <!-- 메뉴/클린리뷰/정보 클릭하는 부분 order_list111-->
        <div class="store_container">
        <form method="post" action="pay.jsp" onsubmit="return isSelected()">
            <div id="order_list">
                <div>
                    <p>주문표</p>
                </div>
                <div id="findingParent">                
                    <p id="tb_order"></p>
                    <p id="tb_price"></p>
                    <p id="quantity"></p>
                    <!-- <input type="hidden" id="pay_howmany" name="pay_howmany" value="a"> -->
                    <input type="hidden" id="pay_scode" name="pay_scode" value="<%=store_code%>">
                </div>
                <div>
                    <p id="baedalYogum">배달요금 <%=s_tip%>원 별도</p>
                    <p><span id="tot_price" class="info1">0</span><span class="info1">원</span></p>
                    <input type="hidden" id="kf_pay" name="kf_pay" value="0">
                    <input type="hidden" id="info_minOrder" name="info_minOrder" value="<%=s_minOrder%>">
                </div>
                <div id="hiddenContainer">
               </div>
                <input type="submit" id="go_to_pay" value="주문하기">
            </div>
       </form>
            <div class="check_menu">
                <button type="button" onclick="menuFunc()">메뉴</button>
                <!--누르면 메뉴가 열림-->
                <button type="button" onclick="reviewFunc()">클린리뷰</button>
                <!--누르면 클린리뷰가 열림-->
                <button type="button" onclick="infoFunc()">정보</button>
                <!--누르면 정보가 열림-->
            </div>
            <!-- 메뉴/클린리뷰/정보 클릭하는 부분 끝 -->
        </div>
        <!-- 메뉴 -->
        <div class="store_container" id="menu_open">
            <div id="chicken_photo">
                <table>
                    <tr>
                    <%
      }
            sql = "SELECT m_name, m_price, m_intro,m_file FROM menu where s_code =?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, store_code);
            rs = pstmt.executeQuery();
            while(rs.next()){
               m_name = rs.getString("m_name");
               m_price = rs.getString("m_price");
               m_intro = rs.getString("m_intro");
               m_file = rs.getString("m_file");
  %>
                        <td style="width: 143px;">
                            <div>
                                <a class="add_menu">
                                <%
                    String imgStr = "";
                    if(m_file == null){
                       imgStr = "images/noimg.jpg";
                    }else{
                   	 imgStr = "http://localhost:9090/upload/menu/"+m_file;
                    }
                    %>
                                    <img src="<%=imgStr %>" alt="<%=m_file %>" style="height:103px">
                                    <p><span class="menu_name"><%=m_name %></span><br><span class="menu_price"><%=m_price %></span>원</p>
                                </a>
                            </div>
                        </td>
                    <%
                  }
                    %>
                    </tr>
                </table>
            </div>
            <div id="popular_menu"><img src="images/prize.png"><a href="#"> 인기메뉴</a></div>
            <!-- <-이것을 클릭하면 아래 메뉴가 펼쳐지는 모양입니다.-->
<%
            sql = "SELECT m_code, m_name, m_price, m_intro, m_file FROM menu where s_code =?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, store_code);
            ResultSet rs1 = pstmt.executeQuery();
            while(rs1.next()){
               m_name = rs1.getString("m_name");
               m_price = rs1.getString("m_price");
               m_intro = rs1.getString("m_intro");
               m_code = rs1.getString("m_code");
               m_file = rs1.getString("m_file");
%>
            <div id="menu_detail_container" class="menu_controll">
                <div class="menu_detail">
                    <div><a href="#aa" class="add_menu">
                            <p class="menu_name"><%=m_name %></p>
                            <input type="hidden" value=<%=m_code %>>
                            <p><%=m_intro %></p>
                            <p><span class="menu_price"><%=m_price %></span>원</p>
                        </a>
                    </div>
                    <%
                    String imgStr = "";
                    if(m_file == null){
                       imgStr = "images/noimg.jpg";
                    }else{
                   	 imgStr = "http://localhost:9090/upload/menu/"+m_file;
                    }
                    %>
                    <div><img src="<%=imgStr %>" style="height: 80px;" alt="이상"></div>
                </div>  
            </div>
            <!-- 메뉴 옵션 추가하기 menuOption111 -->
            <div class="menuOption">
                  <div class="menuDetail">
                     <div class="aaa">메뉴상세</div>
                  </div>
                  <div class="m_name"><%=m_name %></div>
                  <div class="priceFor"><strong class="leftname">가격 :</strong><span class="m_price"></span></div>
                  <div class="op_side_bar">
                     <div class="m_option">
                        <br>
                        <div class="optionChoice">옵션 선택(선택)</div>
                        <br>
                    <%
                    sql = "select o_name from option where m_code=? group by o_name";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, m_code);
                    rs = pstmt.executeQuery();
                    while(rs.next()){
                        String o_name=rs.getString(1);
                    %> 
                       
                    <div class="o_name" style="font-size: 20px; font-weight:bold;"><%=o_name%></div>
                    
<%
               sql = "select o_extra from option where m_code=? and o_name=?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, m_code);
               pstmt.setString(2, o_name);
               rs3 = pstmt.executeQuery();
               while(rs3.next()){
                   String o_extra = rs3.getString(1);
                     String tot_op[] = o_extra.split("/");
%>
                    <div class="o_name" style="display: none"><%=o_name%></div>
                    <div class="linePac"><input type="radio" class="option_chk" id="op<%=o_num %>" name=<%= o_name%> value=<%= tot_op[1]%>><%= tot_op[0]%></div>
                    <div class="linePac2"><span class="o_price"><%= tot_op[1]%></span>원</div>
                    
<%            o_num++;
               }
%>

<%
                    }
  %>                  
                
                     </div>
                     <div class="m_side">
                         <br>
                        <div class="optionChoice">사이드 선택(선택)</div>
                        <br>
                      <%
               sql = "select s_name, s_extra from side where m_code=?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, m_code);
               rs = pstmt.executeQuery();
               while(rs.next()){
                   String side_name=rs.getString(1);
                   String s_extra = rs.getString(2);
                   
               %>
                     <div class="sideChoice">
                        <div class="side_name" id="sideN<%=s_num%>"><%=side_name %></div>
                        <div class="findSide"><span class="s_price"><%=s_extra %></span>원</div>
                        <a href="#aa" class="SminusOne">-</a>
                        <div class="s_num" id="sideQ<%=s_num%>">0</div>
                        <a href="#aa" class="SplusOne">+</a>
                        <input type="hidden" name=<%=side_name %>>
                    </div>    
                 <%
              s_num++;   
               } %>
                     </div>
                     <br>
                   <div class="optionChoice2">메뉴 추가</div>
                     <div class="m_num_container">                      
                        <a href="#aa" class="MminusOne">-</a><div class="m_num">1</div><a href="#aa" class="MplusOne">+</a>                      
                     </div>
                     <div class="tot_price_container">
                        총 주문금액      <div><span class="tot_price"></span></div>
                     </div>
                  </div>
                  <div class="add_order_container">
                     <div class="add_order">주문표에 추가</div>
                     <div class="close_order">닫기</div>
                  </div>
            </div>
              <!-- 메뉴 옵션 추가하기 끝 menuOption111-->
<%} %>             
            
            <div class="from_info"><a href="#" onclick="infoFunc()">원산지 정보▶</a></div>
            <!-- 메뉴 끝 -->
        </div>
        <!-- 클린리뷰 -->
        <div class="store_container" id="review_content">
        <%
           sql = "SELECT r_title,r_content,avg(r_star1) as avg_star1,avg(r_star2) as avg_star2,avg(r_star3) as avg_star3,avg(r_star) as avg_star from review where s_code=?";
           pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, store_code);
          rs = pstmt.executeQuery();
          if(rs.next()){
             String r_title = rs.getString("r_title");
             String r_content = rs.getString("r_content");
             String r_star1 = String.format("%.1f",rs.getDouble("avg_star1"));
             String r_star2 = String.format("%.1f",rs.getDouble("avg_star2"));
             String r_star3 = String.format("%.1f",rs.getDouble("avg_star3"));
             String r_star = String.format("%.1f",rs.getDouble("avg_star"));      
        %>
            <div id="score_container">
                <div id="total_score">
                
                    <table>
                        <tr>
                            <td>
                                <p><%=r_star%></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
               <%
                   double staru = Double.parseDouble(r_star);
               for(int i=1; i<=staru; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>  
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="star_score">
                    <ul>
                        <li>
                            맛
                <%
               double star1 = Double.parseDouble(r_star1);
               for(int i=1; i<=star1; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>                            
                            <%=r_star1 %>
                             
                        </li>      
                    </ul>
                    <ul>                   
                        <li>
                            양
                <%
                   double star2 = Double.parseDouble(r_star2);
               for(int i=1; i<=star2; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>                             
                            <%=r_star2 %>
                            
                        </li>                        
                    </ul>
                    <ul>                    
                        <li>
                            배달
                <%
                   double star3 = Double.parseDouble(r_star3);
               for(int i=1; i<=star3; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>                             
                            <%=r_star3 %>                            
                        </li>                        
                    </ul>
                </div>
            </div>
            <div id="review_part_one">
            <%
         sql = "SELECT count(r_star) as cnt FROM review where s_code=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, store_code);
         rs = pstmt.executeQuery();
         if(rs.next()){
            totCnt = rs.getInt("cnt");
         }
         sql = "SELECT count(r_star) as onwecnt FROM review where s_code=? and r_didReply='Y'";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, store_code);
         rs = pstmt.executeQuery();
         if(rs.next()){
            OnwCnt = rs.getInt("onwecnt");
         }
            %>
                <div>
                    <p>리뷰 <span><%=totCnt %></span>개·사장님댓글 <span><%=OnwCnt %> </span>개</p>
                </div>
                <div>
                    <!--예전에 touristIntour만들때 로그인에서 로그인유지 버튼만들때 이렇게 하셨길래 저도 div만 그대로 올립니다.-->
                    <div></div>
                </div>
            </div>
            <!-- 고객이 작성한 리뷰 -->
            <%
            String r_titlea = "";
            String r_contenta = "";
            String r_star1a = "";
            String r_star2a = "";
            String r_star3a = "";
            String r_stara = "";
            String u_id = "";
            String r_didReply = "";
            String r_reply = "";
            
             sql = "SELECT r_title, r_content, r_star1, r_star2, r_star3, r_star, r_didReply, r_reply, u_code from review where s_code=? limit ?, ?";
             pstmt = conn.prepareStatement(sql);            
             pstmt.setString(1, store_code);
             pstmt.setInt(2, start);
             pstmt.setInt(3, recNum);
             
             rs = pstmt.executeQuery();
               while(rs.next()){
                 String r_id ="";
                 sql1 = "SELECT u_nick from user where u_code=?";
                 pstmt1 = conn.prepareStatement(sql1); 
                 pstmt1.setString(1, rs.getString("u_code"));
                 rs2 = pstmt1.executeQuery();
                 if(rs2.next()){
                    r_id = rs2.getString("u_nick");
                 }
                  r_titlea = rs.getString("r_title");
                  r_contenta = rs.getString("r_content");
                  r_star1a = rs.getString("r_star1");
                  r_star2a = rs.getString("r_star2");
                  r_star3a = rs.getString("r_star3");
                  r_stara = rs.getString("r_star");
                  r_didReply = rs.getString("r_didReply");
                  r_reply = rs.getString("r_reply");
            %>
            
            <div id="review_customer">
               <br>
                <div class="hihi"><%=r_id %>님</div>
                <br>
                <div class="writer_score">
               <%
                   double stara = Double.parseDouble(r_stara);
               for(int i=1; i<=stara; i++){
                   out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>  
                    <span id="for_color"> | </span>
                    <span> 맛</span>
                <%
                   double star1a = Double.parseDouble(r_star1a);
               for(int i=1; i<=star1a; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>  
                    <span><%=r_star1a %></span>
                    <span>양</span>
                <%
                   double star2a = Double.parseDouble(r_star2a);
               for(int i=1; i<=star2a; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>  
                    <span><%=r_star2a %></span>
                    <span>배달</span>
                <%
                   double star3a = Double.parseDouble(r_star3a);
               for(int i=1; i<=star3a; i++){
                  out.print("<img src='images/star.png' width='13' alt='별'>");
               }
                %>  
                    <span><%=r_star3a %></span>
                </div>
                <div class="writer_content">
                    <p><%=r_titlea %></p>
                    <p id="nodeco"><%out.print(r_contenta); %></p>
                    <%                     
                       if(r_didReply.equals("Y")){   
                    %>  
                  <p>
                     <img src="./images/arrow.png" alt="답변" style="transform: scaleY(-1); width: 50px; height: 30px;">
                     <label style="font-size: 16px; color: #333; vertical-align: top;">♥사장님 댓글♥</label>
                     <div class="review_container_div" style=" width: 620px; height:auto; padding: 15px; display: inline-block; background-color: #e6e6e6; font-size: 16px;"><%out.print(r_reply);%></div>
                  </p>
                  <style>
                  .review_container_div p {margin:0; padding:0; color:#333; width:595px;word-break:break-word;}
                  </style>
                  <%
                     }
                  %>
                </div>

            </div>

              <%
               }
            %>
            <p class="numbo">
            <%
           int pageCnt =0;
           if(totCnt==recNum){
              pageCnt = (totCnt / recNum);
           }else{
              pageCnt = (totCnt / recNum) + 1;
              }
            %>
            <%
            for(int i=1; i<=pageCnt; i++){
               out.print("<a href='store_info.jsp?getValChk=seeReview&s_code="+ store_code+"&pagenum="+i+"';>" + i + "</a>" + " ");
            }
         %>
         </p>
        </div>
      <div class="this_for_space"></div>
        <!-- 클린리뷰 끝 -->
        <!-- 정보 -->
        <div class="store_container" id="notice_content">
            <div id="notice_ahead">
                <div>
                    <p><img src="images/speaker.png"> 사장님 알림</p>
                </div>
<%
   }
   sql = "SELECT sn_ncontent, sn_ordercontent, sn_origin from store_notice where s_code=?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, store_code);
   rs = pstmt.executeQuery();
   if(rs.next()){
      String sn_ncontent = rs.getString("sn_ncontent");
      String sn_ordercontent = rs.getString("sn_ordercontent");
      String sn_origin = rs.getString("sn_origin");
  
%>
                <div id="info_content">
                </div>
                <script>
                document.getElementById("info_content").innerHTML = "<%=sn_ordercontent%>";
                </script>
                <div>
                    <p class="bold_font"><img src="images/store.png" alt="업체"> 업체정보</p>

                    <table class="tbl_info">
                        <tr>
                            <td class="info">영업시간</td>
                            <td class="info_detail"><%=s_open %> - <%=s_close %></td>
                        </tr>
                        <tr>
                            <td class="info">전화번호</td>
                            <td class="info_detail"><%=s_tel %> </td>
                        </tr>
                        <tr>
                            <td class="info">주소</td>
                            <td class="info_detail"><%=s_addr %></td>
                        </tr>
                    </table>
                </div>
                <div>
                    <p class="bold_font"><img src="images/credit_card.png" alt="신용카드"> 결제정보</p>
                    <table class="tbl_info">
                        <tr>
                            <td class="info">최소주문금액</td>
                            <td class="info_detail"><%=s_minOrder %></td>
                        </tr>
                        <tr>
                            <td class="info">최소주문금액</td>
                            <td class="info_detail"><%=s_htpay %></td>
                        </tr>
                    </table>
                </div>
                <div>
                    <p class="bold_font"><img src="images/business.png" alt="사업자"> 사업자 정보</p>

                    <table class="tbl_info">
                        <tr>
                            <td class="info">상호명</td>
                            <td class="info_detail"><%=s_name %></td>
                        </tr>
                        <tr>
                            <td class="info">사업자등록번호</td>
                            <td class="info_detail"><%=s_storeNum %></td>
                        </tr>
                    </table>
                </div>
                <div>
                    <p class="bold_font"><img src="images/food_info.png" alt="원산지"> 원산지 정보</p>
                    <table class="tbl_info">
                        <tr>
                            <td>
                        <%=sn_origin %>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="from_info"><a href="#">원산지 정보▶</a></div>
        </div>
        <!-- 정보 끝 -->
<%      }else{out.println("<script>alert('준비중인 가게입니다.'); location.href='main.jsp'</script>");}
      }

   }catch(Exception e){
      e.printStackTrace();
   }
%>
    </div>
    <!-- footer -->
    <div class="footer" style="clear:both;">
        <div class="footer_list_div">
            <div class="box_inner">
                <ul class="footer_list">
                    <li><a href="./edragon.jsp" target="_sub">이용약관</a></li>
                    <li><a href="./jungbo.jsp" target="_sub">개인정보처리방침</a></li>
                    <li><a href="./company_intro.jsp" target="_sub">회사소개</a></li>
                    <li><a href="./gong.jsp" target="_sub">공지사항</a></li>
                </ul>
            </div>
        </div>
        <div class="box_inner">
            <div class="company_logo">
                <img src="https://www.woowahan.com/img/pc/common-logo.png" alt="우아한 형제들">
            </div>
            <div class="company_info">
                <div class="company"><a href="https://www.woowahan.com/" target="_sub">(주)우아한형제들</a></div>
                <div>
                    <p>사업자등록번호 : 120-87-65763 사업자정보확인 대표 : 김범준 주소 : 서울 송파구 위례성대로 2, 장은빌딩 2층 대표전화 : 1600-0987 팩스:
                        050-6050-0400 대표메일 : help@woowahan.com
                        대면 상담센터 운영 - 운영시간 : (365일) 10:00 ~ 19:00, 찾아오시는길 : 서울특별시 송파구 백제고분로 478 순창빌딩 3F</p>
                </div>
            </div>
        </div>
    </div>
    <!-- footer 끝 -->
</body>
<script>
    let menu = document.getElementById("menu_open");
    let review = document.getElementById("review_content");
    let info = document.getElementById("notice_content");
    let no = document.getElementById("notice_owner");
    no.innerHTML = document.getElementById("info_content").textContent
    let str = "";
    function menuFunc() {
        menu.style.display = "block";
        review.style.display = "none";
        info.style.display = "none";
    }
    function reviewFunc() {
        menu.style.display = "none";
        review.style.display = "block";
        info.style.display = "none";
    }
    
    function infoFunc() {
        menu.style.display = "none";
        review.style.display = "none";
        info.style.display = "block";
    }
    <%
    if(getValChk.equals("seeReview")){
    %>
    reviewFunc();
    <%
    }else{
    %>
       menuFunc();
    <%
       }
    %>

    function isSelected(){
       var minmOrder = document.getElementById('info_minOrder').value;  
       var miniOrder = parseInt(minmOrder);
    	
       if($("#tot_price").text()==0){
          alert("주문상품을 선택하세요");
          location.href="store_info.jsp?s_code=<%=store_code%>"
          return false;
       }
       
       if($("#tot_price").text() < miniOrder){
    	  alert("최소주문 금액은 " +miniOrder + "원입니다");
    	  location.href="store_info.jsp?s_code=<%=store_code%>"
    	  return false;
       }
       
         return true;
    }
    /* 질문하기 팝업 jquery */
    $(".search_a").on("click", function (e) {
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;

            var oWidth = $('.search_div').width();
            var oHeight = $('.search_div').height();

            var divLeft = e.clientX + 10;
            var divTop = e.clientY + 5;

            if (divLeft + oWidth > sWidth) divLeft -= oWidth;
            if (divTop + oHeight > sHeight) divTop -= oHeight;

            if (divLeft < 0) divLeft = 0;
            if (divTop < 0) divTop = 0;

            $('.search_div').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            })
            $(".search_div").stop().fadeToggle(200); //팝업창 뜨는 속도
            return false; //중요
        });
     
        $(document).click(function(e){ //문서 body를 클릭했을때
            if(e.target.className == "search_input"){return true} // 검색창 누르면 안 닫히게
           if(e.target.className =="search_div"){return false} //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)
           $(".search_div").stop().fadeOut(200);
     });
</script>
</html>