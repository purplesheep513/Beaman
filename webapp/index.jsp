<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달의 민족</title>
    <style>
        body { background-color: #2AC1BC; width: 100%; height: 100%;
        position: absolute; margin:0;}
        .content { text-align: center; width: 100%;}
        #img {
            display: block;
            margin: 0 auto;
            margin-top: 300px;
            width: 800px;
            height: 400px;
            position: relative;
            z-index: 1;
        }
        #go {
            color: #2AC1BC;
            font-weight: bold;
            font-size: 30px;
            background-color: #ffffff;
            border-radius: 20px;
            padding: 0 10px;

        }
        .text {
            position: relative;
            top: 64%;
            z-index: 2;
        }
        div {
            position: absolute;
            text-align: center;
        }
        #go:link { color: #2AC1BC; text-decoration: none;}
        #go:visited { color: #2AC1BC; text-decoration: none;}
        #go:hover { color: #000000;}
    </style>
</head>
<body>
    <div class="content">
        <img src="https://lh3.googleusercontent.com/Z6TW6j5_9AbLlnicMg-efU_LMX7wWYC1gws7KSGZ9ymC94q0Dgte8Dqf0WwG5BZWmw" alt="배달의민족" id="img">
    </div>
    <div class="text content">
        <a id="go" href="main.jsp">주문 하러 가기</a>
    </div>
</body>
</html>