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
	    .ck { width: 40px; height: auto; display: none; position: absolute; right: 3.3%;}
	</style>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    
</head>
<body>
<div class="box_inner">
    <div id="menutitle">
        <div class="titlef">
            회원가입
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
                <div class="menucen">회원가입은 어떻게 하나요?</div>
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
                <div class="menucen">회원가입 할 때 본인인증에 실패합니다.</div>
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
                <div class="menucen">휴먼 전환 안내 메일을 받았어요. 해제 방법은 어떻게 되나요?</div>
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


