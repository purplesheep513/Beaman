<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <script src="./jquery-3.5.1.min.js"></script>
    <style>
	    .notice { padding: 0 120px 0 150px; }
	    .ck { width: 40px; height: auto; display: none;  position: absolute; right: 3.3%;}
	</style>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    
</head>
<body>
<div class="box_inner">
    <div id="menutitle">
        <div class="titlef">
            이용문의
        </div>
    </div>
    <div id="question_cont2">
        <ul>
            <li class="menuline">
                <div class="menulef">No</div>
                <div class="menucen">내용</div>
                <div class="menurig">펼쳐보기</div>
            </li>
            <li>
                <div class="menulef">01</div>
                <div class="menucen">아이디/비밀번호를 잊어버렸어요.</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <h4>1. 가게에서 주문을 접수하기 전</h4>
                <p>-App에서 직접 취소할 수 있습니다.</p>
                <p>●경로 : 주문내역 > '취소할 주문'클릭 > '주문취소' 버튼클릭</p>
                <h4>2. 가게에서 주문을 접수한 후</h4>
                <p>-주문한 가게로 연락하여 취소가 가능한지 확인할 수 있습니다.</p>
                <p>●경로 : 주문내역 > '취소할 주문'클릭 > 가게명 옆 '전화' 버튼클릭</p>
                <br>
                <p>-단, 배민 라이더스, 배민치킨, 배민마켓은 고객센터로 연락해주세요.</p>
            </li>
            <li>
                <div class="menulef">02</div>
                <div class="menucen">내 주문내역을 삭제할 수 있나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>App에서 주문과 동시에 결제가 진행하는 방법과 배달원에게 직접 결제하는 [만나서 결제] 방법이 있습니다</p>
                <h4>배달의 민족 APP결제 방식은 아래의 방법 중 하나를 선택할 수 있습니다.</h4>
                <p>①신용카드<br>②휴대폰<br>③배민페이 : 최소 1회 카드 정보 및 비밀번호를 설정하면, 이 후 사용에는 비밀번호만으로 편리하게 사용 가능한 결제방식<br>④배민페이 계좌이체 : 본인인증 후 비밀번호 설정으로 손쉽게 계좌 결제를 할 수 있는 간편 결제방식<br>⑤카카오페이, PAYCO, 네이버페이, 토스 : 별도 해당 서비스 가입 후 결제하는 방식</p>
            </li>
            <li>
                <div class="menulef">03</div>
                <div class="menucen">주류 구매 시 연령인증은 꼭 해야하나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>주문접수가 완료되었다는 알림톡을 받으셨다면, 결제한 내용에 대한 변경이 어렵습니다.</p>
                <p>아직 알림톡이 오지 않았다면, 주문하신 가게 또는 고객센터로 연락주시기 바랍니다.</p>
                <p>주문 접수가 완료되었다는 알림톡을 받으셨다면, 결제한 내용에 대한 변경이 어렵습니다.</p>
                <p>아직 알림톡이 오지 않았다면, 주문하신 가게 또는 고객센터로 연락주시기 바랍니다.</p>
                <p>주문접수가 완료되었다는 알림톡을 받으셨다면, 결제한 내용에 대한 변경이 어렵습니다.</p>
                <p>아직 알립톡이 오지 않았다면, 주문하신 가게 또는 고객센터로 연락주시기 바랍니다.</p>
            </li>
                        <li>
                <div class="menulef">04</div>
                <div class="menucen">위치설정을 변경하고싶어요. 어떻게하나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>네, 맞습니다. 고객안심센터는 배달의 민족을 이용하며 발생된 가게와 관련된 불편사항을 접수하여 문제를 해결해드립니다.<br><br>또한, 고객안심센터 및 배달의 민족 고객센터로 직접 신고된 이물 신고 중 개인정보(이름, 연락처 등) 제공에 동의하실 경우 식품의약품 안전처로 전달됩니다.<br>이물 통보 접수 후 조사결과는 최대 15일 이내 관할 제자체에서 고객님께 직접 회신해드립니다.</p>
            </li>
                        <li>
                <div class="menulef">05</div>
                <div class="menucen">안심번호가 뭔가요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>주문내역에서 리뷰를 작성하고자 하는 주문 건 하단의 [리뷰쓰기] 버튼을 클릭하면 리뷰를 작성할 수 있습니다. <br>작성한 리뷰는 [리뷰관리]메뉴에서 확인할 수 있습니다.</p>
            	<p>●리뷰 작성 조건<br>1. 리뷰작성은 배달의 민족 회원에게 한하여 가능하며, 비회원은 작성이 불가합니다.<br>2. 배달완료 후 7일 이내에 작성이 가능하며, 주문번호 기준으로 1개의 리뷰 작성이 가능합니다.<br>3. 주문이 취소된 경우 리뷰 작성이 불가합니다.<br>4. 전화주문 이용 시에는 리뷰 작성이 불가합니다.</p>
            </li>
                        <li>
                <div class="menulef">06</div>
                <div class="menucen">회원 등급 산정은 어떻게 되나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>리뷰를 작성한 회원정보로 로그인하시면 리뷰를 수정/삭제 할 수 있습니다.</p>
                <p>●경로 : 리뷰관리 > 작성한 리뷰의 '수정/삭제'버튼 클릭</p>
            </li>
                        <li>
                <div class="menulef">07</div>
                <div class="menucen">포인트 사용은 어떻게 하나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>아이디/비밀번호 찾기는[로그인>아이디/비밀번호 찾기]에서 가능합니다.</p>
            </li>
                        <li>
                <div class="menulef">08</div>
                <div class="menucen">월간 쿠폰북이 무엇인가요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>'배민페이(계좌이체)','카카오페이(계좌이체)','네이버페이(계좌이체)','토스(계좌이체)'로 결제 시,</p>
                <p>결제가 완료된 주문 건에 대하여 발급되며, 영업일 기준 최대 1일 정도 소요됩니다.</p>
                <p>●경로 : 주문내역 > 간편결제(계좌이체) 주문 선택 > "현금 영수중 보기"클릭</p>
                <p>결제 단계에서 현금 영수증 발급 신청을 안하셨다면,</p>
                <p>위 경로에서 발급번호 확인한 후 국세청 홈페이지에서 자진 발급분을 등록해주세요.</p>
            </li>
                        <li>
                <div class="menulef">09</div>
                <div class="menucen">본인인증 메일이 안와요.</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>배달의 민족에서는 당사를 통해 제공되는 컨텐츠를 쾌적하고, 신뢰할 수 있도록 유지하기 위해 관리하고 있습니다.</p>
                <p>따라서, 관련 법력(정보통신망 이용 촉진 및 정보 보호등에 관한 법률, 개인정보보호법)에 의거하여 모니터링을 진행하고 있으며 음란물 및 비속어가 기재된 리뷰를 차단하고 있습니다</p>
            </li>
                        <li>
                <div class="menulef">10</div>
                <div class="menucen">푸시알림을 끄고싶어요.</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="tac"></button></div>
                <img src="./images/qnadup.png" class="ck">
            </li>
            <li class="notice" style="display: none;">
                <p>회원 탈퇴 시 배달의 민족 App이용이 불가능하며 포인트 및 주문내역 등 모든정보가 사라집니다.</p>
                <p>탈퇴를 원하신다면 [내정보(닉네임 클릭) > "회원탈퇴"버튼]을 클릭해주세요.</p>
            </li>
        </ul>
    </div>
</div>
<div></div>
</body>
<script>
    $(".tac").on("click", function(){
    	$(".notice").css("display", "none");
    	$(".ck").css({"display":"none"});
    	$(".tac").css("display","block");
        $(this).parents('li').next(".notice").css("display" , "block");
        $(this).parents('div').next().css({"display":"block"});
        $(this).css("display", "none");
    });

    $(".ck").on("click", function(){
        $(this).parent().next().css("display", "none");
        $(this).css("display", "none");
        $(this).prev().find(".tac").css("display","block");
    });
    
</script>
</html>


