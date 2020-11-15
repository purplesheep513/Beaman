<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%  request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="storeDTO" class="com.koreait.store.Store" scope="page" />
<jsp:useBean id="storeDAO" class="com.koreait.store.Store_DAO" scope="page"/>
<%    
request.setCharacterEncoding("UTF-8");
String search_input = request.getParameter("search_input");
String loc;
if(session.getAttribute("loc")!=null){
	loc = (String)session.getAttribute("loc");
}else{loc = "";}
      String s_name ="";
      String s_star = "";
      String s_intro = "";
	  
      String s_addr = "";
      String s_code="";	
      String s_category="";
		
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
      request.setAttribute("start", start);
      request.setAttribute("recNum", recNum);
	   
	   
	   
	   

%>    
<c:set var="storeSearch" value="${storeDAO.getSearch(sessionScope.u_code, param.search_input )}" />    
<%
String userid = (String)session.getAttribute("id");
String u_code = (String)session.getAttribute("u_code");
String category = request.getParameter("s_category");

int cnt=0;
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <link href="./css/style_store_list.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6e359c4f1c560df3108c11cf17af13c3&libraries=services"></script>
	<script src="./jquery-3.5.1.min.js"></script>
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
    <div class="food_cate_list_div">
        <div class="box_inner">
            <ul class="food_cate_list">
                <li class="main_search"><!-- 검색하는 돋보기 -->
                   <form action="search.jsp" class="search_action" method="get"> 
                    <a href="search" class="search_a" onclick="ques_bt()"><img src="./images/search.png"></a>
                    <div class="search_div"> 
                        <input type="search" class="search_input" name="search_input">
                        <button type="submit" value="검색" class="btn_search"><img src="./images/search.png"></button>
                    </div>
                    </form> 
                </li>
                <li><a href="store_list.jsp?s_category=한식&loc=<%=loc %>" id="getSName" class="food_cate">한식</a></li>
                <li><a href="store_list.jsp?s_category=분식&loc=<%=loc %>" id="getSName" class="food_cate">분식</a></li>
                <li><a href="store_list.jsp?s_category=카페/디저트&loc=<%=loc %>" id="getSName" class="food_cate">카페·디저트</a></li>
                <li><a href="store_list.jsp?s_category=일식/돈까스&loc=<%=loc %>" id="getSName" class="food_cate">일식·돈까스</a></li>
                <li><a href="store_list.jsp?s_category=치킨&loc=<%=loc %>" id="getSName" class="food_cate">치킨</a></li>
                <li><a href="store_list.jsp?s_category=피자/양식&loc=<%=loc %>" id="getSName" class="food_cate">피자·양식</a></li>
                <li><a href="store_list.jsp?s_category=아시안&loc=<%=loc %>" id="getSName" class="food_cate">아시안</a></li>
                <li><a href="store_list.jsp?s_category=중국집&loc=<%=loc %>" id="getSName" class="food_cate">중국집</a></li>
                <li><a href="store_list.jsp?s_category=족발/보쌈&loc=<%=loc %>" id="getSName" class="food_cate">족발·보쌈</a></li>
                <li><a href="store_list.jsp?s_category=야식&loc=<%=loc %>" id="getSName" class="food_cate">야식</a></li>
                <li><a href="store_list.jsp?s_category=찜/탕&loc=<%=loc %>" id="getSName" class="food_cate">찜·탕</a></li>
                <li><a href="store_list.jsp?s_category=도시락&loc=<%=loc %>" id="getSName" class="food_cate">도시락</a></li>
                <li><a href="store_list.jsp?s_category=패스트푸드&loc=<%=loc %>" id="getSName" class="food_cate">패스트푸드</a></li>
                <li><a href="store_list.jsp?s_category=프랜차이즈&loc=<%=loc %>" id="getSName" class="food_cate">프랜차이즈</a></li>
            </ul>
        </div>
    </div>
    <!-- 음식종류별 메뉴 끝-->
    <div class="box_inner">
        <!-- 가게리스트 -->
        <div class="order_by_div">
            <select class="order_by">
                <option>기본정렬 순</option>
                <option>별점 순</option>
                <option>리뷰많은 순</option>
                <option>최소 주문 금액 순</option>
                <option>배달시간 순</option>
            </select>
        </div>
        <br>
        <div>
            <table class="store_list"> 

<%
      
      int s_count = 0;
      int user_re = 0;
      int owner_re = 0;
	
%>
<c:forEach var="item" items="${storeSearch}" varStatus="status">
                <tr>
                    <td>
                        <div class="s_list_td">
                              <form method="post" name="zzim" action="zzim_ok.jsp?s_code=${item.s_code} &s_category=<%=category %>&loc=<%=loc %>" onsubmit="return zzimcheck()">
                            <div class="s_list_content">
                            <input type="hidden" value="<%=u_code %>" name="u_code">
                                <img src="http://localhost:9090/upload/${item.m_file}" alt="족발" id="s_main_img">
                                <div class="s_list_s">
                                    <div class="store_name"><a href="store_info.jsp?s_code=${item.s_code}">${item.s_name}</a></div>
                                    <div class="store_c"><span class="star_t"><img src="./images/star.png" alt="별"> ${item.s_star}</span> | <span>리뷰 ${item.review1 }</span> | <span>사장님 댓글  ${item.review2 }</span></div>
									<div class="like_img">
										<c:if test="${item.zzimCheck!=0 }">
											<input type="submit" value="" id="btn_like" class="check-icon2">
										</c:if>
										<c:if test="${item.zzimCheck==0 }">
											<input type="submit" value="" id="btn_like" class="check-icon">
										</c:if>
									</div>
                                    <input type="hidden" name="s_code" value="${item.s_code}">
                                </div>
                                <p>${item.s_intro}</p>
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
			geocoder.addressSearch('${item.s_addr}' , function(result, status) {
			
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
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">${item.s_name}</div>'
			        });
			        infowindow.open(map<%=cnt %>, marker);
			
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map<%=cnt %>.setCenter(coords);
			    } 
			});    
</script>
                              </form>
                        </div>
                    </td>
                </tr>
                
<%
cnt++;   
%>
</c:forEach>
<%
int pageCnt = (totCnt / recNum) + 1;
%>
		<tr>
			<td colspan="5" class="paging">
			<%
				for(int i=1; i<=pageCnt; i++){
			%>
					<a href='search.jsp?search_input=<%=search_input%>&loc=<%=loc %>&pagenum=<%=i%>'><%=i%></a>													
		<%
				}
		%>
			</td>
		</tr>
		
            </table>
        </div>
    </div>
    <!-- 가게리스트 끝 -->
    <!-- footer -->
    <div class="footer">
        <div class="footer_list_div">
            <div class="box_inner">
                <ul class="footer_list">
                    <li><a href="http://www.naver.com/" target="_sub">이용약관</a></li>
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
                <div><p>사업자등록번호 : 120-87-65763 사업자정보확인 대표 : 김범준 주소 : 서울 송파구 위례성대로 2, 장은빌딩 2층 대표전화 : 1600-0987 팩스: 050-6050-0400 대표메일 : help@woowahan.com
                    대면 상담센터 운영 - 운영시간 : (365일) 10:00 ~ 19:00, 찾아오시는길 : 서울특별시 송파구 백제고분로 478 순창빌딩 3F</p></div>
            </div>
        </div>
    </div>
<!-- footer 끝 -->
</body>
</html>

<script>



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