<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <script src="./jquery-3.5.1.min.js"></script>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="box_inner">
    <div id="menutitle">
        <div class="titlef">
            기타
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
                <div class="menucen">비장의카드(VIP카드)은 무엇인가요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" id="tac1"></button></div>
                <img src="./images/qnadup.png" id="ck1">
            </li>
            <li class="notice1" style="display: none;">
                1. Lorem ipsum dolor sit amet consectetur adipisicing elit. Illo animi unde cumque architecto odio tempore quaerat sit distinctio ad reprehenderit rem quibusdam est nam, itaque quisquam obcaecati temporibus nihil eaque!Lorem
            </li>
            <li>
                <div class="menulef">02</div>
                <div class="menucen">배달의민족 글꼴을 마음대로 사용해도 되나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" id="tac2"></button></div>
                <img src="./images/qnadup.png" id="ck2">
            </li>
            <li class="notice2" style="display: none;">
                2. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus, a! Laboriosam maxime natus voluptate ea cumque repellat pariatur vel alias sed, minus numquam quis, maiores rem odio itaque quam recusandae.
            </li>
            <li>
                <div class="menulef">03</div>
                <div class="menucen">음식에서 이물질이 나왔는데 고객안심센터로 연락하면 되나요?</div>
                <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" id="tac3"></button></div>
                <img src="./images/qnadup.png" id="ck3">
            </li>
            <li class="notice3" style="display: none;">
                3. Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius est maiores eligendi iste, harum labore rem illum nesciunt nostrum, odit laborum fugit accusantium obcaecati. Quos odio nisi assumenda officiis quam.
            </li>
        </ul>
    </div>
    <p></p>
</body>
</html>
<style>
    .notice1 { padding: 0 120px 0 150px; }
    .notice2 { padding: 0 120px 0 150px; }
    .notice3 { padding: 0 120px 0 150px; }
    #ck1 { width: 40px; height: auto; display: none; padding-right: 35px; }
    #ck2 { width: 40px; height: auto; display: none; padding-right: 35px; }
    #ck3 { width: 40px; height: auto; display: none; padding-right: 35px; } 
</style>
<script>
    $("#tac1").on("click", function(){
        $(".notice1").css("display" , "block");
        $("#ck1").css({"display":"block"});
        $("#tac1").css("display", "none");
    });
    $("#tac2").on("click", function(){
        $(".notice2").css("display" , "block");
        $("#ck2").css({"display":"block"});
        $("#tac2").css("display", "none");
    });
    $("#tac3").on("click", function(){
        $(".notice3").css("display" , "block");
        $("#ck3").css({"display":"block"});
        $("#tac3").css("display", "none");
    });
    $("#ck1").on("click", function(){
        $(".notice1").css("display", "none");
        $("#ck1").css("display", "none");
        $("#tac1").css("display","block");
    });
    $("#ck2").on("click", function(){
        $(".notice2").css("display", "none");
        $("#ck2").css("display", "none");
        $("#tac2").css("display","block");
    });
    $("#ck3").on("click", function(){
        $(".notice3").css("display", "none");
        $("#ck3").css("display", "none");
        $("#tac3").css("display","block");
    });
</script>