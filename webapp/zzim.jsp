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
	String get_sql = request.getParameter("sql");
	if(get_sql == null){
		get_sql="select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime, s_img FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? limit ?, ?";
	}
	String what = (String)session.getAttribute("what");
	if(what == null){
		what = "1";
	}
	
	int recNum = 5; // 페이지당 글 개수
	int start = 0;	// 시작글 번호
	int totCnt = 0;	// 전체 글 개수
	
	String pagenum = request.getParameter("pagenum");
	if(pagenum != null && !pagenum.equals("")){
		start = (Integer.parseInt(pagenum)-1) * recNum;
	}else{
		pagenum = "1";
		start = 0;
	}

	
	String s_minOrder = "";
	String s_deliverytime ="";
	String s_code = "";
	String u_code = "";
	String s_name ="";
	String s_star = "";
	String s_intro = "";
	int review_owner=0;
	String s_addr = "";
	int review_user=0;
	int s_count = 0;
	int cnt = 0;
	int user_re = 0;
	int owner_re = 0;
	String s_img = "";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	String url = "jdbc:mariadb://localhost:3306/tproject3";
	String uid = "root";
	String upw = "1234";
	
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		if(conn != null){
				sql = "select u_code FROM user where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				rs = pstmt.executeQuery();
				if(rs.next()){
					u_code = rs.getString(1);
				}
				
				sql = "SELECT count(?) as cnt FROM zzim_store";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,u_code);
				rs = pstmt.executeQuery();
				if(rs.next()){
					totCnt = rs.getInt("cnt");
				}

				sql = get_sql;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_code);
				pstmt.setInt(2, start);
				pstmt.setInt(3, recNum);
				rs = pstmt.executeQuery();
		}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>찜한가게</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    <style>
    .store_name {margin-top: 0px;}
    .tb_paging {margin: 10px 0 30px 0; width: 100%; }
    .tb_paging .paging >a{font-size: 25px; font-weight: bold; margin-right: 10px;}
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6e359c4f1c560df3108c11cf17af13c3&libraries=services"></script>
</head>
<script src="./jquery-3.5.1.min.js"></script>
<body>
    <div class="box_inner zzim_cont">
        <h1>찜한 가게</h1>
        <p><img src="images/deco_line.png"> 내가 찜한 가게는?!</p>
        <div class="order_by_div">
            <select class="order_by">
                <option <%if(what.equals("1")){  out.println(" selected");} %>>기본정렬 순</option>
                <option <%if(what.equals("2")){  out.println(" selected");} %>>별점 순</option>
                <option <%if(what.equals("3")){  out.println(" selected");} %>>리뷰많은 순</option>
                <option <%if(what.equals("4")){  out.println(" selected");} %>>최소 주문 금액 순</option>
                <option <%if(what.equals("5")){  out.println(" selected");} %>>배달시간 순</option>
            </select>
        </div>
        <br>
        <div>
            <div class="store_list"> 

<%
					while(rs.next()){
                    	s_code = rs.getString("store.s_code");
                    	s_name = rs.getString("s_name");
                    	s_star = rs.getString("s_star");
                    	s_intro = rs.getString("s_intro");
                    	s_addr = rs.getString("s_addr");
                    	s_minOrder = rs.getString("s_minOrder");
                    	s_deliverytime = rs.getString("s_deliverytime");
                    	s_img = rs.getString("s_img");
                    	
                        sql = "select count(*) from review inner join store on review.s_code=store.s_code where store.s_code=? and review.r_didReply='Y'";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1,s_code);
                        ResultSet rs1 = pstmt.executeQuery();
                        if(rs1.next()){
                           review_owner = rs1.getInt(1);
                        }
                        sql = "select count(*) from review inner join store on review.s_code=store.s_code where store.s_code=?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1,s_code);
                        rs1 = pstmt.executeQuery();
                        if(rs1.next()){
                           review_user = rs1.getInt(1);
                        }
%>
                        <div class="s_list_td">
                        <form method="post" name="zzim" action="zzim_ok2.jsp" onsubmit="return zzimcheck()">
                            <div class="s_list_content">
                                <img src="http://localhost:9090/upload/<%=s_img %>" alt="족발" id="s_main_img">
                                <div class="s_list_s">
                                    <div class="store_name"><%=s_name%></div>
                                    <div class="store_c"><span class="star_t"><img src="./images/star.png" alt="별"><%=s_star%></span> | <span>리뷰 <%=review_user %></span> | <span>사장님답변 <%=review_owner %></span></div>
                                    <div class="store_c">최소주문금액 : <%=s_minOrder %></div><div class="store_c">배달시간 : <%= s_deliverytime%></div>
                                    <div class="like_img">
                                  	<input type="submit" value="" id="btn_like" class="check-icon2">

                                    </div>
                                    <input type="hidden" name="s_code" value="<%=s_code%>"> 
                                    <input type="hidden" name="u_code" value="<%=u_code%>">                                             	
                                </div>
                                <p><%=s_intro%></p>
                                
                            </div>
                           <div id="map<%=cnt %>" class="s_list_map">지도</div>
                            <p style="margin-top:-12px">
			    <em class="link">
			    </em>
			</p>
			
			
			
			<script>
			var mapContainer = document.getElementById('map<%=cnt %>'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			let map<%=cnt %> = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('<%=s_addr%>' , function(result, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map<%=cnt %>,
			            position: coords
			        });
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=s_name%></div>'
			        });
			        infowindow.open(map<%=cnt %>, marker);
			
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map<%=cnt %>.setCenter(coords);
			    } 
			});    
</script>
                      </form>
                            </div>
                    

<%
                cnt++;
                    }
		
						}catch(Exception e){
							e.printStackTrace();
						}

		int pageCnt =0;
		if((totCnt % 5) == 0){
			pageCnt = (totCnt/recNum);

		}else if((totCnt % 5) != 0){
			pageCnt = (totCnt / recNum)+1;
		}
%>
            </div>
			<table class="tb_paging">
				<tr>
					<th colspan="5" class="paging">
						<%
							for(int i=1; i<=pageCnt; i++){
								out.print("<a href='zzim.jsp?sql="+ get_sql +"&pagenum="+i+"'>" + i + "</a>" + " ");	
							}
						%>
					</th>
				</tr>
			</table>
        </div>
    </div>  
</body>
</html>
<script>
$(function(){
	$("select").on('change',function(){
		let sql;
		let what;
		if($(".order_by option:selected").val()=="별점 순"){
			sql =  "select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime,s_img FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? order by store.s_star desc limit ?, ?";	
			what = 2;
		}else if($(".order_by option:selected").val()=="리뷰많은 순"){
			sql =  "select *,count(*) FROM store left outer JOIN zzim_store on store.s_code=zzim_store.s_code left outer join review on store.s_code=review.s_code where zzim_store.u_code=? group by store.s_code order by count(*) desc limit ?,?";	
			what = 3;
		}else if($(".order_by option:selected").val()=="최소 주문 금액 순"){
			sql =  "select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime,s_img FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? order by store.s_minOrder asc limit ?, ?";	
			what = 4;
		}else if($(".order_by option:selected").val()=="배달시간 순"){
			sql =  "select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime,s_img FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? order by substring(store.s_deliverytime, 1, 2) asc limit ?, ?";	
			what = 5;
		}else{
			sql = "select store.s_code,s_name,s_star,s_intro,s_addr,s_minOrder, s_deliverytime,s_img FROM store LEFT OUTER JOIN zzim_store on store.s_code=zzim_store.s_code where zzim_store.u_code=? limit ?, ?";
			what = 1;
		}
		location.href ="zzim_orderBy.jsp?what="+what+"&sql="+sql;
	})
})
</script>