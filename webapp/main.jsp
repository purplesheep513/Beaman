<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = null;
	if(session.getAttribute("id") != null){
		userid = (String)session.getAttribute("id");
	}
	String u_code = (String)session.getAttribute("u_code");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    <style>
    .menulist{height:640px;}
    h1{margin:0; color:#373737; text-align:center; padding-bottom:20px;}
    </style>
    <script type="text/javascript" src="./js/main.js"></script>
    <script src="./jquery-3.5.1.min.js"></script>
     <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6e359c4f1c560df3108c11cf17af13c3&libraries=services"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function (data) {
                var addr = ''; // 주소 변수
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                document.getElementById("sample3_address").value = addr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize: function (size) {
                element_wrap.style.height = size.height + 'px';
            },
            width: '100%',
            height: '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }

    let latitude = "";
    let longitude ="";
    
    function getLocation(){
        if (navigator.geolocation) { // GPS를 지원하면
            navigator.geolocation.getCurrentPosition(function (position) {
                latitude = position.coords.latitude;
                longitude = position.coords.longitude;
                after();
            }, function (error) {
				console.error(error);
            }, {
                enableHighAccuracy: false,
                maximumAge: 0,
                timeout: Infinity
            });
        } else {
            alert('현재 위치를 가져올 수 없습니다.');
        }
    }
    function after(){
    	
    	var geocoder = new kakao.maps.services.Geocoder();

    	var coord = new kakao.maps.LatLng(latitude, longitude);
    	var callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        	$("#sample3_address").val(result[0].address.address_name);
        }
        
    };

    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    }
    	
    $(function(){
        $(".substrLoc").on("click",function(){
        	loc =$("#sample3_address").val();
            loc = loc.substr(3,2)
            Sname = $(this).find(".getSName").val()
            location.href="store_list.jsp?s_category="+Sname+"&loc="+loc;
        })
     })

    
</script>
</head>

<body>
    <div class="header">
        <div class="box_inner">
            <a href="#"><img src="./images/logo_icon.png" alt="배달의민족"></a>
            <%
            	if(userid==null){
            %>
            <ul class="user_list">
                <li><a href="login.jsp">로그인</a></li>
                <li> | </li>
                <li><a href="add_member.jsp">회원가입</a></li>
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
    <div class="container">
        <div class="box_inner headerimg">
            <div class="header_img">
                <div class="choice_bae">
                    <div class="input_type">
                        <span class="input_type_maps"><a id="gpsTrace" href="#" onclick="getLocation()"><img src="./images/mapsico.png" alt="주소찾기"></a></span>
                        <input type="search" id="sample3_address" class="input_type_search"
                            placeholder="건물명, 도로명, 지번으로 입력하세요.">
                        <button class="input_type_btn" onclick="sample3_execDaumPostcode()">검색</button>
                        <div id="wrap"
                            style="display:none;border:1px solid;width:400px;height:300px;margin:0;position:absolute;top:195px">
                            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap"
                                style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1"
                                onclick="foldDaumPostcode()" alt="접기 버튼">
                        </div>
                    </div>
                </div>
            </div>
            <h1>오늘의 추천메뉴</h1>
        </div>
        <%@ include file="recMenu.jsp" %>
        <div class="box_inner">
        		
            <div class="menulist">
                <ul class="menu">
                    <li>
                        <a class="substrLoc" href="#aa">
                        	<input type="hidden" class="getSName" value="한식">
                            <img src="./images/korean.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        	<input type="hidden" class="getSName" value="분식">
                            <img src="./images/dduck.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="카페/디저트">
                            <img src="./images/dessert.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="일식/돈까스">
                            <img src="./images/ja.png">
                        </a>
                    </li>
                </ul>
                <ul class="menu">
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="치킨">
                            <img src="./images/chicken.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="피자/양식">
                            <img src="./images/pizza.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="아시안">
                            <img src="./images/asian.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="중국집">
                            <img src="./images/chinese.png">
                        </a>
                    </li>
                </ul>
                <ul class="menu">
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="족발/보쌈">
                            <img src="./images/foot.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="야식">
                            <img src="./images/night.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="찜/탕">
                            <img src="./images/tang.png">
                        </a>
                    </li>
                    <li>
                        <a class="substrLoc" href="#aa">
                        <input type="hidden" class="getSName" value="도시락">
                            <img src="./images/doshirak.png">
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div id="rider_recruit">
            <a href="gong.jsp" ><img src="./images/notice_brief.png"></a>
            <a href="mypage.jsp" ><img src="./images/myPage_brief.png"></a>
            <a href="http://www.baeminriders.kr/" target="_blank">
                <img src="./images/bmrider.png">
            </a>
        </div>
    </div>

  <%@ include file="mainslider.jsp" %>
    <div class="footer">
        <div class="footer_list_div">
            <div class="box_inner">
                <ul class="footer_list">
                    <li><a href="./edragon.jsp" target="_sub">이용약관</a></li>
                    <li><a href="./jungbo.jsp" target="_sub">개인정보처리방침</a></li>
                    <li><a href="./company_intro.jsp" target="_sub">회사소개</a></li>
                    <li><a href="./gong.jsp" target="_sub">공지사항</a></li>
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

</html>