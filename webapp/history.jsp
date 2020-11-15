<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
   String u_code = request.getParameter("u_code");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   ResultSet rs3 = null;
   
   String sql = "";
   String sql2 = "";
   String sql3 = "";
   String url = "jdbc:mariadb://localhost:3306/tproject3";
   String uid = "root";
   String upw = "1234";
   
   String s_code= "";
   String m_name = "";
   String m_price = "";
   String j_quantity = "";
   String m_file = "";
   String s_name = "";
   String j_code = "";
   String j_date = "";
   
   try{
      Class.forName("org.mariadb.jdbc.Driver");
      conn = DriverManager.getConnection(url, uid, upw);
      if(conn != null){
    	 int jCount = 0;

    	 sql = "select count(j_code) as cnt FROM jumoon where j_progress='D' and u_code='" + u_code + "';";
    	      	 pstmt = conn.prepareStatement(sql);
    	           rs = pstmt.executeQuery();
    	           if(rs.next()){
    	              jCount = rs.getInt("cnt");
    	           }
    	  
         sql = "select s_code, m_price, j_code, j_progress FROM jumoon where u_code=? GROUP BY j_code order by j_date desc";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,u_code);
         rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문내역</title>
    <link href="css/style_history_review.css" rel="stylesheet" type="text/css">
    <script src="https://cdn.ckeditor.com/ckeditor5/19.1.1/classic/ckeditor.js"></script>
    <style>
    .title{margin-top:50px;}
    .his_review .button ul .write input[type=submit] {
    width: 100%;
    background-color: #2AC1BC;
    border: 0;
    font-size: 16px;
    color: white;
    margin: 0;
    height: 50px;
 
}
.ck-editor__editable {
    width: 477px;
    height: 150px;
}
.his_review {height: 828px;}

.his_review input {
    margin-left: 78px;
    margin-bottom: 20px;
    width: 204px;
}
.star-input1>.input1>input:checked+label, .star-input2>.input2>input:checked+label, .star-input3>.input3>input:checked+label{
    margin-left: 4px;
}
.menuNameNs_name{width:490px;}

.content { margin-bottom: 0; }

    </style>
    <script src="jquery-3.5.1.min.js"></script>
</head>
<body>
    <!--history 시작-->
    <div class="box_inner history_container just_for_check">
        <div id="title_history">
            <h2>주문내역</h2>
            <p><img src="images/deco_line.png"> 주문하신 상품 정보를 확인하세요</p>
            <p>주문상품(<span><%=jCount %></span>)</p> <!-- span안에 그동안 주문한 갯수 불러와서 넣는걸로..-->
        </div>
<%         
         while(rs.next()){
            int i =1;
            s_code = rs.getString(1);
            m_price = rs.getString(2);
            if(m_price.length()>3){
            m_price = m_price.substring(0,(m_price.length()-3)) + "," + m_price.substring((m_price.length()-3),m_price.length());
            }
            j_code = rs.getString(3);
            j_date = rs.getString(4);
            sql2 = "SELECT s_name, s_img from menu inner join store on menu.s_code=store.s_code where menu.s_code=?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1,s_code);
            rs2 = pstmt.executeQuery();
            if(rs2.next()){
               s_name = rs2.getString(1);
               m_file = rs2.getString("s_img");
               
%>   
   <div id="table_history" class="table_history_cls">
            <div id="table_history_menu" class="table_history_menu_cls">
                <div><img src="images/check2.png" alt="체크박스"></div>
                <div>상품정보</div>
                <div>수량</div>
                <div>가격</div>
                <div>주문상태</div>
            </div>
            <div id="history1" class="history">
                <!-- 여기서부터 DB에서 내가 주문했던 상품 불러와 넣으면 될것같아요-->
                <div><img src="images/check.png" alt="체크박스"></div>
                <div class="menuNameNs_name">
                    <img src="http://localhost:9090/upload/<%=m_file %>" alt="<%=m_file %>">
                    <div>
                        <h3 class="store_name"><%=s_name %></h3>
                        <p class="menu_name">
<%
            sql2 = "select m_name FROM jumoon j2  where u_code=? and j_code=?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1,u_code);
            pstmt.setString(2,j_code);
            rs3 = pstmt.executeQuery();
            while(rs3.next()){
            m_name = rs3.getString(1);
%>
                        <%=m_name %><br>
<%} %>                   
                        </p>
                        <input type=hidden class="hidden_data3" value="<%=s_code%>">
                    </div>
                </div>
            <div>
                    <p>
<%
            sql2 = "select j_quantity FROM jumoon j2  where u_code=? and j_code=?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1,u_code);
            pstmt.setString(2,j_code);
            rs3 = pstmt.executeQuery();
            while(rs3.next()){
            j_quantity= rs3.getString(1);
%>                    
                    <%=j_quantity %><br>
<%} %>                    
                    </p>
                </div>
                <div>
                    <p><span><%= m_price%></span>원</p>
                </div>
                <div>
                    <p><%
                    if(j_date.equals("O")){
                    	out.println("주문대기");
                    }else if(j_date.equals("W")){
                    	out.println("배달중");
                    }else{
                    	out.println("배달완료");
                    }
                    
                    %></p>
                </div>
                <div id="button_mv">
                    <nav>
                        <div>
                            <img src="images/pencil.png">
                        </div>
                        <div>
                            <a href="#" class="review_wr">리뷰쓰기</a>
                        </div>
                    </nav>
                    <nav>
                        <div><img src="images/store_big.png"></div>
                        <div><a href="store_info.jsp?s_code=<%=s_code%>" target="_blank">가게보기</a></div>
                    </nav>
                </div>
            </div>
            <div class="go_clear"></div>
        </div>
<%
         i++;
            }
         }
      }
   }catch(Exception e){
      
   }

%>           
    </div>

    <!--history 끝-->
    <!-- 리뷰작성 -->
<form method="post" action="history_ok.jsp?u_code=<%=u_code%>">
    <div class="his_review">
        <div class="review_header_logo">
            <img src="./images/popup_logo.png" alt="질문등록">
        </div>
        <p class="title"><label for="inquire_title">제목<input type="text" name="title"></label></p>
        <!-- 별점 -->
        <p class="star-input1">
            <span class="input1">
                <input type="radio" name="star-input1" value="1" id="p1">
                <label for="p1">1</label>
                <input type="radio" name="star-input1" value="2" id="p2">
                <label for="p2">2</label>
                <input type="radio" name="star-input1" value="3" id="p3">
                <label for="p3">3</label>
                <input type="radio" name="star-input1" value="4" id="p4">
                <label for="p4">4</label>
                <input type="radio" name="star-input1" value="5" id="p5">
                <label for="p5">5</label>
            </span>
            <output for="star-input"><b>0</b>점</output>
            <p id="st_choice">맛 별점을 선택하세요</p>
        </p>
        <p class="star-input2">
            <span class="input2">
                <input type="radio" name="star-input2" value="1" id="p6">
                <label for="p6">1</label>
                <input type="radio" name="star-input2" value="2" id="p7">
                <label for="p7">2</label>
                <input type="radio" name="star-input2" value="3" id="p8">
                <label for="p8">3</label>
                <input type="radio" name="star-input2" value="4" id="p9">
                <label for="p9">4</label>
                <input type="radio" name="star-input2" value="5" id="p10">
                <label for="p10">5</label>
            </span>
            <output for="star-input"><b>0</b>점</output>
            <p id="st_choice">배달 별점을 선택하세요</p>
        </p>
        <p class="star-input3">
            <span class="input3">
                <input type="radio" name="star-input3" value="1" id="p11">
                <label for="p11">1</label>
                <input type="radio" name="star-input3" value="2" id="p12">
                <label for="p12">2</label>
                <input type="radio" name="star-input3" value="3" id="p13">
                <label for="p13">3</label>
                <input type="radio" name="star-input3" value="4" id="p14">
                <label for="p14">4</label>
                <input type="radio" name="star-input3" value="5" id="p15">
                <label for="p15">5</label>
            </span>
            <output for="star-input"><b>0</b>점</output>
            <p id="st_choice">양 별점을 선택하세요</p>
        </p>
        <p>
        <input type="hidden" class="hidden_data1" name="hidden_data1" value="">
        <input type="hidden" class="hidden_data2" name="hidden_data2" value="">
        <input type="hidden" class="hidden_data3" name="hidden_data3" value="">
        </p>
        <p class="content">
        <textarea name="inquiry" id="inquire_subtance" cols="40" rows="30"></textarea>
        </p>
        <div class="button">
            <ul>
               
                <li class="cancle"><input type="button" value="취소"></li>
                <li class="write"><input type="submit" class="review_input_btn" value="등록"></li>
            </ul>
        </div>
    </div>
</form>
    <!-- 별점 끝 -->
    <!-- 리뷰작성 끝 -->
</body>
</html>

<script>
   ClassicEditor
   .create(document.getElementById('inquire_subtance'))
   .catch(error => {
       console.error(error);
   });

    // 맛 별점 제이쿼리 ---> 별을 선택하면 그 옆에 몇 점을 선택했는지 표시해주는 부분 
    var starRating1 = function () {
        var $star = $(".star-input1"),
            $result = $star.find("output>b");
        $(document)
            .on("focusin", ".input1",
                function () {
                    $(this).addClass("focus");
                })

            .on("focusout", ".input1", function () {
                var $this = $(this);
                setTimeout(function () {
                    if ($this.find(":focus").length === 0) {
                        $this.removeClass("focus");
                    }
                }, 100);
            })

            .on("change", ".star-input1 :radio", function () {
                $result.text($(this).next().text());
            })
            .on("mouseover", ".star-input1 label", function () {
                $result.text($(this).text());
            })
            .on("mouseleave", ".input1", function () {
                var $checked = $star.find(":checked");
                if ($checked.length === 0) {
                    $result.text("0");
                } else {
                    $result.text($checked.next().text());
                }
            });
    };

    starRating1();
    // 맛 별점 제이쿼리 끝
    // 배달 별점 제이쿼리
    var starRating2 = function () {
        var $star2 = $(".star-input2"),
            $result2 = $star2.find("output>b");

        $(document).on("focusin", ".input2",
                function () {
                    $(this).addClass("focus2");
                })

            .on("focusout", ".input2", function () {
                var $this = $(this);
                setTimeout(function () {
                    if ($this.find(":focus2").length === 0) {
                        $this.removeClass("focus2");
                    }
                }, 100);
            })

            .on("change", ".star-input2 :radio", function () {
                $result2.text($(this).next().text());
            })
            .on("mouseover", ".star-input2 label", function () {
                $result2.text($(this).text());
            })
            .on("mouseleave", ".input2", function () {
                var $checked2 = $star2.find(":checked");
                if ($checked2.length === 0) {
                    $result2.text("0");
                } else {
                    $result2.text($checked2.next().text());
                }
            });
    };

    starRating2();
    // 배달 별점 제이쿼리 끝
    // 양 별점 제이쿼리
    var starRating3 = function () {
        var $star3 = $(".star-input3"),
            $result3 = $star3.find("output>b");

        $(document)
            .on("focusin", ".input3",
                function () {
                    $(this).addClass("focus3");
                })

            .on("focusout", ".input3", function () {
                var $this = $(this);
                setTimeout(function () {
                    if ($this.find(":focus3").length === 0) {
                        $this.removeClass("focus3");
                    }
                }, 100);
            })

            .on("change", ".star-input3 :radio", function () {
                $result3.text($(this).next().text());
            })
            .on("mouseover", ".star-input3 label", function () {
                $result3.text($(this).text());
            })
            .on("mouseleave", ".input3", function () {
                var $checked3 = $star3.find(":checked");
                if ($checked3.length === 0) {
                    $result3.text("0");
                } else {
                    $result3.text($checked3.next().text());
                }
            });
    };

    starRating3();
    // 양 별점 제이쿼리 끝

    /* 리뷰하기 팝업 jquery */
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) +
            "px");
        this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) +
            "px");
        return this;
    }
    ques_bt = function () {
        $(".his_review").show();
        $(".his_review").center();
    }



    $(function () {
        $(".cancle").on("click", function () {
            $(".his_review").css({
                "display": "none"
            });
        });
    });

    $(function () {
        $(".write").on("click", function () {
            $(".his_review").css({
                "display": "none"
            });



        });
    });

    $(function () {
        $(".review_wr").on("click", function () {
            $(".his_review").css({
                "display": "block"
            });
         let storeName = $(this).parents(".history").find(".store_name").text()
         let menuName = $(this).parents(".history").find(".menu_name").text()
         let storeCode = $(this).parents(".history").find(".hidden_data3").val()
         $(".hidden_data1").attr("value",storeName);
         $(".hidden_data2").attr("value",menuName);
         $(".hidden_data3").attr("value",storeCode);
         console.log($(".hidden_data3").attr("value"))        
        });
   
    });
    
    
</script>