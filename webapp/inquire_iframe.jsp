<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
    <script>


        function link(input) {
            switch (input) {
                case "m1":
                    document.getElementById('the_iframe').setAttribute("src", "inquire_question.jsp");
                    break;
                case "m2":
                    document.getElementById('the_iframe').setAttribute("src", "inquire_signup.jsp");
                    break;
                case "m3":
                    document.getElementById('the_iframe').setAttribute("src", "inquire_payment.jsp");
                    break;
                case "m4":
                    document.getElementById('the_iframe').setAttribute("src", "inquire_review.jsp");
                    break;
                case "m5":
                    document.getElementById('the_iframe').setAttribute("src", "inquire_help.jsp");
                    break;
                case "m6":
                    document.getElementById('the_iframe').setAttribute("src", "ansim.jsp");
                    break;
                case "m7":
                    document.getElementById('the_iframe').setAttribute("src", "info_etc.jsp");
                    break;
            }
        }
    </script>
</head>

<body>
    <div id="frequent_q_container">
        <div id="frequent_q">
            <h1>자주 묻는 질문</h1>
            <p>
                <img src="images/deco_line.png">고객들이 자주 묻는 질문을 모아놓은 게시판입니다
            </p>
        </div>
        <div class="inquire_question_category">
            <ul id="question_top">
                <li>
                    <a href="#" id="m1" onclick="link(this.id)">
                        <p>TOP10</p>
                    </a>
                </li>
                <li>
                    <a href="#" id="m2" onclick="link(this.id)">
                        <p>회원가입</p>
                    </a>
                </li>
                <li>
                    <a href="#" id="m3" onclick="link(this.id)">
                        <p>바로결제</p>
                    </a>
                </li>
                <li>
                    <a href="#" id="m4" onclick="link(this.id)">
                        <p>리뷰관리</p>
                    </a>
                </li>
            </ul>
            <ul id="question_bottom">
                <li>
                    <a href="#" id="m5" onclick="link(this.id)">
                        <p>이용문의</p>
                    </a>
                </li>
                <li>
                    <a href="#" id="m6" onclick="link(this.id)">
                        <p>불편문의</p>
                    </a>
                </li>
                <li>
                    <a href="#" id="m7" onclick="link(this.id)">
                        <p>기타</p>
                    </a>
                </li>
            </ul>
        </div>
        <div id="iframe_container">
            <iframe src="inquire_question.jsp" id="the_iframe" name="WrittenPublic" frameborder="0"
                 style="overflow-x:hidden; overflow:auto; width:100%; min-height:500px;"></iframe>
        </div>
    </div>
</body>

</html>