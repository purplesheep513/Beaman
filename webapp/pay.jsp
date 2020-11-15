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
   request.setCharacterEncoding("UTF-8");
   
   String userid = null;
   if(session.getAttribute("id") != null){
      userid = (String)session.getAttribute("id");
   }
   
   String s_code = request.getParameter("pay_scode");
   int fPrice = Integer.parseInt(request.getParameter("kf_pay"));
   String pay_name = request.getParameter("pay_name");
   String pay_option = request.getParameter("pay_option");
   String pay_side = request.getParameter("pay_side");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String user_code = "";
   int user_point = 0;
   int s_tip = 0;
   String htpay = "";
   
   String sql = "";
   String url = "jdbc:mariadb://localhost:3306/tproject3";
   String uid = "root";
   String upw = "1234";
   
   
   try{
         Class.forName("org.mariadb.jdbc.Driver");
         conn = DriverManager.getConnection(url, uid, upw);
         
         if(conn != null){
            Statement stmt = conn.createStatement();
            //user테이블과 u_code가 일치하는 point테이블 레코드에서 p_point를 찾아 값을 저장
            sql = "SELECT u_code FROM user WHERE u_id='" + userid + "';";
            stmt = conn.createStatement();
            rs =stmt.executeQuery(sql);
            if(rs.next()) {
               user_code = rs.getString("u_code");
            }
            
            sql = "SELECT 0.05*sum(m_price),sum(j_usedPoint ) FROM jumoon j2 WHERE u_code='" + user_code + "' and j_progress ='D'";
            stmt = conn.createStatement();
            rs =stmt.executeQuery(sql);
            if(rs.next()) {
               user_point = rs.getInt(1)-rs.getInt(2);
            }
            
            //이전 페이지에서 가게 코드를 가져와 배달료 값을 저장
            sql = "SELECT s_deliveryTip,s_htpay FROM store WHERE s_code = '" + s_code +"';";
            stmt = conn.createStatement();
            rs =stmt.executeQuery(sql);
            if(rs.next()) {
               s_tip = rs.getInt("s_deliveryTip");
               htpay = rs.getString("s_htpay");
            }
            
          }
      }catch(Exception e) {
         e.printStackTrace();
      }
   
   if(request.getParameter("hiddenMenu") != null){
      String menus[] = request.getParameterValues("hiddenMenu");
      String quantity[] = request.getParameterValues("hiddenQuantity");
   
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <link rel="stylesheet" href="./css/style_order.css">
    <script src="./jquery-3.5.1.min.js"></script>
    <script> 
        $(function(){
            $("#radio2").on("click", function() {
                $("#gowhere").css({"display" : "block"});
                $("#lbl2").css({"color" : "#333"});
                $("#lbl1").css({"color" : "#ccc"});
            })
        })
        $(function(){
            $("#radio1").on("click", function() {
                $("#gowhere").css({"display" : "none"});
                $("#lbl1").css({"color" : "#333"});
                $("#lbl2").css({"color" : "#ccc"});
            })
        })

        
        function ShowCookie123() {
            var divCookie = document.getElementById("cookie_list");

            if( document.cookie == null || document.cookie == "" ) {
               divCookie.innerHTML = "";
               return;
            }

         var listCookie = document.cookie.split( "; " );
         var strCookie = "";

         for(var i = 0; i < listCookie.length; ++i) {
            var iPos = listCookie[i].indexOf("=");
            var strName = listCookie[i].substring(0,iPos);
            var strValue = listCookie[i].substring(iPos+1);
            strValue = decodeURIComponent( strValue );
            strCookie += strName + "=" + strValue + "<br>\n";
         }

         divCookie.innerHTML = strCookie;
         }
      //onkeypress="return whyEnter();"
        function whyEnter() {
           if(event.keyCode == 13) {
              alert("사용 버튼을 이용해서 사용해주세요");
              return false;
           }
        }
    </script>
</head>
<style>
   .phonepaychk {
      font-size: 14px;
      margin-left: 45px;
   }
</style>
<body>
   <form method="post" action="pay_ok.jsp" onsubmit="return pleaseFinish()">
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
    <!--컨테이너 시작-->
    <div id="order_container" class="box_inner">
        <div id="destination">
            <h2 id="div_head"></h2>
            <img src="./images/deliever.png">
            <h2><span id="des_info">배송지 정보</span></h2>
            <div id="path_select">
                <p><input type="radio" id="radio1" class="css-radio" name="where" value="original" checked><label id="lbl1">기본주소지</label></p>
                <p><input type="radio" id="radio2" class="css-radio" name="where" value="specific"><label id="lbl2">다른 주소로 배달</label></p>
            </div>
            <div id="gowhere">
               <input type="text" id="sample6_postcode" placeholder="우편번호">
                <input type="text" id="sample6_address" name="sample5_address" placeholder="주소">
                <input type="button" id="gowhere_btn" onclick="sample6_execDaumPostcode()" value="주소찾기"><br>
                <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address_detail"> <input type="text" id="sample6_extraAddress" placeholder="나머지주소" name="else">

                <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
                function sample6_execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            var addr = '';
                            var extraAddr = '';
            
                            if (data.userSelectedType === 'R') {
                                addr = data.roadAddress;
                            } else {
                                addr = data.jibunAddress;
                            }
            
                            if(data.userSelectedType === 'R'){
                                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                    extraAddr += data.bname;
                                }
                                if(data.buildingName !== '' && data.apartment === 'Y'){
                                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                }
                                if(extraAddr !== ''){
                                    extraAddr = ' (' + extraAddr + ')';
                                }
                                document.getElementById("sample6_detailAddress").value = extraAddr;
                            
                            } else {
                                document.getElementById("sample6_detailAddress").value = '';
                            }
            
                            document.getElementById('sample6_postcode').value = data.zonecode;
                            document.getElementById("sample6_address").value = addr;
                            document.getElementById("sample6_extraAddress").focus();
                        }
                    }).open();
                }
            </script>
            </div>
        </div>
        
        <div id="order_list20">    
            <ul>
                <li class="order_cc">주문표</li>
                <li class="order_cc2">
                    <div class="menus">                    
<%   for (String totMenu : menus){
      out.print("<p>"+totMenu+"</p>");
      out.print("<input type='hidden' name='hiddenMenuPay' value='" + totMenu + "'>");
   } 
%>
                    </div>
                    <div class="menu_p">
<%   for (String q : quantity){
      out.print("<p>"+q+"개</p>");
      out.print("<input type='hidden' name='hiddenQuantityPay' value='" + q + "'>");
   }
}%>
                    </div>
                    <div id="for_clear_both"></div>
                </li>
                
                <li class="order_final">
                    <p><span class="final_pay1">(배달료 : <%=s_tip%>원)</span> <span class="final_pay2">결제금액</span> <span class="final_pay3" id="final_price"><%=fPrice + s_tip%>원</span></p>
                </li>
            </ul>
               <input type="hidden" id="jumoon_scode" name="jumoon_scode" value="<%=s_code%>">
               <input type="hidden" id="jumoon_price" name="jumoon_price" value="<%=fPrice + s_tip%>">
               <input type="hidden" id="jumoon_rp" name="jumoon_rp" value="<%=user_point%>">   <!-- 남은 포인트 -->
               <input type="submit" id="orderBtn" value="주문하기">
           
        </div>
        <div id="request">
            <h2 id="div_head">요청사항</h2><br>
            <form action="" method="POST">
                <textarea id="request_text" name="request_text"></textarea>
            </form>         
        </div>
        <div id="point">
            <h2 id="div_head">포인트</h2><br>
            <form action="" method="POST">
                <p><label>가용 포인트 : </label><span id="hPoint" name="hPoint"><%=user_point%></span> <label>사용할 포인트 : </label><input type="text" placeholder="                       원" id="vPoint" name="vPoint" onkeypress="return whyEnter();"><br><input type="button" value="사용" id="usePoint" name="usePoint"></p>
            </form>
            </form>
            <!-- 보유중인 포인트가 사용하려고 입력한 포인트보다 적을 경우 사용불가 -->
            <script>
               $(function(){               
                  $("#usePoint").on("click",function(){
                         let hPoint = document.getElementById('hPoint').innerHTML;
                     let vPoint = document.getElementById('vPoint').value;
                     
                     if(parseInt(vPoint) > parseInt(hPoint)) {
                        alert("포인트가 부족합니다");
                        return false;
                     }else{
                        //포인트 사용시 우측 주문표의 결제금액에서 사용한 포인트만큼 가격 할인
                        let pointConfirm = confirm(vPoint + "만큼 포인트를 사용하시겠습니까?");
                        if(pointConfirm) {
                           let final_price = document.getElementById('final_price').innerHTML;
                           let priceWithPoint = parseInt(final_price)-parseInt(vPoint);
                           //포인트 사용 후 남은 포인트 출력
                           let remainPoint = parseInt(hPoint)-parseInt(vPoint);
                           
                           $('#final_price').html(priceWithPoint + "원");
                           $('#hPoint').html(remainPoint);
                           $('#jumoon_rp').val(remainPoint);
                           $('#vPoint').val("");
                           alert("성공적으로 사용되었습니다");   
                                                    
                        }else{
                           alert("취소하였습니다");
                        }
                     }
                  })
               })
            </script>
        </div>
        <div id="payment">
            <h2 id="div_head">결제수단 <span id="htpChk">(<%=htpay%>)</span> <span class="phonepaychk">*휴대폰 결제는 상시 사용가능합니다</span></h2>
            <div class="howToPay" id="pay1">
                <p>
                <a href="#aa">카드결제</a>
                </p>
            </div>
            <div class="howToPay" id="pay2">
                <p>
                <a href="#aa">휴대폰결제</a>
                </p>
            </div>
            <div class="howToPay" id="pay3">
                <p>
                <a href="#aa">현장결제</a>
                </p>
            </div>
        </div>
    </div>
    <!--컨테이너 끝-->
    <div class="footer">
        <div class="footer_list_div">
            <div class="box_inner">
                <ul class="footer_list">
                    <li><a href="http://www.naver.com/" target="_sub">이용약관</a></li>
                    <li><a href="./jungbo.jsp" target="_sub">개인정보처리방침</a></li>
                    <li>회사소개</li>
                    <li>공지사항</li>
                </ul>
                <ul class="footer_sns">
                    <li><a href="https://www.facebook.com/smartbaedal" target="_blank"><img src="./images/facebook.png"
                                alt="배달의민족페이스북"></a></li>
                    <li><a href="https://www.instagram.com/baemin_official/" target="_blank"><img
                                src="./images/instagram.png" alt="배달의민족인스타그램"></a></li>
                    <li><a href="http://blog.naver.com/smartbaedal" target="_blank"><img src="./images/blog.png"
                                alt="배달의민족네이버블로그"></a></li>
                    <li><a href="https://www.youtube.com/user/smartbaedal2" target="_blank"><img
                                src="./images/youtube.png" alt="배달의민족"></a></li>
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
</body>
<script>
   var hwpay = 0;
   var hwpayChk = document.getElementById("htpChk").innerHTML;
   console.log(hwpayChk);
   
    $(function() {
        $("#pay1").on("click",function(){
           if(hwpayChk.includes("신용카드")) {
            $("#pay1").css({"border":"3px solid #333"});
            $("#pay2").css({"border" : "none"});
            $("#pay3").css({"border" : "none"});
            hwpay = 1;
           }else{
              alert("신용카드 결제가 불가능한 가게입니다");
           }
           
        })
    });
    
    $(function() {
        $("#pay2").on("click",function(){
            $("#pay1").css({"border" : "none"});
            $("#pay2").css({"border" : "3px solid #333"});
            $("#pay3").css({"border" : "none"});
            hwpay = 1;
        })
    });
    
      $(function() {
        $("#pay3").on("click",function(){
           $("#pay1").css({"border" : "none"});
           $("#pay2").css({"border" : "none"});
           $("#pay3").css({"border" : "3px solid #333"});
           hwpay = 1;
                 if(hwpayChk.includes("신용카드") && hwpayChk.includes("현금")){
                    alert("현장 결제시 해당 가게는 신용카드 혹은 현금으로 결제 가능합니다");
               }else if(!hwpayChk.includes("신용카드")) {
                  alert("현장 결제시 해당 가게는 현금 결제만 가능합니다");
               }else if(!hwpayChk.includes("현금")) {
                  alert("현장 결제시 해당 가게는 카드 결제만 가능합니다");
             }
        })
    });  
      
    function pleaseFinish() {
       if(hwpay==0) {
          alert("결제 수단을 확인해주세요");
          return false;
       }else{
          return true;
       }
    }
    
    
    
</script>
</html>