<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>슬롯머신</title>
		<script type="text/javascript" src="jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="./js/roolet.js">
		</script>

		<style type="text/css">
			#container {				
				width:100%;
				height:170px;
				overflow:hidden;
				background-color:#fff;
			}

			#container div {
				position:relative;
				width:10%;
				float:left;
				overflow:hidden;
				margin-left: 44.5%;
			}

			#container div img {
				width:100%;
				height:100%;
			}
			#start{background:url('images/click.png') no-repeat; width:30px; height:30px; outline:none; border:none;}
			#start:hover{cursor:pointer;}
		</style>
	</head>

	<body>
		<div id="container">
			<div id="one">
				<img src="images/1.png" />
				<img src="images/2.png" />
				<img src="images/3.png" />
				<img src="images/4.png" />
				<img src="images/5.png" />
				<img src="images/6.png" />
				<img src="images/7.png" />
				<img src="images/8.png" />
				<img src="images/9.png" />
				<img src="images/10.png" />
				<img src="images/11.png" />
				<img src="images/12.png" />
			</div>
			<p><input id="start" type="button" onclick="roolet()" style="margin-top:100px;"/></p>
		</div>
		
	</body>
</html>
    