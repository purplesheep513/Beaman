<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");
String u_code = (String)session.getAttribute("u_code");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;


String sql = "";
String url = "jdbc:mariadb://localhost:3306/tproject3";
String uid = "root";
String upw = "1234";
String sql1 = "";

int mCount = 0;
int num = 1;
try{
   Class.forName("org.mariadb.jdbc.Driver");
   conn = DriverManager.getConnection(url, uid, upw);
   if(conn != null){
      sql = "SELECT count(m_code) as cnt FROM mun2 WHERE u_code='" + u_code + "';";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if(rs.next()){
            mCount = rs.getInt("cnt");
         }
      
      
      sql = "SELECT m_code, m_title, m_content, m_answer FROM mun2 where u_code=? order by m_code desc;";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, u_code);
      rs = pstmt.executeQuery();
   }

   
   %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>
<link href="css/style_inquire_history_rigist.css" rel="stylesheet" type="text/css">
<script src="https://cdn.ckeditor.com/ckeditor5/19.1.1/classic/ckeditor.js"></script>
<style>
.content { margin-bottom: 0; }
.ck-editor__editable {
    width: 477px;
    height: 200px;
}
</style>
</head>
<body>
    <div id="inquirehis">
        <h1>문의내역</h1>
        <p><img src="images/deco_line.png"> 직접 문의했던 내용과 답변 내역 게시판입니다.</p>
    </div> 
<div class="box_inner">
    <div id="inquhis_menutitle">
        <div class="inquhis_titlef">
            <button id="inquir_btn" onclick="ques_bt()">질문하기</button>
        </div>
    </div>
    <div id="inquhis_question_cont2">
        <ul>
            <li class="inq_menuline">
                <div class="inq_menulef">No</div>
                <div class="inq_menucen">제목</div>
                <div class="inq_menurig">펼쳐보기</div>
            </li>
 <%            
          
            while(rs.next()){
         String m_code = rs.getString("m_code");
         String m_title = rs.getString("m_title");
         String m_content = rs.getString("m_content");
         String m_answer = rs.getString("m_answer");
          if(m_answer == null) {
               m_answer = "답변 대기중입니다";
           }
%>            
            
            <li>
                <div class="inq_menulef"><%=mCount-num+1%></div>
                <div class="inq_menucen"><%=m_title%></div>
                <div class="inq_menurig"><a class="a_qnad" href="#"><img src="./images/qnad.png" alt="펼쳐보기"></a><a class="a_qnadup" href="#"><img src="./images/qnadup.png" alt=""></a></div>
            </li>
            <li class="inq_menurig_cont">
                <div>
                    <span class="menurig_cont_ques">Q. </span>
               <p class="inq_content_container"><%=m_content%></p>
                    
                    <span class="menuring_cont_an_check1">A.</span><p><%=m_answer%></p>
                </div>
            </li>
            <%
            num++;
      }
   }catch(Exception e){
      e.printStackTrace();
   }
%>
        </ul>
    </div>
    <p></p>
    <form method="post" action="inquire_history_regist_ok.jsp">
    <div class="inquire">
        <div class="header_logo">
            <img src="./images/question_many.png" alt="질문등록">
        </div>
        <p class="name"><label for="inquire_name">이름<span class="point">*</span><input type="text" name="in_name" id="in_name"></label></p>
        <p class="email"><label for="inquire_name">이메일<span class="point">*</span><input type="text" name="in_email" id="in_email"></label></p>
        <p class="group">
            <label for="inquire_group">상담분류
                <select name="in_choice" id="in_choice">
                    <option value="#">선택 안 함</option>
                    <option value="오류문의">오류문의</option>
                    <option value="회원정보문의">회원정보문의</option>
                    <option value="리뷰문의">리뷰문의</option>
                    <option value="제휴문의">제휴문의</option>
                    <option value="업소정보문의">업소정보문의</option>
                    <option value="이벤트">이벤트</option>
                    <option value="기타">기타</option>
                </select>
            </label>
        </p>
        <p class="title"><label for="inquire_title">제목<span class="point">*</span><input type="text" name="in_title" id="in_title"></label></p>
        <p class="content">
        <label for="inauire_title">문의내용<span class="point">*</span></label>
            <textarea name="inquiry" id="inquire_subtance" cols="70" rows="30"></textarea></p>
            <div class="button">
                <ul>
                    <li class="cancle"><input type="button" value="취소"></li>
                    <li class="write"><input type="submit" value="등록" id="btn_write" style="width: 100%; background-color: #2AC1BC; border: 0; height: 50px; font-size: 16px; color: white; margin-left: 0;"></li>
                </ul>
            </div>
    </div>
    </form>
    </div>  
</body>
</html>

<script src="jquery-3.5.1.min.js"></script>
<script>
   ClassicEditor
   .create(document.getElementById('inquire_subtance'))
   .catch(error => {
       console.error(error);
   });
   
    $(function(){
        $(".a_qnad").on("click", function(){
           $(this).parent().parent().next(".inq_menurig_cont").css({"display" : "block"});
            $(this).css({"display":"none"});
            $(this).next(".a_qnadup").css({"display" : "block" });
        });
 
    });
    
    $(function(){
        $(".a_qnadup").on("click", function(){
           $(this).parent().parent().next(".inq_menurig_cont").css({"display" : "none"});
            $(this).css({"display" : "none" });
            $(this).prev(".a_qnad").css({"display" : "block" });

        });      
    });
    
    $(function(){   
       $(".write").on("click", function(){
          if($("#in_name").val() == ""){
             alert("이름을 입력하세요")
             $("#in_name").focus();
             return false;

            } else if($("#in_email").val() == ""){
             alert("메일을 입력하세요")
                 $("#in_email").focus();
                 return false;

             } else if($("#in_title").val() == ""){
               alert("제목을 입력하세요")
             $("#in_title").focus();
             return false;
             
             }
              
  
    });
    });

/* 질문하기 팝업 jquery */
    jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}
    ques_bt = function() {
    $(".inquire").show();
    $(".inquire").center();
    }
    
    $(function(){
        $(".cancle").on("click", function(){
            $(".inquire").css({"display":"none"});
        });
    });

    $(function(){
        $(".write").on("click", function(){
            $(".inquire").css({"display" : "none"});
        });
    });

  /* 질문하기 팝업 jquery 끝*/
</script> 